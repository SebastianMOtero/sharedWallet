// scripts/deploy.js
async function main() {
    // We get the contract to deploy
    const simpleWalletFactory = await ethers.getContractFactory('SimpleWallet');
    console.log('Deploying SimpleWallet...');
    const simpleWallet = await simpleWalletFactory.deploy();
    await simpleWallet.deployed();
    console.log('simpleWallet deployed to:', simpleWallet.address);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });