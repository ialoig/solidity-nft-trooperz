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
    ) public onlyOwner returns (Trait memory) {
        // require(_category.length > 0);
        require(bytes(_name).length > 0);
        // require(_season.length > 0);
        require(bytes(_svg).length > 0);

        // get the current trait ID by incrementing ids variable
        uint256 newTraitId = _traitIds.current();

        // creating new Trait
        Trait memory t = Trait(newTraitId, _category, _name, _season, _svg);

        // insert new trait into array of traits
        // index value is based on trait's category
        traits[uint8(_category)].push(t);

        // send the new Trait event
        emit NewTrait(newTraitId, _category, _name, _season, _svg);

        //increament trait ids
        _traitIds.increment();

        return t;
    }

    /**
     *  @notice Return a Trait from a given Trait ID
     */
    function getTrait(uint8 _category, uint256 _traitId)
        external
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
}
