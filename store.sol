// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

contract AnoteStore {

    uint256 nodePrice;

    function mintNode(uint256 amount) public payable {
        require(msg.value == _withdrawFee * _withdrawCount[msg.sender], "Fee is required.");
        
        address payable owner = payable(owner());
        owner.transfer(msg.value);

        if (_withdraws[msg.sender] > 0) {
            _mint(msg.sender, _withdraws[msg.sender]);
            _withdraws[msg.sender] = 0;
            _withdrawCount[msg.sender] = 0;
        }
    }

}