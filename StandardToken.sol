// SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

import "./BasicToken.sol";


abstract contract IBEP20 is BEP20Basic {
    function allowance(address owner, address spender) public virtual view returns (uint256);
    function approve(address spender, uint256 value) public virtual returns (bool);
    function transferFrom(address from, address to, uint256 value) public virtual returns (bool);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


abstract contract StandardToken is IBEP20, BasicToken {
    mapping(address => mapping(address => uint256)) private _allowed;

    function approve(address spender, uint256 value) public override validRecipient(spender) returns(bool) {
        _approve(msg.sender, spender, value);
        return true;
    }
    
    function _approve(address _owner, address spender, uint256 value) private {
        _allowed[_owner][spender] = value;
        emit Approval(_owner, spender, value);
    }

    function transferFrom(address from, address to, uint256 value) public override validRecipient(to) returns(bool) {
        require(_allowed[from][msg.sender] >= value, "ERROR: transfer amount exceeds allowance");
        _transfer(from, to, value);
        _approve(from, msg.sender, _allowed[from][msg.sender] - value);
        return true;
    }

    function allowance(address _owner, address _spender) public override view returns (uint256) {
        return _allowed[_owner][_spender];
    }

    function increaseAllowance(address spender, uint256 addedValue) public validRecipient(spender) returns(bool) {
        _approve(msg.sender, spender, _allowed[msg.sender][spender] + addedValue);
        return true;
    }
    
    function decreaseAllowance(address spender, uint256 subtractValue) public validRecipient(spender) returns(bool) {
        uint256 oldValue = _allowed[msg.sender][spender];
        if(subtractValue > oldValue) {
            _approve(msg.sender, spender, 0);
        }
        else {
            _approve(msg.sender, spender, oldValue - subtractValue);
        }
        return true;
    }
}
