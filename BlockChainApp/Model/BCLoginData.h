//
//  BCLoginData.h
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCLoginData : NSObject

+(void)savePinToKeyChain:(NSString *)pin;
+(BOOL)isPinCorrect:(NSString *)pin;
+(BOOL)ifPinExists;
+(BOOL)isPinValidFormat:(NSString *)pin;

@end
