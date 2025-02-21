// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {NFTCertificate} from "../src/NFTCertificate.sol";

contract DeployNFTCertificate is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy NFTCertificate contract
        NFTCertificate nftCertificate = new NFTCertificate();
        nftCertificate.mintNFT(
            "Mandala Academy NFT #1",
            "A certificate NFT that student already completed the course",
            "https://ipfs.io/ipfs/bafkreigxnhhmoeyg5vjfcrlr4yluostuxuivpehn77i5uzt4uc4e5zdp2i"
        );

        vm.stopBroadcast();
    }
}
