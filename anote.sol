// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Anote is ERC20PresetMinterPauser, Ownable {
    string _to;
    mapping(address => bool) _withdraws;

    constructor() ERC20PresetMinterPauser("Anote", "ANOTE") {
        // _owner = payable(address(bytes20(bytes("0x32DdA6597AfD12268968a637EC00a56f466509B2"))));
    }

    function decimals() public view virtual override returns (uint8) {
        return 8;
    }

    function forward(string calldata to, uint256 amount) external {
        burn(amount);
        _to = to;
    }

    function withraw() public payable  {
        require(msg.value == 1000000 gwei, "Required fee is 0.001.");
        _withdraws[msg.sender] = true;
        address payable owner = payable(owner());
        owner.transfer(msg.value);
    }

    function withdrawExists(address addr) external view returns(bool)  {
        return _withdraws[addr];
    }

    function rmWithdraw(address addr) public {
        require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        _withdraws[addr] = false;
    }
}