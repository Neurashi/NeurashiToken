// SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

abstract contract BEP20Basic {
    uint public totalSupply;
     function balanceOf(address who) public virtual view returns (uint256);
     function transfer(address to, uint256 value) public virtual returns(bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

abstract contract BasicToken is BEP20Basic {
    
    mapping(address => uint256) internal _balances;
    
    function  transfer(address to, uint256 value) public override validRecipient(to) returns(bool) {
        _transfer(msg.sender, to, value);
        return true;
    }
    
    function _transfer(address from, address to, uint256 value) internal {
        require(from != address(0));
        require(value > 0);
        require(_balances[from] >= value);
        _balances[from] = _balances[from] - value;
        _balances[to] = _balances[to] + value;
        emit Transfer(from, to, value);
    }

   function balanceOf(address _owner)  public override view returns(uint256) {
      return _balances[_owner];
    }

    function availableBalance(address _owner) public view returns(uint256) {
        return _balances[_owner];
    }
 
    modifier validRecipient(address _recipient) {
        require(_recipient != address(0) && _recipient != address(this));
    _;
    }
}
