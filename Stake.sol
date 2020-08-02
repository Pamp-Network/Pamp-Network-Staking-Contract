// SPDX-License-Identifier: MIT

pragma solidity 0.6.10;

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

//Note that assert() is now used because the try/catch mechanism in the Pamp.sol contract does not revert on failure with require();

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a/*, "SafeMath: addition overflow"*/);

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        assert(b <= a/*, errorMessage*/);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        assert(c / a == b/*, "SafeMath: multiplication overflow"*/);

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        assert(b > 0/*, errorMessage*/);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        assert(b != 0/*, errorMessage*/);
        return a % b;
    }
}

contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        assert(_owner == _msgSender()/*, "Ownable: caller is not the owner"*/);
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        assert(newOwner != address(0)/*, "Ownable: new owner is the zero address"*/);
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// Contract used to calculate stakes. Unused currently.

abstract contract CalculatorInterface {
    function calculateNumTokens(uint256 balance, uint256 daysStaked, address stakerAddress, uint256 totalSupply) public view virtual returns (uint256);
    function negativeDayCallback(int numerator, uint denominator, uint256 price, uint256 volume) public virtual;
    function randomness() public view virtual returns (uint256);
}


// Parent token contract, see Pamp.sol
abstract contract PampToken {
    function balanceOf(address account) public view virtual returns (uint256);
    function _burn(address account, uint256 amount) external virtual;
    function mint(address account, uint256 amount) public virtual;
}

abstract contract PreviousContract {
    function resetStakeTimeMigrateState(address addr) external virtual returns (uint256 startTimestamp, uint256 lastTimestamp);
}



/**
 * @dev Implementation of the Pamp Network: https://pamp.network
 * Pamp Network (PAMP) is the world's first price-reactive cryptocurrency.
 * That is, the inflation rate of the token is wholly dependent on its market activity.
 * Minting does not happen when the price is less than the day prior.
 * When the price is greater than the day prior, the inflation for that day is
 * a function of its price, percent increase, volume, any positive price streaks,
 * and the amount of time any given holder has been holding.
 * In the first iteration, the dev team acts as the price oracle, but in the future, we plan to integrate a Chainlink price oracle.
 * This contract is the staking contract for the project and is upgradeable by the owner.
 */
