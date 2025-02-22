// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {NFTCertificate} from "../src/NFTCertificate.sol";

contract DeployNFTCertificate is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy NFTCertificate contract
        NFTCertificate nftCertificate = NFTCertificate(0xb136E5F8Ddf6f62d9f4a3d04B1Ac1c1DC9399835);
        nftCertificate.mintNFT("");

        vm.stopBroadcast();
    }
}
