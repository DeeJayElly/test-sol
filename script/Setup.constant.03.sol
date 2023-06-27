// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";
import "forge-std/Vm.sol";
import "../03_deposit/Exercise.sol";
import "../03_deposit/DepositContract.constant.sol";

contract Setup is Script {
    event DepositEvent(bytes pubkey, bytes withdrawal_credentials, bytes amount, bytes signature, bytes index);

    function run() external {
        DepositContract dc = new DepositContract();
        Exercise exercise = new Exercise();
        exercise.setDepositContract(address(dc));

        (bytes memory publicKey, bytes memory signature, address withdrawal) = exercise.getValues();

        require(publicKey.length == 48, "01");

        exercise.deposit{value: 32 ether}(publicKey, signature, withdrawal);

        require(keccak256(publicKey) == keccak256(dc.DEBUG_LAST_PUBLIC_KEY()), "02");
    }
}
