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
    string public constant TOKEN_NAME = "Trooperz";
    // define the token name
    string public constant TOKEN_NAME_ABR = "TRPZ";
    // define the max supply to be minted
    uint256 public constant maxSupply = 5000;
    // a tot of token reserved for team
    uint256 private _reserved = 100;

    // all Trooperz
    // Trooperz[] internal trooperzs;
    mapping(uint256 => Trooperz) trooperzs;

    // mapping all traits
    // [0] hat
    // [1] eyes
    mapping(uint256 => Trait[]) public traits;

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

    constructor() ERC721("Trooperz", "TRPZ") {
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
        // require(_category.length > 0);
        require(bytes(_name).length > 0);
        // require(_season.length > 0);
        require(bytes(_svg).length > 0);

        // get the current trait ID by incrementing ids variable
        uint256 newTraitId = _traitIds.current();

        // creating new Trait
        Trait memory t = Trait(newTraitId, _category, _name, _season, _svg);
        console.log("[TrooperzTraitFactory] created trait id: %s", t.id);

        // insert new trait into array of traits
        // index value is based on trait's category
        traits[uint8(_category)].push(t);
        console.log(
            "[TrooperzTraitFactory] traits size:",
            traits[uint8(_category)].length
        );

        // send the new Trait event
        emit NewTrait(newTraitId, _category, _name, _season, _svg);

        //increament trait ids
        _traitIds.increment();

        return newTraitId;
    }

    /**
     *  @notice Return a Trait from a given Trait ID
     */
    function getTraitById(uint8 _category, uint256 _traitId)
        internal
        view
        returns (Trait memory)
    {
        require(_traitId >= 0);
        require(_category >= 0);

        Trait memory trait = traits[_category][_traitId];
        return trait;
    }

    /**
     *   @notice Clear the traits
     */
    function clearTraits(uint8 _category) public onlyOwner {
        require(_category >= 0);
        delete traits[_category];
    }

    function pickTraitFromCategory(Category _category, uint256 trooperzId)
        internal
        view
        returns (Trait memory)
    {
        console.log("[TrooperzBase] _category: %s", uint8(_category));

        //getting a random trait for the category passed as a param
        uint256 size = traits[uint8(_category)].length;
        console.log("[TrooperzBase] traits size: %s", size);
        uint256 random = TrooperzLibrary.generateRandom(trooperzId, size);

        Trait memory t = traits[uint8(_category)][random];
        console.log("[TrooperzBase] picked trait: %s", t.id);
        return t;
    }

    function getTrooperz(uint256 trooperzId)
        internal
        view
        returns (string memory)
    {
        string memory traitsSVG = string(
            abi.encodePacked(
                pickTraitFromCategory(Category.HAT, trooperzId).svg
            )
        );

        string memory svg = TrooperzLibrary.generateSVG(traitsSVG);
        console.log("[TrooperzBase] svg: %s", svg);
        return svg;
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
        console.log("[TrooperzBase] genTraits size: %s", genTraits.length);

        Trooperz memory trpz = Trooperz(trooperzId, "", genTraits);
        // string memory svg = TrooperzLibrary.generateSVG(traitsSVG);
        console.log("[TrooperzBase] id: %s", trpz.id);
        return trpz.id;
    }

    function mintTrooperz() public returns (uint256) {
        // get the current trait ID
        uint256 newTrooperzId = _trooperzIds.current();
        require(newTrooperzId < maxSupply);

        // string memory svg = getTrooperz(newTrooperzId);
        uint256 svg = generateTrooperz(newTrooperzId);

        //incrementing trooperz ids
        _trooperzIds.increment();
        return svg;
    }
}
