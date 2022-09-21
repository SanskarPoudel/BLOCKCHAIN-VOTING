// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract evoting {

    struct Voter {
        address id;
        string fname;
        string lname;
        string email;
        uint256 dob;
        string mobile;
        string uidai;
        string role;
        bool verified;
        bool voted;
        uint256 vote;
    }

    struct VoterMap {
        address[] keys;
        mapping(address => Voter) values;
        mapping(address => uint256) indexOf;
        mapping(address => bool) inserted;
    }

    VoterMap private voterMap;


    function voterMapSet(address key, Voter memory val) private {
        if (voterMap.inserted[key]) {
            voterMap.values[key] = val;
        } else {
            voterMap.inserted[key] = true;
            voterMap.values[key] = val;
            voterMap.indexOf[key] = voterMap.keys.length;
            voterMap.keys.push(key);
        }
    }

    function voterMapRemove(address key) private {
        if (!voterMap.inserted[key]) {
            return;
        }
        delete voterMap.inserted[key];
        delete voterMap.values[key];

        uint256 index = voterMap.indexOf[key];
        uint256 lastIndex = voterMap.keys.length - 1;
        address lastKey = voterMap.keys[lastIndex];

        voterMap.indexOf[lastKey] = index;
        delete voterMap.indexOf[key];
        voterMap.keys[index] = lastKey;
        voterMap.keys.pop();
    }

    address admin;

    struct Team {
        string representative;
        string description;
        string teamName;
        uint256 voteCount;
    }

    Team[] public teams;
    event AddVoter(Voter _voter);
    constructor(
        string memory fname,
        string memory lname,
        string memory email,
        uint256 dob,
        string memory mobile,
        string memory uidai
    ) {
        admin = msg.sender;
        Voter memory voter = Voter(
            admin,
            fname,
            lname,
            email,
            dob,
            mobile,
            uidai,
            "admin",
            true,
            false,
            0
        );
        voterMapSet(admin, voter);
    }

    event AddTeam(Team _team);

    function addTeam(
        string memory representative,
        string memory description,
        string memory teamName
    ) public {
        require(msg.sender == admin, "Only admin can add new teams");
        teams.push(
            Team({
                representative: representative,
                description: description,
                teamName: teamName,
                voteCount: 0
            })
        );
        emit AddTeam(teams[teams.length - 1]);
    }

    event Register(Voter _voter);

    function register(
        string memory fname,
        string memory lname,
        string memory email,
        uint256 dob,
        string memory mobile,
        string memory uidai
    ) public {
        address sender = msg.sender;
        Voter memory voter = Voter(
            sender,
            fname,
            lname,
            email,
            dob,
            mobile,
            uidai,
            "user",
            false,
            false,
            0
        );
        voterMapSet(sender, voter);
        emit Register(voter);
    }

    function getTeams() public view returns (Team[] memory) {
        return teams;
    }

    function getVoter() public view returns (Voter memory) {
        return voterMap.values[msg.sender];
    }

    event Vote(Voter _voter);

    function vote(uint256 to) public {
        Voter storage voter = voterMap.values[msg.sender];

        require(voter.verified, "You are not eligible to give vote.");
        require(!voter.voted, "You are already voted.");

        voter.voted = true;
        voter.vote = to;
        teams[to].voteCount += 1;
        emit Vote(voter);
    }

    function getUnverifiedVoter() public view returns (Voter[] memory) {
        uint256 counter = 0;

        for (uint256 i = 0; i < voterMap.keys.length; i++) {
            Voter memory item = voterMap.values[voterMap.keys[i]];
            if (!item.verified) counter++;
        }

        Voter[] memory voters = new Voter[](counter);
        uint256 j = 0;
        for (uint256 i = 0; i < voterMap.keys.length; i++) {
            Voter memory item = voterMap.values[voterMap.keys[i]];
            if (!item.verified) {
                voters[j] = item;
                j++;
            }
        }
        return voters;
    }

    event VerifyVoter(string _message);

    function verifyVoter(address _address) public {
        require(msg.sender == admin, "Only admin can verify voter");
        Voter storage voter = voterMap.values[_address];
        voter.verified = true;
        emit VerifyVoter("Voter update success");
    }

    function getWinnerIndex() private view returns (uint256 _winner) {
        uint256 maxVote = 0;
        for (uint256 i = 0; i < teams.length; i++) {
            if (teams[i].voteCount > maxVote) {
                maxVote = teams[i].voteCount;
                _winner = i;
            }
        }
    }

    function getWinner() public view returns (Team memory _winner) {
        require(teams.length != 0, "There is no teams added yet");
        _winner = teams[getWinnerIndex()];
    }
}
