// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

error ErrorTournamentIsClosed();
error ErrorTournamentAlreadyClosed();
error ErrorTournamentNotExist();
error ErrorOnlyOwnerFunction();
error ErrorListOfParticipantEmpty();

contract TournamentContract {
    address public owner;

    struct Match {
        string participant1;
        string participant2;
        int256 scoreParticipant1;
        int256 scoreParticipant2;
    }

    struct Tournament {
        uint256 tournamentId;
        string[] participants;
        Match[] matches;
        bool isOpen;
    }

    mapping(uint256 => Tournament) private allTournaments;
    uint256 public totalTournaments;

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert ErrorOnlyOwnerFunction();
        }
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createTournament(string[] memory _participants) public onlyOwner returns (uint256) {
        if (_participants.length == 0) {
            revert ErrorListOfParticipantEmpty();
        }
        
        Tournament storage newTournament = allTournaments[totalTournaments];
        newTournament.tournamentId = totalTournaments;
        newTournament.participants = _participants;
        newTournament.isOpen = true;
        totalTournaments++;

        return totalTournaments - 1;
    }

    function addMatch(uint256 _tournamentId, string memory _participant1, string memory _participant2, int256 _scoreParticipant1, int256 _scoreParticipant2) public onlyOwner {
        Tournament storage currentTournament = allTournaments[_tournamentId];
        if (!currentTournament.isOpen) {
            revert ErrorTournamentIsClosed();
        }
        if (!containsParticipant(currentTournament.participants, _participant1)) {
            revert ErrorTournamentNotExist();
        }
        if (!containsParticipant(currentTournament.participants, _participant2)) {
            revert ErrorTournamentNotExist();
        }

        Match memory newMatch = Match(_participant1, _participant2, _scoreParticipant1, _scoreParticipant2);
        currentTournament.matches.push(newMatch);
    }

    function containsParticipant(string[] memory participants, string memory participant) internal pure returns (bool) {
        for (uint256 i = 0; i < participants.length; i++) {
            if (keccak256(abi.encodePacked(participants[i])) == keccak256(abi.encodePacked(participant))) {
                return true;
            }
        }
        return false;
    }

    function closeTournament(uint256 _tournamentId) public onlyOwner {
        Tournament storage currentTournament = allTournaments[_tournamentId];
        if (_tournamentId >= totalTournaments) {
            revert ErrorTournamentNotExist();
        }
        if (!currentTournament.isOpen) {
            revert ErrorTournamentAlreadyClosed();
        }
        currentTournament.isOpen = false;
    }

    function getTournamentParticipants(uint256 _tournamentId) public view returns (string[] memory) {
        if (_tournamentId >= totalTournaments) {
            revert ErrorTournamentNotExist();
        }
        return allTournaments[_tournamentId].participants;
    }

    function getTournamentMatches(uint256 _tournamentId) public view returns (Match[] memory) {
        if (_tournamentId >= totalTournaments) {
            revert ErrorTournamentNotExist();
        }
        return allTournaments[_tournamentId].matches;
    }
}
