// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

contract TrooperzTypes {
    // define the Season which the Trooperz belongs to
    enum Season {
        ONE,
        TWO,
        THREE,
        FOUR,
        FIVE
    }

    enum Category {
        HAT,
        EYES,
        BACKGROUND
    }

    // define a Trait used by the Trooperz
    struct Trait {
        uint256 id;
        Category category;
        string name;
        Season season;
        string svg;
    }

    struct TokenURIParams {
        string name;
        string description;
    }

    // define a Trooperz
    struct Trooperz {
        uint256 id;
        string tokenURI;
        Trait[] traits;
    }
}
