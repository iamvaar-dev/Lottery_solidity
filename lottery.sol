// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract lottery{
    address public manager;
    address payable[] public players;
    address payable public winner;

    constructor(){
        manager=msg.sender;
    }

function participate() public payable{
    require(msg.value==90 ether, "Please pay 90 ether");
    players.push(payable (msg.sender));
} 

function checkBalance() public view returns(uint) {
    require(msg.sender==manager, "You aren't the manager");
    return address(this).balance;
}

function random() public view returns(uint){
 return uint(keccak256(abi.encodePacked(msg.sender, players.length,block.timestamp)));
}

function pickWinner() public {
    require(msg.sender==manager, "You are not manager");
    require(players.length>=2, "There are no 2 two players");
    uint rr = random();
    uint index = rr%players.length;
    winner = players[index];
   
    winner.transfer(address(this).balance*95/100);
    players = new address payable[](0);

}

function tr(address payable _reciever) public  payable{
    require(msg.sender==manager, "Not the manager");
    _reciever.transfer(address(this).balance);

}

}

/*
Note:
1.This lottery should have 3 participating members, who should be paid 1 ether. 
2.Winner will be picked by the index which is derived from the modulus of random number by player's array length.
3. For the winner 95% of the funds will be transferred.
4. Remaining 5% funds are remained in the smart contract account.

*/