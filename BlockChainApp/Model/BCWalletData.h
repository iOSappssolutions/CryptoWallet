//
//  BTCWallet.h
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBitcoin/BTCKey.h>
#import <CoreBitcoin/BTCKeyChain.h>
@interface BCWalletData : NSObject


-(NSString *)getFirstAddress;
-(NSString *)getNextAddress;
-(NSString *)getPreviousAddress;
-(NSString *)getPrivateKey;
-(BOOL)ifKeyExists;
-(void)createNewWallet;



@end

