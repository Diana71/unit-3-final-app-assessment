//
//  C4QCatFactsCustomTableViewCell.h
//  unit-3-final-app-assessment
//
//  Created by Diana Elezaj on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol C4QCatFactsCustomTableViewCellDelegate <NSObject>

-(void)selectedFactToSave:(NSInteger )index;

@end


@interface C4QCatFactsCustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *catFactsDescription;
@property (weak, nonatomic) IBOutlet UIButton *catboxChecked;
@property (nonatomic) NSInteger index;

@property (nonatomic, weak) id<C4QCatFactsCustomTableViewCellDelegate> delegate;


@end
