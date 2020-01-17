//
//  BCLoginView.m
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import "BCLoginView.h"
#import "BCLoginData.h"
#import "UIAlertController+BCAlert.h"
@interface BCLoginView ()
    @property (nonatomic, weak) UILabel                *enterPinLabel;
    @property (nonatomic, weak) UITextField            *pinTextField;
    @property (nonatomic, weak) UILabel                *confirmPinLabel;
    @property (nonatomic, weak) UITextField            *confirmPinTextField;
    @property (nonatomic, strong) CALayer              *pinTextFieldBorder;
    @property (nonatomic, strong) CALayer              *confirmPinTextFieldBorder;
    @property (nonatomic, assign) int                  attemptCounter;
@end
@implementation BCLoginView

static NSString * const inccorectPinMessage = @"Incorrect PIN";
static NSString * const tooManyAttemptsMessage = @"Too many PIN attempts.  Please try again later";
static NSString * const pinMissmatchMessage = @"PIN numbers don't match";
static NSString * const pinBadFormatMessage = @"PIN must be consisted of 6 digits";
static NSString * const pinLabelText = @"Enter your 6 digit PIN number:";
static NSString * const confirmPinLabelText = @"Confirm 6 digit PIN number::";

-(id)init{
    self = [super init];
    if(self){
        _pinExists = [BCLoginData ifPinExists];
        _attemptCounter = 0;
        [self createLoginView];
    }
    return self;
}

-(void)createLoginView{
    UILabel *enterPinLabel = [[UILabel alloc]init];
    enterPinLabel.text = pinLabelText;
    enterPinLabel.numberOfLines = 0;
    enterPinLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    enterPinLabel.textColor = [UIColor grayColor];
    
    UITextField *pinTextField = [[UITextField alloc] init];
    pinTextField.keyboardType = UIKeyboardTypeNumberPad;
    pinTextField.secureTextEntry = YES;
    pinTextField.font = [UIFont fontWithName:@"Helvetica-Bold" size:50];
    pinTextField.delegate = self;
    pinTextField.textColor = [UIColor grayColor];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]init];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    pinTextField.inputAccessoryView = numberToolbar;

    _enterPinLabel = enterPinLabel;
    _pinTextField = pinTextField;
    [self addSubview: _enterPinLabel];
    [self addSubview: _pinTextField];
    _pinTextFieldBorder = [CALayer layer];
    CGFloat borderWidth = 2;
    _pinTextFieldBorder.borderColor = [UIColor darkGrayColor].CGColor;
    _pinTextFieldBorder.borderWidth = borderWidth;
    [_pinTextField.layer addSublayer:_pinTextFieldBorder];
    _pinTextField.layer.masksToBounds = YES;
    [self setConstraints];
    if(!_pinExists){
        [self setConfirmPinViewPart];
    }
    
}

-(void)displayAlert:(NSString *)message{
    
    BOOL      quitApp = NO;
    if(_attemptCounter>=5){
        quitApp = YES;
    }
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              if(quitApp){
                                                                  /* _notMainLogin is true if this is not first screen after application start, this controller is loaded for private key display*/
                                                                  if(_notMainLogin){
                                                                     [_delegate loginDidFinishSuccessfully:NO];
                                                                  }else{
                                                                      //if it is main login page then turn application because of too many attempts
                                                                      exit(0);
                                                                  }
                                                              }
                                                          }];
    
    [alert addAction:defaultAction];
    [alert show];
    
}


