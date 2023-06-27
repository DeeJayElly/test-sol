// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";

import "./ICounter.constant.sol";

contract Exercise is ICounter {
    ICounter private counterImplementation;

    function setCounter(address _counter) external {
        counterImplementation = ICounter(_counter);
    }

    function inc() override external {
        require(address(counterImplementation) != address(0), "Counter implementation address not set");
        counterImplementation.inc();
    }

    function counter() override external returns (uint256) {
        require(address(counterImplementation) != address(0), "Counter implementation address not set");
        return counterImplementation.counter();
    }
}
