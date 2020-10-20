
#import "RNNativeFileHashing.h"
#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#else
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#endif

@implementation RNNativeFileHashing

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()


RCT_REMAP_METHOD(hashSha, path:(NSString *)path
                  password:(NSString *)password
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    BOOL isDir = NO;
    BOOL exists = NO;
    exists = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory: &isDir];

    if (isDir) {
        return reject(@"EISDIR", [NSString stringWithFormat:@"Expecting a file but '%@' is a directory", path], nil);
    }
    if (!exists) {
        return reject(@"ENOENT", [NSString stringWithFormat:@"No such file '%@'", path], nil);
    }

    NSError *error = nil;

    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];

    if (error) {
        reject(@"EUNKNOWN", [error description], nil);
        return;
    }

    if ([attributes objectForKey:NSFileType] == NSFileTypeDirectory) {
        reject(@"EISDIR", [NSString stringWithFormat:@"Expecting a file but '%@' is a directory", path], nil);
        return;
    }

    NSData *content = [[NSFileManager defaultManager] contentsAtPath:path];
    const char *cKey  = [password cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSString *hash;
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), content.bytes, content.length, cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    hash = [HMAC base64EncodedStringWithOptions:0];
   
    resolve(hash);
}

@end
  
