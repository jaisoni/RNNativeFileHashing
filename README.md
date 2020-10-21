# react-native-file-hash

File utility for generating hash mac of file. Currently it suppport hmacsha256 for ios only.

## Installation

```sh
npm install react-native-file-hash
```

## Usage

```js
import {NativeModules} from 'react-native';

// ...

var FileHash = NativeModules.FileHash;
FileHash.hashSha(<File Path>, <Encryption Key>)
  .then((hmac)=>{
    console.log('File hamc => ', hmac);
  }
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
