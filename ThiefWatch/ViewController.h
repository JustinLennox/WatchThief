//
//  ViewController.h
//  ThiefWatch
//
//  Created by Justin Lennox on 6/10/15.
//  Copyright (c) 2015 Justin Lennox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeLeftRecognizer;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeRightRecognizer;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) UILabel *info;
@property (nonatomic) int currentImage;
@property (strong, nonatomic) NSString *imageName;
@property (nonatomic) int currentAnimation;
@property (nonatomic) int maxAnimation;

@end

