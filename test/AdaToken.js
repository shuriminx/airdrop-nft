const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('AdaToken contract', ()=> {
    let AdaTokenFactory, token, owner, addr1, addr2;

    beforeEach(async ()=> {
        AdaTokenFactory = await ethers.getContractFactory('AdaToken')
        token = await AdaTokenFactory.deploy();
        [owner, addr1, addr2 ]= await ethers.getSigners();
    });


});