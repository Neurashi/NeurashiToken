// SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

import "./StandardToken.sol";


abstract contract IBEP677 is IBEP20 {
    function transferAndCall(address receiver, uint value, bytes memory data) public virtual returns (bool success);
    event Transfer(address indexed from, address indexed to, uint256 value, bytes data);
}

abstract contract BEP677Receiver {
    function onTokenTransfer(address _sender, uint _value, bytes memory _data) public virtual;
}

abstract contract SmartToken is IBEP677, StandardToken {
    
    modifier notContract() {
        require((!_isContract(msg.sender)) && (msg.sender == tx.origin), "contract not allowed");
        _;
    }
    
    function transferAndCall(address _to, uint256 _value, bytes memory _data) public override notContract validRecipient(_to) returns(bool success) {
        _transfer(msg.sender, _to, _value);
        emit Transfer(msg.sender, _to, _value, _data);
        if (_isContract(_to)) {
            contractFallback(_to, _value, _data);
        }
        return true;
    }

    function contractFallback(address _to, uint _value, bytes memory _data) private {
        BEP677Receiver receiver = BEP677Receiver(_to);
        receiver.onTokenTransfer(msg.sender, _value, _data);
    }

    function _isContract(address addr) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(addr)
        }
        return size > 0;
    }
    
}
