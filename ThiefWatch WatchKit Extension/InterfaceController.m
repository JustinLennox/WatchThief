//
//  InterfaceController.m
//  ThiefWatch WatchKit Extension
//
//  Created by Justin Lennox on 6/10/15.
//  Copyright (c) 2015 Justin Lennox. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self.thiefRevealImage setHidden:true];
    [self.theThiefWasLabel setHidden:true];
    [self.gemImage setHidden:true];
    [self.lanesGroup setHidden:true];
    self.numberOfPhotos = 30;
    self.laneButtonDictionary = @{@"1":self.lane1, @"2":self.lane2, @"3":self.lane3, @"4":self.lane4};
    self.currentImageDictionary = [[NSMutableDictionary alloc] init];
    self.characterSpeeds = [[NSMutableDictionary alloc] init];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [[NSUserDefaults standardUserDefaults] setValue:@1 forKey:@"Score"];
    if(self.gameRunning){
        self.activatedTime = CACurrentMediaTime();
        self.timeNotLooking = self.activatedTime - self.deactivatedTime;
        self.totalTimeNotLooked += self.timeNotLooking;
        if(self.numberOfLooks == self.maxNumberOfLooks){
            [self timeOut];
        }else{
            if([self.difficulty isEqualToString:@"E"]){
                [self easyUpdateLanes];
            }else if([self.difficulty isEqualToString:@"M"]){
                [self mediumUpdateLanes];

            }else if([self.difficulty isEqualToString:@"H"]){
                [self hardUpdateLanes];

            }
        }
    }else if(self.thiefPaused){
        [self.gemImage setHidden:true];
        [self.theThiefWasLabel setHidden:true];
        self.thiefPaused = false;
        [self revealThief];
        
    }
}

- (void)didDeactivate {
    [super didDeactivate];
    self.numberOfLooks++;
    self.deactivatedTime = CACurrentMediaTime();

}


#pragma mark- Update Lane Logic

-(void) easyUpdateLanes{
    for(id key in self.laneButtonDictionary){
        if([key isEqualToString:[NSString stringWithFormat:@"%d", self.thiefLaneNumber]]){
            int percentage = arc4random() % 4;
            if(percentage == 0 || percentage == 1 || percentage == 3){
                [self easyMoveThiefForwardInLane:key];
            }
        }else{
            NSString *currentCharacter = [self.laneDictionary objectForKey:key];
            NSNumber *currentImage = [self.currentImageDictionary objectForKey:currentCharacter];
            int percentage = arc4random() % 4;
            int nextNumber = 0;
            float speed = [[self.characterSpeeds objectForKey:currentCharacter] floatValue];
            if(percentage == 0 || percentage == 1 || percentage == 3){
                nextNumber = (self.numberOfPhotos/speed) * self.totalTimeNotLooked;
            }else{
                nextNumber = [currentImage intValue] -3;
            }
            if(nextNumber <= 1){
                nextNumber = 2;
            }else if(nextNumber > self.numberOfPhotos){
                nextNumber = self.numberOfPhotos;
            }
       [self.currentImageDictionary setObject:[NSNumber numberWithInt:nextNumber] forKey:currentCharacter];
            [[self.laneButtonDictionary objectForKey:key] setBackgroundImageNamed:[NSString stringWithFormat:@"%@%@", [self.laneDictionary objectForKey:key], [NSNumber numberWithInt:nextNumber]]];
        }
    }
  
}

-(void)easyMoveThiefForwardInLane: (NSString *) laneNumber{
    int number = self.totalTimeNotLooked * (self.numberOfPhotos/self.thiefSpeed);
    if(number <= 1){
        number = 2;
    }else if(number >= self.numberOfPhotos){
        number = self.numberOfPhotos;
    }
    [self.currentImageDictionary setObject:[NSNumber numberWithInt:number] forKey:self.thiefName];
    [[self.laneButtonDictionary objectForKey:laneNumber] setBackgroundImageNamed:[NSString stringWithFormat:@"%@%@", self.thiefName, [NSNumber numberWithInt:number]]];
    [self updateThiefTime];
    
}

