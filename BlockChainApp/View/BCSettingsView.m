//
//  BCSettingsView.m
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import "BCSettingsView.h"
#import "BCLoginData.h"
#import "UIAlertController+BCAlert.h"
@interface BCSettingsView()
@property (nonatomic, weak) UILabel                *enterOldPinLabel;
@property (nonatomic, weak) UITextField            *oldPinTextField;
@property (nonatomic, weak) UILabel                *enterNewPinLabel;
@property (nonatomic, weak) UITextField            *currentPinTextField;
@property (nonatomic, strong) CALayer              *oldPinTextFieldBorder;
@property (nonatomic, strong) CALayer              *currentPinTextFieldBorder;
@property (nonatomic, weak) UITextField            *confirmPinTextField;
@property (nonatomic, weak) UILabel                *confirmPinLabel;
@property (nonatomic, strong) CALayer              *confirmPinTextFieldBorder;

@end
@implementation BCSettingsView

    static NSString * const succesPinChangeMessage = @"PIN changed successfully";
    static NSString * const wrongPinMessage = @"Wrong PIN";
    static NSString * const pinBadFormatMessage = @"PIN has to be consisted of 6 digits";
    static NSString * const oldPinLabelText = @"Enter old PIN number:";
    static NSString * const newPinLabelText = @"Enter new PIN number:";
    static NSString * const confirmPinLabelText = @"Confirm new PIN number:";
    static NSString * const mismatchPinMessage = @"PIN numbers don't match";

-(id)init{
    self = [super init];
    if(self){
        
        [self createSettingsView];
    }
    return self;
}

-(void)createSettingsView{
    UILabel *enterOldPinLabel = [[UILabel alloc]init];
    enterOldPinLabel.numberOfLines = 0;
    enterOldPinLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    enterOldPinLabel.text = oldPinLabelText;
    
    UITextField *oldPinTextField = [[UITextField alloc] init];
    oldPinTextField.keyboardType = UIKeyboardTypeNumberPad;
    oldPinTextField.secureTextEntry = YES;
    oldPinTextField.font = [UIFont fontWithName:@"Helvetica-Bold" size:50];
    oldPinTextField.delegate = self;
    
    UITextField *newPinTextField = [[UITextField alloc] init];
    newPinTextField.keyboardType = UIKeyboardTypeNumberPad;
    newPinTextField.secureTextEntry = YES;
    newPinTextField.font = [UIFont fontWithName:@"Helvetica-Bold" size:50];
    newPinTextField.delegate = self;
    newPinTextField.userInteractionEnabled = NO;
    
    UILabel *enterNewPinLabel = [[UILabel alloc]init];
    enterNewPinLabel.numberOfLines = 0;
    enterNewPinLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    enterNewPinLabel.textColor = [enterNewPinLabel.backgroundColor colorWithAlphaComponent:0.3];
    enterNewPinLabel.text = newPinLabelText;
    
    UITextField *confirmPinTextField = [[UITextField alloc] init];
    confirmPinTextField.keyboardType = UIKeyboardTypeNumberPad;
    confirmPinTextField.secureTextEntry = YES;
    confirmPinTextField.font = [UIFont fontWithName:@"Helvetica-Bold" size:50];
    confirmPinTextField.delegate = self;
    confirmPinTextField.userInteractionEnabled = NO;
    
    UILabel *confirmPinLabel = [[UILabel alloc]init];
    confirmPinLabel.numberOfLines = 0;
    confirmPinLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    confirmPinLabel.textColor = [enterNewPinLabel.backgroundColor colorWithAlphaComponent:0.3];
    confirmPinLabel.text = confirmPinLabelText;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]init];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style: UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    oldPinTextField.inputAccessoryView = numberToolbar;
    newPinTextField.inputAccessoryView = numberToolbar;
    confirmPinTextField.inputAccessoryView = numberToolbar;
    
    _enterOldPinLabel = enterOldPinLabel;
    _oldPinTextField = oldPinTextField;
    _enterNewPinLabel = enterNewPinLabel;
    _currentPinTextField = newPinTextField;
    _confirmPinTextField = confirmPinTextField;
    _confirmPinLabel = confirmPinLabel;
    [self addSubview: _enterOldPinLabel];
    [self addSubview: _oldPinTextField];
    [self addSubview: _enterNewPinLabel];
    [self addSubview: _currentPinTextField];
    [self addSubview:_confirmPinTextField];
    [self addSubview:_confirmPinLabel];
    
    _oldPinTextFieldBorder = [CALayer layer];
    CGFloat borderWidth = 2;
    _oldPinTextFieldBorder.borderColor = [UIColor darkGrayColor].CGColor;
    _oldPinTextFieldBorder.borderWidth = borderWidth;
    [_oldPinTextField.layer addSublayer:_oldPinTextFieldBorder];
    _oldPinTextField.layer.masksToBounds = YES;
    
    _currentPinTextFieldBorder =[CALayer layer];
    _currentPinTextFieldBorder.borderColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3].CGColor;
    _currentPinTextFieldBorder.borderWidth = borderWidth;
    [_currentPinTextField.layer addSublayer:_currentPinTextFieldBorder];
    _currentPinTextField.layer.masksToBounds = YES;
    
    _confirmPinTextFieldBorder =[CALayer layer];
    _confirmPinTextFieldBorder.borderColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3].CGColor;
    _confirmPinTextFieldBorder.borderWidth = borderWidth;
    [_confirmPinTextField.layer addSublayer:_confirmPinTextFieldBorder];
    _confirmPinTextField.layer.masksToBounds = YES;
    
    [self setConstraints];
}

