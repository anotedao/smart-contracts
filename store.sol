// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract AnoteNodeStore {

    address private _owner;
    uint256 nodePrice;
    uint8 nodeTier;

    constructor() {
        nodePrice = 50000000 gwei;
        nodeTier = 10;
        _owner = msg.sender;
    }

    function mintNode(string calldata addr) public payable returns(string calldata) {
        payable(_owner).transfer(msg.value);
        return addr;
    }

}