-(void)thiefStay:(NSString *)laneNumber{
    

    [[self.laneButtonDictionary objectForKey:laneNumber] setBackgroundImageNamed:[NSString stringWithFormat:@"%@%@", self.thiefName, [self.currentImageDictionary objectForKey:self.thiefName]]];
    
}

-(void)updateThiefTime{
    
    self.thiefTimeNotLooked += self.timeNotLooking;
    if(self.thiefTimeNotLooked >= self.thiefSpeed){
        self.gameRunning = false;
        [self timeOut];
    }
    
}
-(void)mediumUpdateLanes{
    
    for(id key in self.laneButtonDictionary){
        if([key isEqualToString:[NSString stringWithFormat:@"%d", self.thiefLaneNumber]]){
            int percentage = arc4random() % 4;
            if(percentage == 0 || percentage == 1 || percentage == 2){
                [self easyMoveThiefForwardInLane:key];
            }
        }else{
            NSString *currentCharacter = [self.laneDictionary objectForKey:key];
            NSNumber *currentImage = [self.currentImageDictionary objectForKey:currentCharacter];
            int percentage = arc4random() % 4;
            int nextNumber = 0;
            float speed = [[self.characterSpeeds objectForKey:currentCharacter] floatValue];
            if(percentage == 0 || percentage == 1 || percentage == 2){
                nextNumber = (self.numberOfPhotos/speed) * self.totalTimeNotLooked;
            }else{
                nextNumber = [currentImage intValue] - 1;
            }
            if(nextNumber <= 0){
                nextNumber = 1;
            }else if(nextNumber > self.numberOfPhotos){
                nextNumber = self.numberOfPhotos;
            }
            [self.currentImageDictionary setObject:[NSNumber numberWithInt:nextNumber] forKey:currentCharacter];
            [[self.laneButtonDictionary objectForKey:key] setBackgroundImageNamed:[NSString stringWithFormat:@"%@%@", [self.laneDictionary objectForKey:key], [NSNumber numberWithInt:nextNumber]]];
        }
    }
    
}

-(void)hardUpdateLanes{
    
    [self setLanes];

    for(id key in self.laneButtonDictionary){
        if([key isEqualToString:[NSString stringWithFormat:@"%d", self.thiefLaneNumber]]){
            int percentage = arc4random() % 4;
            if(percentage == 0 || percentage == 1 || percentage == 2){
                [self easyMoveThiefForwardInLane:key];
            }else{
                [self thiefStay:key];
            }
        }else{
            NSString *currentCharacter = [self.laneDictionary objectForKey:key];
            NSNumber *currentImage = [self.currentImageDictionary objectForKey:currentCharacter];
            int percentage = arc4random() % 4;
            int nextNumber = 0;
            float speed = [[self.characterSpeeds objectForKey:currentCharacter] floatValue];
            if(percentage == 0 || percentage == 1 || percentage == 2 || [currentImage intValue] == 1){
                nextNumber = (self.numberOfPhotos/speed) * self.totalTimeNotLooked;
            }else{
                nextNumber = [currentImage intValue] -1;
            }
            if(nextNumber <= 0){
                nextNumber = 1;
            }else if(nextNumber > self.numberOfPhotos){
                nextNumber = self.numberOfPhotos;
            }
            [self.currentImageDictionary setObject:[NSNumber numberWithInt:nextNumber] forKey:currentCharacter];
            [[self.laneButtonDictionary objectForKey:key] setBackgroundImageNamed:[NSString stringWithFormat:@"%@%@", [self.laneDictionary objectForKey:key], [NSNumber numberWithInt:nextNumber]]];
        }
    }
    
}


