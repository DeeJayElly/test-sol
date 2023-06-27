// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";
import "./ICounter.constant.sol";

contract Me {
    address public immutable me;
    address internal _me;

    constructor() {
        me = address(this);
        _me = address(this);
    }
}

contract Simple is ICounter, Me {
    uint256 public counter;

    function inc() external {
        unchecked {
            ++counter;
        }
    }
}

contract Double is ICounter, Me {
    uint256 public counter;

    function inc() external {
        unchecked {
            ++counter;
            ++counter;
        }
    }
}

contract Override is ICounter, Me {
    uint256 public counter;

    function inc() external {
        counter = uint256(keccak256(abi.encodePacked(address(this))));
    }
}

contract Mul is ICounter, Me {
    uint256 public counter;

    function inc() external {
        unchecked {
            counter = (counter + 1) * 2;
        }
    }
}

contract Div is ICounter, Me {
    uint256 public counter;

    function inc() external {
        unchecked {
            counter = (counter - 1) / 2;
        }
    }
}
