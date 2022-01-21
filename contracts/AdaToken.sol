pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract AdaToken is ERC721 {

    uint _delayDuration;
    address _owner;
    struct Token{
        uint releaseAt;
        uint tokenId;
        address owner;
    }

    mapping(uint => Token) tokens;
    mapping(address => uint) waitlist;

    uint public constant UNIQUE_TOKEN_ID_1 = 1;
    uint public constant UNIQUE_TOKEN_ID_2 = 2;
    uint public constant UNIQUE_TOKEN_ID_3 = 3;
    uint public constant UNIQUE_TOKEN_ID_4 = 4;
    uint public constant UNIQUE_TOKEN_ID_5 = 5;
    uint public constant UNIQUE_TOKEN_ID_6 = 6;
    uint public constant UNIQUE_TOKEN_ID_7 = 7;
    

    constructor(address _galleryAddress, uint delay) ERC721("Ada Token", "ADAT") {
        _owner = _galleryAddress;
        _delayDuration = delay;

        mint(msg.sender, UNIQUE_TOKEN_ID_1);
        mint(msg.sender, UNIQUE_TOKEN_ID_2);
        mint(msg.sender, UNIQUE_TOKEN_ID_3);
        mint(msg.sender, UNIQUE_TOKEN_ID_4);
        mint(msg.sender, UNIQUE_TOKEN_ID_5);
        mint(msg.sender, UNIQUE_TOKEN_ID_6);
        mint(msg.sender, UNIQUE_TOKEN_ID_7);
    }

    function mint(address _to, uint _tokenId) private {
        require(_to != address(0));
        tokens[_tokenId] = Token({releaseAt: block.timestamp + _delayDuration, tokenId: _tokenId, owner: _to});
        super._mint(_to, _tokenId);
    }

    function releaseTime(uint _tokenId) external view returns (uint) {
        return tokens[_tokenId].releaseAt;
    }

    function joinWaitlist(address user, uint tokenId) external returns(bool) {
        require(user != address(0));
        require(tokenId > 0, "Invalid tokenId");
        waitlist[user] = tokenId;
        return true;
    }

    function buy(address _newOwner, uint _tokenId) external returns (bool) {
        require(_newOwner != address(0));
        require(tokens[_tokenId].releaseAt > 0, "Token id does not exist");
        require(waitlist[_newOwner] > 0, "Please join the waitlist");
        tokens[_tokenId].owner = _newOwner;
        return true;
    }

    function transfer(address _to, uint256 _tokenId) external returns(bool) {
        require(tokens[_tokenId].releaseAt > 0);
        require(block.timestamp >= tokens[_tokenId].releaseAt, "Unable to transfer this token, please wait until it is released");
        super.safeTransferFrom(_owner, _to, _tokenId, "");
        return true;
    }

    function listTokens() external pure returns(uint[7] memory) {
        uint[7] memory arrayofint = [
            UNIQUE_TOKEN_ID_1, 
            UNIQUE_TOKEN_ID_2, 
            UNIQUE_TOKEN_ID_3, 
            UNIQUE_TOKEN_ID_4, 
            UNIQUE_TOKEN_ID_5, 
            UNIQUE_TOKEN_ID_6, 
            UNIQUE_TOKEN_ID_7
        ];
        return arrayofint;
    }

}