contract PampStaking is Ownable {
    using SafeMath for uint256;
    
    // A 'staker' is an individual who holds the minimum staking amount in his address.
    
    struct staker {
        uint startTimestamp;    // When the staking started in unix time (block.timesamp)
        uint lastTimestamp;     // When the last staking reward was claimed in unix time (block.timestamp)
    }
    
    struct update {             // Price updateState
        uint timestamp;         // Last update timestamp, unix time
        uint numerator;         // Numerator of percent change (1% increase = 1/100)
        uint denominator;       // Denominator of percent change
        uint price;         // In USD. 0001 is $0.001, 1000 is $1.000, 1001 is $1.001, etc
        uint volume;        // In whole USD (100 = $100)
        uint streak;        // We save the current streak to use later
    }
    
    PampToken public token;     // ERC20 token contract that uses this upgradeable contract for staking and burning
    
    modifier onlyToken() {
        assert(_msgSender() == address(token)/*, "Caller must be PAMP token contract."*/);
        _;
    }
    
    modifier onlyNextStakingContract() {    // Caller must be the next staking contract
        assert(_msgSender() == _nextStakingContract);
        _;
    }
    
    modifier onlyOracle() {
        assert(_msgSender() == oracle);
        _;
    }

    
    mapping (address => staker) private _stakers;        // Mapping of all individuals staking/holding tokens greater than minStake
    
    mapping (address => string) private _whitelist;      // Mapping of all addresses that do not burn tokens on receive and send (generally other smart contracts). Mapping of address to reason (string)
    
    mapping (address => uint256) private _blacklist;     // Mapping of all addresses that receive a specific token burn when receiving. Mapping of address to percent burn (uint256)
    
    mapping (address => string) private _uniwhitelist; // Mapping of all addresses that do not burn tokens when sending to or selling on Uniswap. Mapping of address to reason (string)
    

    bool private _enableBurns; // Enable burning on transfer or fee on transfer
    
    bool private _priceTarget1Hit;  // Price targets, defined in updateState()
    
    bool private _priceTarget2Hit;
    
    address public _uniswapV2Pair;      // Uniswap pair address, done for fees on Uniswap sells
    
    uint public uniswapSellerBurnPercent;        // Uniswap sells pay a fee. Should be based on negative streaks
    
    uint public transferBurnPercent;
    
    bool private _enableUniswapDirectBurns;         // Enable seller fees on Uniswap
    
    uint256 private _minStake;                      // Minimum amount to stake
        
    uint8 public _minStakeDurationDays;            // Minimum amount of time to claim staking rewards
    
    uint8 private _minPercentIncrease;              // Minimum percent increase to enable rewards for the day. 10 = 1.0%, 100 = 10.0%
    
    uint256 public _inflationAdjustmentFactor;     // Factor to adjust the amount of rewards (inflation) to be given out in a single day
    
    uint256 private _streak;                        // Number of days in a row that the price has increased
    
    uint public maxStreak;                          // Max number of days in a row we consider streak bonuses
        
    uint public negativeStreak;                     // Number of days in a row that the price has decreased
    
    update public _lastUpdate;                      // latest price update

    uint public lastNegativeUpdate;                 // last time the price was negative (unix timestamp)
    
    CalculatorInterface private _externalCalculator;    // external calculator to calculate the number of tokens given several variables (defined above). Currently unused
    
    address private _nextStakingContract;                // Next staking contract deployed. Used for migrating staker state.
    
    bool private _useExternalCalc;                      // self-explanatory
    
    bool private _freeze;                               // freeze all transfers in an emergency
    
    bool public _enableHoldersDay;                     // once a month, holders receive a nice bump
    
    mapping (address => bool) public holdersDayRewarded; // Mapping to test whether an individual received his Holder's Day reward
    
    event StakerRemoved(address StakerAddress);     // Staker was removed due to balance dropping below _minStake
    
    event StakerAdded(address StakerAddress);       // Staker was added due to balance increasing abolve _minStake
    
    event StakesUpdated(uint Amount);               // Staking rewards were claimed
    
    event MassiveCelebration();                     // Happens when price targets are hit
    
    event Transfer(address indexed from, address indexed to, uint256 value);        // self-explanatory
    
    uint public maxStakingDays;
    
    uint public holdersDayRewardDenominator;
    
    update[] public updates;
    
    address public liquidityStakingContract;
    
    address public oracle;
    
    PreviousContract public previousStakingContract;
    
    
    constructor (PampToken Token) public {
        token = Token;
        _minStake = 200E18;
        _inflationAdjustmentFactor = 100;
        _streak = 0;
        _minStakeDurationDays = 2;
        _useExternalCalc = false;
        uniswapSellerBurnPercent = 8;
        _enableBurns = false;
        _freeze = false;
        _minPercentIncrease = 10; // 1.0% min increase
        _enableUniswapDirectBurns = false;
        transferBurnPercent = 8;
        _priceTarget1Hit = true;
        oracle = msg.sender;
        maxStreak = 7;
        holdersDayRewardDenominator = 600;
    }
    
    // The owner (or price oracle) will call this function to update the price on days the coin is positive. On negative days, no update is made.
    
    function updateState(uint numerator, uint denominator, uint256 price, uint256 volume) external onlyOracle {  // when chainlink is integrated a separate contract will call this function (onlyOwner state will be changed as well)
    
        require(numerator > 0 && denominator > 0 && price > 0 && volume > 0, "Parameters cannot be negative or zero");
        
        if (numerator < 2 && denominator == 100 || numerator < 20 && denominator == 1000) {
            require(mulDiv(1000, numerator, denominator) >= _minPercentIncrease, "Increase must be at least _minPercentIncrease to count");
        }
        
        uint secondsSinceLastUpdate = (block.timestamp - _lastUpdate.timestamp);       // We calculate time since last price update in days.
        
        if (secondsSinceLastUpdate < 129600) { // We should only update once per day, but block timestamps can vary
            _streak++;
        } else {
            _streak = 1;
        }
        
        if (_streak > maxStreak) {
            _streak = maxStreak;
        }
        
        if (price >= 1000 && _priceTarget1Hit == false) { // 1000 = $1.00
            _priceTarget1Hit = true;
            _streak = 50;
            emit MassiveCelebration();
            
        } else if (price >= 10000 && _priceTarget2Hit == false) {   // It is written, so it shall be done
            _priceTarget2Hit = true;
            _streak = 100;
             _minStake = 100E18;        // Need $1000 to stake
            emit MassiveCelebration();
        }
        
        if(negativeStreak > 0) {
            uniswapSellerBurnPercent = uniswapSellerBurnPercent - (negativeStreak * 2);
            negativeStreak = 0;
        }
        
        
        _lastUpdate = update(block.timestamp, numerator, denominator, price, volume, _streak);
        
        updates.push(_lastUpdate);

    }
    
    // We now update the smart contract on negative days. Currently this is only used to increase the Uniswap burn percent, but we may perform other funcionality in the future.
    function updateStateNegative(int numerator, uint denominator, uint256 price, uint256 volume) external onlyOracle { 
        require(numerator < _minPercentIncrease);
        
        uint secondsSinceLastUpdate = (block.timestamp - lastNegativeUpdate);       // We calculate time since last negative price update in days.
        
        if (secondsSinceLastUpdate < 129600) { // We should only update once per day, but block timestamps can vary
            negativeStreak++;
        } else {
            negativeStreak = 0;
        }
        
        _streak = 1;
        
        uniswapSellerBurnPercent = uniswapSellerBurnPercent + (negativeStreak * 2);     // Negative day streaks increase burn fees
        transferBurnPercent = transferBurnPercent + (negativeStreak * 2);       // May have to contact exchanges about this
    }
    
    function updateHoldersDay(bool enableHoldersDay)   external onlyOwner {
        _enableHoldersDay = enableHoldersDay;
    }
    
    function resetStakeTime() external {    // This is only necessary if a new staking contract is deployed. Resets 0 timestamp to block.timestamp
        uint balance = token.balanceOf(msg.sender);
        assert(balance > 0);
        assert(balance >= _minStake);
        
        staker memory thisStaker = _stakers[msg.sender];
        
        if (thisStaker.lastTimestamp == 0) {
            _stakers[msg.sender].lastTimestamp = block.timestamp;
        }
        if (thisStaker.startTimestamp == 0) {
             _stakers[msg.sender].startTimestamp = block.timestamp;
        }
    }
    
    
    // This is used by the next staking contract to migrate staker state
    function resetStakeTimeMigrateState(address addr) external onlyNextStakingContract returns (uint256 startTimestamp, uint256 lastTimestamp) {
        startTimestamp = _stakers[addr].startTimestamp;
        lastTimestamp = _stakers[addr].lastTimestamp;
        _stakers[addr].lastTimestamp = block.timestamp;
        _stakers[addr].startTimestamp = block.timestamp;
    }
    
    function migratePreviousState() external {      // Migrate state to new contract and reset state from old contract. Also reset current state to block.timestamp if it is zero otherwise
        
        require(_stakers[msg.sender].lastTimestamp == 0, "Last timestamp must be zero");
        require(_stakers[msg.sender].startTimestamp == 0, "Start timestamp must be zero");
        
        (uint startTimestamp, uint lastTimestamp) = previousStakingContract.resetStakeTimeMigrateState(msg.sender);
        
        if(startTimestamp == 0) {
            _stakers[msg.sender].startTimestamp = block.timestamp;
        } else {
            _stakers[msg.sender].startTimestamp = startTimestamp;
        }
        if(lastTimestamp == 0) {
            _stakers[msg.sender].lastTimestamp = block.timestamp;
        } else {
            _stakers[msg.sender].lastTimestamp = lastTimestamp;
        }
        
        if(_stakers[msg.sender].startTimestamp > _stakers[msg.sender].lastTimestamp) {
            _stakers[msg.sender].lastTimestamp = block.timestamp;
        }
        
        
    }
    
    function updateMyStakes(address stakerAddress, uint256 balance, uint256 totalSupply) external onlyToken returns (uint256) {     // This function is called by the token contract. Holders call the function on the token contract every day the price is positive to claim rewards.
        
        assert(balance > 0);
        
        staker memory thisStaker = _stakers[stakerAddress];
        
        assert(thisStaker.lastTimestamp > 0/*,"Error: your last timestamp cannot be zero."*/); // We use asserts now so that we fail on errors due to try/catch in token contract.
        
        
        assert(thisStaker.startTimestamp > 0/*,"Error: your start timestamp cannot be zero."*/);
        
        assert(block.timestamp > thisStaker.lastTimestamp/*, "Error: block timestamp is not greater than your last timestamp!"*/);
        assert(_lastUpdate.timestamp > thisStaker.lastTimestamp/*, "Error: you can only update stakes once per day. You also cannot update stakes on the same day that you purchased them."*/);
        
        uint daysStaked = block.timestamp.sub(thisStaker.startTimestamp) / 86400;  // Calculate time staked in days
        
        assert(daysStaked >= _minStakeDurationDays/*, "You must stake for at least minStakeDurationDays to claim rewards"*/);
        assert(balance >= _minStake/*, "You must have a balance of at least minStake to claim rewards"*/);
        
        assert(thisStaker.lastTimestamp >= thisStaker.startTimestamp); // last timestamp should be greater than or equal to start timestamp
        
        uint numTokens = iterativelyCalculateOwedRewards(thisStaker.lastTimestamp, thisStaker.startTimestamp, balance, stakerAddress, totalSupply);
        
        _stakers[stakerAddress].lastTimestamp = block.timestamp;        // Again, this can be gamed to some extent, but *cannot be before the last block*
        emit StakesUpdated(numTokens);
        
        return numTokens;       // Token contract will add these tokens to the balance of stakerAddress
    
        
    }
    
    // This function can be called once a month, when holder's day is enabled
    function claimHoldersDay() external {
        
        require(!holdersDayRewarded[msg.sender]);
        
        staker memory thisStaker = _stakers[msg.sender];
        uint daysStaked = block.timestamp.sub(thisStaker.startTimestamp) / 86400;  // Calculate time staked in days
        
        if (_enableHoldersDay && daysStaked >= 30) {
            if (daysStaked > maxStakingDays) {      // If you stake for more than maxStakingDays days, you have hit the upper limit of the multiplier
                daysStaked = maxStakingDays;
            }
            uint numTokens = mulDiv(token.balanceOf(msg.sender), daysStaked, holdersDayRewardDenominator);   // Once a month, holders get a nice bump
            token.mint(msg.sender, numTokens);
            holdersDayRewarded[msg.sender] == true;
        }
        
    }
    
    
    // Calculate owed rewards for several days, iterating back through the updates array. This is public so that the frontend can calculate expected rewards.
    function iterativelyCalculateOwedRewards(uint stakerLastTimestamp, uint stakerStartTimestamp, uint balance, address stakerAddress, uint totalSupply) public view returns (uint256) {
         
        uint index = updates.length-1; // Start from the latest update and work our way back
        
        uint numTokens = 0;
        
        for(bool end = false; end == false && index >= 0; index--) {
            
            update memory nextUpdate = updates[index];      // Grab the last update from the array
            if(stakerLastTimestamp > nextUpdate.timestamp || stakerStartTimestamp > nextUpdate.timestamp) { // If the staker's last timestamp or start timestamp is ahead of the next update, the staker is not owed the rewards from that update, and the updates array is in chronological order, so we end here
                end = true;
            } else {
                uint estimatedDaysStaked = nextUpdate.timestamp.sub(stakerStartTimestamp) / 86400; // We estimate the staker's holding time from the point of view of this current update
                numTokens += calculateNumTokens(nextUpdate.numerator, nextUpdate.denominator, nextUpdate.price, nextUpdate.volume, nextUpdate.streak, balance, estimatedDaysStaked, stakerAddress, totalSupply); // calculate the owed tokens from this update
                balance += numTokens; // We support compound interest
            }
            
        }
        return numTokens;
    }

    function calculateNumTokens(uint numerator, uint denominator, uint price, uint volume, uint streak, uint256 balance, uint256 daysStaked, address stakerAddress, uint256 totalSupply) public view returns (uint256) { // This is public so that the Pamp frontend can calculate expected rewards without any js issues
        
        if (_useExternalCalc) {
            return _externalCalculator.calculateNumTokens(balance, daysStaked, stakerAddress, totalSupply); // Use external contract, if one is enabled (disabled by default, currently unused)
        }
        
        uint256 inflationAdjustmentFactor = _inflationAdjustmentFactor;
        
        if (streak > 1) {
            inflationAdjustmentFactor /= streak;       // If there is a streak, we decrease the inflationAdjustmentFactor
        }
        
        if (daysStaked > maxStakingDays) {      // If you stake for more than maxStakingDays days, you have hit the upper limit of the multiplier
            daysStaked = maxStakingDays;
        } else if (daysStaked == 0 || daysStaked == 1) {   // If the minimum days staked is zero, we change the number to 1 so we don't return zero below
            daysStaked = 2;
        }
        
        uint ratio = mulDiv(totalSupply, price, 1000E18).div(volume);       // Ratio of market cap (including locked team tokens) to volume
        
        if (ratio > 50) {  // Too little volume. Decrease rewards. To be honest, this number was arbitrarily chosen.
            inflationAdjustmentFactor = inflationAdjustmentFactor.mul(10);
        } else if (ratio > 25) { // Still not enough. Streak doesn't count.
            inflationAdjustmentFactor = _inflationAdjustmentFactor;
        }
        
        uint numTokens = mulDiv(balance, numerator * daysStaked.div(2), denominator * inflationAdjustmentFactor);      // Function that calculates how many tokens are due. See muldiv below.
        uint tenPercent = mulDiv(balance, 1, 10);
        
        if (numTokens > tenPercent) {       // We don't allow a daily rewards of greater than ten percent of a holder's balance.
            numTokens = tenPercent;
        }
        
        return numTokens;
    }
    
    // Self-explanatory functions to update several configuration variables
    
    function updateTokenAddress(PampToken newToken) external onlyOwner {
        require(address(newToken) != address(0));
        token = newToken;
    }
    
    function updateCalculator(CalculatorInterface calc) external onlyOwner {
        if(address(calc) == address(0)) {
            _externalCalculator = CalculatorInterface(address(0));
            _useExternalCalc = false;
        } else {
            _externalCalculator = calc;
            _useExternalCalc = true;
        }
    }
    
    
    function updateInflationAdjustmentFactor(uint256 inflationAdjustmentFactor) external onlyOwner {
        _inflationAdjustmentFactor = inflationAdjustmentFactor;
    }
    
    function updateStreak(uint streak) external onlyOwner {
        _streak = streak;
    }
    
    function updateMinStakeDurationDays(uint8 minStakeDurationDays) external onlyOwner {
        _minStakeDurationDays = minStakeDurationDays;
    }
    
    function updateMinStakes(uint minStake) external onlyOwner {
        _minStake = minStake;
    }
    function updateMinPercentIncrease(uint8 minIncrease) external onlyOwner {
        _minPercentIncrease = minIncrease;
    }
    
    function enableBurns(bool enabledBurns) external onlyOwner {
        _enableBurns = enabledBurns;
    }
    
    function updateWhitelist(address addr, string calldata reason, bool remove) external onlyOwner returns (bool) {
        if (remove) {
            delete _whitelist[addr];
            return true;
        } else {
            _whitelist[addr] = reason;
            return true;
        }
        return false;        
    }
    
    function updateUniWhitelist(address addr, string calldata reason, bool remove) external onlyOwner returns (bool) {
        if (remove) {
            delete _uniwhitelist[addr];
            return true;
        } else {
            _uniwhitelist[addr] = reason;
            return true;
        }
        return false;        
    }
    
    function updateBlacklist(address addr, uint256 fee, bool remove) external onlyOwner returns (bool) {
        if (remove) {
            delete _blacklist[addr];
            return true;
        } else {
            _blacklist[addr] = fee;
            return true;
        }
        return false;
    }
    
    function updateUniswapPair(address addr) external onlyOwner returns (bool) {
        require(addr != address(0));
        _uniswapV2Pair = addr;
        return true;
    }
    
    function updateDirectSellBurns(bool enableDirectSellBurns) external onlyOwner {
        _enableUniswapDirectBurns = enableDirectSellBurns;
    }
    
    function updateUniswapSellerBurnPercent(uint8 sellerBurnPercent) external onlyOwner {
        uniswapSellerBurnPercent = sellerBurnPercent;
    }
    
    function freeze(bool enableFreeze) external onlyOwner {
        _freeze = enableFreeze;
    }
    
    function updateNextStakingContract(address nextContract) external onlyOwner {
        require(nextContract != address(0));
        _nextStakingContract = nextContract;
    }
    
    function updateLiquidityStakingContract(address _liquidityStakingContract) external onlyOwner {
        liquidityStakingContract = _liquidityStakingContract;
    }
    
    function updateOracle(address _oracle) external onlyOwner {
        oracle = _oracle;
    }
    
    function updatePreviousStakingContract(PreviousContract previousContract) external onlyOwner {
        previousStakingContract = previousContract;
    }
    
    function getStaker(address staker) external view returns (uint256, uint256) {
        return (_stakers[staker].startTimestamp, _stakers[staker].lastTimestamp);
    }
    
    function getWhitelist(address addr) external view returns (string memory) {
        return _whitelist[addr];
    }
    
    function getUniWhitelist(address addr) external view returns (string memory) {
        return _uniwhitelist[addr];
    }
    
    function getBlacklist(address addr) external view returns (uint) {
        return _blacklist[addr];
    }
    
    function removeLatestUpdate() external onlyOwner {
        delete updates[updates.length - 1];
    }

    
    // This function was not written by us. It was taken from here: https://medium.com/coinmonks/math-in-solidity-part-3-percents-and-proportions-4db014e080b1
    // We believe it works but do not have the understanding of math required to verify it 100%.
    // Takes in three numbers and calculates x * (y/z)
    // This is very useful for this contract as percentages are used constantly

    function mulDiv (uint x, uint y, uint z) public pure returns (uint) {
          (uint l, uint h) = fullMul (x, y);
          assert (h < z);
          uint mm = mulmod (x, y, z);
          if (mm > l) h -= 1;
          l -= mm;
          uint pow2 = z & -z;
          z /= pow2;
          l /= pow2;
          l += h * ((-pow2) / pow2 + 1);
          uint r = 1;
          r *= 2 - z * r;
          r *= 2 - z * r;
          r *= 2 - z * r;
          r *= 2 - z * r;
          r *= 2 - z * r;
          r *= 2 - z * r;
          r *= 2 - z * r;
          r *= 2 - z * r;
          return l * r;
    }
    
    function fullMul (uint x, uint y) private pure returns (uint l, uint h) {
          uint mm = mulmod (x, y, uint (-1));
          l = x * y;
          h = mm - l;
          if (mm < l) h -= 1;
    }
    
    function streak() public view returns (uint) {
        return _streak;
    }
    
    function inflationAdjustmentFactor() public view returns (uint) {
        return _inflationAdjustmentFactor;
    }


    // Hooks the transfer() function on pamptoken. All transfers call this function. Takes in sender, recipient address and balances and amount and returns sender balance, recipient balance, and burned amount
    function transferHook(address sender, address recipient, uint256 amount, uint256 senderBalance, uint256 recipientBalance) external onlyToken returns (uint256, uint256, uint256) {
        
        if(sender == liquidityStakingContract) {
            token.mint(recipient, amount);          // Liquidity staking rewards are now part of inflation.
            return (senderBalance, recipientBalance, 0);
        }
        
        assert(_freeze == false);
        assert(sender != recipient);
        assert(amount > 0);
        assert(senderBalance >= amount);
        
        
        uint totalAmount = amount;
        bool shouldAddStaker = true;    // We assume that the recipient is a potential staker (not a smart contract)
        uint burnedAmount = 0;
        
        if (_enableBurns && bytes(_whitelist[sender]).length == 0 && bytes(_whitelist[recipient]).length == 0) { // Burns are enabled and neither the recipient nor the sender are whitelisted
                
            burnedAmount = mulDiv(amount, burnFee(), 100);  // Calculates the amount to be burned. Random integer between 1% and 4%. See _randomness() below
            
            
            if (_blacklist[recipient] > 0) {   //Transferring to a blacklisted address incurs a specific fee
                burnedAmount = mulDiv(amount, _blacklist[recipient], 100);      // Calculate the fee. The fee is burnt
                shouldAddStaker = false;            // Blacklisted addresses will never be stakers. Could be an issue if the blacklisted address already is a staker, but likely not an issue
            }
            
            
            
            if (burnedAmount > 0) {
                if (burnedAmount > amount) {
                    totalAmount = 0;
                } else {
                    totalAmount = amount.sub(burnedAmount);
                }
                senderBalance = senderBalance.sub(burnedAmount, "ERC20: burn amount exceeds balance");  // Remove the burned amount from the sender's balance
            }
        } else if (recipient == _uniswapV2Pair) {    // Uniswap was used. This is a special case. Uniswap is burn on receive but whitelist on send, so sellers pay fee and buyers do not.
            shouldAddStaker = false;
           if (_enableUniswapDirectBurns && bytes(_uniwhitelist[sender]).length == 0) { // We check if burns are enabled and if the sender is whitelisted
                burnedAmount = mulDiv(amount, uniswapSellerBurnPercent, 100);     // Seller fee
                if (burnedAmount > 0) {
                    if (burnedAmount > amount) {
                        totalAmount = 0;
                    } else {
                        totalAmount = amount.sub(burnedAmount);
                    }
                    senderBalance = senderBalance.sub(burnedAmount, "ERC20: burn amount exceeds balance");
                }
            }
        
        }
        
        if (bytes(_whitelist[recipient]).length > 0) {
            shouldAddStaker = false;
        }
        
        // Here we calculate the percent of the balance an address is receiving. If the address receives too many tokens, the staking time and last time rewards were claimed is reset to block.timestamp
        // This is necessary because otherwise funds could move from address to address with no penality and thus an individual could claim multiple times with the same funds
        
        if (shouldAddStaker && _stakers[recipient].startTimestamp > 0 && recipientBalance > 0) {  // If you are currently staking, these should all be true
        
            uint percent = mulDiv(1000000, totalAmount, recipientBalance).div(2);      // This is not really 'percent' it is just a number that represents the totalAmount as a fraction of the recipientBalance. We divide by 2 to reduce the effects
            if(percent == 0) {
                percent == 2;
            }
            if(percent.add(_stakers[recipient].startTimestamp) > block.timestamp) {         // We represent the 'percent' as seconds and add to the recipient's unix time
                _stakers[recipient].startTimestamp = block.timestamp;
            } else {
                _stakers[recipient].startTimestamp = _stakers[recipient].startTimestamp.add(percent);               // Receiving too many tokens resets your holding time
            }
            if(percent.add(_stakers[recipient].lastTimestamp) > block.timestamp) {
                _stakers[recipient].lastTimestamp = block.timestamp;
            } else {
                _stakers[recipient].lastTimestamp = _stakers[recipient].lastTimestamp.add(percent);                 // Receiving too many tokens may make you ineligible to claim the next day
            }
        } else if (shouldAddStaker && recipientBalance == 0 && (_stakers[recipient].startTimestamp > 0 || _stakers[recipient].lastTimestamp > 0)) { // Invalid state, so we reset their data/remove them
            delete _stakers[recipient];
            emit StakerRemoved(recipient);
        }
        

        senderBalance = senderBalance.sub(totalAmount, "ERC20: transfer amount exceeds balance");       // Normal ERC20 transfer
        recipientBalance = recipientBalance.add(totalAmount);
        
        if (shouldAddStaker && _stakers[recipient].startTimestamp == 0 && (totalAmount >= _minStake || recipientBalance >= _minStake)) {        // If the recipient was not previously a staker and their balance is now greater than minStake, we add them automatically
            _stakers[recipient] = staker(block.timestamp, block.timestamp);
            emit StakerAdded(recipient);
        }
        
        if (senderBalance < _minStake) {        // If the sender's balance is below the minimum stake, we remove them automatically
            // Remove staker
            delete _stakers[sender];
            emit StakerRemoved(sender);
        } else {
            _stakers[sender].startTimestamp = block.timestamp;      // Sending tokens automatically resets your 'holding time'
            _stakers[sender].lastTimestamp = block.timestamp;       // Can't claim after sending tokens
        }
    
        return (senderBalance, recipientBalance, burnedAmount);
    }
    
    
    function burnFee() internal view returns (uint256) {        // Calculates token burn on transfer between 1% and 4% (integers)
        if(_useExternalCalc) {
            return _externalCalculator.randomness();
        }
        return transferBurnPercent;
    }
    
    function burn(address account, uint256 amount) external onlyOwner {     // We allow ourselves to burn tokens in case they were minted due to a bug
        token._burn(account, amount);
    }
    
    function resetStakeTimeDebug(address account) external onlyOwner {      // We allow ourselves to reset stake times in case they get changed incorrectly due to a bug
    
        _stakers[account].lastTimestamp = block.timestamp;
      
        _stakers[account].startTimestamp = block.timestamp;
        
    }



}
