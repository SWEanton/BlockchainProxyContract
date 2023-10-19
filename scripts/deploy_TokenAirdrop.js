async function main() {
    const [deployer] = await ethers.getSigners();
    console.log(`Deploying contracts with the account: ${deployer.address}`);

    const TokenAirdrop = await ethers.getContractFactory("TokenAirdrop");
    const tokenAirdrop = await TokenAirdrop.deploy();


    console.log(`TokenAirdrop deployed at address: ${tokenAirdrop.address}`);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });

