// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(address => bool) public hasVoted;
    mapping(string => uint) public votes;
    string[] public candidates;

    constructor(string[] memory _candidates) {
        candidates = _candidates;
    }

    function vote(string memory candidate) public {
        require(!hasVoted[msg.sender], "You have already voted.");
        bool isValidCandidate = false;

        for(uint i = 0; i < candidates.length; i++) {
            if(keccak256(bytes(candidates[i])) == keccak256(bytes(candidate))) {
                isValidCandidate = true;
                break;
            }
        }

        require(isValidCandidate, "Not a valid candidate.");
        votes[candidate]++;
        hasVoted[msg.sender] = true;
    }

    function getCandidates() public view returns (string[] memory) {
        return candidates;
    }

    function getVotes(string memory candidate) public view returns (uint) {
        return votes[candidate];
    }
}