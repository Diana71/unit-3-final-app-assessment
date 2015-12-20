//
//  ViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 11/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QViewController.h"
#import "C4QColorPickerViewController.h"
#import "C4QCatFactsTableViewController.h"
#import "C4QRootViewController.h"


@interface C4QViewController ()<ColorPassingDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bcgImage;

@end

@implementation C4QViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.onwardButton setHidden:YES];
    self.bcgImage.image = [UIImage imageNamed:@"tonsOfCats"];
    self.view.backgroundColor = [UIColor blackColor];
    self.bcgImage.alpha = 0.7;
}



-(void)userDidSelectColor:(UIColor *)colorSelected{
    self.view.backgroundColor = colorSelected;
    
    if (colorSelected == [UIColor redColor]){
        [self.onwardButton setHidden:YES];
        self.bcgImage.image = [UIImage imageNamed:@"red"];
        [self.view setNeedsDisplay];

    }
    if (colorSelected == [UIColor greenColor]){
        [self.onwardButton setHidden:YES];
        self.bcgImage.image = [UIImage imageNamed:@"green"];
        [self.view setNeedsDisplay];

    }
    
    if (colorSelected == [UIColor blueColor]) {
        [self.onwardButton setHidden:NO];
        self.bcgImage.image = [UIImage imageNamed:@"blue"];
        [self.view setNeedsDisplay];
    }
    [self.view setNeedsDisplay];
}
- (IBAction)selectColorTapped:(UIButton *)sender {
    
    C4QColorPickerViewController *cpvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ColorPickerID"];
    
    cpvc.delegate = self;
    
    [self.navigationController pushViewController:cpvc animated:YES];

}




 

@end
