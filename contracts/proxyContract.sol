// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract ProxyContract is UUPSUpgradeable, OwnableUpgradeable {
    uint256 public delay;
    uint256 public lastUpdated;
    address public pendingImplementation;
    address public proxyAdmin;

    function initialize(address initialOwner, uint256 _delay) public initializer {
        __Ownable_init();
        __UUPSUpgradeable_init();

        transferOwnership(initialOwner);
        delay = _delay;
        lastUpdated = block.timestamp;
    }

    function setPendingImplementation(address newPendingImplementation) public onlyOwner {
        pendingImplementation = newPendingImplementation;
        lastUpdated = block.timestamp;
    }

    function _beforeFallback() internal {
        require(msg.sender == address(this), "Fallback only allowed from proxy");
        super._beforeFallback();
    }

    function _upgradeTo(address newImplementation) internal {
        pendingImplementation = newImplementation;
    }

    function _finishUpgrade() internal {
        pendingImplementation = address(0);
        super._finishUpgrade();
    }

    function _getImplementation() internal view returns (address) {
        return pendingImplementation;
    }

    function _setImplementation(address newImplementation) internal {
        pendingImplementation = newImplementation;
    }

    function _getAdmin() internal view returns (address) {
        return owner();
    }

    function _setAdmin(address newAdmin) internal {
        transferOwnership(newAdmin);
    }

    function _willFallback() internal {
        require(msg.sender == address(this), "Fallback only allowed from proxy");
        super._willFallback();
    }

    // Add other proxy-specific methods or overrides as necessary
}

    function _beforeFallback() internal {
        require(msg.sender == address(this), "Fallback only allowed from proxy");
        super._beforeFallback();
    }

    function _upgradeTo(address newImplementation) internal {
        pendingImplementation = newImplementation;
    }

    function _finishUpgrade() internal {
        pendingImplementation = address(0);
        super._finishUpgrade();
    }

    function _getImplementation() internal view returns (address) {
        return pendingImplementation;
    }

    function _setImplementation(address newImplementation) internal {
        pendingImplementation = newImplementation;
    }

    function _getAdmin() internal view returns (address) {
        return owner();
    }

    function _setAdmin(address newAdmin) internal {
        transferOwnership(newAdmin);
    }

    function _willFallback() internal {
        require(msg.sender == address(this), "Fallback only allowed from proxy");
        super._willFallback();
    }

    // Add other proxy-specific methods or overrides as necessary
    function _authorizeUpgrade(address newImplementation) internal onlyOwner override {
        require(pendingImplementation == address(0) || newImplementation == pendingImplementation, "Cannot upgrade to the same implementation");
        super._authorizeUpgrade(newImplementation);
    }
}