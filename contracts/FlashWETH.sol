//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '@openzepellin/contracts/token/ERC20/ERC20.sol';

contract FlashWETH is ERC20("Flash wrapped Eth", "fWETH"){

    receive() external payable {
        deposit();
    }

    function deposit() payable {
        _mint(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(msg.sender, amount);
    }

    function flashMint(type name) {
        
    }
}