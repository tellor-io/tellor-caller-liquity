// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;

import "./interfaces/ITellorCaller.sol";
import "./interfaces/ITellor.sol";
/*
* This contract serves as an example of how to integrate the Tellor oracle into a Liquity-like system. It
* utilizes a best practice for using Tellor by implementing a time buffer. In addition, by caching the most 
* recent value and timestamp, it also seeks to limit dispute attacks.
* 
* This contract has a single external function that calls Tellor: getTellorCurrentValue(). 
*
* The function is called by the Liquity contract PriceFeed.sol. If any of its inner calls to Tellor revert, 
* this function will revert, and PriceFeed will catch the failure and handle it accordingly.
*
*/
contract TellorCaller is ITellorCaller {
    ITellor public tellor;

    mapping (bytes32 => uint256) public lastStoredTimestamps;
    mapping (bytes32 => uint256) public lastStoredPrices;

    constructor (address payable _tellorOracleAddress) public {
        tellor = ITellor(_tellorOracleAddress);
    }

    /*
    * getTellorCurrentValue(): retrieves most recent value with a 20 minute time buffer.
    * This buffer can be updated before deployment.
    *
    * @dev Allows the user to get the latest value with a time buffer for the queryId specified
    * @param _queryId is the queryId to look up the value for
    * @return ifRetrieve bool true if it is able to retrieve a value and the value's timestamp
    * @return value the value retrieved, converted from bytes to a uint256 value
    * @return _timestampRetrieved the value's timestamp
    */
    function getTellorCurrentValue(bytes32 _queryId)
        external
        override
        returns (
            bool ifRetrieve,
            uint256 value,
            uint256 _timestampRetrieved
        )
    {
        // retrieve most recent 20+ minute old value for a queryId. the time buffer allows time for a bad value to be disputed
        (, bytes memory data, uint256 timestamp) = tellor.getDataBefore(_queryId, block.timestamp - 20 minutes);
        uint256 _value = abi.decode(data, (uint256));
        if (timestamp == 0 || _value == 0) return (false, _value, timestamp);
        if (timestamp > lastStoredTimestamps[_queryId]) {
            lastStoredTimestamps[_queryId] = timestamp;
            lastStoredPrices[_queryId] = _value;
            return (true, _value, timestamp);
        } else {
            return (true, lastStoredPrices[_queryId], lastStoredTimestamps[_queryId]);
        }
    }
}
