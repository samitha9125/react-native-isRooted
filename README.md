# react-native-isrooted

## Getting started

`$ npm install react-native-isrooted --save`

### AutoLinking

Android  
For React Native version >= 0.60.0 will be autolinked 

iOS  
you need to run, cd ios/ && pod install && cd ..

### Manual Linking
For React Native version < 0.60.0  
`$ react-native link react-native-isrooted`

## Usage

```javascript
import DeviceStatus from 'react-native-isrooted';

async componentDidMount(){
   console.log(await DeviceStatus.isRooted());
}

or

componentDidMount(){
   const isRooted = DeviceStatus.isRooted(status => status));
}
```

#### Contribution

Thank you all who helped to compile this amazing library.

* Yang @beast
* Erandi Hasithanjali @era21
