// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract TokenAirdrop is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    ERC20Upgradeable public token;
    mapping(address => uint256) private _whitelist;  // Updated the datatype from uint8 to uint256 for more flexible token amounts
    
    event Whitelisted(address indexed account, uint256 allowedAmount);
    event TokensDistributed(address indexed to, uint256 amount);

    function initialize(ERC20Upgradeable _token, address initialOwner) public initializer {
        __Ownable_init(initialOwner);
        token = _token;
    }

    function setWhiteList(address[] calldata addresses, uint256[] calldata amounts) external onlyOwner {
        require(addresses.length == amounts.length, "Addresses and amounts length mismatch");
        
        for (uint256 i = 0; i < addresses.length; i++) {
            _whitelist[addresses[i]] = amounts[i];
            emit Whitelisted(addresses[i], amounts[i]);
        }
    }

    function allowedToReceive(address account) external view returns (uint256) {
        return _whitelist[account];
    }

    function distributeTokens(address[] calldata recipients) external onlyOwner {
        for (uint256 i = 0; i < recipients.length; i++) {
            uint256 amount = _whitelist[recipients[i]];
            require(amount > 0, "Recipient is not whitelisted or has already received tokens");
            
            _whitelist[recipients[i]] = 0;  // Mark the tokens as distributed
            require(token.transferFrom(msg.sender, recipients[i], amount), "Transfer of tokens failed");
            
            emit TokensDistributed(recipients[i], amount);
        }
    }

    function _authorizeUpgrade(address) internal override onlyOwner {}
}