-(void)setConfirmPinViewPart{
    UILabel *confirmPinLabel = [[UILabel alloc]init];
    confirmPinLabel.text = confirmPinLabelText;
    confirmPinLabel.numberOfLines = 0;
    confirmPinLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    confirmPinLabel.textColor = [UIColor grayColor];
    
    UITextField *confirmPinTextField = [[UITextField alloc] init];
    confirmPinTextField.keyboardType = UIKeyboardTypeNumberPad;
    confirmPinTextField.secureTextEntry = YES;
    confirmPinTextField.font = [UIFont fontWithName:@"Helvetica-Bold" size:50];
    confirmPinTextField.delegate = self;
    confirmPinTextField.textColor = [UIColor grayColor];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]init];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    confirmPinTextField.inputAccessoryView = numberToolbar;
    
    _confirmPinLabel = confirmPinLabel;
    _confirmPinTextField = confirmPinTextField;
    [self addSubview: _confirmPinLabel];
    [self addSubview: _confirmPinTextField];
    _confirmPinTextFieldBorder = [CALayer layer];
    CGFloat borderWidth = 2;
    _confirmPinTextFieldBorder.borderColor = [UIColor darkGrayColor].CGColor;
    _confirmPinTextFieldBorder.borderWidth = borderWidth;
    [_confirmPinTextField.layer addSublayer:_confirmPinTextFieldBorder];
    _confirmPinTextField.layer.masksToBounds = YES;
    
    _confirmPinLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _confirmPinTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [_confirmPinLabel.topAnchor constraintEqualToAnchor:_pinTextField.bottomAnchor constant:30].active = YES;
    [_confirmPinLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:15].active = YES;
    [_confirmPinLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor constant: -15].active = YES;
    [_confirmPinTextField.topAnchor constraintEqualToAnchor:_confirmPinLabel.bottomAnchor constant: 10].active = YES;
    [_confirmPinTextField.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_confirmPinTextField.heightAnchor constraintEqualToConstant:50].active = YES;
    [_confirmPinTextField.widthAnchor constraintEqualToConstant:200].active = YES;
    
    [self setConfirmPartDisable];
    
}
-(void)setConfirmPartEnable{
    _confirmPinTextField.userInteractionEnabled = YES;
    _confirmPinTextField.alpha = 1;
    _confirmPinTextFieldBorder.borderColor = [[UIColor grayColor] colorWithAlphaComponent:1].CGColor;
    _confirmPinLabel.alpha = 1;
}
-(void)setConfirmPartDisable{
    _confirmPinTextField.userInteractionEnabled = NO;
    _confirmPinTextField.alpha = 0.3;
    _confirmPinLabel.alpha = 0.3;
    _confirmPinTextFieldBorder.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.3].CGColor;
}

-(void)setConstraints{
    _enterPinLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _pinTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [_enterPinLabel.centerYAnchor constraintEqualToAnchor: self.centerYAnchor constant: -130].active = YES;
    [_enterPinLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:15].active = YES;
    [_enterPinLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor constant: -15].active = YES;
    [_pinTextField.topAnchor constraintEqualToAnchor:_enterPinLabel.bottomAnchor constant: 10].active = YES;
    [_pinTextField.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_pinTextField.heightAnchor constraintEqualToConstant:50].active = YES;
    [_pinTextField.widthAnchor constraintEqualToConstant:200].active = YES;
}

-(void)layoutSubviews{
    _pinTextFieldBorder.frame = CGRectMake(0, _pinTextField.frame.size.height - _pinTextFieldBorder.borderWidth, _pinTextField.frame.size.width, _pinTextField.frame.size.height);
     _confirmPinTextFieldBorder.frame = CGRectMake(0, _confirmPinTextField.frame.size.height - _confirmPinTextFieldBorder.borderWidth, _confirmPinTextField.frame.size.width, _confirmPinTextField.frame.size.height);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 6;
}


-(void)cancelNumberPad{
    if(_pinTextField.isFirstResponder){
        [_pinTextField resignFirstResponder];
        _pinTextField.text = @"";
    }
    if(_confirmPinTextField.isFirstResponder){
        [_confirmPinTextField resignFirstResponder];
        _confirmPinTextField.text = @"";
    }
}

-(void)doneWithNumberPad{
    if(_pinTextField.isFirstResponder){
        if([BCLoginData isPinValidFormat:_pinTextField.text]){
            if(_pinExists){
                if([BCLoginData isPinCorrect:_pinTextField.text]){
                    [_pinTextField resignFirstResponder];
                    [_delegate loginDidFinishSuccessfully:YES];
                }else{
                    _pinTextField.text = @"";
                    [self wrongPinMessage];
                }
            }else{
                [self setConfirmPartEnable];
                [_pinTextField resignFirstResponder];
            }
        }else{
            if(_pinExists){
                _pinTextField.text = @"";
                [self wrongPinMessage];
            }else{
                [self displayAlert:pinBadFormatMessage];
                [self setConfirmPartDisable];
                _confirmPinTextField.text = @"";
            }
        }
    }
    if(_confirmPinTextField.isFirstResponder){
        if(_pinTextField.text.length !=6){
            _confirmPinTextField.text = @"";
            [self displayAlert:pinBadFormatMessage];
        }else{
            if([_confirmPinTextField.text isEqualToString:_pinTextField.text]){
                [BCLoginData savePinToKeyChain:_pinTextField.text];
                [_confirmPinTextField resignFirstResponder];
                [_delegate loginDidFinishSuccessfully:YES];
            }else{
                [self displayAlert:pinMissmatchMessage];
                _confirmPinTextField.text = @"";
            }
        }
    }
    
}

-(void)wrongPinMessage{
    _attemptCounter++;
    if(_attemptCounter <5){
        [self displayAlert:inccorectPinMessage];
    }else{
        [self displayAlert:tooManyAttemptsMessage];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
