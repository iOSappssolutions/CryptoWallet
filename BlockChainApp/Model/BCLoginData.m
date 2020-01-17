//
//  BCLoginData.m
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import "BCLoginData.h"
#import "SimpleKeyChainWrapper.h"
#import "BCConstants.h"
//class that wraps around Simple keychain 3rd party framework currently saves to keychain only pin code
@implementation BCLoginData


+(void)savePinToKeyChain:(NSString *)pin{
    [SimpleKeyChainWrapper setString:pin forKey:kPinKey];
}

+(BOOL)isPinCorrect:(NSString *)pin{
    BOOL isPinCorrect = NO;
    if([pin isEqualToString: [SimpleKeyChainWrapper stringForKey:kPinKey]]){
        isPinCorrect = YES;
    }

    return isPinCorrect;
}

+(BOOL)ifPinExists{
    BOOL ifPinExists = NO;
    if([SimpleKeyChainWrapper stringForKey:kPinKey] != nil){
        ifPinExists = YES;
    }
    return ifPinExists;
}

+(BOOL)isPinValidFormat:(NSString *)pin{
    BOOL isInputValid;
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([pin rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        if(pin.length == 6){
            isInputValid = YES;
        }else{
            isInputValid = NO;
        }
        
    }else{
        isInputValid = NO;
        
    }
    
    return isInputValid;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
