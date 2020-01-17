//
//  SimpleKeyChainWrapper.h
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/22/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleKeyChainWrapper : NSObject

+(void)setData:(NSData *) data forKey:(NSString *) key;
+(void)setString:(NSString *) string forKey:(NSString *) key;
+(NSData *) dataForKey:(NSString *) key;
+(NSString *) stringForKey:(NSString *) key;
+(BOOL)deleteEntryForKey:(NSString *) key;

@end
