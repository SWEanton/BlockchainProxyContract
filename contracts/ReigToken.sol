// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract REIGToken is Initializable, ERC20Upgradeable {
    function initialize() public initializer {
        __ERC20_init("REIG Token", "REIG");
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}