pragma solidity >=0.4.22;

import "./registerNode.sol";

contract PowerTradingTransaction is registerNode {

    struct SellPower {
    address producer;
    uint32 price;
    uint64 power;
    uint64 timestamp;
  }

  struct BuyPower {
    address producer;
    uint32 price;
    uint64 power;
    address nodeAddress;
    uint64 timestamp;
  }

  //add address of the universal supplier
  address public universalSupplier = 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C;

  SellPower[] public sellPowers;
  BuyPower[] public buyPowers;

  //stores the amount of power supplied by the producer
  BuyPower[] public producerpower;

  mapping(address => uint) public sellIndex;
  mapping(address => uint) public buyIndex;
  
  event sellEvent(address indexed producer, uint32 indexed price, uint64 power);
  event buyEvent(address indexed producer, uint32 price, uint64 power, address meterAddress);

  function sellpower(uint32 aprice, uint64 apower, uint64 atimestamp) onlyRegisteredMeters public {
    
    require(apower >= 1);

    // recording the sell transaction
    uint idx = sellIndex[msg.sender];

    sellPowers.push(SellPower({
      producer: msg.sender,
      price: aprice,
      power: apower,
      timestamp: atimestamp
      }));
    emit sellEvent(sellPowers[idx].producer, sellPowers[idx].price, sellPowers[idx].power);
  }

  function buypower(address aproducer, uint32 aprice, uint64 apower, address mAddress, uint64 atimestamp) onlyRegisteredMeters public {
    // finding offer by the power producer 
    uint idx = sellIndex[aproducer];

    require(0x0 != idx);

    // If the offer is valid
    if ((sellPowers.length > idx) && (sellPowers[idx].producer == aproducer)) {
      //If it corresponds to the price
      require(sellPowers[idx].price == aprice);

      buyIndex[msg.sender] = buyPowers.length;
     
      buyPowers.push(BuyPower({
        producer: aproducer,
        price: aprice,
        power: apower,
        nodeAddress: mAddress,
        timestamp: atimestamp
        }));
      emit buyEvent(aproducer, aprice, apower, mAddress);

      //checks if the consumer received from the producer and logs it
      require(buyPowers[idx].producer == universalSupplier);
      producerpower.push(BuyPower({
        producer: aproducer,
        price: aprice,
        power: apower,
        nodeAddress: mAddress,
        timestamp: atimestamp
        }));

     } else {
      revert();
    }
  }
}
