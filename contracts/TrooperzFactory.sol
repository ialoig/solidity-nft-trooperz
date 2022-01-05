// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "./TrooperzBase.sol";

contract TrooperzFactory is TrooperzBase {
    using Counters for Counters.Counter;

    // define id of the Trooperz
    Counters.Counter internal _trooperzIds;

    function mintTrooperz() public view returns (uint256) {
        // get the current trait ID
        uint256 newTrooperzId = _trooperzIds.current();
        require(newTrooperzId < maxSupply);

        return newTrooperzId;
    }

    function generateSVG() internal view returns (string memory) {
        // TODO:
        // iterate for all the values of Category and for each Category get a random Trait calling pickTraitFromCategory().
        // Get svg string from given Trait and add it to the global svg String.
        // Add header and closing svg tags to it.
        // It will represents the SVG Image.
    }

    function pickTraitFromCategory(uint8 _category, string memory _input)
        internal
        view
        returns (Trait memory)
    {
        //getting a random trait for the category passed as a param
        uint256 random = generateRandom(_input, traits[_category].length);
        Trait memory t = traits[_category][random];
        return t;
    }

    /**
     *  @notice Generate a random number between 1 and max
     *  @param _input: could be whatever you want
     *  @param _max: Maximun value of the random number
     */
    function generateRandom(string memory _input, uint256 _max)
        internal
        view
        returns (uint256)
    {
        uint256 random = uint256(
            keccak256(
                abi.encodePacked(
                    block.difficulty,
                    block.number,
                    tx.origin,
                    tx.gasprice,
                    _input,
                    _trooperzIds.current(),
                    block.timestamp
                )
            )
        );
        random = (random % (_max + 1)) + 1;
        console.log("[TrooperzFactory] random: %s", random);
        return random;
    }
}
