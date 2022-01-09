// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./TrooperzTypes.sol";
import "./libraries/TrooperzLibrary.sol";

contract TrooperzBase is ERC721URIStorage, Ownable, TrooperzTypes {
    using Counters for Counters.Counter;
    // define the token name
    string constant TOKEN_NAME = "Trooperz";
    // define the token name
    string constant TOKEN_NAME_CODE = "TRPZ";
    // define the max supply to be minted
    uint256 public constant maxSupply = 5000;
    // a tot of token reserved for team
    uint256 private _reserved = 100;

    // all Trooperz
    mapping(uint256 => Trooperz) public trooperzs;

    // mapping all traits
    mapping(Category => Trait[]) traits;

    // define id of the Trait
    Counters.Counter internal _traitIds;
    // define id of the Trooperz
    Counters.Counter internal _trooperzIds;

    // event is emitted when a new Trait is created
    event NewTrait(
        uint256 _id,
        Category _category,
        string _name,
        Season _season,
        string _svg
    );

    // event is emitted when a new Trooperz is created
    event NewTrooperz(address sender, uint256 id);

    constructor() ERC721(TOKEN_NAME, TOKEN_NAME_CODE) {
        console.log("constructor: Trooperz Token");
    }

    /**
     *   @notice Create a Trait and save it to traits arrays of TrooperzBase contract
     */
    function createTrait(
        Category _category,
        string memory _name,
        Season _season,
        string memory _svg
    ) public onlyOwner returns (uint256) {
        // require(uint8(_category) > 0);
        require(bytes(_name).length > 0);
        // require(uint8(_season) > 0);
        require(bytes(_svg).length > 0);

        // get the current trait ID by incrementing ids variable
        uint256 newTraitId = _traitIds.current();

        // creating new Trait
        Trait memory t = Trait({
            id: newTraitId,
            category: _category,
            name: _name,
            season: _season,
            svg: _svg
        });

        console.log("[TrooperzBase] created trait id: %s", t.id);

        // insert new trait into array of traits
        // index value is based on trait's category
        traits[_category].push(t);
        console.log("[TrooperzBase] traits size:", traits[_category].length);

        // send the new Trait event
        emit NewTrait(newTraitId, _category, _name, _season, _svg);

        //increament trait ids
        _traitIds.increment();

        return newTraitId;
    }

    /**
     *  @notice Return a Trait from a given Trait ID
     */
    function getTraitNameByCategoryAndId(Category _category, uint256 _traitId)
        public
        view
        returns (string memory)
    {
        require(_traitId >= 0);
        require(uint8(_category) >= 0);

        Trait memory trait = traits[_category][_traitId];
        return trait.name;
    }

    /**
     *   @notice Clear the traits
     */
    function clearTraits(Category _category) public onlyOwner {
        require(uint8(_category) >= 0);
        delete traits[_category];
    }

    function pickTraitFromCategory(Category _category, uint256 trooperzId)
        internal
        view
        returns (Trait memory)
    {
        //getting a random trait for the category passed as a param
        uint256 size = traits[_category].length;
        console.log(
            "[TrooperzBase] n.%s traits from category %s",
            size,
            uint8(_category)
        );
        uint256 random = TrooperzLibrary.generateRandom(trooperzId, size);

        Trait memory t = traits[_category][random];
        console.log("[TrooperzBase] picked trait id: %s", t.id);
        return t;
    }

    function generateTrooperz(uint256 trooperzId)
        internal
        view
        returns (uint256)
    {
        Trait memory headTrait = pickTraitFromCategory(
            Category.HAT,
            trooperzId
        );
        Trait[] memory genTraits = new Trait[](1);
        genTraits[uint8(Category.HAT)] = headTrait;

        string memory traitsSVG = string(abi.encodePacked(headTrait.svg));

        // creating Trooperz svg string
        string memory trooperzSVG = TrooperzLibrary.generateSVG(traitsSVG);

        // creating Trooperz object
        Trooperz memory trpz = trooperzs[trooperzId];
        trpz.id = trooperzId;
        trpz.tokenURI = "";
        trpz.traits = genTraits;
        trpz.svg = trooperzSVG;

        console.log("[TrooperzBase] created id: %s", trpz.id);
        return trpz.id;
    }

    function mintTrooperz() public returns (uint256) {
        // get the current trait ID
        uint256 newTrooperzId = _trooperzIds.current();
        require(newTrooperzId < maxSupply);

        generateTrooperz(newTrooperzId);

        // send the new Trait event
        emit NewTrooperz(msg.sender, newTrooperzId);

        //incrementing trooperz ids
        _trooperzIds.increment();
        console.log("[TrooperzBase] ---> Trooperz minted #%s", newTrooperzId);
        return newTrooperzId;
    }
}
