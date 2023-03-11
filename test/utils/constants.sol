// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Leaf } from "test/PrizeClaim.t.sol";
contract MerkleConstants {
    function getLeaves() public pure returns (Leaf[] memory) {
        Leaf[] memory leaves = new Leaf[](14);
        leaves[0] = Leaf({
            user: 0x96Dc4a236a262E9f7D30B4B3ba04211A235b7b52,
            amount: 100000000000000000000000,
            duration: 7,
            stakeName: 'name'
        });
        leaves[1] = Leaf({
            user: 0x72c7cdd2a04FfCA264f0c9ea61d34fF8182C4210,
            amount: 65000000000,
            duration: 14,
            stakeName: 'name'
        });
        leaves[2] = Leaf({
            user: 0xdE43713C0b02162EF0D8DC7DEff9324E1a5ac8A8,
            amount: 34139486975,
            duration: 21,
            stakeName: 'name'
        });
        leaves[3] = Leaf({
            user: 0x1F03C2D3C34dAD4D945d04Ab5338b22dC7D9D04f,
            amount: 20000000000000000000001,
            duration: 3333,
            stakeName: 'name'
        });
        leaves[4] = Leaf({
            user: 0x8Ae4A382cFc5316b2Ae6B4A302bb299aa17AFd52,
            amount: 1000000,
            duration: 3000,
            stakeName: 'name'
        });
        leaves[5] = Leaf({
            user: 0xe3F641AD659249a020e2aF63c3f9aBd6cfFb668b,
            amount: 250000,
            duration: 1000,
            stakeName: 'name'
        });
        leaves[6] = Leaf({
            user: 0xde1D464cc6d3809d748F39F474Ad92d016a47F05,
            amount: 250000,
            duration: 30,
            stakeName: 'name'
        });
        leaves[7] = Leaf({
            user: 0x97fE9A20615A55a49040DfC28816B1BcC597DE6e,
            amount: 250000,
            duration: 60,
            stakeName: 'name'
        });
        leaves[8] = Leaf({
            user: 0xAF68d12E2c79dff7C3CE207e44a6e0920BD67d47,
            amount: 250000,
            duration: 90,
            stakeName: 'name'
        });
        leaves[9] = Leaf({
            user: 0x49e990E159f3eA9Da7E8638c3B9eDAFfa1B086b3,
            amount: 250000,
            duration: 180,
            stakeName: 'name'
        });
        leaves[10] = Leaf({
            user: 0xBaA5179D9cb4769100FA720f6518F0BC2898d182,
            amount: 250000,
            duration: 365,
            stakeName: 'name'
        });
        leaves[11] = Leaf({
            user: 0x9CfCE6BcD960ECeFa1A583C1B037F3e5F644C3D0,
            amount: 250000,
            duration: 50,
            stakeName: 'name'
        });
        leaves[12] = Leaf({
            user: 0x6E20397a8334Fe1C035dF538aA87946c676f828F,
            amount: 250000,
            duration: 100,
            stakeName: 'name'
        });
        leaves[13] = Leaf({
            user: 0x15bd5088dC798Eb209367953a73e418a0312c774,
            amount: 250000,
            duration: 250,
            stakeName: 'name'
        });
        return leaves;
    }

    function getProofs() public pure returns (bytes32[][] memory) {
        bytes32[] memory proof0 = new bytes32[](4);
        proof0[0] = bytes32(uint256(0x1b9c2894858802465fa94bbe653cd5d718cff8093ab08295fa5acc6b6b3e7bfd));
        proof0[1] = bytes32(uint256(0xc3759535cddfd758328ca9c68ac58dacd6ae82984fe9a0e1bb9b7f88af1611d1));
        proof0[2] = bytes32(uint256(0x44e2c1922336deb8b5d789ee2d94c873ab65e15a0c6b2fb09e7e612f010f6f42));
        proof0[3] = bytes32(uint256(0x6b1d2fdf06c9592993f24465cc0eb87dc9d0edff27d3ab3e28078aabdcad5284));

        bytes32[] memory proof1 = new bytes32[](4);
        proof1[0] = bytes32(uint256(0x64a4ec7b5647774cb7282eda5416bfb683e47b8ef56ad6e8e44b7e628dc4e68f));
        proof1[1] = bytes32(uint256(0x4e371e277a32184e5e8c75529c9ec8c68a5fa8d636ae436e7d02a30492f54fef));
        proof1[2] = bytes32(uint256(0xf8593e11ce98c41845baeefc0f9134562c43ef1b8ca9b5ab586e8905f48346ab));
        proof1[3] = bytes32(uint256(0xd1604025792ffca1312f56a65a1199ab4d4407e807b455c46f81480dec4f5f9c));

        bytes32[] memory proof2 = new bytes32[](4);
        proof2[0] = bytes32(uint256(0x0a726ee84e6862c6323e26fa06a1b8071f166547e422057f36f58e9a13aa39c8));
        proof2[1] = bytes32(uint256(0xc3759535cddfd758328ca9c68ac58dacd6ae82984fe9a0e1bb9b7f88af1611d1));
        proof2[2] = bytes32(uint256(0x44e2c1922336deb8b5d789ee2d94c873ab65e15a0c6b2fb09e7e612f010f6f42));
        proof2[3] = bytes32(uint256(0x6b1d2fdf06c9592993f24465cc0eb87dc9d0edff27d3ab3e28078aabdcad5284));

        bytes32[] memory proof3 = new bytes32[](3);
        proof3[0] = bytes32(uint256(0x9ddfc0fcdff6d90fdd4e059a05408e6486eb5116a2b470a4ce3881b2aa03eb4f));
        proof3[1] = bytes32(uint256(0xf2cee1e252f605e3640cf45bc7b34dc5dfd66facaa1347b4c66a590e40dc8dba));
        proof3[2] = bytes32(uint256(0x6b1d2fdf06c9592993f24465cc0eb87dc9d0edff27d3ab3e28078aabdcad5284));

        bytes32[] memory proof4 = new bytes32[](4);
        proof4[0] = bytes32(uint256(0x1e0757c9be09dc4c35725d61a48d7f717038541d083523b272de6d228a948eb0));
        proof4[1] = bytes32(uint256(0xbe0ecb575062b114a8452cf6f9bae480fb6d43933e333ca00b9fa717a1c405cd));
        proof4[2] = bytes32(uint256(0x44e2c1922336deb8b5d789ee2d94c873ab65e15a0c6b2fb09e7e612f010f6f42));
        proof4[3] = bytes32(uint256(0x6b1d2fdf06c9592993f24465cc0eb87dc9d0edff27d3ab3e28078aabdcad5284));

        bytes32[] memory proof5 = new bytes32[](4);
        proof5[0] = bytes32(uint256(0x9b3041bb0dd407be5f5831b6722d69ddb95fba30534b244e3300d640e8801523));
        proof5[1] = bytes32(uint256(0xf95dffd4cbaca9c926528eda7e3bd4f25b82eb5867b65de014ee8257eb9035cf));
        proof5[2] = bytes32(uint256(0xd92ce8e11598ae7bb73da6c3ad9c72d144886690c95e62e0b5421d395c3e5a34));
        proof5[3] = bytes32(uint256(0xd1604025792ffca1312f56a65a1199ab4d4407e807b455c46f81480dec4f5f9c));

        bytes32[] memory proof6 = new bytes32[](4);
        proof6[0] = bytes32(uint256(0x22447e1d922ff4192bce75e13b362019f47d5f989bc59cd8e8537cc97bbade3a));
        proof6[1] = bytes32(uint256(0xbe0ecb575062b114a8452cf6f9bae480fb6d43933e333ca00b9fa717a1c405cd));
        proof6[2] = bytes32(uint256(0x44e2c1922336deb8b5d789ee2d94c873ab65e15a0c6b2fb09e7e612f010f6f42));
        proof6[3] = bytes32(uint256(0x6b1d2fdf06c9592993f24465cc0eb87dc9d0edff27d3ab3e28078aabdcad5284));

        bytes32[] memory proof7 = new bytes32[](4);
        proof7[0] = bytes32(uint256(0x703592c00499f6d833f7aba7f229bdaa72ff709257c5af99d4915b82116441bf));
        proof7[1] = bytes32(uint256(0xc354ebad6d19878ffb09a96c6ec101e6c9c257409ebf94dd837fae689d8dc3b8));
        proof7[2] = bytes32(uint256(0xd92ce8e11598ae7bb73da6c3ad9c72d144886690c95e62e0b5421d395c3e5a34));
        proof7[3] = bytes32(uint256(0xd1604025792ffca1312f56a65a1199ab4d4407e807b455c46f81480dec4f5f9c));

        bytes32[] memory proof8 = new bytes32[](4);
        proof8[0] = bytes32(uint256(0x835f11630ece36016eb50ab6cab599daa7bb672ae2b0b843d4b92a919eeec516));
        proof8[1] = bytes32(uint256(0xc354ebad6d19878ffb09a96c6ec101e6c9c257409ebf94dd837fae689d8dc3b8));
        proof8[2] = bytes32(uint256(0xd92ce8e11598ae7bb73da6c3ad9c72d144886690c95e62e0b5421d395c3e5a34));
        proof8[3] = bytes32(uint256(0xd1604025792ffca1312f56a65a1199ab4d4407e807b455c46f81480dec4f5f9c));

        bytes32[] memory proof9 = new bytes32[](3);
        proof9[0] = bytes32(uint256(0xd776e3480f85d6a16435158398be4547ed813eb45d377eb7e4ddff46aa14b5e9));
        proof9[1] = bytes32(uint256(0xf2cee1e252f605e3640cf45bc7b34dc5dfd66facaa1347b4c66a590e40dc8dba));
        proof9[2] = bytes32(uint256(0x6b1d2fdf06c9592993f24465cc0eb87dc9d0edff27d3ab3e28078aabdcad5284));

        bytes32[] memory proof10 = new bytes32[](4);
        proof10[0] = bytes32(uint256(0x5e1fe43e5cffcdcd667a998c58e401eff895bf4f31fda3cacf029bf9ac96465b));
        proof10[1] = bytes32(uint256(0x4e371e277a32184e5e8c75529c9ec8c68a5fa8d636ae436e7d02a30492f54fef));
        proof10[2] = bytes32(uint256(0xf8593e11ce98c41845baeefc0f9134562c43ef1b8ca9b5ab586e8905f48346ab));
        proof10[3] = bytes32(uint256(0xd1604025792ffca1312f56a65a1199ab4d4407e807b455c46f81480dec4f5f9c));

        bytes32[] memory proof11 = new bytes32[](4);
        proof11[0] = bytes32(uint256(0x591d461a57b436f35500fccdc5c8f580118e912d7a2121ce616e197264addd3b));
        proof11[1] = bytes32(uint256(0x60a6cd6c6dca202ee8292896931cbc7a8d38747a37751bfa25441f957fbed7f5));
        proof11[2] = bytes32(uint256(0xf8593e11ce98c41845baeefc0f9134562c43ef1b8ca9b5ab586e8905f48346ab));
        proof11[3] = bytes32(uint256(0xd1604025792ffca1312f56a65a1199ab4d4407e807b455c46f81480dec4f5f9c));

        bytes32[] memory proof12 = new bytes32[](4);
        proof12[0] = bytes32(uint256(0x30c955960a45fbbff5a8e85bb7354104470b924a4964b8cd3bebda7c519be8d3));
        proof12[1] = bytes32(uint256(0x60a6cd6c6dca202ee8292896931cbc7a8d38747a37751bfa25441f957fbed7f5));
        proof12[2] = bytes32(uint256(0xf8593e11ce98c41845baeefc0f9134562c43ef1b8ca9b5ab586e8905f48346ab));
        proof12[3] = bytes32(uint256(0xd1604025792ffca1312f56a65a1199ab4d4407e807b455c46f81480dec4f5f9c));

        bytes32[] memory proof13 = new bytes32[](4);
        proof13[0] = bytes32(uint256(0x8f1ad87bc73325525fbb98c90d6b96936dd18644c666f93be0835cb5c49ba990));
        proof13[1] = bytes32(uint256(0xf95dffd4cbaca9c926528eda7e3bd4f25b82eb5867b65de014ee8257eb9035cf));
        proof13[2] = bytes32(uint256(0xd92ce8e11598ae7bb73da6c3ad9c72d144886690c95e62e0b5421d395c3e5a34));
        proof13[3] = bytes32(uint256(0xd1604025792ffca1312f56a65a1199ab4d4407e807b455c46f81480dec4f5f9c));

        bytes32[][] memory proofs = new bytes32[][](14);
        proofs[0] = proof0;
        proofs[1] = proof1;
        proofs[2] = proof2;
        proofs[3] = proof3;
        proofs[4] = proof4;
        proofs[5] = proof5;
        proofs[6] = proof6;
        proofs[7] = proof7;
        proofs[8] = proof8;
        proofs[9] = proof9;
        proofs[10] = proof10;
        proofs[11] = proof11;
        proofs[12] = proof12;
        proofs[13] = proof13;

        return proofs;
    }

    function getProof(uint256 index) public pure returns (bytes32[] memory) {
        bytes32[][] memory proofs = getProofs();
        return proofs[index];
    }

    function getProofSingle() public pure returns (bytes32[] memory) {
        bytes32[] memory proof = new bytes32[](4);
        proof[0] = bytes32(uint256(0xcec894a447d3784018f51e12660fd2452ca2e82a15d9361b37e75e10df22aec7));
        proof[1] = bytes32(uint256(0xbd9f41a8be1cb1c059dfb0a96987505aadd2740b49a3a5daaf017dd70ea0cd18));
        proof[2] = bytes32(uint256(0x8d2c3b1a3a6ffb2a4365fced884703a418d67c7091369ecabcfba44cc3a39f3a));
        proof[3] = bytes32(uint256(0x5ce0d3aeb7338bbbc40dd80cfb9d23c7aa7d93645d5ba99a8637d32820a1eefc));
        return proof;
    }

    function getLeaf() public pure returns (Leaf memory leaf) {
        leaf = Leaf({
            user: 0xC079c7431970A5a3BE8975A34eFA232e0c961477,
            amount: 100000,
            duration: 180,
            stakeName: 'Share in 1,000,000 $MAXX (early birds)'
        });
    }
}