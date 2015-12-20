//
//  C4QCatFactsCustomTableViewCell.m
//  unit-3-final-app-assessment
//
//  Created by Diana Elezaj on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsCustomTableViewCell.h"

 
@implementation C4QCatFactsCustomTableViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)catBoxChecked:(UIButton *)sender {
    NSLog(@"checked ");
    
    NSLog(@"should pass %ld",self.index);
    [self.catboxChecked setImage:[UIImage imageNamed:@"checkboxSelected"]
              forState:UIControlStateNormal];
    [self.delegate selectedFactToSave:self.index];
}

    



@end
