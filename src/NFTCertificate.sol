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

    event Minted(address indexed to, uint256 indexed tokenId, string uri);

    constructor() ERC721("Made Praba Jaya Kusuma", "PRB") {}

    function _createMetadata(string memory base64Image, uint256 certificateId) private pure returns (string memory) {
        bytes memory metadata = abi.encodePacked(
            "{",
            '"name": "#Praba from Mandala Academy#',
            Strings.toString(certificateId),
            '", ',
            '"description": "A certificate NFT that student already completed the course", ',
            '"image_url": "',
            "https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i",
            base64Image,
            '"',
            "}"
        );

        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(metadata)));
    }
    // Minting NFT with dynamic metadata

    function mintNFT(string memory base64Image) public onlyOwner {
        uint256 tokenId = ++_tokenIdCounter;

        string memory tokenURI = _createMetadata(base64Image, tokenId);
        require(bytes(tokenURI).length > 0, "Token URI cannot be empty");

        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        emit Minted(msg.sender, tokenId, tokenURI);
    }

    // Create dynamic metadata for NFT

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
