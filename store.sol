// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

contract AnoteNodeStore {

    address private _owner;
    uint256 nodePrice;
    uint8 nodeTier;

    constructor() {
        nodePrice = 50000000 gwei;
        nodeTier = 10;
        _owner = msg.sender;
    }

    function mintNode(string calldata addr) public payable {
        payable(_owner).transfer(msg.value);
    }

}