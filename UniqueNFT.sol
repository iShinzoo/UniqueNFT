// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";
import "@openzeppelin/contracts@4.7.3/utils/Strings.sol";

contract UniqueNFT is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private tokenIdCounter;

    uint256 public minRate = 0.00069 ether;

    constructor() ERC721("UniqueNFT", "UNF") {}

    function _baseURI() 
    internal 
    pure 
    override 
    returns (string memory) 
    {
        return "ipfs://bafybeidt5boy4ousc3jl7v6v5xvle6ybiteqduek7moil6gtzajazfxq2y/";
    }

    function safeMint()
    public 
    payable 
    {
        require(msg.value >= minRate, "Not enough Ether sent.");
        
        uint256 tokenId = tokenIdCounter.current();
        tokenIdCounter.increment();

        _safeMint(msg.sender, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId)
    internal
    override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
    public
    view
    override(ERC721, ERC721URIStorage)
    returns (string memory)
    {
        require(_exists(tokenId), "Token does not exist.");
        return string(abi.encodePacked(_baseURI(), tokenId.toString(), ".json"));
    }
}
