    // Set initial constant as timer for the lock time in hours
    uint256 private constant lockDuration = 24 hours;
    
    // Keeps track of the timer for each wallet locked
    mapping(address => uint256) private lockTimers;

    // Minting 2.5% of the total supply to WalletAddress1 !! UNLOCKED ON LAUNCH !!
    uint256 wallet1Amount = (_totalSupply * 25) / 1000; // 2.5% to MW 1
    balances[address(0x0000000000000000000000000000000000000000)] = wallet1Amount;

    // Minting 2.5% of the total supply to WalletAddress2 !! UNLOCKED 24H AFTER LAUNCH !!
    uint256 wallet2Amount = (_totalSupply * 25) / 1000; // 2.5% to MW 2
    balances[address(0x0000000000000000000000000000000000000000)] = wallet2Amount;

    // Totals up all of the tokens to be minted and sets it as the total amount to mint in the token supply creation
    uint256 totalMintAmount = wallet1Amount + wallet2Amount;
    
    // Adds rest of tokens minus the lockjed amount to Dev wallet
    uint256 adjustedCreatorAmount = _totalSupply - totalMintAmount;
    
    // Sets the initial lock duration + time to add to create a set up locks that expire over given time period per wallet
    lockTimers[0x0000000000000000000000000000000000000000] = block.timestamp + lockDuration; // UNLOCK 24H AFTER LAUNCH
    lockTimers[0x0000000000000000000000000000000000000000] = block.timestamp + lockDuration + 72 hours; // UNLOCK 4 DAYS AFTER LAUNCH
    
    / Add to transfer and transferfrom functions of token contract as a require statement to set up the locks
    require(isUnlocked(msg.sender), "Tokens are currently locked");
