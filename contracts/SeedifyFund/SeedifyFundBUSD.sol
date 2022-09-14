/*
*Seedify.fund
*Decentralized Incubator
*A disruptive blockchain incubator program / decentralized seed stage fund, empowered through DAO based community-involvement mechanisms
*/
pragma solidity ^0.6.0;

// SPDX-License-Identifier: UNLICENSED

import "../ERC20/IERC20.sol";
import "../Ownable/Context.sol";
import "../Ownable/Ownable.sol";
import "../ERC20/SafeERC20.sol";

//SeedifyFundsContract

contract SeedifyFundsContract is Ownable {
    using SafeERC20 for IERC20;

    //token attributes
    string public constant NAME = "Seedify.funds"; //name of the contract
    uint256 public immutable maxCap; // Max cap in BUSD
    uint256 public immutable saleStartTime; // start sale time
    uint256 public immutable saleEndTime; // end sale time
    uint256 public totalBUSDReceivedInAllTier; // total bnd received
    uint256 public totalBUSDInTierOne; // total BUSD for tier one
    uint256 public totalBUSDInTierTwo; // total BUSD for tier Tier
    uint256 public totalBUSDInTierThree; // total BUSD for tier Three
    uint256 public totalBUSDInTierFour; // total BUSD for tier Four
    uint256 public totalBUSDInTierFive; // total BUSD for tier Five
    uint256 public totalBUSDInTierSix; // total BUSD for tier Six
    uint256 public totalBUSDInTierSeven; // total BUSD for tier Seven
    uint256 public totalBUSDInTierEight; // total BUSD for tier Eight
    uint256 public totalBUSDInTierNine; // total BUSD for tier Nine
    uint256 public totalparticipants; // total participants in ido
    address payable public projectOwner; // project Owner

    // max cap per tier
    uint256 public tierOneMaxCap;
    uint256 public tierTwoMaxCap;
    uint256 public tierThreeMaxCap;
    uint256 public tierFourMaxCap;
    uint256 public tierFiveMaxCap;
    uint256 public tierSixMaxCap;
    uint256 public tierSevenMaxCap;
    uint256 public tierEightMaxCap;
    uint256 public tierNineMaxCap;

    //total users per tier
    uint256 public totalUserInTierOne;
    uint256 public totalUserInTierTwo;
    uint256 public totalUserInTierThree;
    uint256 public totalUserInTierFour;
    uint256 public totalUserInTierFive;
    uint256 public totalUserInTierSix;
    uint256 public totalUserInTierSeven;
    uint256 public totalUserInTierEight;
    uint256 public totalUserInTierNine;

    //max allocations per user in a tier
    uint256 public maxAllocaPerUserTierOne;
    uint256 public maxAllocaPerUserTierTwo;
    uint256 public maxAllocaPerUserTierThree;
    uint256 public maxAllocaPerUserTierFour;
    uint256 public maxAllocaPerUserTierFive;
    uint256 public maxAllocaPerUserTierSix;
    uint256 public maxAllocaPerUserTierSeven;
    uint256 public maxAllocaPerUserTierEight;
    uint256 public maxAllocaPerUserTierNine;

    //min allocation per user in a tier
    uint256 public minAllocaPerUserTierOne;
    uint256 public minAllocaPerUserTierTwo;
    uint256 public minAllocaPerUserTierThree;
    uint256 public minAllocaPerUserTierFour;
    uint256 public minAllocaPerUserTierFive;
    uint256 public minAllocaPerUserTierSix;
    uint256 public minAllocaPerUserTierSeven;
    uint256 public minAllocaPerUserTierEight;
    uint256 public minAllocaPerUserTierNine;

    // address array for tier one whitelist
    address[] private whitelistTierOne;

    // address array for tier two whitelist
    address[] private whitelistTierTwo;

    // address array for tier three whitelist
    address[] private whitelistTierThree;

    // address array for tier Four whitelist
    address[] private whitelistTierFour;

    // address array for tier three whitelist
    address[] private whitelistTierFive;

    // address array for tier three whitelist
    address[] private whitelistTierSix;

    // address array for tier three whitelist
    address[] private whitelistTierSeven;

    // address array for tier three whitelist
    address[] private whitelistTierEight;

    // address array for tier three whitelist
    address[] private whitelistTierNine;

    IERC20 public ERC20Interface;
    address public tokenAddress;

    //mapping the user purchase per tier
    mapping(address => uint256) public buyInOneTier;
    mapping(address => uint256) public buyInTwoTier;
    mapping(address => uint256) public buyInThreeTier;
    mapping(address => uint256) public buyInFourTier;
    mapping(address => uint256) public buyInFiveTier;
    mapping(address => uint256) public buyInSixTier;
    mapping(address => uint256) public buyInSevenTier;
    mapping(address => uint256) public buyInEightTier;
    mapping(address => uint256) public buyInNineTier;

    // CONSTRUCTOR
    constructor(
        uint256 _maxCap,
        uint256 _saleStartTime,
        uint256 _saleEndTime,
        address payable _projectOwner,
        uint256 _tierOneValue,
        uint256 _tierTwoValue,
        uint256 _tierThreeValue,
        uint256 _tierFourValue,
        uint256 _tierFiveValue,
        uint256 _tierSixValue,
        uint256 _tierSevenValue,
        uint256 _tierEightValue,
        uint256 _tierNineValue,
        uint256 _totalparticipants,
        address _tokenAddress
    ) public {
        maxCap = _maxCap;
        saleStartTime = _saleStartTime;
        saleEndTime = _saleEndTime;

        projectOwner = _projectOwner;
        tierOneMaxCap = _tierOneValue;
        tierTwoMaxCap = _tierTwoValue;
        tierThreeMaxCap = _tierThreeValue;
        tierFourMaxCap = _tierFourValue;
        tierFiveMaxCap = _tierFiveValue;
        tierSixMaxCap = _tierSixValue;
        tierSevenMaxCap = _tierSevenValue;
        tierEightMaxCap = _tierEightValue;
        tierNineMaxCap = _tierNineValue;

        minAllocaPerUserTierOne = 10000000000000;
        minAllocaPerUserTierTwo = 20000000000000;
        minAllocaPerUserTierThree = 30000000000000;
        minAllocaPerUserTierFour = 40000000000000;
        minAllocaPerUserTierFive = 50000000000000;
        minAllocaPerUserTierSix = 60000000000000;
        minAllocaPerUserTierSeven = 70000000000000;
        minAllocaPerUserTierEight = 80000000000000;
        minAllocaPerUserTierNine = 90000000000000;
        
        totalUserInTierOne = 2;
        totalUserInTierTwo = 2;
        totalUserInTierThree = 2;
        totalUserInTierFour = 2;
        totalUserInTierFive = 2;
        totalUserInTierSix = 2;
        totalUserInTierSeven = 2;
        totalUserInTierEight = 2;
        totalUserInTierNine = 2;
        
        maxAllocaPerUserTierOne = tierOneMaxCap / totalUserInTierOne;
        maxAllocaPerUserTierTwo = tierTwoMaxCap / totalUserInTierTwo;
        maxAllocaPerUserTierThree = tierThreeMaxCap / totalUserInTierThree;
        maxAllocaPerUserTierFour = tierFourMaxCap / totalUserInTierFour;
        maxAllocaPerUserTierFive = tierFiveMaxCap / totalUserInTierFive;
        maxAllocaPerUserTierSix = tierSixMaxCap / totalUserInTierSix;
        maxAllocaPerUserTierSeven = tierSevenMaxCap / totalUserInTierSeven;
        maxAllocaPerUserTierEight = tierEightMaxCap / totalUserInTierEight;
        maxAllocaPerUserTierNine = tierNineMaxCap / totalUserInTierNine;
        totalparticipants = _totalparticipants;
        require(_tokenAddress != address(0), "Zero token address"); //Adding token to the contract
        tokenAddress = _tokenAddress;
        ERC20Interface = IERC20(tokenAddress);
    }

    // function to update the tiers value manually
    function updateTierValues(
        uint256 _tierOneValue,
        uint256 _tierTwoValue,
        uint256 _tierThreeValue,
        uint256 _tierFourValue,
        uint256 _tierFiveValue,
        uint256 _tierSixValue,
        uint256 _tierSevenValue,
        uint256 _tierEightValue,
        uint256 _tierNineValue
    ) external onlyOwner {
        tierOneMaxCap = _tierOneValue;
        tierTwoMaxCap = _tierTwoValue;
        tierThreeMaxCap = _tierThreeValue;
        tierFourMaxCap = _tierFourValue;
        tierFiveMaxCap = _tierFiveValue;
        tierSixMaxCap = _tierSixValue;
        tierSevenMaxCap = _tierSevenValue;
        tierEightMaxCap = _tierEightValue;
        tierNineMaxCap = _tierNineValue;

        maxAllocaPerUserTierOne = tierOneMaxCap / totalUserInTierOne;
        maxAllocaPerUserTierTwo = tierTwoMaxCap / totalUserInTierTwo;
        maxAllocaPerUserTierThree = tierThreeMaxCap / totalUserInTierThree;
        maxAllocaPerUserTierFour = tierFourMaxCap / totalUserInTierFour;
        maxAllocaPerUserTierFive = tierFiveMaxCap / totalUserInTierFive;
        maxAllocaPerUserTierSix = tierSixMaxCap / totalUserInTierSix;
        maxAllocaPerUserTierSeven = tierSevenMaxCap / totalUserInTierSeven;
        maxAllocaPerUserTierEight = tierEightMaxCap / totalUserInTierEight;
        maxAllocaPerUserTierNine = tierNineMaxCap / totalUserInTierNine;
    }

    // function to update the tiers users value manually
    function updateTierUsersValue(
        uint256 _tierOneUsersValue,
        uint256 _tierTwoUsersValue,
        uint256 _tierThreeUsersValue,
        uint256 _tierFourUsersValue,
        uint256 _tierFiveUsersValue,
        uint256 _tierSixUsersValue,
        uint256 _tierSevenUsersValue,
        uint256 _tierEightUsersValue,
        uint256 _tierNineUsersValue
    ) external onlyOwner {
        totalUserInTierOne = _tierOneUsersValue;
        totalUserInTierTwo = _tierTwoUsersValue;
        totalUserInTierThree = _tierThreeUsersValue;
        totalUserInTierFour = _tierFourUsersValue;
        totalUserInTierFive = _tierFiveUsersValue;
        totalUserInTierSix = _tierSixUsersValue;
        totalUserInTierSeven = _tierSevenUsersValue;
        totalUserInTierEight = _tierEightUsersValue;
        totalUserInTierNine = _tierNineUsersValue;

        maxAllocaPerUserTierOne = tierOneMaxCap / totalUserInTierOne;
        maxAllocaPerUserTierTwo = tierTwoMaxCap / totalUserInTierTwo;
        maxAllocaPerUserTierThree = tierThreeMaxCap / totalUserInTierThree;
        maxAllocaPerUserTierFour = tierFourMaxCap / totalUserInTierFour;
        maxAllocaPerUserTierFive = tierFiveMaxCap / totalUserInTierFive;
        maxAllocaPerUserTierSix = tierSixMaxCap / totalUserInTierSix;
        maxAllocaPerUserTierSeven = tierSevenMaxCap / totalUserInTierSeven;
        maxAllocaPerUserTierEight = tierEightMaxCap / totalUserInTierEight;
        maxAllocaPerUserTierNine = tierNineMaxCap / totalUserInTierNine;
    }

    //add the address in Whitelist tier One to invest
    function addWhitelistOne(address _address) external onlyOwner {
        require(_address != address(0), "Invalid address");
        whitelistTierOne.push(_address);
    }

    //add the address in Whitelist tier two to invest
    function addWhitelistTwo(address _address) external onlyOwner {
        require(_address != address(0), "Invalid address");
        whitelistTierTwo.push(_address);
    }

    //add the address in Whitelist tier three to invest
    function addWhitelistThree(address _address) external onlyOwner {
        require(_address != address(0), "Invalid address");
        whitelistTierThree.push(_address);
    }

    //add the address in Whitelist tier Four to invest
    function addWhitelistFour(address _address) external onlyOwner {
        require(_address != address(0), "Invalid address");
        whitelistTierFour.push(_address);
    }

    //add the address in Whitelist tier three to invest
    function addWhitelistFive(address _address) external onlyOwner {
        require(_address != address(0), "Invalid address");
        whitelistTierFive.push(_address);
    }

    //add the address in Whitelist tier three to invest
    function addWhitelistSix(address _address) external onlyOwner {
        require(_address != address(0), "Invalid address");
        whitelistTierSix.push(_address);
    }

    //add the address in Whitelist tier three to invest
    function addWhitelistSeven(address _address) external onlyOwner {
        require(_address != address(0), "Invalid address");
        whitelistTierSeven.push(_address);
    }

    //add the address in Whitelist tier three to invest
    function addWhitelistEight(address _address) external onlyOwner {
        require(_address != address(0), "Invalid address");
        whitelistTierEight.push(_address);
    }

    //add the address in Whitelist tier three to invest
    function addWhitelistNine(address _address) external onlyOwner {
        require(_address != address(0), "Invalid address");
        whitelistTierNine.push(_address);
    }

    // check the address in whitelist tier one
    function getWhitelistOne(address _address) public view returns (bool) {
        uint256 i;
        uint256 length = whitelistTierOne.length;
        for (i = 0; i < length; i++) {
            address _addressArr = whitelistTierOne[i];
            if (_addressArr == _address) {
                return true;
            }
        }
        return false;
    }

    // check the address in whitelist tier two
    function getWhitelistTwo(address _address) public view returns (bool) {
        uint256 i;
        uint256 length = whitelistTierTwo.length;
        for (i = 0; i < length; i++) {
            address _addressArr = whitelistTierTwo[i];
            if (_addressArr == _address) {
                return true;
            }
        }
        return false;
    }

    // check the address in whitelist tier three
    function getWhitelistThree(address _address) public view returns (bool) {
        uint256 i;
        uint256 length = whitelistTierThree.length;
        for (i = 0; i < length; i++) {
            address _addressArr = whitelistTierThree[i];
            if (_addressArr == _address) {
                return true;
            }
        }
        return false;
    }

    // check the address in whitelist tier Four
    function getWhitelistFour(address _address) public view returns (bool) {
        uint256 i;
        uint256 length = whitelistTierFour.length;
        for (i = 0; i < length; i++) {
            address _addressArr = whitelistTierFour[i];
            if (_addressArr == _address) {
                return true;
            }
        }
        return false;
    }

    // check the address in whitelist tier Five
    function getWhitelistFive(address _address) public view returns (bool) {
        uint256 i;
        uint256 length = whitelistTierFive.length;
        for (i = 0; i < length; i++) {
            address _addressArr = whitelistTierFive[i];
            if (_addressArr == _address) {
                return true;
            }
        }
        return false;
    }

    // check the address in whitelist tier Six
    function getWhitelistSix(address _address) public view returns (bool) {
        uint256 i;
        uint256 length = whitelistTierSix.length;
        for (i = 0; i < length; i++) {
            address _addressArr = whitelistTierSix[i];
            if (_addressArr == _address) {
                return true;
            }
        }
        return false;
    }

    // check the address in whitelist tier Seven
    function getWhitelistSeven(address _address) public view returns (bool) {
        uint256 i;
        uint256 length = whitelistTierSeven.length;
        for (i = 0; i < length; i++) {
            address _addressArr = whitelistTierSeven[i];
            if (_addressArr == _address) {
                return true;
            }
        }
        return false;
    }

    // check the address in whitelist tier Eight
    function getWhitelistEight(address _address) public view returns (bool) {
        uint256 i;
        uint256 length = whitelistTierEight.length;
        for (i = 0; i < length; i++) {
            address _addressArr = whitelistTierEight[i];
            if (_addressArr == _address) {
                return true;
            }
        }
        return false;
    }

    // check the address in whitelist tier Nine
    function getWhitelistNine(address _address) public view returns (bool) {
        uint256 i;
        uint256 length = whitelistTierNine.length;
        for (i = 0; i < length; i++) {
            address _addressArr = whitelistTierNine[i];
            if (_addressArr == _address) {
                return true;
            }
        }
        return false;
    }

    modifier _hasAllowance(address allower, uint256 amount) {
        // Make sure the allower has provided the right allowance.
        // ERC20Interface = IERC20(tokenAddress);
        uint256 ourAllowance = ERC20Interface.allowance(allower, address(this));
        require(amount <= ourAllowance, "Make sure to add enough allowance");
        _;
    }

    function buyTokens(uint256 amount)
        external
        _hasAllowance(msg.sender, amount)
        returns (bool)
    {
        require(now >= saleStartTime, "The sale is not started yet "); // solhint-disable
        require(now <= saleEndTime, "The sale is closed"); // solhint-disable
        require(
            totalBUSDReceivedInAllTier + amount <= maxCap,
            "buyTokens: purchase would exceed max cap"
        );

        if (getWhitelistOne(msg.sender)) {
            buyInOneTier[msg.sender] += amount;
            require(
                buyInOneTier[msg.sender] >= minAllocaPerUserTierOne,
                "your purchasing Power is so Low"
            );
            require(
                totalBUSDInTierOne + amount <= tierOneMaxCap,
                "buyTokens: purchase would exceed Tier one max cap"
            );
            require(
                buyInOneTier[msg.sender] <= maxAllocaPerUserTierOne,
                "buyTokens:You are investing more than your tier-1 limit!"
            );

            totalBUSDReceivedInAllTier += amount;
            totalBUSDInTierOne += amount;
            ERC20Interface.safeTransferFrom(msg.sender, projectOwner, amount); //changes to transfer BUSD to owner
        } else if (getWhitelistTwo(msg.sender)) {
            buyInTwoTier[msg.sender] += amount;
            require(
                buyInTwoTier[msg.sender] >= minAllocaPerUserTierTwo,
                "your purchasing Power is so Low"
            );
            require(
                totalBUSDInTierTwo + amount <= tierTwoMaxCap,
                "buyTokens: purchase would exceed Tier two max cap"
            );
            require(
                buyInTwoTier[msg.sender] <= maxAllocaPerUserTierTwo,
                "buyTokens:You are investing more than your tier-2 limit!"
            );
            totalBUSDReceivedInAllTier += amount;
            totalBUSDInTierTwo += amount;
            ERC20Interface.safeTransferFrom(msg.sender, projectOwner, amount); //changes to transfer BUSD to owner
        } else if (getWhitelistThree(msg.sender)) {
            buyInThreeTier[msg.sender] += amount;
            require(
                buyInThreeTier[msg.sender] >= minAllocaPerUserTierThree,
                "your purchasing Power is so Low"
            );
            require(
                buyInThreeTier[msg.sender] <= maxAllocaPerUserTierThree,
                "buyTokens:You are investing more than your tier-3 limit!"
            );
            require(
                totalBUSDInTierThree + amount <= tierThreeMaxCap,
                "buyTokens: purchase would exceed Tier three max cap"
            );
            totalBUSDReceivedInAllTier += amount;
            totalBUSDInTierThree += amount;
            ERC20Interface.safeTransferFrom(msg.sender, projectOwner, amount); //changes to transfer BUSD to owner
        } else if (getWhitelistFour(msg.sender)) {
            buyInFourTier[msg.sender] += amount;
            require(
                buyInFourTier[msg.sender] >= minAllocaPerUserTierFour,
                "your purchasing Power is so Low"
            );
            require(
                totalBUSDInTierFour + amount <= tierFourMaxCap,
                "buyTokens: purchase would exceed Tier Four max cap"
            );
            require(
                buyInFourTier[msg.sender] <= maxAllocaPerUserTierFour,
                "buyTokens:You are investing more than your tier-4 limit!"
            );
            totalBUSDReceivedInAllTier += amount;
            totalBUSDInTierFour += amount;
            ERC20Interface.safeTransferFrom(msg.sender, projectOwner, amount); //changes to transfer BUSD to owner
        } else if (getWhitelistFive(msg.sender)) {
            buyInFiveTier[msg.sender] += amount;
            require(
                buyInFiveTier[msg.sender] >= minAllocaPerUserTierFive,
                "your purchasing Power is so Low"
            );
            require(
                totalBUSDInTierFive + amount <= tierFiveMaxCap,
                "buyTokens: purchase would exceed Tier Five max cap"
            );
            require(
                buyInFiveTier[msg.sender] <= maxAllocaPerUserTierFive,
                "buyTokens:You are investing more than your tier-5 limit!"
            );
            totalBUSDReceivedInAllTier += amount;
            totalBUSDInTierFive += amount;
            ERC20Interface.safeTransferFrom(msg.sender, projectOwner, amount); //changes to transfer BUSD to owner
        } else if (getWhitelistSix(msg.sender)) {
            buyInSixTier[msg.sender] += amount;
            require(
                buyInSixTier[msg.sender] >= minAllocaPerUserTierSix,
                "your purchasing Power is so Low"
            );
            require(
                totalBUSDInTierSix + amount <= tierSixMaxCap,
                "buyTokens: purchase would exceed Tier Six max cap"
            );
            require(
                buyInSixTier[msg.sender] <= maxAllocaPerUserTierSix,
                "buyTokens:You are investing more than your tier-6 limit!"
            );
            totalBUSDReceivedInAllTier += amount;
            totalBUSDInTierSix += amount;
            ERC20Interface.safeTransferFrom(msg.sender, projectOwner, amount); //changes to transfer BUSD to owner
        } else if (getWhitelistSeven(msg.sender)) {
            buyInSevenTier[msg.sender] += amount;
            require(
                buyInSevenTier[msg.sender] >= minAllocaPerUserTierSeven,
                "your purchasing Power is so Low"
            );
            require(
                totalBUSDInTierSeven + amount <= tierSevenMaxCap,
                "buyTokens: purchase would exceed Tier Seven max cap"
            );
            require(
                buyInSevenTier[msg.sender] <= maxAllocaPerUserTierSeven,
                "buyTokens:You are investing more than your tier-7 limit!"
            );
            totalBUSDReceivedInAllTier += amount;
            totalBUSDInTierSeven += amount;
            ERC20Interface.safeTransferFrom(msg.sender, projectOwner, amount); //changes to transfer BUSD to owner
        } else if (getWhitelistEight(msg.sender)) {
            buyInEightTier[msg.sender] += amount;
            require(
                buyInEightTier[msg.sender] >= minAllocaPerUserTierEight,
                "your purchasing Power is so Low"
            );
            require(
                totalBUSDInTierEight + amount <= tierEightMaxCap,
                "buyTokens: purchase would exceed Tier Eight max cap"
            );
            require(
                buyInEightTier[msg.sender] <= maxAllocaPerUserTierEight,
                "buyTokens:You are investing more than your tier-8 limit!"
            );
            totalBUSDReceivedInAllTier += amount;
            totalBUSDInTierEight += amount;
            ERC20Interface.safeTransferFrom(msg.sender, projectOwner, amount); //changes to transfer BUSD to owner
        } else if (getWhitelistNine(msg.sender)) {
            buyInNineTier[msg.sender] += amount;
            require(
                buyInNineTier[msg.sender] >= minAllocaPerUserTierNine,
                "your purchasing Power is so Low"
            );
            require(
                totalBUSDInTierNine + amount <= tierNineMaxCap,
                "buyTokens: purchase would exceed Tier Nine max cap"
            );
            require(
                buyInNineTier[msg.sender] <= maxAllocaPerUserTierNine,
                "buyTokens:You are investing more than your tier-9 limit!"
            );
            totalBUSDReceivedInAllTier += amount;
            totalBUSDInTierNine += amount;
            ERC20Interface.safeTransferFrom(msg.sender, projectOwner, amount); //changes to transfer BUSD to owner
        } else {
            revert("Not whitelisted");
        }
        return true;
    }
}