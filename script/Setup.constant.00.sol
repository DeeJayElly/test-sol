// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";
import "../00_welcome/List.constant.sol";

contract Setup is Script {
    function run() external {
        List list = new List();

        for (uint256 idx; idx < 100;) {
            list.push(idx);
            unchecked {
                ++idx;
            }
        }

        for (uint256 idx; idx < 100;) {
            list.remove(idx);
            unchecked {
                idx += 2;
            }
        }

        require(list.length() == 50, "01");

        for (uint256 idx = 1; idx < 100;) {
            list.remove(idx);
            unchecked {
                idx += 2;
            }
        }

        require(list.length() == 0, "02");
    }
}
