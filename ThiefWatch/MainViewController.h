//
//  MainViewController.h
//  ThiefWatch
//
//  Created by Justin Lennox on 6/14/15.
//  Copyright (c) 2015 Justin Lennox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) UIImageView *titleImage;
-(void)refreshLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *howToPlayButton;
@property (strong, nonatomic) IBOutlet UIImageView *watchIcon;
@property (strong, nonatomic) IBOutlet UILabel *scoreNumberLabel;
@property (strong, nonatomic) IBOutlet UIImageView *charactersImage;

@end
