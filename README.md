# BLOCKCHAIN-VOTING
Online voting using  Ethereum blockchain environment and React Js frontend.

<h2> Installation Guide </h2>

-> Go to client directory ( cd client) and run  <b> "npm install" </b>  to install all the required dependencies mentioned in package.json file.

-> Install truffle using cmd <b> "npm install -g truffle" </b> 

-> Install Ganache in your computer and run a blockchain environment in there.

-> Install metamask in your browser and import the accounts  from Ganache.

-> Run following commands in sequence in the main directory of your code
     - <b> "truffle init" </b>
     - <b> "truffle compile" </b>
     - <b> "truffle migrate" </b>

-> After running above commands, smart contract will get deployed.

-> Then goto client directory and run <b> "npm start" </b> 

<h2> More Information </h2>

-> The account which is firstly used to deploy the smart contract using <b> "truffle migrate" </b> will  automatically be  admin account.

-> You should import the same accout on metamask which is mentioned above to access the admin control and stuff.

-> You can use all other accounts account as a user to register and vote.
