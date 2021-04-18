//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

import "./interfaces/IFlashMinter.sol";

contract FlashWETH is ERC20("Flash wrapped Eth", "fWETH"){

    receive() external payable {
        deposit();
    }

    function deposit() public payable {
        _mint(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(amount);
    }

    function flashMint(address recipent, uint256 amount, bytes calldata data) external {
        IFlashMinter flashminter = IFlashMinter(recipent);
        _mint(recipent, amount);
        flashminter.onFlashMint(msg.sender, amount, data);
       _burn(recipent, amount); 
    }
}