//
//  C4QColorPickerViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QColorPickerViewController.h"
#import "UIImage+animatedGIF.h"

@interface C4QColorPickerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIImageView *blueButtonImage;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIImageView *redButtonImage;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIImageView *greenButtonImage;

@end

@implementation C4QColorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}

-(void)viewWillAppear:(BOOL)animated {
    self.blueButton.backgroundColor = [UIColor blueColor];
    self.greenButton.backgroundColor = [UIColor greenColor];
    self.redButton.backgroundColor = [UIColor redColor];
    
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"boss" withExtension:@"gif"];
    self.redButtonImage.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url1]];
    
    NSURL *url2 = [[NSBundle mainBundle] URLForResource:@"dancingCats" withExtension:@"gif"];
    self.greenButtonImage.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url2]];
    
    NSURL *url3 = [[NSBundle mainBundle] URLForResource:@"smartCat" withExtension:@"gif"];
    self.blueButtonImage.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url3]];
    
}

- (IBAction)colorButtonTapped:(UIButton *)sender {
    
    [self.delegate userDidSelectColor:sender.backgroundColor];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
