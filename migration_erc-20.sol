Solidity
// Migration token whit Liquidity

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RFKJMigration is ERC20 {
    address public RFKJAddress; // Dirección del token $RFKJ
    uint256 public RFKJToBOBBYRatio = 1; // Ratio de intercambio (1 $RFKJ = 1 $BOBBY)

    constructor(string memory name, string memory symbol, address _RFKJAddress) ERC20(name, symbol) {
        RFKJAddress = _RFKJAddress;
    }

    function migrateRFKJToBOBBY(uint256 amount) public {
        require(ERC20(RFKJAddress).balanceOf(msg.sender) >= amount, "Insufficient RFKJ balance");

      
        // Quemar tokens $RFKJ transferidos
        ERC20(RFKJAddress).burn(amount);

        // Transferir tokens $RFKJ al contrato
        ERC20(RFKJAddress).transferFrom(msg.sender, address(this), amount);

        // Minting tokens $BOBBY al holder
        _mint(msg.sender, amount * RFKJToBOBBYRatio);
    }
}
