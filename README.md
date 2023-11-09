# Tournament Contract Documentation

## Overview

This documentation provides a concise explanation of the `TournamentContract` smart contract. The contract facilitates the creation and management of tournaments, allowing the owner to add matches, close tournaments, and retrieve information about participants and matches.

## Contract Structure

The contract consists of state variables, structs, a mapping, and several functions:

- State Variables:
  - `owner`: Address of the contract owner.

- Structs:
  - `Match`: Represents a match between two participants, including scores.
  - `Tournament`: Defines the structure of a tournament, including an ID, participants, matches, and openness status.

- Mapping:
  - `allTournaments`: Maps tournament IDs to their respective details.

## Modifiers

### `onlyOwner`

This modifier restricts access to functions to only the owner of the contract. Unauthorized access results in the `ErrorOnlyOwnerFunction` error.

## Functions

### Constructor

#### `constructor()`

- **Access:** Public
- **Description:** Initializes the contract and sets the deployer's address as the owner.

### `createTournament(string[] memory _participants)`

- **Access:** Public, onlyOwner
- **Parameters:** Array of participant names (`_participants`).
- **Returns:** ID of the newly created tournament.
- **Description:** Creates a new tournament with the provided participants.

### `addMatch(uint256 _tournamentId, string memory _participant1, string memory _participant2, int256 _scoreParticipant1, int256 _scoreParticipant2)`

- **Access:** Public, onlyOwner
- **Parameters:** Tournament ID, participant names, and match scores.
- **Description:** Adds a match to the specified tournament.

### `containsParticipant(string[] memory participants, string memory participant)`

- **Access:** Internal, pure
- **Parameters:** Array of participant names (`participants`), participant name to check (`participant`).
- **Returns:** Boolean indicating if the participant exists.
- **Description:** Internal function to check if a participant exists in an array.

### `closeTournament(uint256 _tournamentId)`

- **Access:** Public, onlyOwner
- **Parameters:** Tournament ID.
- **Description:** Closes the specified tournament, preventing further modifications.

### `getTournamentParticipants(uint256 _tournamentId)`

- **Access:** Public, view
- **Parameters:** Tournament ID.
- **Returns:** Array of participant names in the specified tournament.
- **Description:** Retrieves the participants of the specified tournament.

### `getTournamentMatches(uint256 _tournamentId)`

- **Access:** Public, view
- **Parameters:** Tournament ID.
- **Returns:** Array of matches in the specified tournament.
- **Description:** Retrieves the matches of the specified tournament.