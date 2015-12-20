//
//  C4QCatFactDetailViewController.m
//  unit-3-final-app-assessment
//
//  Created by Michael Kavouras on 12/18/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsDetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImage+animatedGIF.h"

#define CAT_GIF_URL @"http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC"

@interface C4QCatFactsDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *catDetailImageView;
@property (weak, nonatomic) IBOutlet UILabel *catDetailLabel;
@property (nonatomic) BOOL stopDownloadingImages;
@end

@implementation C4QCatFactsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.catDetailLabel.text = self.catFactCellSelected;
    [self fetchCatPicture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fetchGiphyCatImageWithCompletion:(void (^)(UIImage *catImage))onCompletion{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:CAT_GIF_URL
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *data = responseObject[@"data"];
        NSDictionary *dictionary = data[arc4random_uniform((int)data.count)];
            NSDictionary *images = [dictionary objectForKey:@"images"];
             NSDictionary *fixed_height = images[@"fixed_height"];
             NSString *giphyUrlString = fixed_height[@"url"];
            
             NSURL *giphyURL = [NSURL URLWithString:giphyUrlString];
             NSLog(@"string URL %@ ",giphyURL);
             
             [self downloadImage:giphyURL handler:onCompletion ];
            
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error: %@", error.userInfo);
        
    }];
    
 }


- (void)fetchCatPicture{
    
    
    [self fetchGiphyCatImageWithCompletion:^(UIImage *catImage) {
        self.catDetailImageView.alpha = 0.5;
        self.catDetailImageView.image = catImage;
        
    }];
    
}



- (void)downloadImage:(NSURL *)url handler:(void (^)(UIImage *randomGiphyImage))onCompletion{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        while (self.stopDownloadingImages == NO) {
            
            UIImage *randomGiphyImage = [UIImage animatedImageWithAnimatedGIFURL:url];
    
            dispatch_sync(dispatch_get_main_queue(), ^{
                onCompletion(randomGiphyImage);
            });
            break;
        }
        
        NSLog(@"Back button tapped!");
    });
}

- (void)viewWillDisappear:(BOOL)animated{
    self.stopDownloadingImages = YES;
    
    [self.catDetailImageView stopAnimating];
}



@end
