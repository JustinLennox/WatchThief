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
    
    self.openingUIArray = @[self.titleImage];
    [self.thiefRevealImage setHidden:true];
    [self.theThiefWasLabel setHidden:true];
    [self.gemImage setHidden:true];
    [self.lanesGroup setHidden:true];
    self.numberOfPhotos = 6;
    self.laneButtonDictionary = @{@"1":self.lane1, @"2":self.lane2, @"3":self.lane3, @"4":self.lane4};
    self.currentImageDictionary = [[NSMutableDictionary alloc] init];
    self.characterSpeeds = [[NSMutableDictionary alloc] init];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    if(self.gameRunning){
        
        self.activatedTime = CACurrentMediaTime();
        self.timeNotLooking = self.activatedTime - self.deactivatedTime;
        self.totalTimeNotLooked += self.timeNotLooking;

        NSLog(@"Total time not looked:%f", self.totalTimeNotLooked);

        if([self.difficulty isEqualToString:@"E"]){
            [self easyUpdateLanes];
        }else if([self.difficulty isEqualToString:@"M"]){
            [self mediumUpdateLanes];

        }else if([self.difficulty isEqualToString:@"H"]){
            [self hardUpdateLanes];

        }
    }

}

- (void)didDeactivate {
    [super didDeactivate];
    
    self.deactivatedTime = CACurrentMediaTime();

}


#pragma mark- Update Lane Logic

-(void) easyUpdateLanes{
    
    for(id key in self.laneButtonDictionary){
        if([key isEqualToString:[NSString stringWithFormat:@"%d", self.thiefLaneNumber]]){
            int percentage = arc4random() % 4;
            if(percentage == 0 || percentage == 1 || percentage == 3){
                [self easyMoveThiefForwardInLane:key];
                NSLog(@"Thief moves");
            }
        }else{
            NSString *currentCharacter = [self.laneDictionary objectForKey:key];
            NSNumber *currentImage = [self.currentImageDictionary objectForKey:currentCharacter];
            int percentage = arc4random() % 4;
            int nextNumber = 0;
            float speed = [[self.characterSpeeds objectForKey:currentCharacter] floatValue];
            if(percentage == 0 || percentage == 1 || percentage == 3 || [currentImage intValue] == 1){
                nextNumber = (self.numberOfPhotos/speed) * self.totalTimeNotLooked;
                NSLog(@"Character %@ moves", key);
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

-(void)easyMoveThiefForwardInLane: (NSString *) laneNumber{
    
    int number = (self.numberOfPhotos/self.thiefSpeed) * self.totalTimeNotLooked;
    if(number < self.numberOfPhotos){
        number++;
    }else if(number >= self.numberOfPhotos){
        number = self.numberOfPhotos;
    }
    [[self.laneButtonDictionary objectForKey:laneNumber] setBackgroundImageNamed:[NSString stringWithFormat:@"%@%@", self.thiefName, [NSNumber numberWithInt:number]]];
    [self updateThiefTime];
    
}

-(void)updateThiefTime{
    
    self.thiefTimeNotLooked += self.timeNotLooking;
    NSLog(@"Thief time not looked:%f", self.thiefTimeNotLooked);
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

-(void)hardUpdateLanes{
    
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
    for(UIView *view in self.openingUIArray){
        [view setHidden:true];
        
    }
    
    [self.lanesGroup setHidden:false];
    [self.playButtons setHidden:true];
    [self.theThiefWasLabel setHidden:true];
    [self.thiefRevealImage setHidden:true];
    
    [self setThief];
    [self setLanes];
    [self setThiefSpeed];
    [self.gemImage setImageNamed:@"GEM"];
    [self.gemImage setHidden:false];
    
    self.totalTimeNotLooked = 0.0f;
    self.thiefTimeNotLooked = 0.0f;
    
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
    
    self.fakeThief = self.thiefName;
    while([self.fakeThief isEqualToString:self.thiefName]){
        int fakeThiefNumber = arc4random() % 4;
        NSArray *names = @[@"K", @"S", @"B", @"I"];
        self.fakeThief = [names objectAtIndex:fakeThiefNumber];
    }
    
    NSLog(@"Thief: %@", self.thiefName);
    NSLog(@"Fake thief: %@", self.fakeThief);
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
    NSLog(@"%@", self.laneDictionary);
    
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
    }else if([self.difficulty isEqualToString:@"M"]){
        self.thiefSpeed = 10.0f;
    }else if([self.difficulty isEqualToString:@"H"]){
        self.thiefSpeed = 6.0f;
    }
    
    for(id key in self.laneDictionary){
        if(!([key intValue] == self.thiefLaneNumber)){
            int negative = arc4random() % 2 ? 1 : -1;
            float randomSpeed = self.thiefSpeed + ((double)(arc4random() % 3) * negative);
            [self.characterSpeeds setObject:[NSNumber numberWithFloat:randomSpeed] forKey:[self.laneDictionary objectForKey:key]];
            
        }
    }
    NSLog(@"Character speeds:%@", self.characterSpeeds);
}

-(void)gameOver{
    
    [self.gemImage setHidden:true];
    [self.lanesGroup setHidden:true];
    [self.theThiefWasLabel setHidden:false];
    [self performSelector:@selector(revealThief) withObject:nil afterDelay:1.5f];
    self.gameRunning = false;

}


-(void)revealThief{
    
    [self.theThiefWasLabel setHidden:true];
    [self.thiefRevealImage setHidden:false];
    NSLog(@"Won?:%d", self.won);
    
    
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
    
    [self.gemImage setImageNamed:[NSString stringWithFormat:@"%@1", self.thiefName]];
    [[self.laneButtonDictionary objectForKey:[NSString stringWithFormat:@"%d", self.thiefLaneNumber]] setBackgroundImage:nil];
    [self.theThiefWasLabel setText:@"The thief stole your gem!"];
    [self performSelector:@selector(gameOver) withObject:nil afterDelay:1.5f];
}

- (IBAction)forceTouch {
}
@end



