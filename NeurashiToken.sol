// SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

import "./SmartToken.sol";

contract NeurashiToken is SmartToken {
    string private constant _name = "Neurashi";
    string private constant _symbol = "NEI";
    uint8 private immutable _decimals = 18;
    
    constructor()  {
        address account = msg.sender;
        uint256 amount = 45000000000e18;
        totalSupply = totalSupply + amount;
        _balances[account] = _balances[account] + amount;
        emit Transfer(address(0), account, amount);
    }

    function name() public pure returns(string memory) {
        return _name;
    }

    function symbol() public pure returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint8) {
        return _decimals;
    }
    
}
