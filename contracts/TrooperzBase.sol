// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./TrooperzTypes.sol";

contract TrooperzBase is ERC721URIStorage, Ownable, TrooperzTypes {
    // define the token name
    string public constant TOKEN_NAME = "Trooperz";
    // define the token name
    string public constant TOKEN_NAME_ABR = "TRPZ";
    // define the max supply to be minted
    uint256 public constant maxSupply = 5000;
    // a tot of token reserved for team
    uint256 private _reserved = 100;

    // all Trooperz
    Trooperz[] internal trooperzs;

    // mapping all traits
    // [0] hat
    // [1] eyes
    mapping(uint256 => Trait[]) public traits;

    constructor() ERC721(TOKEN_NAME, TOKEN_NAME_ABR) {
        console.log("constructor: Trooperz Token");
    }
}