-(void)replayGame{
    self.thiefPaused = false;
    
    [self.titleImage setHidden:true];
    [self.titleLabel setHidden:true];
    [self.lanesGroup setHidden:false];
    [self.playButtons setHidden:true];
    [self.theThiefWasLabel setHidden:true];
    [self.thiefRevealImage setHidden:true];
    
    [self setThief];
    [self setLanes];
    [self setBeginningImages];
    [self setThiefSpeed];
    [self.gemImage setImageNamed:@"flatWatch"];
    [self.gemImage setHidden:false];
    
    self.totalTimeNotLooked = 0.0f;
    self.thiefTimeNotLooked = 0.0f;
    self.numberOfLooks = 0;
    
    self.gameRunning = true;
}

#pragma mark- play buttons pressed
- (IBAction)easyButtonPressed {
    self.difficulty = @"E";
    [self replayGame];
    
}

- (IBAction)mediumButtonPressed {
    self.difficulty = @"M";
    [self replayGame];
    
}

- (IBAction)hardButtonPressed {
    self.difficulty = @"H";
    [self replayGame];
    
}

-(void)setThief{
    
    int thiefNumber = arc4random() % 4;
    
    if(thiefNumber == 0){
        self.thiefName = @"K";
    }else if(thiefNumber == 1){
        self.thiefName = @"S";
    }else if(thiefNumber == 2){
        self.thiefName = @"B";
    }else if(thiefNumber == 3){
        self.thiefName = @"I";
    }
    
}

-(void)setLanes{
    
    float ran = arc4random() % 4;
    
    NSDictionary *tempLaneDictionary = [[NSDictionary alloc] init];
    
    if(ran == 0){
       tempLaneDictionary = @{@"1":@"K", @"2":@"S", @"3":@"B", @"4":@"I"};
    }else if(ran == 1){
        tempLaneDictionary = @{@"1":@"I", @"2":@"K", @"3":@"S", @"4":@"B"};
    }else if(ran == 2){
        tempLaneDictionary = @{@"1":@"B", @"2":@"I", @"3":@"K", @"4":@"S"};
    }else if(ran == 3){
        tempLaneDictionary = @{@"1":@"S", @"2":@"B", @"3":@"I", @"4":@"K"};
    }
    
    for(id key in tempLaneDictionary){
        
        if([[tempLaneDictionary objectForKey:key] isEqualToString:self.thiefName]){
            self.thiefLaneNumber = [key intValue];
        }
    }
    self.laneDictionary = [NSMutableDictionary dictionaryWithDictionary:tempLaneDictionary];
}

-(void)setBeginningImages{
    
    for(id key in self.laneDictionary){
        [self.lane1 setBackgroundImageNamed:[NSString stringWithFormat:
                                             @"%@1", [self.laneDictionary objectForKey:@"1"]]];
        
        [self.lane2 setBackgroundImageNamed:[NSString stringWithFormat:
                                             @"%@1", [self.laneDictionary objectForKey:@"2"]]];
        [self.lane3 setBackgroundImageNamed:[NSString stringWithFormat:
                                             @"%@1", [self.laneDictionary objectForKey:@"3"]]];
        [self.lane4 setBackgroundImageNamed:[NSString stringWithFormat:
                                             @"%@1", [self.laneDictionary objectForKey:@"4"]]];
        
        self.currentImageDictionary = [NSMutableDictionary dictionaryWithDictionary:@{@"K":@1, @"I":@1, @"B":@1, @"S":@1}];
        
        
    }
    
}

-(void)setThiefSpeed{
    
    if([self.difficulty isEqualToString:@"E"]){
        self.thiefSpeed = 15.0f;
        self.maxNumberOfLooks = 40;
    }else if([self.difficulty isEqualToString:@"M"]){
        self.thiefSpeed = 7.0f;
        self.maxNumberOfLooks = 15;
    }else if([self.difficulty isEqualToString:@"H"]){
        self.thiefSpeed = 7.0f;
        self.maxNumberOfLooks = 20;
    }
    
    for(id key in self.laneDictionary){
        if(!([key intValue] == self.thiefLaneNumber)){
            int negative = arc4random() % 2 ? 1 : -1;
            float randomSpeed = self.thiefSpeed + ((double)(arc4random() % 3) * negative);
            [self.characterSpeeds setObject:[NSNumber numberWithFloat:randomSpeed] forKey:[self.laneDictionary objectForKey:key]];
            
        }
    }
}

