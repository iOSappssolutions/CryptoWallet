//
//  BTCWallet.m
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import "BCWalletData.h"
#import <CoreBitcoin/BTCAddress.h>
#import <CoreBitcoin/BTCKey.h>
#import "SimpleKeyChainWrapper.h"
#import "BCConstants.h"
@interface BCWalletData()
@property (nonatomic, strong) BTCKeychain         *walletKeychain;
@property (nonatomic, assign) int                 keyIndex;
@end
@implementation BCWalletData


-(id)init{
    self = [super init];
    if(self){
        // initialize last wallet
        if([self ifKeyExists]){
            BTCKey *key = [[BTCKey alloc]initWithPrivateKey:[self getKeyFromPhone]];
            _walletKeychain = [[BTCKeychain alloc ]initWithSeed:key.privateKey];
            _keyIndex = 0;
            
        }
    }
    return self;
}

-(void)createNewWallet{
    BTCKey *key = [[BTCKey alloc]init];
    [self saveKeyToPhone:key.privateKey];
    _walletKeychain = [[BTCKeychain alloc ]initWithSeed:key.privateKey];
    _keyIndex = 0;
    
}

// returns compressed public key address for our wallet at first index
-(NSString *)getFirstAddress{
    BTCPublicKeyAddress *pubAddress = [_walletKeychain keyAtIndex:0].compressedPublicKeyAddress;
    
    return pubAddress.publicAddress.string;
    
}

// gets next address by going through wallet key chain
-(NSString *)getNextAddress{
    _keyIndex++;
    
     return [self getAddressAtIndex:_keyIndex];
    
}

// gets previous address by going through wallet key chain
-(NSString *)getPreviousAddress{
    if(_keyIndex > 0){
        _keyIndex--;
    }
    
    return [self getAddressAtIndex:_keyIndex];
}

-(NSString *)getAddressAtIndex:(int) index{
    BTCPublicKeyAddress *pubAddress = [_walletKeychain keyAtIndex:index].compressedPublicKeyAddress;
    
    return pubAddress.publicAddress.string;
}

// retunrns private key in WIF format
-(NSString *)getPrivateKey{
    
     return  [_walletKeychain keyAtIndex:_keyIndex].WIF;
}

// in this test requirement wasn't to persist wallet info, if it was real app it wouldn't be saved to Iphone keychain, more secure option would be used
-(void)saveKeyToPhone:(NSData *)privateKey{
    [SimpleKeyChainWrapper setData:privateKey forKey:kWalletIdKey];
}


-(BOOL)ifKeyExists{
    BOOL ifKeyExists = NO;
    if([SimpleKeyChainWrapper dataForKey:kWalletIdKey] != nil){
        ifKeyExists = YES;
    }
    return ifKeyExists;
}

-(NSData *)getKeyFromPhone{
    return [SimpleKeyChainWrapper dataForKey:kWalletIdKey];
}
@end
