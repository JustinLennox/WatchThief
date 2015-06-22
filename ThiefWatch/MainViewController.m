//
//  MainViewController.m
//  ThiefWatch
//
//  Created by Justin Lennox on 6/14/15.
//  Copyright (c) 2015 Justin Lennox. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UILabel *titleLabel = [[UILabel alloc] init];
//    [titleLabel setFrame:CGRectMake(0, self.view.frame.size.height/10.0f, self.view.frame.size.width, 50.0f)];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [titleLabel setText:@"WatchThief"];
//    [titleLabel setFont:[UIFont fontWithName:@"SourceSansPro-Light" size:50.0f]];
//    [titleLabel setTextColor:[UIColor whiteColor]];
//    [titleLabel setMinimumScaleFactor:12.0/[UIFont labelFontSize]];
//    [self.view addSubview:titleLabel];
    
//  self.titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(128, self.view.frame.size.height/10.0f, 256, 256)];
//    self.titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WatchThiefTitle"]];
//    self.titleImage.contentMode = UIViewContentModeScaleAspectFit;
//    [self.titleImage setImage:[UIImage imageNamed:@"WatchThiefTitle.png"]];
//    [self.view addSubview:self.titleImage];
//    [self.titleImage setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self formatLayout];
    
//    [self.scoreNumberLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.howToPlayButton setTranslatesAutoresizingMaskIntoConstraints:NO];
////    [self.watchIcon setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.watchIcon setFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 256, 256)];

    [self formatLayout];

    
//    UILabel *scoreLabel = [[UILabel alloc] init];
//    [scoreLabel setFrame:CGRectMake(0, self.view.frame.size.height/2 - 50.0f, self.view.frame.size.width, 50.0f)];
//    scoreLabel.textAlignment = NSTextAlignmentCenter;
//    scoreLabel.text = @"Score";
//    [scoreLabel setFont:[UIFont fontWithName:@"SourceSansPro-Light" size:50.0f]];
//    [scoreLabel setTextColor:[UIColor whiteColor]];
//    [scoreLabel setMinimumScaleFactor:12.0/[UIFont labelFontSize]];
//    [self.view addSubview:scoreLabel];
//    
//    
//    // Do any additional setup after loading the view, typically from a nib.
//    self.scoreLabel = [[UILabel alloc] init];
//    [self.scoreLabel setFrame:CGRectMake(0, CGRectGetMaxY(scoreLabel.frame) + 10, self.view.frame.size.width, 50.0f)];
//    self.scoreLabel .textAlignment = NSTextAlignmentCenter;
//    [self.scoreLabel  setFont:[UIFont fontWithName:@"SourceSansPro-Light" size:50.0f]];
//    [self.scoreLabel  setTextColor:[UIColor whiteColor]];
//    [self.scoreLabel setMinimumScaleFactor:12.0/[UIFont labelFontSize]];
//    [self.view addSubview:self.scoreLabel];
//    
//    UIButton *howToButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [howToButton setFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame) - 50, self.view.frame.size.width, 50)];
//    [howToButton addTarget:self action:@selector(howToPressed) forControlEvents:UIControlEventTouchUpInside];
//    [howToButton setTitle:@"How To Play" forState:UIControlStateNormal];
//    [howToButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [howToButton setBackgroundColor:[UIColor colorWithRed:(39/255.0f) green:(174/255.0f) blue:(96/255.0f) alpha:1.0f]];
//    [self.view addSubview:howToButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshLabel) name:@"WatchKitReq" object:nil];
    
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.WatchThief"];
    if([mySharedDefaults valueForKey:@"Score"]){
        [self.scoreNumberLabel setText:[NSString stringWithFormat:@"%@", [mySharedDefaults valueForKey:@"Score"]]];
    }else{
        [self.scoreNumberLabel setText:@"0"];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.WatchThief"];
    
    if(![mySharedDefaults valueForKey:@"Score"]){
        [self performSegueWithIdentifier:@"showHowPlaySegue" sender:self];
        // Create and share access to an NSUserDefaults object.
        
        // Use the shared user defaults object to update the user's account.
        [mySharedDefaults setValue:@0 forKey:@"Score"];

    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.watchIcon.translatesAutoresizingMaskIntoConstraints = YES;
    self.scoreNumberLabel.translatesAutoresizingMaskIntoConstraints = YES;
    [self.watchIcon setFrame:CGRectMake(self.view.frame.size.width/2 - 64.0f, self.view.frame.size.height/2 - 64.0f, 128.0f, 128.0f)];
    [self.scoreNumberLabel setFrame:CGRectMake(self.view.frame.size.width/2 - 25.0f, self.view.frame.size.height/2 - 26.0f, 50.0f, 50.0f)];
    self.charactersImage.translatesAutoresizingMaskIntoConstraints = YES;
    [self.charactersImage setCenter:self.view.center];
    [self.charactersImage setFrame:CGRectMake(self.charactersImage.frame.origin.x, CGRectGetMinY(self.howToPlayButton.frame) - 100.0f, 128.0f, 128.0f)];
    [self.view bringSubviewToFront:self.scoreNumberLabel];

}

-(void)howToPressed{
    [self performSegueWithIdentifier:@"showHowPlaySegue" sender:self];
}

-(void)refreshLabel{
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.WatchThief"];
    [self.scoreNumberLabel setText:[NSString stringWithFormat:@"%@", [mySharedDefaults valueForKey:@"Score"]]];
}

-(void)formatLayout{
    
    [self.view removeConstraints:self.view.constraints];
    
    NSDictionary *views = @{@"scoreLabel":self.scoreNumberLabel, @"HowToPlay":self.howToPlayButton, @"titleLabel":self.titleLabel, @"watchIcon":self.watchIcon, @"charactersImage":self.charactersImage};
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[HowToPlay]|"
                                                                   options:0                                                                  metrics:nil
                                                                     views:views];
    
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[HowToPlay(<=150)]|"
                                                                                                     options:0
                                                                                                     metrics:nil
                                                                                                       views:views]];
    
    
    
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[titleLabel]-30-|"
                                                                                                     options:0
                                                                                                     metrics:nil
                                                                                                       views:views]];
    
    
    
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[titleLabel]"
                                                                                                     options:0
                                                                                                     metrics:nil
                                                                                                       views:views]];
    
    
//    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[charactersImage(<=128)][HowToPlay]"
//                                                                                                     options:0
//                                                                                                     metrics:nil
//                                                                                                       views:views]];
    
    
//    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[watchIcon(<=100)]"
//                                                                                                     options:0
//                                                                                                     metrics:nil
//                                                                                                       views:views]];
    
//    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[scoreLabel]-[watchIcon(<=100)]"
//                                                                                                     options:NSLayoutFormatAlignAllCenterX
//                                                                                                     metrics:nil
//                                                                                                       views:views]];
//
//    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[watchIcon]-20-[titleLabel]"
//                                                                                                     options:NSLayoutFormatAlignAllCenterX
//                                                                                                     metrics:nil
//                                                                                                       views:views]];
    

    
    [self.view addConstraints:constraints];


}



@end
