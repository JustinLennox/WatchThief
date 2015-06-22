//
//  ViewController.m
//  ThiefWatch
//
//  Created by Justin Lennox on 6/10/15.
//  Copyright (c) 2015 Justin Lennox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    UILabel *directions = [[UILabel alloc] init];
    [directions setText:@"watchthief"];
    [directions setFrame:CGRectMake(0, self.view.frame.size.height/10.0f, self.view.frame.size.width, 50.0f)];
    directions.adjustsFontSizeToFitWidth = YES;
    directions.textAlignment = NSTextAlignmentCenter;
    [directions setFont:[UIFont systemFontOfSize:50.0f]];
    [directions setFont:[UIFont fontWithName:@"SFUIDisplay-Light" size:60.0f]];
    [directions setTextColor:[UIColor whiteColor]];
    [directions setMinimumScaleFactor:10.0f/[UIFont labelFontSize]];
    [self.view addSubview:directions];
    
    
    UILabel *tapOrSwipe = [[UILabel alloc] init];
    [tapOrSwipe setText:@"Tap or Swipe to Continue"];
    [tapOrSwipe setFrame:CGRectMake(0, self.view.frame.size.height - 30.0f, self.view.frame.size.width, 30.0f)];
    tapOrSwipe.textAlignment = NSTextAlignmentCenter;
    [tapOrSwipe setFont:[UIFont systemFontOfSize:20.0f]];
    [tapOrSwipe setFont:[UIFont fontWithName:@"SourceSansPro-Light" size:15.0f]];
    [tapOrSwipe setTextColor:[UIColor whiteColor]];
    [tapOrSwipe setMinimumScaleFactor:12.0/[UIFont labelFontSize]];
    [self.view addSubview:tapOrSwipe];
    
    self.info = [[UILabel alloc] init];
    self.info.textAlignment = NSTextAlignmentCenter;
    [self.info setFont:[UIFont systemFontOfSize:15.0f]];
    [self.info setFont:[UIFont fontWithName:@"SourceSansPro-Light" size:30.0f]];
    [self.info setTextColor:[UIColor whiteColor]];
    [self.info setMinimumScaleFactor:5.0/[UIFont labelFontSize]];
    self.info.adjustsFontSizeToFitWidth = true;
    self.info.numberOfLines = -1;
    [self.view addSubview:self.info];
    
    self.currentImage = 0;
    self.imageArray = @[@"These thieves are out to steal your watch!", @"They won't be easy to catch though", @"The thieves will only move when you're not looking", @"Tilt your watch away from you and they'll scatter!", @"The thief leader will only move forward or stay still. His henchmen will sneak backwards now and then.", @"Tap the character you think is the thief leader to stop the bandits!", @"Careful! If you look away for too long the thief leader will snatch your watch!"];
    
    [self.info setText:[self.imageArray objectAtIndex:self.currentImage]];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 64, self.view.frame.size.height/2 - 64, 128, 128)];
    [self.imageView setImage:[UIImage imageNamed:@"Characters256.png"]];
    [self.view addSubview:self.imageView];
    
    [self.info setFrame:CGRectMake(5.0f, CGRectGetMaxY(self.imageView.frame), self.view.frame.size.width - 10.0f, 300.0f)];
    [self.info sizeToFit];
    [self.info setFrame:CGRectMake(10.0f, CGRectGetMaxY(self.imageView.frame), self.view.frame.size.width- 20.0f, self.info.frame.size.height)];
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    self.swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftHandler:)];
    self.swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightHandler:)];
    self.swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.tapRecognizer];
    [self.view addGestureRecognizer:self.swipeRightRecognizer];
    [self.view addGestureRecognizer:self.swipeLeftRecognizer];
}

-(void)viewDidAppear:(BOOL)animated{
    self.currentAnimation = 1;

    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(animateImageWithName:) userInfo:nil repeats:YES];
}

-(void)tapHandler:(UITapGestureRecognizer *)handler{
    if(handler.state == UIGestureRecognizerStateEnded){
        if(self.currentImage < self.imageArray.count - 1){
            self.currentImage++;
            [self animateImage];
            [self.info setText:[self.imageArray objectAtIndex:self.currentImage]];

        }else if(self.currentImage == self.imageArray.count -1){
            [self performSegueWithIdentifier:@"showMainSegue" sender:self];
        }
    }
}

-(void)swipeLeftHandler:(UISwipeGestureRecognizer *)handler{
    if(handler.state == UIGestureRecognizerStateEnded){
        if(self.currentImage < self.imageArray.count - 1){
            self.currentImage++;
            [self animateImage];
            [self.info setText:[self.imageArray objectAtIndex:self.currentImage]];

        }else if(self.currentImage == self.imageArray.count -1){
            [self performSegueWithIdentifier:@"showMainSegue" sender:self];
        }
    }
}

-(void)swipeRightHandler:(UISwipeGestureRecognizer *)handler{
    if(handler.state == UIGestureRecognizerStateEnded){
        if(self.currentImage > 0){
            self.currentImage--;
            [self animateImage];
            [self.info setText:[self.imageArray objectAtIndex:self.currentImage]];

        }
    }
}

-(void)animateImage{

    if(self.currentImage == 2 || self.currentImage == 3){
        self.maxAnimation = 4;
        self.imageName = @"WatchAnimation";
    }else if(self.currentImage == 4){
        self.currentAnimation = 1;
        self.maxAnimation = 5;
        self.imageName = @"Watch2Animation";
    }else if(self.currentImage == 5){
        [self.imageView setImage:[UIImage imageNamed:@"Jail.png"]];
    }else if(self.currentImage == 6){
        [self.imageView setImage:[UIImage imageNamed:@"Loss.png"]];
    }
}

-(void)animateImageWithName:(NSTimer*) timer{
    if(self.currentImage == 2 || self.currentImage == 3 || self.currentImage == 4){
        NSString *imageName = [NSString stringWithFormat:@"%@%d.png", self.imageName, self.currentAnimation];
        if(self.currentAnimation < self.maxAnimation){
            self.currentAnimation++;
        }else{
            self.currentAnimation = 1;
        }
        [self.imageView setImage:[UIImage imageNamed:imageName]];
    }
}

@end
