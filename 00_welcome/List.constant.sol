// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";
import "./Exercise.sol";

contract List is Exercise {
    uint256[] public list;

    function push(uint256 _value) external {
        require(indexOf(_value) == -1, "duplicate");
        list.push(_value);
    }

    function remove(uint256 _value) external {
        int256 index = indexOf(_value);
        require(index >= 0, "not found");
        Exercise._remove(list, uint256(index));
    }

    function indexOf(uint256 _value) public view returns (int256) {
        for (uint256 idx; idx < list.length;) {
            if (list[idx] == _value) {
                return int256(idx);
            }
            unchecked {
                ++idx;
            }
        }
        return -1;
    }

    function length() external view returns (uint256) {
        return list.length;
    }
}
