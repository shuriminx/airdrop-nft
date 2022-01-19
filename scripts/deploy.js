const hre = require("hardhat");
const fs = require('fs');

async function main() {
  const Gallery = await hre.ethers.getContractFactory("Gallery");
  const gallery = await Gallery.deploy();
  await gallery.deployed();
  console.log("gallery deployed to:", gallery.address);

  const NFT = await hre.ethers.getContractFactory("NFT");
  const nft = await NFT.deploy(gallery.address);
  await nft.deployed();
  console.log("nft deployed to:", nft.address);

  let config = `
  export const gallaryaddress = "${gallery.address}"
  export const nftaddress = "${nft.address}"
  `

  let data = JSON.stringify(config)
  fs.writeFileSync('src/contract-config.js', JSON.parse(data))

}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
