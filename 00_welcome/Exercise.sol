// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";

contract Exercise {
    function _remove(uint256[] storage _arr, uint256 _index) internal {
        _arr[_index] = _arr[_arr.length - 1];
        _arr.pop();
    }
}
