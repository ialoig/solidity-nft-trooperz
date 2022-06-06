<p align="center">
  <img width="200" height="200" src="./assets/img/logo/trooper.svg">
</p>
<h1 align="center"> NFT Trooperz </h1>

<h2> Mint your own NFT Trooperz Collection</h2>



# 🚀 Getting started

1.  **Setup local tooling**
    ```shell
    mkdir project-name
    cd project-name
    npm init -y
    npm install --save-dev hardhat
    ```

Now you can install a sample project, running:

```shell
    npx harhat
```

Go ahead and install these other dependencies just in case it didn't do it automatically.

```shell
    npm install --save-dev @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers
    npm install @openzeppelin/contracts
```

2.  **To run the contract locally**

    ```shell
    npx hardhat run scripts/run.js
    ```

3.  **To deploy the contract on Ethereum [Rinkeby network](https://hardhat.org/tutorial/deploying-to-a-live-network.html#_7-deploying-to-a-live-network)**


    ```shell
    npx hardhat run scripts/deploy.js --network rinkeby
    ```

# 📚 Advanced Sample Hardhat Project 👷‍

This project demonstrates an advanced Hardhat use case, integrating other tools commonly used alongside Hardhat in the ecosystem.

The project comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts. It also comes with a variety of other tools, preconfigured to work with the project code.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
npx hardhat help
REPORT_GAS=true npx hardhat test
npx hardhat coverage
npx hardhat run scripts/deploy.js
node scripts/deploy.js
npx eslint '**/*.js'
npx eslint '**/*.js' --fix
npx prettier '**/*.{json,sol,md}' --check
npx prettier '**/*.{json,sol,md}' --write
npx solhint 'contracts/**/*.sol'
npx solhint 'contracts/**/*.sol' --fix
```

# ✅ Etherscan verification

To try out Etherscan verification, you first need to deploy a contract to an Ethereum network that's supported by Etherscan, such as Ropsten.

In this project, copy the .env.example file to a file named .env, and then edit it to fill in the details. Enter your Etherscan API key, your Ropsten node URL (eg from Alchemy), and the private key of the account which will send the deployment transaction. With a valid .env file in place, first deploy your contract:

```shell
hardhat run --network rinkeby scripts/deploy.js
```

Then, copy the deployment address and paste it in to replace `DEPLOYED_CONTRACT_ADDRESS` in this command:

```shell
npx hardhat verify --network rinkeby DEPLOYED_CONTRACT_ADDRESS "Hello, Hardhat!"
```


# 🔭 Learning Solidity
## Function Visibility Specifiers

```shell
    function myFunction() <visibility specifier> returns (bool) {
        return true;
    }
```

- `public`: visible externally and internally (creates a getter function for storage/state variables)

- `private`: only visible in the current contract

- `external`: only visible externally (only for functions) - i.e. can only be message-called (via this.func)

- `internal`: only visible internally

### Modifiers
- `pure` for functions: Disallows modification or access of state.

- `view` for functions: Disallows modification of state.

- `payable` for functions: Allows them to receive Ether together with a call.

- `constant` for state variables: Disallows assignment (except initialisation), does not occupy storage slot.

- `immutable` for state variables: Allows exactly one assignment at construction time and is constant afterwards. Is stored in code.

- `anonymous` for events: Does not store event signature as topic.

- `indexed` for event parameters: Stores the parameter as topic.

- `virtual` for functions and modifiers: Allows the function’s or modifier’s behaviour to be changed in derived contracts.

- `override`: States that this function, modifier or public state variable changes the behaviour of a function or modifier in a base contract.