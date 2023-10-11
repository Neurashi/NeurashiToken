// SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

import "./SmartToken.sol";

contract NeurashiToken is SmartToken {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    constructor()  {
        _name = "Neurashi";
        _symbol = "NEI";
        _decimals = 18;
        address account = msg.sender;
        uint256 amount = 45000000000e18;
        totalSupply = totalSupply + amount;
        _balances[account] = _balances[account] + amount;
        emit Transfer(address(0), account, amount);
    }

    function name() public view returns(string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }
    
}