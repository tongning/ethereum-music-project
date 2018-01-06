pragma solidity ^0.4.17;

contract SongComposition {
    // Note options range from 4th octave C to 5th octave E plus rest, no sharps or flats
    enum Note { C4, D4, E4, F4, G4, A4, B4, C5, D5, E5, Rest }

    // The song is a dynamic list of notes
    uint[] public song;

    // Mapping from note ID to its number of votes
    mapping(uint => uint) public votesForNextNote;

    // Track how many votes we've collected for the next note
    uint numVotesForNextNote = 0;

    function vote (uint note) public {
        require(note > 0);
        require(note < 11);

        votesForNextNote[note]++;
        numVotesForNextNote++;

        if (numVotesForNextNote >= 10) {
            addMostPopularNoteToSongIfNoTies();
        }
    }

    function addMostPopularNoteToSongIfNoTies() private {
        uint winningNoteCount = 0;
        for (uint i = 0; i < 11; i++) {
            if (votesForNextNote[i] > winningNoteCount) {
                winningNoteCount = votesForNextNote[i];
                uint winningNote = i;
            }
        }
        if (verifyNoTies(winningNoteCount)) {
            addNoteToSong(winningNote);
            resetVotes();
        }
    }

    function verifyNoTies(uint winningNoteCount) private view returns (bool){
        uint numVotesWithCount = 0;
        for (uint i = 0; i < 11; i++) {
            if (votesForNextNote[i] == winningNoteCount) {
                numVotesWithCount++;
            }
        }
        if (numVotesWithCount == 1) {
            return true;
        }
        return false;
    }

    function addNoteToSong(uint winningNote) private {
        song.length++;
        song[song.length-1] = winningNote;
    }

    function resetVotes() private {
        for (uint i = 0; i < 11; i++) {
            votesForNextNote[i] = 0;
        }
        numVotesForNextNote = 0;
    }
}