-(void)gameOver{
    
    self.gameRunning = false;
    [self.gemImage setHidden:true];
    [self.lanesGroup setHidden:true];
    [self.theThiefWasLabel setHidden:false];
    self.thiefPaused = true;
    [self performSelector:@selector(revealThief) withObject:nil afterDelay:1.5f];

}


-(void)revealThief{

    [self.theThiefWasLabel setHidden:true];
    [self.thiefRevealImage setHidden:false];
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.WatchThief"];
    
    NSNumber *currentScore = [mySharedDefaults valueForKey:@"Score"];

    if(self.won){
        NSNumber *newScore = [NSNumber numberWithInt:[currentScore intValue]+1];
        [mySharedDefaults setValue:newScore forKey:@"Score"];
        [self.thiefRevealImage setImageNamed:[NSString stringWithFormat:@"%@Win", self.thiefName]];
        NSDictionary *userScore = @{@"Score":@1};
        [WKInterfaceController openParentApplication:userScore reply:^(NSDictionary * __nonnull replyInfo, NSError * __nullable error) {
        }];

    }else{
        NSNumber *newScore = [NSNumber numberWithInt:[currentScore intValue]-1];
        [mySharedDefaults setValue:newScore forKey:@"Score"];
        [self.thiefRevealImage setImageNamed:[NSString stringWithFormat:@"%@Lose", self.thiefName]];

    }
    
    NSDictionary *emptyDic = @{@"E":@"E"};

    [WKInterfaceController openParentApplication:emptyDic reply:^(NSDictionary *replyInfo, NSError *error) {
            
    }];
    
    [self.playButtons setHidden:false];

    
}

- (IBAction)lane1Pressed {
    if(self.gameRunning){
        [self.theThiefWasLabel setText:@"The thief was..."];
        [self gameOver];
        if([self.thiefName isEqualToString:[self.laneDictionary objectForKey:@"1"]]){
            self.won = true;
        }else{
            self.won = false;
        }
    }
}

- (IBAction)lane2Pressed {
    if(self.gameRunning){

        [self.theThiefWasLabel setText:@"The thief was..."];
        [self gameOver];
        if([self.thiefName isEqualToString:[self.laneDictionary objectForKey:@"2"]]){
            self.won = true;
        }else{
            self.won = false;
        }
    }
}

- (IBAction)lane3Pressed {
    if(self.gameRunning){
        [self.theThiefWasLabel setText:@"The thief was..."];
        [self gameOver];
        if([self.thiefName isEqualToString:[self.laneDictionary objectForKey:@"3"]]){
            self.won = true;
        }else{
            self.won = false;
        }
    }
}

- (IBAction)lane4Pressed {
    if(self.gameRunning){
        [self.theThiefWasLabel setText:@"The thief was..."];
        [self gameOver];
        if([self.thiefName isEqualToString:[self.laneDictionary objectForKey:@"4"]]){
            self.won = true;
        }else{
            self.won = false;
        }
    }
}

-(void)timeOut{
    self.gameRunning = false;
    self.won = false;
    [self.gemImage setImageNamed:[NSString stringWithFormat:@"%@0", self.thiefName]];
    [[self.laneButtonDictionary objectForKey:[NSString stringWithFormat:@"%d", self.thiefLaneNumber]] setBackgroundImage:nil];
    [self.theThiefWasLabel setText:@"Somebody stole your watch!"];
    [self performSelector:@selector(gameOver) withObject:nil afterDelay:1.5f];
}

- (IBAction)forceTouch {
}
@end



