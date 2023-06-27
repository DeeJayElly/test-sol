// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";
import "../01_delegation/Counters.constant.sol";
import "../01_delegation/Exercise.sol";

contract Setup is Script {
    function run(bytes calldata randomness) external {
        ICounter exercise = ICounter(address(new Exercise()));

        require(address(exercise).code.length < 1_000, "01");

        uint256 counter;

        for (uint256 idx; idx < randomness.length;) {
            uint8 impl = uint8(randomness[idx]) % 5;

            if (impl == 0) {
                Exercise(address(exercise)).setCounter(address(new Simple()));

                exercise.inc();
                unchecked {
                    ++counter;
                }
            } else if (impl == 1) {
                Exercise(address(exercise)).setCounter(address(new Double()));

                exercise.inc();
                unchecked {
                    ++counter;
                    ++counter;
                }
            } else if (impl == 2) {
                Exercise(address(exercise)).setCounter(address(new Override()));

                exercise.inc();
                counter = uint256(keccak256(abi.encodePacked(address(exercise))));
            } else if (impl == 3) {
                Exercise(address(exercise)).setCounter(address(new Mul()));

                exercise.inc();
                unchecked {
                    counter = (counter + 1) * 2;
                }
            } else if (impl == 4) {
                Exercise(address(exercise)).setCounter(address(new Div()));

                exercise.inc();
                unchecked {
                    counter = (counter - 1) / 2;
                }
            }

            unchecked {
                ++idx;
            }
        }

        (bool ok, bytes memory data) = address(exercise).staticcall(abi.encodeWithSignature("counter()"));
        require(ok, "02");
        require(data.length == 32, "03");
        (uint256 _counter) = abi.decode(data, (uint256));
        require(_counter == counter, "04");
    }
}
