//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Keith {
    uint256 public count = 0; 

    struct pages {
        string timestamp;
        string text;
    }

    struct diary {
        address user;
        uint256 index;
        pages[] pageList;
    }

    mapping(address => diary) public diaries;
    mapping(address => bool) public doesExist;

    function createBlankDiary() public {
        require(!doesExist[msg.sender], "Address aldready exists");
        count += 1;
        pages[] memory myPages;
        diaries[msg.sender] = diary(msg.sender, count+1, myPages);
        doesExist[msg.sender] = true;
    }
}