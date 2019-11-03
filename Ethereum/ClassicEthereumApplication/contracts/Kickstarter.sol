/*
    A contributor can vote only 1 time.
    Voting systems resilient to large voters. 
*/   

pragma solidity ^0.4.17; 

contract Kickstarter{
    
    struct Request {
        string description; 
        uint value;
        address recipient; 
        bool complete;                         // To make sure that once a request is complete, people can't approve again. 
        uint approvalCount;                    // Count of people that approved the request. 
        mapping(address => bool) approvals;    // Whether a voter, has voted yet. 
    } 
    
    Request[] public requests; 
    address public manager; 
    uint public minimumContribution = 100 wei; 
    mapping(address => bool) public approvers;
    uint public approversCount;            // How many people have joined in. 
    
    
    modifier restricted() {
        require(msg.sender == manager);  
        _; 
    }
     
    function Kickstarter() public {
        manager = msg.sender; 
    } 
    
    function contribute() public payable {
        require(msg.value > minimumContribution); 
        
        approvers[msg.sender] = true;
        approversCount++; 
    }
    
    function createRequest(string description, uint value, address recipient) public restricted {
    Request memory newRequest = Request({
       description: description,
       value: value,
       recipient: recipient,
       complete: false, 
       approvalCount: 0
    }); 

    requests.push(newRequest);
}
    
    function approveRequest(uint index) public {
        Request storage request = requests[index]; // That particular sender is saved in request. 
        
        require(approvers[msg.sender]); // Sender has to be a contributer. 
        require(!requests[index].approvals[msg.sender]);  // If sender has already voted. 
        
        request.approvals[msg.sender] = true;
        request.approvalCount++; 
    } 
    
    function finalizeRequest(uint index) public restricted {
        Request storage request = requests[index]; 
        
        require(request.approvalCount > (approversCount / 2)); 
        require(!request.complete); 
        
        request.recipient.transfer(request.value); 
        request.complete = true; 
    }
      
    
}