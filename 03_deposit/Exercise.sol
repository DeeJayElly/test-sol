// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";

import "./DepositContract.constant.sol";

// steth is your friend
contract Exercise {
    IDepositContract dc;

    // setDepositContract saves the address of the DepositContract
    function setDepositContract(address _dc) external {
        dc = IDepositContract(_dc);
    }

    // getValues generates random values for public key, signature and withdrawal address
    // It returns them for testing purposes
    function getValues() external pure returns (bytes memory, bytes memory, address) {
        bytes memory publicKey = new bytes(48);
        bytes memory signature = new bytes(96);
        for (uint i = 0; i < 48; i++) {
            publicKey[i] = bytes1(uint8(i));
        }
        for (uint i = 0; i < 96; i++) {
            signature[i] = bytes1(uint8(i));
        }
        address withdrawal = address(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
        return (publicKey, signature, withdrawal);
    }

    // deposit calls the deposit function on the DepositContract with the provided values
    function deposit(bytes calldata pubkey, bytes calldata signature, address withdrawal) external payable {
        bytes memory withdrawal_credentials = new bytes(32);
        for (uint i = 0; i < 20; i++) {
            withdrawal_credentials[i] = bytes20(withdrawal)[i];
        }

        // Construct the deposit_data_leaf (simulate the construction)
        bytes32 pubkey_root = sha256(abi.encodePacked(pubkey, bytes16(0)));
        bytes32 signature_root = sha256(abi.encodePacked(sha256(abi.encodePacked(signature[:64])), sha256(abi.encodePacked(signature[64:], bytes32(0)))));
        uint256 deposit_amount = msg.value / 1 gwei;
        bytes memory amount = to_little_endian_64(uint64(deposit_amount));
        bytes32 deposit_data_leaf = sha256(
            abi.encodePacked(
                sha256(abi.encodePacked(pubkey_root, withdrawal_credentials)),
                sha256(abi.encodePacked(amount, bytes24(0), signature_root))
            )
        );

        dc.deposit{value: msg.value}(pubkey, withdrawal_credentials, signature, deposit_data_leaf);
    }

    function to_little_endian_64(uint64 value) internal pure returns (bytes memory ret) {
        ret = new bytes(8);
        bytes8 bytesValue = bytes8(value);
        ret[0] = bytesValue[7];
        ret[1] = bytesValue[6];
        ret[2] = bytesValue[5];
        ret[3] = bytesValue[4];
        ret[4] = bytesValue[3];
        ret[5] = bytesValue[2];
        ret[6] = bytesValue[1];
        ret[7] = bytesValue[0];
    }
}
