pragma solidity >=0.4.22;

contract registerNode {
    mapping (address => bool) registeredNode;
    address[] public registeredNodes;

    constructor() public payable  {
    }

    function register() public payable{
        require(msg.value > .01 ether);
        registeredNode[msg.sender] = true;
        registeredNodes.push(msg.sender);
    }

    //ensure that only registered nodes can generate power transaction in the power grid
    modifier onlyRegisteredMeters {
        require (registeredNode[msg.sender] == true);
        _;
    }
}
