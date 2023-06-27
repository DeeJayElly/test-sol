// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

contract Exercise {
    function getSigner() external pure returns (address) {
        return 0x76C09917EF1A6E885affCb8B14c0E09df271F393;
    }

    function getSignature() external pure returns (bytes memory) {
        return
        hex"2b7fe067cf63bbfff8df636002eb6f71f4610b3958e75e759a2f6633c75c0a03147da8cbcbf788174b3c771e829ac5089a3cbc6511f9b76f2575ba2dd64dbfdd1b";
    }
}
