// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Leaf } from "test/PrizeClaim.t.sol";
contract MerkleConstants {
    function getLeaves() public pure returns (Leaf[] memory) {
        Leaf[] memory leaves = new Leaf[](14);
        leaves[0] = Leaf({
            user: 0x96Dc4a236a262E9f7D30B4B3ba04211A235b7b52,
            amount: 100000000000000000000000
        });
        leaves[1] = Leaf({
            user: 0x72c7cdd2a04FfCA264f0c9ea61d34fF8182C4210,
            amount: 65000000000
        });
        leaves[2] = Leaf({
            user: 0xdE43713C0b02162EF0D8DC7DEff9324E1a5ac8A8,
            amount: 34139486975
        });
        leaves[3] = Leaf({
            user: 0x1F03C2D3C34dAD4D945d04Ab5338b22dC7D9D04f,
            amount: 20000000000000000000001
        });
        leaves[4] = Leaf({
            user: 0x8Ae4A382cFc5316b2Ae6B4A302bb299aa17AFd52,
            amount: 1000000
        });
        leaves[5] = Leaf({
            user: 0xe3F641AD659249a020e2aF63c3f9aBd6cfFb668b,
            amount: 250000
        });
        leaves[6] = Leaf({
            user: 0xde1D464cc6d3809d748F39F474Ad92d016a47F05,
            amount: 250000
        });
        leaves[7] = Leaf({
            user: 0x97fE9A20615A55a49040DfC28816B1BcC597DE6e,
            amount: 250000
        });
        leaves[8] = Leaf({
            user: 0xAF68d12E2c79dff7C3CE207e44a6e0920BD67d47,
            amount: 250000
        });
        leaves[9] = Leaf({
            user: 0x49e990E159f3eA9Da7E8638c3B9eDAFfa1B086b3,
            amount: 250000
        });
        leaves[10] = Leaf({
            user: 0xBaA5179D9cb4769100FA720f6518F0BC2898d182,
            amount: 250000
        });
        leaves[11] = Leaf({
            user: 0x9CfCE6BcD960ECeFa1A583C1B037F3e5F644C3D0,
            amount: 250000
        });
        leaves[12] = Leaf({
            user: 0x6E20397a8334Fe1C035dF538aA87946c676f828F,
            amount: 250000
        });
        leaves[13] = Leaf({
            user: 0x15bd5088dC798Eb209367953a73e418a0312c774,
            amount: 250000
        });
        return leaves;
    }

    function getProofs() public pure returns (bytes32[][] memory) {
        bytes32[] memory proof0 = new bytes32[](4);
        proof0[0] = bytes32(uint256(0x9dbc442380c44b2d6a90dd27a7a0b38195ddff87b6d28e3bab4202a5c7378c63));
        proof0[1] = bytes32(uint256(0x00307dc04dc610636d5405caf317fdbdb2376e592187562c4ca820e3399d5697));
        proof0[2] = bytes32(uint256(0x8941c5000bae681e761425dd66838c82f1ca0b2797a1408375008659d7532cef));
        proof0[3] = bytes32(uint256(0x5d23b68bfdb49eb540c7adc0ad4e33d8188d4f8993f8a34b8029b92704abc81c));

        bytes32[] memory proof1 = new bytes32[](4);
        proof1[0] = bytes32(uint256(0x9402ec7923a9c845ca76695a306a1c30a57ca1c8f6986f7ecfbd9b3547d1bcfc));
        proof1[1] = bytes32(uint256(0x9f01d95ab1595bad1d7d0965f2b7dd5286456dc8a1d02164d9dac4232317e037));
        proof1[2] = bytes32(uint256(0x5d05641c1b037f40f32866e40a77d869d9dbdeb83a454a9b7e859c6a54264889));
        proof1[3] = bytes32(uint256(0x5d23b68bfdb49eb540c7adc0ad4e33d8188d4f8993f8a34b8029b92704abc81c));

        bytes32[] memory proof2 = new bytes32[](4);
        proof2[0] = bytes32(uint256(0xa778f2f58710a7d93aab291a9b7fc0d38d1ebbcacabd3aeb6b20240e5d988313));
        proof2[1] = bytes32(uint256(0x00307dc04dc610636d5405caf317fdbdb2376e592187562c4ca820e3399d5697));
        proof2[2] = bytes32(uint256(0x8941c5000bae681e761425dd66838c82f1ca0b2797a1408375008659d7532cef));
        proof2[3] = bytes32(uint256(0x5d23b68bfdb49eb540c7adc0ad4e33d8188d4f8993f8a34b8029b92704abc81c));

        bytes32[] memory proof3 = new bytes32[](3);
        proof3[0] = bytes32(uint256(0xf4fe2442b0f54eb64cc6025a16373c7ab90833d200b4abb8dabac08a0cdad547));
        proof3[1] = bytes32(uint256(0x80d80cbed5c5210fbd88e597030ab8edddd0348aee88924007d2895df1168ecb));
        proof3[2] = bytes32(uint256(0x61821eb00ae23fa67ebf33f7fe4981981a20cbe8172f2ac43381a23d9debb687));

        bytes32[] memory proof4 = new bytes32[](4);
        proof4[0] = bytes32(uint256(0x52a23d69db94dca9b2dbd1498217439e01e448e66d53430a59bfa3f2e8e6c421));
        proof4[1] = bytes32(uint256(0xb4bf33f2cf02c5c6c0d88cad14d50cfd7ac20a76336a0a4eba8ad206986630b1));
        proof4[2] = bytes32(uint256(0xfa58e045a123c52235779adccb6857411dfcc9ec66a69ce81d08159852fa4b00));
        proof4[3] = bytes32(uint256(0x61821eb00ae23fa67ebf33f7fe4981981a20cbe8172f2ac43381a23d9debb687));

        bytes32[] memory proof5 = new bytes32[](4);
        proof5[0] = bytes32(uint256(0xea5a815fb95f1627fd4096561ebf098775ab4e9b3c6e35acbc5984a5a06ab850));
        proof5[1] = bytes32(uint256(0x92f7d6a71de036ebd14fb60376f63e98553f2c96444f35c8415bdccf56b4f0d5));
        proof5[2] = bytes32(uint256(0x8941c5000bae681e761425dd66838c82f1ca0b2797a1408375008659d7532cef));
        proof5[3] = bytes32(uint256(0x5d23b68bfdb49eb540c7adc0ad4e33d8188d4f8993f8a34b8029b92704abc81c));

        bytes32[] memory proof6 = new bytes32[](4);
        proof6[0] = bytes32(uint256(0x7d9c6c1bb8d4bb033b508646ea67dfed9159b44f09b84da972d6b629c21c8555));
        proof6[1] = bytes32(uint256(0x4f77375e1bed4fd2c912403b68634ab4b8319d79650cb62ca44428db97a9fb31));
        proof6[2] = bytes32(uint256(0x5d05641c1b037f40f32866e40a77d869d9dbdeb83a454a9b7e859c6a54264889));
        proof6[3] = bytes32(uint256(0x5d23b68bfdb49eb540c7adc0ad4e33d8188d4f8993f8a34b8029b92704abc81c));

        bytes32[] memory proof7 = new bytes32[](4);
        proof7[0] = bytes32(uint256(0xa8672a56ac4485d0578b46680be2d80f2fde6fbb959f6f6641e96d4bbf0e1059));
        proof7[1] = bytes32(uint256(0x92f7d6a71de036ebd14fb60376f63e98553f2c96444f35c8415bdccf56b4f0d5));
        proof7[2] = bytes32(uint256(0x8941c5000bae681e761425dd66838c82f1ca0b2797a1408375008659d7532cef));
        proof7[3] = bytes32(uint256(0x5d23b68bfdb49eb540c7adc0ad4e33d8188d4f8993f8a34b8029b92704abc81c));

        bytes32[] memory proof8 = new bytes32[](4);
        proof8[0] = bytes32(uint256(0x677f8bc3c3d21523828357902ff56054af6dfe8603fbfa69f4371d0cdd15f572));
        proof8[1] = bytes32(uint256(0x86a329b32f46d056ac178fb91004253a41b22c5eccbeb02e6dee4a9b3851aaac));
        proof8[2] = bytes32(uint256(0xfa58e045a123c52235779adccb6857411dfcc9ec66a69ce81d08159852fa4b00));
        proof8[3] = bytes32(uint256(0x61821eb00ae23fa67ebf33f7fe4981981a20cbe8172f2ac43381a23d9debb687));

        bytes32[] memory proof9 = new bytes32[](4);
        proof9[0] = bytes32(uint256(0x37334fd77ab4ec16730bc2861553c2e22ceebc366253972f9869ad864c154c32));
        proof9[1] = bytes32(uint256(0xb4bf33f2cf02c5c6c0d88cad14d50cfd7ac20a76336a0a4eba8ad206986630b1));
        proof9[2] = bytes32(uint256(0xfa58e045a123c52235779adccb6857411dfcc9ec66a69ce81d08159852fa4b00));
        proof9[3] = bytes32(uint256(0x61821eb00ae23fa67ebf33f7fe4981981a20cbe8172f2ac43381a23d9debb687));

        bytes32[] memory proof10 = new bytes32[](4);
        proof10[0] = bytes32(uint256(0x95cf61a29003d7779a4d99791f8273da237e5997dbb3da66b41945ce7aec63ee));
        proof10[1] = bytes32(uint256(0x9f01d95ab1595bad1d7d0965f2b7dd5286456dc8a1d02164d9dac4232317e037));
        proof10[2] = bytes32(uint256(0x5d05641c1b037f40f32866e40a77d869d9dbdeb83a454a9b7e859c6a54264889));
        proof10[3] = bytes32(uint256(0x5d23b68bfdb49eb540c7adc0ad4e33d8188d4f8993f8a34b8029b92704abc81c));

        bytes32[] memory proof11 = new bytes32[](4);
        proof11[0] = bytes32(uint256(0x756612044f212729c6ebcd88d313e4fac13f0e0965842d8e57c49e8666e8ba7e));
        proof11[1] = bytes32(uint256(0x4f77375e1bed4fd2c912403b68634ab4b8319d79650cb62ca44428db97a9fb31));
        proof11[2] = bytes32(uint256(0x5d05641c1b037f40f32866e40a77d869d9dbdeb83a454a9b7e859c6a54264889));
        proof11[3] = bytes32(uint256(0x5d23b68bfdb49eb540c7adc0ad4e33d8188d4f8993f8a34b8029b92704abc81c));

        bytes32[] memory proof12 = new bytes32[](4);
        proof12[0] = bytes32(uint256(0x5383f2cf551951367831ed8ebf0e52146eb676939e2c7cf56baf881c56f77a0a));
        proof12[1] = bytes32(uint256(0x86a329b32f46d056ac178fb91004253a41b22c5eccbeb02e6dee4a9b3851aaac));
        proof12[2] = bytes32(uint256(0xfa58e045a123c52235779adccb6857411dfcc9ec66a69ce81d08159852fa4b00));
        proof12[3] = bytes32(uint256(0x61821eb00ae23fa67ebf33f7fe4981981a20cbe8172f2ac43381a23d9debb687));

        bytes32[] memory proof13 = new bytes32[](3);
        proof13[0] = bytes32(uint256(0xffa552b15a446d20710497583e149b4adfff3e32fae4fa18326448e6afe0db40));
        proof13[1] = bytes32(uint256(0x80d80cbed5c5210fbd88e597030ab8edddd0348aee88924007d2895df1168ecb));
        proof13[2] = bytes32(uint256(0x61821eb00ae23fa67ebf33f7fe4981981a20cbe8172f2ac43381a23d9debb687));

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
}