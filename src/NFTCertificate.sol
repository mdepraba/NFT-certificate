// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFTCertificate is ERC721URIStorage, Ownable {
    // Custom errors
    error CannotTransfer();
    error CannotApprove();
    error CannotApprovalForAll();

    uint256 private _tokenIdCounter;

    constructor() ERC721("Made Praba Jaya Kusuma", "PRB") Ownable() {}

    event Minted(address indexed to, uint256 indexed tokenId, string uri);

    // Minting NFT with dynamic metadata
    function mintNFT(string memory name, string memory description, string memory image_url) public onlyOwner {
        uint256 tokenId = ++_tokenIdCounter;

        string memory tokenURI = _createMetadata(name, description, image_url);
        require(bytes(tokenURI).length > 0, "Token URI cannot be empty");

        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        emit Minted(msg.sender, tokenId, tokenURI);
    }

    // Create dynamic metadata for NFT
    function _createMetadata(string memory name, string memory description, string memory image_url)
        private
        pure
        returns (string memory)
    {
        string memory metadata = string(
            abi.encodePacked(
                '{"name":"', name, '",', '"description":"', description, '",', '"image":"', image_url, '"}'
            )
        );
        metadata = Base64.encode(bytes(metadata));
        return string(abi.encodePacked("data:application/json;base64,", metadata));
    }

    // Preventions
    function transferFrom(address, address, uint256) public pure override(ERC721, IERC721) {
        revert CannotTransfer();
    }

    function approve(address, uint256) public pure override(ERC721, IERC721) {
        revert CannotApprove();
    }

    function setApprovalForAll(address, bool) public pure override(ERC721, IERC721) {
        revert CannotApprovalForAll();
    }
}
