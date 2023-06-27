// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";
import "forge-std/Vm.sol";
import "../04_brute_power/Exercise.sol";
import "../04_brute_power/Libraries.constant.sol";

contract Setup is Script {
    bytes32 constant hashed = keccak256("\x19Ethereum Signed Message:\n3504_brute_power requires brute power");

    function points(address signer) internal pure returns (uint256 score) {
        for (uint256 idx = 0; idx < 20; ++idx) {
            if (bytes20(signer)[idx] == 0) {
                ++score;
            }
        }
    }

    function run() external {
        Exercise exercise = new Exercise();

        address signer = exercise.getSigner();
        bytes memory signature = exercise.getSignature();

        require(SignatureChecker.isValidSignatureNow(signer, hashed, signature), "01");
        require(points(signer) >= 14, "02");
    }
}
