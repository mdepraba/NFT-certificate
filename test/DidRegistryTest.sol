// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {DidRegistry} from "../src/DidRegistry.sol";

contract DidRegistryTest is Test {
    DidRegistry public didRegistry;
    address public user1 = address(1);
    address public user2 = address(2);

    function setUp() public {
        didRegistry = new DidRegistry();
    }

    function testCreateDid() public {
        vm.prank(user1);
        uint256 tokenId = didRegistry.createDid(DidRegistry.DidType.Claimer, "test metadata");

        DidRegistry.DID memory _did = didRegistry.getDid(tokenId);
        assertEq(_did.owner, user1);
        assertEq(_did.metadata, "test metadata");
        assertEq(uint256(_did.didType), uint256(DidRegistry.DidType.Claimer));
    }

    function testModify() public {
        vm.prank(user1);
        uint256 tokenId = didRegistry.createDid(DidRegistry.DidType.Claimer, "test metadata");

        vm.prank(user1);
        didRegistry.modifyDid(tokenId, "new metadata");

        DidRegistry.DID memory _did = didRegistry.getDid(tokenId);
        assertEq(_did.metadata, "new metadata");
    }

    function testRevertMetadataNotModify() public {
        vm.prank(user1);
        uint256 tokenId = didRegistry.createDid(DidRegistry.DidType.Claimer, "test metadata");

        vm.expectRevert(DidRegistry.MetadataNotChange.selector);
        vm.prank(user1);

        didRegistry.modifyDid(tokenId, "test metadata");
    }

    function testRevertModifyNotOwner() public {
        vm.prank(user1);
        uint256 tokenId = didRegistry.createDid(DidRegistry.DidType.Claimer, "test metadata");

        vm.expectRevert(DidRegistry.NotOwner.selector);
        vm.prank(user2);

        didRegistry.modifyDid(tokenId, "wrong metadata");
    }
}
