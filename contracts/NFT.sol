pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC721 {

    uint _delayDuration;
    address _owner;
    struct Token{
        uint releaseAt;
        uint tokenId;
        address owner;
    }

    mapping(uint => Token) tokens;
    mapping(address => uint) waitlist;

    uint public constant UNIQUE_TOKEN_1 = 1;
    uint public constant UNIQUE_TOKEN_2 = 2;
    uint public constant UNIQUE_TOKEN_3 = 3;
    uint public constant UNIQUE_TOKEN_4 = 4;
    uint public constant UNIQUE_TOKEN_5 = 5;
    uint public constant UNIQUE_TOKEN_6 = 6;
    uint public constant UNIQUE_TOKEN_7 = 7;

    constructor(address _galleryAddress, uint delay) ERC721("Ada Token", "ADAT") {
        _owner = _galleryAddress;
        _delayDuration = delay;

        mint(msg.sender, UNIQUE_TOKEN_1);
        mint(msg.sender, UNIQUE_TOKEN_2);
        mint(msg.sender, UNIQUE_TOKEN_3);
        mint(msg.sender, UNIQUE_TOKEN_4);
        mint(msg.sender, UNIQUE_TOKEN_5);
        mint(msg.sender, UNIQUE_TOKEN_6);
        mint(msg.sender, UNIQUE_TOKEN_7);
    }

    function mint(address _to, uint _tokenId) public {
        require(_to != address(0));
        tokens[_tokenId] = Token({releaseAt: block.timestamp + _delayDuration, tokenId: _tokenId, owner: _to});
        super._mint(_to, _tokenId);
    }

    function releaseTime(uint _tokenId) public view returns (uint) {
        return tokens[_tokenId].releaseAt;
    }

    function joinWaitlist(address user, uint tokenId) external returns(bool) {
        require(user != address(0));
        waitlist[user] = tokenId;
        return true;
    }

    function buy(address _newOwner, uint _tokenId) public returns (bool) {
        require(_newOwner != address(0));
        require(tokens[_tokenId].releaseAt > 0, "TokenID does not exist");
        require(waitlist[_newOwner] > 0, "Please join the waitlist");
        tokens[_tokenId].owner = _newOwner;
        return true;
    }

    function transfer(address _to, uint256 _tokenId) public returns(bool) {
        require(tokens[_tokenId].releaseAt > 0);
        require(block.timestamp >= tokens[_tokenId].releaseAt, "Unable to transfer this token yet until released");
        super.safeTransferFrom(_owner, _to, _tokenId, "");
        return true;
    }

}
