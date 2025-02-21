// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721URIStorage} from "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract NFTCertificate is ERC721URIStorage {
    uint265 private _tokenId;
    constructor() ERC721("Made Praba Jaya Kusuma", "PRB") {}

    event minted(uint256 indexed tokenId, address indexed owner, string uri);


    function createMetadata(string memory base64Image) private pure returns (string memory) {
        return string(abi.encodePacked("data:image/png;base64,", base64Image));
    }

    function mintNFT(address owner, string memory name, string memory description, string memory imageUrl) public onlyOwner{
        uint256 tokenId = _tokenId++;

        string memory metadata = string(abi.encodePacked(
            '{"name":"', name, '",',
            '"description":"', description, '",',
            '"image":"', imageUrl, '"}'
        ));
        string memory tokenURI = string(abi.encodePacked("data:application/json;base64,", base64(bytes(metadata))));

        _mint(owner, tokenId);
        _setTokenURI(tokenId, tokenURI);
        emit minted(tokenId, owner, tokenURI);
    }



    function _transfer(address from, address to, uint256 tokenId) internal virtual override {
        require(from == address(0) || to == address(0), "Soulbound token: transfer is not allowed.");
        super._transfer(from, to, tokenId);
    }
}
