// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

error foodTrusty__NotRegistered();

contract foodTrusty is Ownable {
    mapping(address => bool) public restaurant;
    mapping(address => bool) public manufacturer;
    mapping(address => bool) public grower;
    mapping(address => bool) public slaughter;
    mapping(address => bool) public wholesaler;
    mapping(address => bool) public admin;
    mapping(uint256 => string) public productToHash;

    uint256 productID = 1;

    struct product {
        string ipfsHash;
        uint256 addingTime;
        uint256 productId;
    }
    product[] public products;

    event productAdd(address indexed adder, uint256 indexed productId);

    constructor() {
        manufacturer[0xb636C663De47df7cf95F1E87C86745dd7f7E3d67] = true;
        manufacturer[0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266] = true;
    }

    modifier isRegistered(address _addresss) {
        if (
            restaurant[_addresss] ||
            manufacturer[_addresss] ||
            grower[_addresss] ||
            slaughter[_addresss] ||
            wholesaler[_addresss] ||
            admin[_addresss]
        ) {
            _;
        } else revert foodTrusty__NotRegistered();
    }

    function addProduct(
        string memory _ipfsHash
    ) public isRegistered(msg.sender) {
        products.push(product(_ipfsHash, block.timestamp, productID));
        productToHash[productID] = _ipfsHash;
        emit productAdd(msg.sender, productID);

        productID++;
    }

    function addRestaurant(address _restaurant) public onlyOwner {
        restaurant[_restaurant] = true;
    }

    function addGrower(address _grower) public onlyOwner {
        grower[_grower] = true;
    }

    function addSlaughter(address _slaughter) public onlyOwner {
        slaughter[_slaughter] = true;
    }

    function addManufacturer(address _manufacturer) public onlyOwner {
        manufacturer[_manufacturer] = true;
    }

    function addWholesaler(address _wholesaler) public onlyOwner {
        wholesaler[_wholesaler] = true;
    }

    function getProductById(
        uint256 _productId
    ) public view returns (string memory, uint256, uint256) {
        product memory _product = products[_productId - 1];
        return (_product.ipfsHash, _product.addingTime, _product.productId);
    }

    function getManufacturer(address _manufacturer) public view returns (bool) {
        return manufacturer[_manufacturer];
    }

    function getRestaurant(address _restaurant) public view returns (bool) {
        return restaurant[_restaurant];
    }

    function getGrower(address _grower) public view returns (bool) {
        return grower[_grower];
    }

    function getSlaughter(address _slaughter) public view returns (bool) {
        return slaughter[_slaughter];
    }

    function getWholesaler(address _wholesaler) public view returns (bool) {
        return wholesaler[_wholesaler];
    }

    function getAdmin(address _admin) public view returns (bool) {
        return admin[_admin];
    }

    function getIpfsHashById(
        uint256 _productId
    ) public view returns (string memory) {
        return productToHash[_productId];
    }

    function getLastProductId() public view returns (uint256) {
        return productID;
    }
}
