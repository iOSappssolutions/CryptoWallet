//
//  SimpleKeyChainWrapper.m
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/22/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import "SimpleKeyChainWrapper.h"
#import "A0SimpleKeychain.h"
#import <CoreBitcoin/BTCData.h>
#import <CoreBitcoin/BTCBase58.h>

@implementation SimpleKeyChainWrapper
+(void)setData:(NSData *) data forKey:(NSString *) key{
    key = [SimpleKeyChainWrapper cryptoKey:key];
    [[A0SimpleKeychain keychain] setData:data forKey:key];
}

+(void)setString:(NSString *) string forKey:(NSString *) key{
    key = [SimpleKeyChainWrapper cryptoKey:key];
    [[A0SimpleKeychain keychain] setString:string forKey:key];
}

+(NSData *) dataForKey:(NSString *) key{
    key = [SimpleKeyChainWrapper cryptoKey:key];
    return [[A0SimpleKeychain keychain] dataForKey:key];
}

+(NSString *)stringForKey:(NSString *) key{
    key = [SimpleKeyChainWrapper cryptoKey:key];
    return [[A0SimpleKeychain keychain] stringForKey:key];
}

+(BOOL)deleteEntryForKey:(NSString *) key{
    key = [SimpleKeyChainWrapper cryptoKey:key];
    return [[A0SimpleKeychain keychain] deleteEntryForKey:key];
}

+(NSString *)cryptoKey:(NSString *)key{
    NSData* dataKey = [key dataUsingEncoding:NSUTF8StringEncoding];
    return key = BTCBase58StringWithData(BTCHash160(dataKey));
    
}


@end
