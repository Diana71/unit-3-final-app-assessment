//
//  RootViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QRootViewController.h"

@interface C4QRootViewController ()

@property (weak, nonatomic) IBOutlet UIButton *onwardButton;

@end

@implementation C4QRootViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.onwardButton.hidden = self.view.backgroundColor != [UIColor greenColor];
}

@end
