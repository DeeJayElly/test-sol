// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";
import "../02_pack/Exercise.sol";

contract Setup is Script {
    function run(bytes32 _values) external {
        Exercise exercise = new Exercise();

        uint64 _a = uint64((uint256(_values) >> 192) & type(uint64).max);
        uint64 _b = uint64((uint256(_values) >> 128) & type(uint64).max);
        address _c = address(this);
        uint128 _d = uint64(uint256(_values) & type(uint128).max);

        vm.record();
        exercise.setValues(_a, _b, _c, _d);
        (, bytes32[] memory writes) = vm.accesses(address(exercise));

        require(writes.length == 2, "01");

        (uint64 a, uint64 b, address c, uint128 d) = exercise.getValues();

        require(a == _a, "02");
        require(b == _b, "03");
        require(c == _c, "04");
        require(d == _d, "05");
    }
}