-(void)setConstraints{
    _enterOldPinLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _oldPinTextField.translatesAutoresizingMaskIntoConstraints = NO;
    _enterNewPinLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _currentPinTextField.translatesAutoresizingMaskIntoConstraints = NO;
    _confirmPinLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _confirmPinTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_enterOldPinLabel.topAnchor constraintEqualToAnchor: self.topAnchor constant: 80].active = YES;
    [_enterOldPinLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:15].active = YES;
    [_enterOldPinLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor constant: -15].active = YES;
    
    [_oldPinTextField.topAnchor constraintEqualToAnchor:_enterOldPinLabel.bottomAnchor constant: 10].active = YES;
    [_oldPinTextField.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_oldPinTextField.heightAnchor constraintEqualToConstant:50].active = YES;
    [_oldPinTextField.widthAnchor constraintEqualToConstant:200].active = YES;
    
    [_enterNewPinLabel.topAnchor constraintEqualToAnchor: _oldPinTextField.bottomAnchor constant: 25].active = YES;
    [_enterNewPinLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:15].active = YES;
    [_enterNewPinLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor constant: -15].active = YES;
    
    [_currentPinTextField.topAnchor constraintEqualToAnchor:_enterNewPinLabel.bottomAnchor constant: 10].active = YES;
    [_currentPinTextField.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_currentPinTextField.heightAnchor constraintEqualToConstant:50].active = YES;
    [_currentPinTextField.widthAnchor constraintEqualToConstant:200].active = YES;
    
    [_confirmPinLabel.topAnchor constraintEqualToAnchor: _currentPinTextField.bottomAnchor constant: 25].active = YES;
    [_confirmPinLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:15].active = YES;
    [_confirmPinLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor constant: -15].active = YES;
    
    [_confirmPinTextField.topAnchor constraintEqualToAnchor:_confirmPinLabel.bottomAnchor constant: 10].active = YES;
    [_confirmPinTextField.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [_confirmPinTextField.heightAnchor constraintEqualToConstant:50].active = YES;
    [_confirmPinTextField.widthAnchor constraintEqualToConstant:200].active = YES;
    
}

-(void)cancelNumberPad{
    if(_oldPinTextField.isFirstResponder){
        [_oldPinTextField resignFirstResponder];
    }else if(_currentPinTextField.isFirstResponder){
        [_currentPinTextField resignFirstResponder];
    }else if(_confirmPinTextField.isFirstResponder){
        [_confirmPinTextField resignFirstResponder];
    }
   
}

-(void)doneWithNumberPad{
    if(_oldPinTextField.isFirstResponder){
        if([BCLoginData isPinCorrect:_oldPinTextField.text]){
            [self enableNewPinTextField];
            [_oldPinTextField resignFirstResponder];
        }else{
            [self displayAlert:wrongPinMessage];
            _oldPinTextField.text = @"";
            _currentPinTextField.text = @"";
            _confirmPinTextField.text = @"";
            [self disableNewPinTextField];
            [self disableConfirmPinTextField];
        }
    
    }else if(_currentPinTextField.isFirstResponder){
        if(![BCLoginData isPinValidFormat:_currentPinTextField.text]){
            [self displayAlert:pinBadFormatMessage];
            _currentPinTextField.text = @"";
            _confirmPinTextField.text = @"";
            [self disableConfirmPinTextField];
        }else{
            [_currentPinTextField resignFirstResponder];
            [self enableConfirmPinTextField];
        }
    }else if(_confirmPinTextField.isFirstResponder){
        if(![_confirmPinTextField.text isEqualToString:_currentPinTextField.text]){
            [self displayAlert:mismatchPinMessage];
            _confirmPinTextField.text = @"";
        }else{
            [BCLoginData savePinToKeyChain:_confirmPinTextField.text];
            [_confirmPinTextField resignFirstResponder];
            [_delegate pinChanged];
            
        }
    }
}
-(void)enableNewPinTextField{
    _currentPinTextField.userInteractionEnabled = YES;
    _currentPinTextFieldBorder.borderColor = [[UIColor darkGrayColor] colorWithAlphaComponent:1].CGColor;
    _enterNewPinLabel.textColor = [ _enterNewPinLabel.textColor colorWithAlphaComponent:1];
}
-(void)disableNewPinTextField{
    _currentPinTextField.userInteractionEnabled = NO;
    _currentPinTextFieldBorder.borderColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3].CGColor;
    _enterNewPinLabel.textColor = [ _enterNewPinLabel.textColor colorWithAlphaComponent:0.3];
}
-(void)enableConfirmPinTextField{
    _confirmPinTextField.userInteractionEnabled = YES;
    _confirmPinTextFieldBorder.borderColor = [[UIColor darkGrayColor] colorWithAlphaComponent:1].CGColor;
    _confirmPinLabel.textColor = [ _enterNewPinLabel.textColor colorWithAlphaComponent:1];
}
-(void)disableConfirmPinTextField{
    _confirmPinTextField.userInteractionEnabled = NO;
    _confirmPinTextFieldBorder.borderColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3].CGColor;
    _confirmPinLabel.textColor = [ _enterNewPinLabel.textColor colorWithAlphaComponent:0.3];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _currentPinTextFieldBorder.frame = CGRectMake(0, _currentPinTextField.frame.size.height - _currentPinTextFieldBorder.borderWidth, _currentPinTextField.frame.size.width, _currentPinTextField.frame.size.height);
    _oldPinTextFieldBorder.frame = CGRectMake(0, _oldPinTextField.frame.size.height - _oldPinTextFieldBorder.borderWidth, _oldPinTextField.frame.size.width, _oldPinTextField.frame.size.height);
    
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


-(void)displayAlert:(NSString*)message{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                          }];
    
    [alert addAction:defaultAction];
    [alert show];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
