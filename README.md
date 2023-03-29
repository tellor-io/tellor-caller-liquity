## Overview

<b>TellorCaller</b> serves as a bridge between `PriceFeed` and the Tellor oracle for [Liquity](https://www.liquity.org/)-like systems. It adopts best practices for using Tellor by incorporating a time buffer. Moreover, it caches the most recent value and timestamp to mitigate dispute attacks, where potential attackers may dispute valid values in order pull more favorable older values from the oracle. Keep in mind that this caching feature implies that once a value is cached, it becomes finalized and will be used, regardless of an subsequent dispute status, until a newer value is cached.

For more in-depth information about Tellor checkout our [documentation](https://docs.tellor.io), [whitepaper](https://tellor.io/whitepaper/) and [website](https://tellor.io/).

Quick references are included below:

* <b> [Reporter Documentation](https://docs.tellor.io/tellor/reporting-data/introduction)</b>

* <b> [Integration Documentation](https://docs.tellor.io/tellor/getting-data/reading-data)</b>

## Setting up and testing

Install Dependencies
```
npm i
```
Compile Smart Contracts
```
npx hardhat compile
```

## Maintainers <a name="maintainers"> </a>
This repository is maintained by the [Tellor team](https://github.com/orgs/tellor-io/people)


## How to Contribute<a name="how2contribute"> </a>  

Check out our issues log here on Github or feel free to reach out anytime [info@tellor.io](mailto:info@tellor.io)

## Copyright

Tellor Inc. 2023