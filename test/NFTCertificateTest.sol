// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/NFTCertificate.sol";

contract NFTCertificateTest is Test {
    NFTCertificate nft;
    address owner = address(0x1);
    address nonOwner = address(0x2);
    string base64Image = "testImageBase64";

    function setUp() public {
        vm.prank(owner);
        nft = new NFTCertificate();
    }

    function testMintNFT() public {
        vm.prank(owner);
        nft.mintNFT(base64Image);
        
        assertEq(nft.ownerOf(1), owner);
        assertTrue(bytes(nft.tokenURI(1)).length > 0);
    }

    function test_RevertWhen_NonOwnerMintsNFT() public {
        vm.prank(nonOwner);
        vm.expectRevert("Ownable: caller is not the owner");
        nft.mintNFT(base64Image);
    }

    function testCannotTransferNFT() public {
        vm.prank(owner);
        nft.mintNFT(base64Image);

        vm.expectRevert(NFTCertificate.CannotTransfer.selector);
        nft.transferFrom(owner, nonOwner, 1);
    }

    function testCannotApproveNFT() public {
        vm.prank(owner);
        nft.mintNFT(base64Image);

        vm.expectRevert(NFTCertificate.CannotApprove.selector);
        nft.approve(nonOwner, 1);
    }

    function testCannotSetApprovalForAll() public {
        vm.expectRevert(NFTCertificate.CannotApprovalForAll.selector);
        nft.setApprovalForAll(nonOwner, true);
    }
}
