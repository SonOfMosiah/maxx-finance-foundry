// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./interfaces/ILiquidityAmplifier.sol";

/// @title MAXXBoost NFT Collection
/// @author SonOfMosiah.eth
/// @notice Using an NFT from this collection when you stake your MAXX Tokens will give you APR bonuses. NFTs can be only used one time.
contract MAXXBoost is ERC721, Ownable {
    using Strings for uint256;
    using Counters for Counters.Counter;

    Counters.Counter private supply;

    // Token URI for the NFTs available to use for Staking APR Bonus
    string internal constant AVAILABLE_URI = "/available";

    // Token URI for used NFTs
    string internal constant USED_URI = "/used";

    // Base URI
    string private _baseUri;

    /// @notice The maximum supply of the collection
    uint256 public constant MAX_SUPPLY = 150;

    /// @notice The address of the MAXX Liquidity Amplifier Smart Contract
    address public amplifierContract;

    /// @notice The address of the MAXX Staking Smart Contract
    address public stakingContract;

    // Mapping of Token ID to used state
    mapping(uint256 => bool) private usedState;

    /// @notice Emitted when the Base URI is set
    /// @param _baseUri the Base URI
    event BaseURISet(string _baseUri);

    /// @notice Sets the Name and Token for the Collection
    constructor() ERC721("MAXXBoost", "MAXXB") {
        _transferOwnership(tx.origin);
    }

    /// @notice Called by Owner to mint to a lucky winner that participated in the MAXX Liquidity Amplifier
    /// @param _to the address of the lucky winner
    /// @dev supply.increment() is called before _safeMint() to start the collection at tokenId 1
    function mint(address _to) external onlyOwner {
        require(
            supply.current() + 1 <= MAX_SUPPLY,
            "Maximum supply has been reached!"
        );
        supply.increment();
        _safeMint(_to, supply.current());
    }

    /// @notice Marks NFT as used after it has been used in the MAXX Staking Contract
    /// @param _tokenId the Token ID of the NFT to be marked as used
    /// @dev This function is only callable by the MAXX Staking Contract
    function setUsed(uint256 _tokenId) external {
        require(
            msg.sender == stakingContract,
            "Only the Staking Contract can set a token as used"
        );
        usedState[_tokenId] = true;
    }

    /// @notice Set the MAXX Staking Contract address
    /// @param _maxxStake the address of the MAXX Staking Contract
    function setMaxxStake(address _maxxStake) external onlyOwner {
        stakingContract = _maxxStake;
    }

    /// @notice Set the MAXX Liquidity Amplifier Contract address
    /// @param _liquidityAmplifier the address of the MAXX Liquidity Amplifier Contract
    function setLiquidityAmplifier(address _liquidityAmplifier)
        external
        onlyOwner
    {
        amplifierContract = _liquidityAmplifier;
    }

    /// @notice Set the baseURI for the token collection
    /// @param baseURI_ The baseURI for the token collection
    function setBaseURI(string memory baseURI_) external onlyOwner {
        _baseUri = baseURI_;
        emit BaseURISet(baseURI_);
    }

    /// @notice Verifies if a NFT is used or not
    /// @param _tokenId the Token ID that is verified
    /// @return Bool for the used state of the NFT
    function getUsedState(uint256 _tokenId) external view returns (bool) {
        return usedState[_tokenId];
    }

    /// @notice Returns the Token IDs of the NFTs owner by a user
    /// @param _owner the address of the user
    /// @return The Token IDs owned by the address
    function tokensOfOwner(address _owner)
        public
        view
        returns (uint256[] memory)
    {
        uint256 ownerTokenCount = balanceOf(_owner);
        uint256[] memory ownedTokenIds = new uint256[](ownerTokenCount);
        uint256 currentTokenId = 1;
        uint256 ownedTokenIndex;
        while (
            ownedTokenIndex < ownerTokenCount && currentTokenId <= MAX_SUPPLY
        ) {
            address currentTokenOwner = ownerOf(currentTokenId);
            if (currentTokenOwner == _owner) {
                ownedTokenIds[ownedTokenIndex] = currentTokenId;
                ownedTokenIndex++;
            }
            currentTokenId++;
        }
        return ownedTokenIds;
    }

    /// @notice Returns the URI used to access the IPFS file containing the NFT Metadata
    /// @param tokenId the Token ID of the NFT
    /// @return The URI for the Token ID
    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
        string memory baseURI = _baseURI();
        if (usedState[tokenId]) {
            return
                bytes(baseURI).length > 0
                    ? string(
                        abi.encodePacked(baseURI, tokenId.toString(), USED_URI)
                    )
                    : "";
        } else {
            return
                bytes(baseURI).length > 0
                    ? string(
                        abi.encodePacked(
                            baseURI,
                            tokenId.toString(),
                            AVAILABLE_URI
                        )
                    )
                    : "";
        }
    }

    /// @notice Returns the total supply of the collection
    function totalSupply() public view returns (uint256) {
        return supply.current();
    }

    /**
     * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`. Empty
     * by default, can be overridden in child contracts.
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseUri;
    }
}
