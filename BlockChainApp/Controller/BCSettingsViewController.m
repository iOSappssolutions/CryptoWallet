//
//  BCSettingsViewController.m
//  BlockChainApp
//
//  Created by Miroslav Djukic on 10/20/17.
//  Copyright © 2017 Miroslav Djukic. All rights reserved.
//

#import "BCSettingsViewController.h"

@interface BCSettingsViewController ()
    @property (nonatomic, weak) BCSettingsView            *settingsView;
@end

@implementation BCSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSettingsView];
    // Do any additional setup after loading the view.
}

-(void)loadSettingsView{
    BCSettingsView *settingsView = [[BCSettingsView alloc]init];
    settingsView.delegate = self;
    _settingsView = settingsView;
    
    [self.view addSubview:_settingsView];
    [self setConstraints];
    [self.view layoutIfNeeded];
    
}

-(void)setConstraints{
    _settingsView.translatesAutoresizingMaskIntoConstraints = NO;
    [_settingsView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [_settingsView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_settingsView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_settingsView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pinChanged{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"Pin changed"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                               [self.navigationController popViewControllerAnimated:YES];
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}


@end
