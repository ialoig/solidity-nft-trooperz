// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "hardhat/console.sol";

library TrooperzLibrary {
    function generateSVG(string memory traitsSVG)
        internal
        pure
        returns (string memory)
    {
        // TODO:
        // iterate for all the values of Category and for each Category get a random Trait calling pickTraitFromCategory().
        // Get svg string from given Trait and add it to the global svg String.
        // Add header and closing svg tags to it.
        // It will represents the SVG Image.
        string memory startSVG = string(
            abi.encodePacked(
                "<svg width='2000' height='2000' viewBox='0 0 2000 2000' fill='none' xmlns='http://www.w3.org/2000/svg'>"
            )
        );

        string memory baseSVG = string(
            abi.encodePacked(
                "<rect width='2000' height='2000' fill='#C4C4C4'/>",
                "<path d='M752.157 884.349V923.828C736.501 923.828 722.661 942.434 720.165 953.779C719.938 963.535 720.165 1001.83 720.165 1022.53C720.165 1036.82 726.972 1036.82 726.972 1036.82V1051.8C726.291 1052.48 690.897 1080.39 690.897 1080.39C648.125 1114.46 672.292 1179.08 690.216 1203.59C694.527 1208.13 697.703 1215.24 710.636 1221.97C727.653 1230.82 736.274 1232.63 746.711 1234.22L750.115 1249.19C760.325 1291.4 822.265 1319.31 844.728 1327.47C867.19 1335.64 917.559 1331.56 928.45 1331.56C937.162 1331.56 959.307 1310.23 969.29 1299.57H1031.23C1031.23 1299.57 1063.47 1331.56 1072.07 1331.56C1080.67 1331.56 1133.33 1336.43 1155.79 1328.26C1178.25 1320.09 1239.68 1291.4 1249.89 1249.19L1253.29 1234.22C1263.73 1232.63 1272.35 1230.82 1289.36 1221.97C1302.3 1215.24 1305.47 1208.13 1309.78 1203.59C1327.71 1179.08 1351.88 1114.46 1309.1 1080.39C1309.1 1080.39 1273.71 1052.48 1273.03 1051.8V1036.82C1273.03 1036.82 1279.83 1036.82 1279.83 1022.53C1279.83 1001.83 1280.06 963.535 1279.83 953.779C1277.34 942.434 1263.5 923.828 1247.84 923.828V884.349C1249.89 765.229 1188.63 712.136 1159.36 699.884C1143.79 693.369 1094.25 667 1000.31 667C906.382 667 856.206 693.369 840.644 699.884C811.375 712.136 750.115 765.229 752.157 884.349Z' fill='#CACACA' stroke='black' stroke-width='8'/>"
            )
        );
        string memory endSVG = string(abi.encodePacked("</svg>"));

        // generating final SVG
        string memory globalSVG = string(
            abi.encodePacked(startSVG, baseSVG, traitsSVG, endSVG)
        );
        return globalSVG;
    }

    /**
     *  @notice Generate a random number between 1 and max
     *  @param _trooperzId: id of the NFT to be generated
     *  @param _max: Maximun value of the random number
     */
    function generateRandom(uint256 _trooperzId, uint256 _max)
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
                    _trooperzId,
                    block.timestamp
                )
            )
        );
        console.log("[TrooperzFactory] random before: %s", random);
        random = random % _max;
        console.log("[TrooperzFactory] random after: %s", random);
        return random;
    }
}
