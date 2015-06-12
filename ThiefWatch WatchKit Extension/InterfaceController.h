//
//  InterfaceController.h
//  ThiefWatch WatchKit Extension
//
//  Created by Justin Lennox on 6/10/15.
//  Copyright (c) 2015 Justin Lennox. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

//Opening Screen UI
@property (strong, nonatomic) IBOutlet WKInterfaceImage *titleImage;
@property (strong, nonatomic) NSArray *openingUIArray;

//Opening Screen Actions
- (IBAction)easyButtonPressed;
- (IBAction)mediumButtonPressed;
- (IBAction)hardButtonPressed;


//GameUI
@property (strong, nonatomic) IBOutlet WKInterfaceImage *coverImage;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *lane1;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *lane2;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *lane3;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *lane4;
@property (strong, nonatomic) IBOutlet WKInterfaceImage *gemImage;
@property (strong, nonatomic) IBOutlet WKInterfaceGroup *playButtons;
@property (strong, nonatomic) IBOutlet WKInterfaceGroup *lanesGroup;

//GameUI Actions
- (IBAction)lane1Pressed;
- (IBAction)lane2Pressed;
- (IBAction)lane3Pressed;
- (IBAction)lane4Pressed;

//ReplayUI
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *theThiefWasLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceImage *thiefRevealImage;


//Game Logic Mechanics
@property (strong, nonatomic) NSString *thiefName;
@property (strong, nonatomic) NSString *fakeThief;
@property (strong, nonatomic) NSString *difficulty;
@property (strong, nonatomic) NSMutableDictionary *laneDictionary;
@property (strong, nonatomic) NSDictionary *laneButtonDictionary;
@property (strong, nonatomic) NSMutableDictionary *currentImageDictionary;
@property (nonatomic) int thiefLaneNumber;
@property (nonatomic) int numberOfPhotos;
@property (nonatomic) float deactivatedTime;
@property (nonatomic) float activatedTime;
@property (nonatomic) float timeNotLooking;
@property (nonatomic) float totalTimeNotLooked;
@property (nonatomic) float thiefTimeNotLooked;
@property (nonatomic) float thiefSpeed;
@property (strong, nonatomic) NSMutableDictionary *characterSpeeds;


//Game Flow Mechanics
@property (nonatomic) BOOL gameRunning;
@property (nonatomic) BOOL won;

//ForceTouch
- (IBAction)forceTouch;



@end
