//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IFlashMinter.sol";

contract FlashMinter is IFlashMinter {
    uint256 public totalBorrowed;
    address private immutable _controller;
    address private immutable _fWETH;

    constructor(address fWETH){
        _fWETH = fWETH;
        _controller = msg.sender;
    }

    function onFlashMint(address sender, uint256 amount, bytes calldata data) external override {
        require(msg.sender ==_fWETH, "msg sender does not matches _fWETH address");
        require(sender == _controller, "sender and controller should match");
        totalBorrowed += amount;
    }

}