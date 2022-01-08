// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "./TrooperzBase.sol";

contract TrooperzTraitFactory is TrooperzBase {
    using Counters for Counters.Counter;

    // define id of the Trait
    Counters.Counter internal _traitIds;

    // event is emitted when a new Trait is created
    event NewTrait(
        uint256 _id,
        Category _category,
        string _name,
        Season _season,
        string _svg
    );

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
        Trait storage t = Trait(newTraitId, _category, _name, _season, _svg);
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
    function getTrait(uint8 _category, uint256 _traitId)
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

    // // define id of the Trooperz
    // Counters.Counter internal _trooperzIds;

    // function mintTrooperz() public view returns (uint256) {
    //     // get the current trait ID
    //     uint256 newTrooperzId = _trooperzIds.current();
    //     require(newTrooperzId < maxSupply);

    //     return newTrooperzId;
    // }

    // function generateSVG() public view returns (string memory) {
    //     // TODO:
    //     // iterate for all the values of Category and for each Category get a random Trait calling pickTraitFromCategory().
    //     // Get svg string from given Trait and add it to the global svg String.
    //     // Add header and closing svg tags to it.
    //     // It will represents the SVG Image.
    //     string memory startSVG = string(
    //         abi.encodePacked(
    //             "<svg width='2000' height='2000' viewBox='0 0 2000 2000' fill='none' xmlns='http://www.w3.org/2000/svg'>"
    //         )
    //     );

    //     string memory baseSVG = string(
    //         abi.encodePacked(
    //             "<rect width='2000' height='2000' fill='#C4C4C4'/>",
    //             "<path d='M752.157 884.349V923.828C736.501 923.828 722.661 942.434 720.165 953.779C719.938 963.535 720.165 1001.83 720.165 1022.53C720.165 1036.82 726.972 1036.82 726.972 1036.82V1051.8C726.291 1052.48 690.897 1080.39 690.897 1080.39C648.125 1114.46 672.292 1179.08 690.216 1203.59C694.527 1208.13 697.703 1215.24 710.636 1221.97C727.653 1230.82 736.274 1232.63 746.711 1234.22L750.115 1249.19C760.325 1291.4 822.265 1319.31 844.728 1327.47C867.19 1335.64 917.559 1331.56 928.45 1331.56C937.162 1331.56 959.307 1310.23 969.29 1299.57H1031.23C1031.23 1299.57 1063.47 1331.56 1072.07 1331.56C1080.67 1331.56 1133.33 1336.43 1155.79 1328.26C1178.25 1320.09 1239.68 1291.4 1249.89 1249.19L1253.29 1234.22C1263.73 1232.63 1272.35 1230.82 1289.36 1221.97C1302.3 1215.24 1305.47 1208.13 1309.78 1203.59C1327.71 1179.08 1351.88 1114.46 1309.1 1080.39C1309.1 1080.39 1273.71 1052.48 1273.03 1051.8V1036.82C1273.03 1036.82 1279.83 1036.82 1279.83 1022.53C1279.83 1001.83 1280.06 963.535 1279.83 953.779C1277.34 942.434 1263.5 923.828 1247.84 923.828V884.349C1249.89 765.229 1188.63 712.136 1159.36 699.884C1143.79 693.369 1094.25 667 1000.31 667C906.382 667 856.206 693.369 840.644 699.884C811.375 712.136 750.115 765.229 752.157 884.349Z' fill='#CACACA' stroke='black' stroke-width='8'/>"
    //         )
    //     );
    //     string memory endSVG = string(abi.encodePacked("</svg>"));

    //     // getting traits
    //     Trait memory headTrait = pickTraitFromCategory(Category.HAT, "aa");

    //     // generating final SVG
    //     string memory globalSVG = string(
    //         abi.encodePacked(startSVG, baseSVG, headTrait.svg, endSVG)
    //     );
    //     return globalSVG;
    // }

    // function pickTraitFromCategory(Category _category, string memory _input)
    //     internal
    //     view
    //     returns (Trait memory)
    // {
    //     console.log("[TrooperzFactory] _category: %s", uint8(_category));

    //     //getting a random trait for the category passed as a param
    //     uint256 size = traits[uint8(_category)].length;
    //     uint256 random = generateRandom(_input, size);
    //     // Trait[] memory traitForCategory = traits[uint8(_category)];
    //     // console.log(
    //     //     "[TrooperzFactory] traits length: %s",
    //     //     traitForCategory.length
    //     // );

    //     Trait memory t = traits[uint8(_category)][random];
    //     console.log("[TrooperzFactory] picked trait: %s", t.id);
    //     return t;
    // }

    // /**
    //  *  @notice Generate a random number between 1 and max
    //  *  @param _input: could be whatever you want
    //  *  @param _max: Maximun value of the random number
    //  */
    // function generateRandom(string memory _input, uint256 _max)
    //     internal
    //     view
    //     returns (uint256)
    // {
    //     uint256 random = uint256(
    //         keccak256(
    //             abi.encodePacked(
    //                 block.difficulty,
    //                 block.number,
    //                 tx.origin,
    //                 tx.gasprice,
    //                 _input,
    //                 _trooperzIds.current(),
    //                 block.timestamp
    //             )
    //         )
    //     );
    //     console.log("[TrooperzFactory] random before: %s", random);
    //     random = random % _max;
    //     console.log("[TrooperzFactory] random after: %s", random);
    //     return random;
    // }
}
