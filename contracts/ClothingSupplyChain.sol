pragma solidity ^0.8.11;

import "./SupplyChainStorage.sol";



contract ClothingSupplyChain {
    SupplyChainStorage supplyChainStorage;
    event CottonHarvested(address indexed user, address indexed batchNo);
    event CottonBatchNo(address indexed user, string registrationNo,string farmerName,string farmAddress,string exporterName,string importerName);
    event FabricManufactured(address indexed user, address indexed batchNo);
    event ShirtManufactured(address indexed user, address indexed batchNo);
    event RetrievedAll(address indexed user, SupplyChainStorage.basicDetails[] result);

    struct basicDetails{
        string registrationNo;
        
        string farmerName;
        string farmAddress;
        string exporterName;
        string importerName;
    }

    constructor(address _supplyChainAddress) public{
        supplyChainStorage = SupplyChainStorage(_supplyChainAddress);
    }

        function setBasicDetails(string memory _registrationNo,
                             string memory _farmerName,
                             string memory _farmAddress,
                             string memory _exporterName,
                             string memory _importerName
                            ) public  returns(address) {
    
        address batchNo = supplyChainStorage.setBasicDetails(_registrationNo,
                                                            _farmerName,
                                                            _farmAddress,
                                                            _exporterName,
                                                            _importerName);
        
        emit CottonHarvested(msg.sender, batchNo); 
        
        return (batchNo);
    }
     function getBasicDetails(address _batchNo) public  returns (string memory registrationNo,
                                                                     string memory farmerName,
                                                                     string memory farmAddress,
                                                                     string memory exporterName,
                                                                     string memory importerName) {
        /* Call Storage Contract */
        (registrationNo, farmerName, farmAddress, exporterName, importerName) = supplyChainStorage.getBasicDetails(_batchNo);  
        emit CottonBatchNo(msg.sender,registrationNo, farmerName, farmAddress, exporterName, importerName);
        return (registrationNo, farmerName, farmAddress, exporterName, importerName);
    }

    function getAllBasicDetails() public returns(SupplyChainStorage.basicDetails[] memory result){
        SupplyChainStorage.basicDetails[] memory tempResult = supplyChainStorage.getAllBasicDetails();
        emit RetrievedAll(msg.sender, tempResult);
        return(tempResult);
    }

}