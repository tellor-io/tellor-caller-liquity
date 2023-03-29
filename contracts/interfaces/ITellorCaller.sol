// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;

interface ITellorCaller {
    function getTellorCurrentValue(bytes32 _queryId)
        external
        returns (
            bool ifRetrieve,
            uint256 value,
            uint256 _timestampRetrieved
        );
}