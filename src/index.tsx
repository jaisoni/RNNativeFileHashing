import { NativeModules } from 'react-native';

type FileHashType = {
  multiply(a: number, b: number): Promise<number>;
};

const { FileHash } = NativeModules;

export default FileHash as FileHashType;
