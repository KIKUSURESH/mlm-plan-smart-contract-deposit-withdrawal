// SPDX-License-Identifier: none
pragma solidity ^0.8.6;
/**     
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }
  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }
  /**
  * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }
  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a); 
    return c;
  }
}
contract Ownable {
///contract owner
  address public owner;
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
  constructor() {
    owner = msg.sender;
  }
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
}
contract MLM_PLAN_NAME is Ownable {    
    using SafeMath for uint256; 
    ////emit when any user deposit.
    event DepositAt(address user, uint8 tariff, uint256 amount);
    event WithdrawalAt(address user, uint amount);
    /////deposit trx function 
    function deposit(uint8 _tariff) external payable {
        require(msg.value >= 50000000,"Minimum deposit 50 TRX");        
        require(msg.value < 50000000001,"Maximum deposit 50000 TRX");        
        emit DepositAt(msg.sender, _tariff, msg.value);
    }
    ////token withdrawal by only owner
    function withdrawalToAddress(address payable to, uint amount) external{
        require(msg.sender == owner, "Only owner");
        to.transfer(amount);
        emit WithdrawalAt(msg.sender,amount);
    }
  //// change owner wallet address
    function transferOwnership(address to) public {
        require(msg.sender == owner, "Only owner");
        address oldOwner  = owner;
        owner = to;
        emit OwnershipTransferred(oldOwner,to);
    }
}
