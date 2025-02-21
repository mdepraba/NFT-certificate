// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721, ERC721URIStorage} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract Counter is ERC721{
    constructor() ERC721("Made Praba Jaya Kusuma", "MPJK") {}
}
