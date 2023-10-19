// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract ReiToken is Initializable, ERC20Upgradeable {
    
    function initialize(string memory name, string memory symbol) public initializer {
        __ERC20_init("ReiToken","REI");
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
    
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        return super.approve(spender, amount);
    }
}