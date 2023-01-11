// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract ShadowpakRedeeming {
    string public constant TARGET_URI = "https://ipfs.infura.io:5001/api/v0/cat/QmZDRNJWf2Zwkhfs467MTXwCqVH5PKWmXjddfJ96txHxSF";
    address public constant PILLS_CONTRACT = 0x33a4CFc925AD40e5bb2b9b2462D7a1A5a5DA4476;

    mapping(uint => bool) public claimed;

    function redeem(uint _token_id) external {
        require(msg.sender == tx.origin, "Contract interactions prohibited");
        require(!claimed[_token_id], "Already claimed ETH for this token id");
        string memory token_uri = ERC721(PILLS_CONTRACT).uri(_token_id);
        require(keccak256(abi.encodePacked(token_uri)) == keccak256(abi.encodePacked(TARGET_URI)), "Token is not a shadowpak");
        
        claimed[_token_id] = true;
        payable(msg.sender).transfer(1 ether);
    }
}

interface ERC721 {
    function uri(
        uint256 _id
    ) external view returns (string memory);
}
