//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract keithV2 {

    struct page {
        string text;
        uint256 timestamp;
        string heading;
    }

    struct diary {
        address user;
        string name;
        uint256 timestamp;
        uint16 countPages;
    }

    mapping(address => diary) public diaries;
    mapping(address => page[]) public pages;
    mapping(address => bool) public doesExist;

    function createBlankDiary(string memory name) public {
        require(!doesExist[msg.sender], "You aldready have a diary");
        diaries[msg.sender] = diary({
            user: msg.sender,
            name: name,
            timestamp: block.timestamp,
            countPages: 1
        });
        pages[msg.sender].push(page("Hello", block.timestamp, "Byee"));
        doesExist[msg.sender] = true;
    }

    function addPage(string memory text, string memory heading) public {
        diaries[msg.sender].countPages += 1;
        pages[msg.sender].push(page(text, block.timestamp, heading));
    }

    function deletePage(string memory heading) public {
        for(uint i = 0; i < pages[msg.sender].length; i++){
            if(keccak256(abi.encodePacked(pages[msg.sender][i].heading)) == keccak256(abi.encodePacked(heading))){
                delete pages[msg.sender][i];
                diaries[msg.sender].countPages -= 1;
                break;
            }
        }
    }

    function editPage(string memory heading, string memory text) public {
        for(uint i = 0; i < pages[msg.sender].length; i++){
            if(keccak256(abi.encodePacked(pages[msg.sender][i].heading)) == keccak256(abi.encodePacked(heading))){
                pages[msg.sender][i].text = text;
            }
        }
    }
}