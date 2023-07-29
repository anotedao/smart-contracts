// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Anote is ERC20PresetMinterPauser, Ownable {
    mapping(address => uint256) _withdraws;

    constructor() ERC20PresetMinterPauser("Anote", "ANOTE") {
        // _owner = payable(address(bytes20(bytes("0x32DdA6597AfD12268968a637EC00a56f466509B2"))));
    }

    function decimals() public view virtual override returns (uint8) {
        return 8;
    }

    function deposit(string calldata to, uint256 amount) public returns(string calldata) {
        burn(amount);
        return to;
    }

    function withdraw() public payable {
        require(msg.value == 1000000 gwei, "Required fee is 0.001.");
        
        address payable owner = payable(owner());
        owner.transfer(msg.value);

        if (_withdraws[msg.sender] > 0) {
            _mint(msg.sender, _withdraws[msg.sender]);
            _withdraws[msg.sender] = 0;
        }
    }

    function withdrawExists(address addr) public view returns(bool)  {
        return _withdraws[addr] > 0;
    }

    function addWithdraw(address addr, uint256 amount) public {
        require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        _withdraws[addr] = amount;
    }

    function rmWithdraw(address addr) public {
        require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        _withdraws[addr] = 0;
    }
}