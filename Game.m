#import "Game.h"

@interface Game ()

@end

@implementation Game


-(void)GameOver{
    
    //un-comment this section when you have signed the iAd contract.
    //        ADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    //        adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    //        [adView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    //        CGRect adFrame = adView.frame;
    //        adFrame.origin.y = adView.frame.size.height-adView.frame.size.height;
    //        adView.frame = adFrame;
    //        [self.view addSubview:adView];
    
    if (GameCount == 10) {
        [self ShowRateAlert];
    }
    // Stop the music if it's playing
    if (MusicOn == TRUE) {
        [_audioPlayer stop];
    }
    
    // Hide the following
    LeaderBoard.hidden = NO;
    Pause.hidden = YES;
    MusicSwitch.hidden = YES;
    Chicken.hidden = YES;
    Platform1.hidden = YES;
    Platform2.hidden = YES;
    Platform3.hidden = YES;
    Platform4.hidden = YES;
    Platform5.hidden = YES;
    Platform6.hidden = YES;
    ChickenFood.hidden = YES;
    
    StatsLabel.hidden = YES;
    Resume.hidden = YES;
    
    // Display the following
    Characters.hidden = NO;
    MainLabel.hidden = NO;
    
    if(DifLevel == 0)
        DifString = @"Easy";
    
    MainLabel.text = [NSString stringWithFormat:@"Game Over!\n Difficulty: %@", DifString];
    
    Exit.hidden = NO;
    FinalScore.hidden = NO;
    HighScore.hidden = NO;
    PlayAgain.hidden = NO;
    Link.hidden = NO;
    FinalScore.text = [NSString stringWithFormat:@"Final Score: %i", ScoreNumber];
    
    // Stop any movement
    [Movement invalidate];
    
    // Set the score and high score
    if (ScoreNumber > HighScoreNumber) {
        HighScoreNumber = ScoreNumber;
        [[NSUserDefaults standardUserDefaults] setInteger:HighScoreNumber forKey:@"HighScoreSaved"];
        HighScore.hidden = NO;
    }
//    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    HighScore.text = [NSString stringWithFormat:@"High Score: %li", (long)HighScoreNumber];
    [self reportScore];
    
}

-(void)Scoring{
    
    ScoreNumber += AddedScore;
    AddedScore -= 1;
    
    if (AddedScore < 0) {
        AddedScore = 0;
    }
    
    StatsLabel.text = [NSString stringWithFormat:@"%i\nLevel: %d\nHops: %i\n", ScoreNumber, LevelNumber, Hops];
    
    if (ScoreNumber > 1000 && ScoreNumber < 2000){
        LevelNumber = 2;
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgrounNew.jpg"]];
        
    }
    
    if (ScoreNumber > 2000 && ScoreNumber < 3500) {
        LevelNumber = 3;
        self.view.backgroundColor = [UIColor blueColor];
    }
    
    if (ScoreNumber > 3500 && ScoreNumber < 5000) {
        LevelNumber = 4;
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    
    if (ScoreNumber > 5000 && ScoreNumber < 7000) {
        LevelNumber = 5;
        self.view.backgroundColor = [UIColor grayColor];
        
    }
    
    if (ScoreNumber > 7000) {
        LevelNumber = 6;
        self.view.backgroundColor = [UIColor yellowColor];
        
    }
    
}

-(void)PlatformFall{
    
    if (Chicken.center.y > 500){
        PlatformMoveDown = 1;
    }
    else if (Chicken.center.y > 450){
        PlatformMoveDown = 2;
    }
    else if (Chicken.center.y > 400){
        PlatformMoveDown = 4;
    }
    else if (Chicken.center.y > 300){
        PlatformMoveDown = 5;
    }
    else if (Chicken.center.y > 250){
        PlatformMoveDown = 6;
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    ChickenLeft = NO;
    ChickenRight = NO;
    StopSideMovement = YES;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    if (point.x < 160) {
        ChickenLeft = YES;
    }
    else{
        ChickenRight = YES;
    }
    // detect double tap.
    // maybe add a feature that works when you double tap
    NSUInteger numTaps = [[touches anyObject] tapCount];
    if (numTaps== 2) {
        //NSLog(@"Dt");
        //some operations here
    }
    
    
}

-(void)PlatformMovement{
    Platform1.center = CGPointMake(Platform1.center.x, Platform1.center.y + PlatformMoveDown);
    Platform2.center = CGPointMake(Platform2.center.x + Platform2SideMovement, Platform2.center.y + PlatformMoveDown);
    Platform3.center = CGPointMake(Platform3.center.x + Platform3SideMovement, Platform3.center.y + PlatformMoveDown);
    Platform4.center = CGPointMake(Platform4.center.x + Platform4SideMovement, Platform4.center.y + PlatformMoveDown);
    Platform5.center = CGPointMake(Platform5.center.x + Platform5SideMovement, Platform5.center.y + PlatformMoveDown);
    Platform6.center = CGPointMake(Platform6.center.x, Platform6.center.y + PlatformMoveDown);
    ChickenFood.center = CGPointMake(ChickenFood.center.x, ChickenFood.center.y + PlatformMoveDown);
    
    
    if (Platform1.center.x < 37) {
        switch (LevelNumber) {
            case 1:
                Platform1SideMovement = 2;
                break;
            case 2:
                Platform1SideMovement = 3;
                break;
            case 3:
                Platform1SideMovement = 4;
                break;
            case 4:
                Platform1SideMovement = 5;
                break;
            case 5:
                Platform1SideMovement = 6;
                break;
            case 6:
                Platform1SideMovement = 7;
                break;
            default:
                break;
        }
    }
    
    if (Platform1.center.x > 283) {
        switch (LevelNumber) {
            case 1:
                Platform1SideMovement = -2;
                break;
            case 2:
                Platform1SideMovement = -3;
                break;
            case 3:
                Platform1SideMovement = -4;
                break;
            case 4:
                Platform1SideMovement = -5;
                break;
            case 5:
                Platform1SideMovement = -6;
                break;
            case 6:
                Platform1SideMovement = -7;
                break;
            default:
                break;
        }
    }
    
    if (Platform2.center.x < 37) {
        switch (LevelNumber) {
            case 1:
                Platform2SideMovement = 2;
                break;
            case 2:
                Platform2SideMovement = 3;
                break;
            case 3:
                Platform2SideMovement = 4;
                break;
            case 4:
                Platform2SideMovement = 5;
                break;
            case 5:
                Platform2SideMovement = 6;
                break;
            case 6:
                Platform2SideMovement = 7;
                break;
            default:
                break;
        }
    }
    
    if (Platform2.center.x > 283) {
        switch (LevelNumber) {
            case 1:
                Platform2SideMovement = -2;
                break;
            case 2:
                Platform2SideMovement = -3;
                break;
            case 3:
                Platform2SideMovement = -4;
                break;
            case 4:
                Platform2SideMovement = -5;
                break;
            case 5:
                Platform2SideMovement = -6;
                break;
            case 6:
                Platform2SideMovement = -7;
                break;
            default:
                break;
        }
    }
    
    if (Platform3.center.x < 37) {
        switch (LevelNumber) {
            case 1:
                Platform3SideMovement = 2;
                break;
            case 2:
                Platform3SideMovement = 3;
                break;
            case 3:
                Platform3SideMovement = 4;
                break;
            case 4:
                Platform3SideMovement = 5;
                break;
            case 5:
                Platform3SideMovement = 6;
                break;
            case 6:
                Platform3SideMovement = 7;
                break;
            default:
                break;
        }
    }
    
    if (Platform3.center.x > 283) {
        switch (LevelNumber) {
            case 1:
                Platform3SideMovement = -2;
                break;
            case 2:
                Platform3SideMovement = -3;
                break;
            case 3:
                Platform3SideMovement = -4;
                break;
            case 4:
                Platform3SideMovement = -5;
                break;
            case 5:
                Platform3SideMovement = -6;
                break;
            case 6:
                Platform3SideMovement = -7;
                break;
            default:
                break;
        }
    }
    
    if (Platform4.center.x < 37) {
        switch (LevelNumber) {
            case 1:
                Platform4SideMovement = 2;
                break;
            case 2:
                Platform4SideMovement = 3;
                break;
            case 3:
                Platform4SideMovement = 4;
                break;
            case 4:
                Platform4SideMovement = 5;
                break;
            case 5:
                Platform4SideMovement = 6;
                break;
            case 6:
                Platform4SideMovement = 7;
                break;
            default:
                break;
        }
    }
    
    if (Platform4.center.x > 283) {
        switch (LevelNumber) {
            case 1:
                Platform4SideMovement = -2;
                break;
            case 2:
                Platform4SideMovement = -3;
                break;
            case 3:
                Platform4SideMovement = -4;
                break;
            case 4:
                Platform4SideMovement = -5;
                break;
            case 5:
                Platform4SideMovement = -6;
                break;
            case 6:
                Platform4SideMovement = -7;
                break;
            default:
                break;
        }
    }
    
    if (Platform5.center.x < 37) {
        switch (LevelNumber) {
            case 1:
                Platform5SideMovement = 2;
                break;
            case 2:
                Platform5SideMovement = 3;
                break;
            case 3:
                Platform5SideMovement = 4;
                break;
            case 4:
                Platform5SideMovement = 5;
                break;
            case 5:
                Platform5SideMovement = 6;
                break;
            case 6:
                Platform5SideMovement = 7;
                break;
            default:
                break;
        }
    }
    
    if (Platform5.center.x > 283) {
        switch (LevelNumber) {
            case 1:
                Platform5SideMovement = -2;
                break;
            case 2:
                Platform5SideMovement = -3;
                break;
            case 3:
                Platform5SideMovement = -4;
                break;
            case 4:
                Platform5SideMovement = -5;
                break;
            case 5:
                Platform5SideMovement = -6;
                break;
            case 6:
                Platform5SideMovement = -7;
                break;
            default:
                break;
        }
    }
    
    if (Platform6.center.x < 37) {
        switch (LevelNumber) {
            case 1:
                Platform6SideMovement = 2;
                break;
            case 2:
                Platform6SideMovement = 3;
                break;
            case 3:
                Platform6SideMovement = 4;
                break;
            case 4:
                Platform6SideMovement = 5;
                break;
            case 5:
                Platform6SideMovement = 6;
                break;
            case 6:
                Platform6SideMovement = 7;
                break;
            default:
                break;
        }
    }
    
    if (Platform6.center.x > 283) {
        switch (LevelNumber) {
            case 1:
                Platform6SideMovement = -2;
                break;
            case 2:
                Platform6SideMovement = -3;
                break;
            case 3:
                Platform6SideMovement = -4;
                break;
            case 4:
                Platform6SideMovement = -5;
                break;
            case 5:
                Platform6SideMovement = -6;
                break;
            case 6:
                Platform6SideMovement = -7;
                break;
            default:
                break;
        }
    }
    
    
    PlatformMoveDown = PlatformMoveDown - 0.11;
    
    if (PlatformMoveDown < 0) {
        PlatformMoveDown = 0;
    }
    
    
    if (Platform1.center.y > 575) {
        RandomPosition = arc4random() %248;
        RandomPosition = RandomPosition + 36;
        Platform1.center = CGPointMake(RandomPosition, -6);
        Platform1Used = NO;
    }
    
    if (Platform2.center.y > 575) {
        RandomPosition = arc4random() %248;
        RandomPosition = RandomPosition + 36;
        Platform2.center = CGPointMake(RandomPosition, -6);
        Platform2Used = NO;
    }
    if (Platform3.center.y > 575) {
        RandomPosition = arc4random() %248;
        RandomPosition = RandomPosition + 36;
        Platform3.center = CGPointMake(RandomPosition, -6);
        Platform3Used = NO;
    }
    
    if (Platform4.center.y > 575) {
        RandomPosition = arc4random() %248;
        RandomPosition = RandomPosition + 36;
        Platform4.center = CGPointMake(RandomPosition, -6);
        Platform4Used = NO;
    }
    if (Platform5.center.y > 575) {
        RandomPosition = arc4random() %248;
        RandomPosition = RandomPosition + 36;
        Platform5.center = CGPointMake(RandomPosition, -6);
        Platform5Used = NO;
    }
    
    if (Platform6.center.y > 575) {
        RandomPosition = arc4random() %248;
        RandomPosition = RandomPosition + 36;
        Platform6.center = CGPointMake(RandomPosition, -6);
        Platform6Used = NO;
    }
    if (ChickenFood.center.y > 575) {
        RandomPosition = arc4random() %248;
        RandomPosition = RandomPosition + 36;
        ChickenFood.center = CGPointMake(RandomPosition, -6);
    }
    
}

-(void)Bounce{
    
    // Set the new image from iOS photo lib or camera as the bounc animation.
    
    Chicken.animationImages = [NSArray arrayWithObjects:
                               [UIImage imageWithData:data],
                               [UIImage imageWithData:data],
                               [UIImage imageWithData:data],
                               [UIImage imageWithData:data], nil];
    
    [Chicken setAnimationRepeatCount:1];
    Chicken.animationDuration = 0.2;
    [Chicken startAnimating];
    
    if (Chicken.center.y > 450) {
        XMovement = 5;
    }
    else if (Chicken.center.y > 350){
        XMovement = 4;
    }
    else if (Chicken.center.y > 250){
        XMovement = 4;
    }
    
}

-(void)Moving{

    if(LevelNumber != 2){
        ChickenFood.hidden = YES;
    }
    else
        ChickenFood.hidden = NO;
    
    if (ChickenFoodUsed == YES) {
        ChickenFood.hidden = YES;
    }
    
    // Pausing Music while playing the game from the pause menu
    if(MusicOn == FALSE)
    {
        [_audioPlayer pause];
    }
    
    // Resuming Music while playing the game from the pause menu
    if(MusicOn == TRUE)
    {
        [_audioPlayer play];
    }
    
    // Game over if chicken falls off the screen
    if (Chicken.center.y > 580)
    {
        [self GameOver];
    }
    
    [self Scoring];
    
    if (Chicken.center.y < 250)
    {
        Chicken.center = CGPointMake(Chicken.center.x, 250);
    }
    
    [self PlatformMovement];
    
    Chicken.center = CGPointMake(Chicken.center.x + YMovement, Chicken.center.y - XMovement);
    
    // Calling Bounce movement function when chicken lands on a platform
    if((CGRectIntersectsRect(Chicken.frame, Platform1.frame)) && (XMovement <= -1))
    {
        [self Bounce];
        [self PlatformFall];
        if (Platform1Used == NO) {
            AddedScore = 10;
            Platform1Used = YES;
            Hops += 1;
        }
    }
    if((CGRectIntersectsRect(Chicken.frame, Platform2.frame)) && (XMovement <= -1))
    {
        [self Bounce];
        [self PlatformFall];
        if (Platform2Used == NO) {
            AddedScore = 10;
            Platform2Used = YES;
            Hops += 1;
        }
    }
    if((CGRectIntersectsRect(Chicken.frame, Platform3.frame)) && (XMovement <= -1))
    {
        [self Bounce];
        [self PlatformFall];
        if (Platform3Used == NO) {
            AddedScore = 10;
            Platform3Used = YES;
            Hops += 1;
        }
    }
    if((CGRectIntersectsRect(Chicken.frame, Platform4.frame)) && (XMovement <= -1))
    {
        [self Bounce];
        [self PlatformFall];
        if (Platform4Used == NO) {
            AddedScore = 10;
            Platform4Used = YES;
            Hops += 1;
        }
    }
    if((CGRectIntersectsRect(Chicken.frame, Platform5.frame)) && (XMovement <= -1))
    {
        [self Bounce];
        [self PlatformFall];
        if (Platform5Used == NO) {
            AddedScore = 10;
            Platform5Used = YES;
            Hops += 1;
            
        }
    }
    if(DifLevel != 0 && (CGRectIntersectsRect(Chicken.frame, Platform6.frame)))
    {
        Platform6Used = YES;
        PlatformMoveDown = 0;
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [self GameOver];
        MainLabel.text = [NSString stringWithFormat:@"The Bug ate the Chicken!\n Difficulty: %@", DifString];
        
    }
    
    if((CGRectIntersectsRect(Chicken.frame, ChickenFood.frame)) && LevelNumber == 2)
    {
        if (ChickenFoodUsed == NO) {
            AddedScore = 30;
            ChickenFoodUsed = YES;
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            
        }
        ChickenFood.hidden = YES;
    }
    
    
    XMovement = XMovement - 0.1;
    
    if (ChickenLeft == YES)
    {
        YMovement = YMovement - 0.3;
        if (YMovement < -5) {
            YMovement = -5;
        }
    }
    
    
    if (ChickenRight == YES)
    {
        YMovement = YMovement + 0.3;
        if (YMovement > 5) {
            YMovement = 5;
        }
    }
    
    
    if(StopSideMovement == YES && YMovement > 0)
    {
        YMovement = YMovement - 0.1;
        if (YMovement < 0) {
            YMovement = 0;
            StopSideMovement = NO;
        }
    }
    
    if (StopSideMovement == YES && YMovement < 0)
    {
        YMovement = YMovement + 0.1;
        if (YMovement > 0) {
            YMovement = 0;
            StopSideMovement = NO;
        }
    }
    
    
    // When chicken goes off the side of the scrren
    if (Chicken.center.x < -11)
    {
        Chicken.center = CGPointMake(330, Chicken.center.y);
    }
    
    if (Chicken.center.x > 330)
    {
        Chicken.center = CGPointMake(-11, Chicken.center.y);
    }
}

-(IBAction)StartGame:(id)sender{
    
    GameCount++;
    [_audioPlayer stop];
    
    Start.hidden = YES;
    XMovement = -5;
    
    // Needed for the game
    Pause.hidden = NO;
    Chicken.hidden = NO;
    Platform1.hidden = NO;
    Platform2.hidden = NO;
    Platform3.hidden = NO;
    Platform4.hidden = NO;
    Platform5.hidden = NO;
    StatsLabel.hidden = NO;
    
    if(DifLevel != 0){
        Platform6.hidden = NO;
    }
    
    MainLabel.hidden = YES;
    MusicSwitch.hidden = YES;
    MusicLabel.hidden = YES;
    //    ImagePickerButton.hidden = YES;
    PickChicken1.hidden = YES;
    PickChicken2.hidden = YES;
    
    RandomPosition = arc4random()%248;
    RandomPosition = RandomPosition + 36;
    Platform2.center = CGPointMake(RandomPosition, 448);
    
    RandomPosition = arc4random()%248;
    RandomPosition = RandomPosition + 36;
    Platform3.center = CGPointMake(RandomPosition, 336);
    
    RandomPosition = arc4random()%248;
    RandomPosition = RandomPosition + 36;
    Platform4.center = CGPointMake(RandomPosition, 224);
    
    RandomPosition = arc4random()%248;
    RandomPosition = RandomPosition + 36;
    Platform5.center = CGPointMake(RandomPosition, 112);
    
    RandomPosition = arc4random()%248;
    RandomPosition = RandomPosition + 36;
    Platform6.center = CGPointMake(RandomPosition, 45);
    
    Platform1SideMovement = -2;
    Platform2SideMovement = 2;
    Platform3SideMovement = -2;
    Platform4SideMovement = 2;
    Platform5SideMovement = -2;
    Platform6SideMovement = 2;
    
    // Construct URL to sound file
    if(MusicOn == TRUE)
    {
        NSString *path = [NSString stringWithFormat:@"%@/chickenSong.mp3", [[NSBundle mainBundle] resourcePath]];
        NSURL *soundUrl = [NSURL fileURLWithPath:path];
        
        // Create audio player object and initialize with URL to sound
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
        
        [_audioPlayer play];
    }
    [self authenticateLocalPlayer];
    Movement = [NSTimer scheduledTimerWithTimeInterval:TimerSpeed target:self selector:@selector(Moving) userInfo:nil repeats:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PauseMethod) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PauseMethod) name:UIApplicationWillResignActiveNotification object:nil];
}

-(IBAction)MusicControl:(id)sender{
    
    if([sender isOn]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"MusicSwitchOn"];
        MusicOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"MusicSwitchOn"];
        MusicOn = TRUE;
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"MusicSwitchOn"];
        MusicOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"MusicSwitchOn"];
        MusicOn = FALSE;
    }
    
    
}

-(void)PauseMethod{
    // Needed during the game
    Chicken.hidden = YES;
    Platform1.hidden = YES;
    Platform2.hidden = YES;
    Platform3.hidden = YES;
    Platform4.hidden = YES;
    Platform5.hidden = YES;
    Platform6.hidden = YES;
    MainLabel.hidden = NO;
    FinalScore.hidden = YES;
    HighScore.hidden = YES;
    PlayAgain.hidden = YES;
    Pause.hidden = YES;
    
    Resume.hidden = NO;
    Exit.hidden = NO;
    Link.hidden = NO;
    
    MainLabel.text = (@"Game Paused");
    
    MusicSwitch.hidden = NO;
    MusicLabel.hidden = NO;
    
    
    if (MusicOn == TRUE) {
        [MusicSwitch setOn:YES];
    }
    else  {
        [MusicSwitch setOn:NO];
    }
    
    if (ChickenFood.hidden == NO) {
        ChickenFood.hidden = YES;
    }
    
    
    // Pause the movement
    [Movement invalidate];
    Movement = nil;
    
    // Pause the music if it's playing
    [_audioPlayer pause];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(IBAction)Pause:(id)sender{
    
    [self PauseMethod];
    
}

-(IBAction)Resume:(id)sender{
    
    
    // Needed during the game
    Chicken.hidden = NO;
    Platform1.hidden = NO;
    Platform2.hidden = NO;
    Platform3.hidden = NO;
    Platform4.hidden = NO;
    Platform5.hidden = NO;
    
    if(DifLevel != 0){
        Platform6.hidden = NO;
    }
    
    if (LevelNumber == 2 && ChickenFoodUsed == NO) {
        ChickenFood.hidden = NO;
    }
    
    Pause.hidden = NO;
    
    // Needed when the game is over
    MainLabel.hidden = YES;
    FinalScore.hidden = YES;
    HighScore.hidden = YES;
    Exit.hidden = YES;
    PlayAgain.hidden = YES;
    Link.hidden = YES;
    Resume.hidden = YES;
    MusicSwitch.hidden = YES;
    MusicLabel.hidden = YES;
    
    // Start the movement again
    Movement = [NSTimer scheduledTimerWithTimeInterval:TimerSpeed target:self selector:@selector(Moving) userInfo:nil repeats:YES];
    
    // Start the music again
    [_audioPlayer play];
    
}

-(IBAction)Link:(id)sender{
    
    // Use this function to open an external link. Currently using Liem's Soundcloud
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://soundcloud.com/liemnguyen15"]];
}

-(IBAction)LeaderBoard:(id)sender{
    [self reportScore];
    [self showLeaderboardAndAchievements:TRUE];
}

-(IBAction)ChangeToLChicken:(id)sender{
    
    BoolPickLChicken = TRUE;
    BoolPickChicken2 = FALSE;
    
}

-(IBAction)ChangeToChicken2:(id)sender{
    
    BoolPickChicken2 = TRUE;
    BoolPickLChicken = FALSE;
    
}

-(IBAction)ChangeToDefaultChicken:(id)sender{
    
    BoolPickChicken2 = FALSE;
    BoolPickLChicken = FALSE;
    
}

-(IBAction)Easy:(id)sender{
    
    DifLevel = 0;
    DifString = @"Easy";
    TimerSpeed = .02;
    
    [EasyButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [MedButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [HardButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [ExpertButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
}

-(IBAction)Medium:(id)sender{
    
    DifLevel = 1;
    DifString = @"Medium";
    [MedButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [EasyButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [HardButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [ExpertButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    TimerSpeed = .02;
}

-(IBAction)Hard:(id)sender{
    
    DifLevel = 2;
    DifString = @"Hard";
    [HardButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [MedButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [EasyButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [ExpertButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    TimerSpeed = .015;
    
}

-(IBAction)Expert:(id)sender{
    
    DifLevel = 3;
    DifString = @"Expert";
    [ExpertButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [MedButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [HardButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [EasyButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    TimerSpeed = .015;
    
}

-(void)viewDidLoad{
    
    // Setting default timer speed and button colors
    if(DifLevel == 0){
        [EasyButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        TimerSpeed = .02;
    }
    else if (DifLevel == 1){
        [MedButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
    }
    else if (DifLevel == 2){
        [HardButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    else{
        [ExpertButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    
    // Picking and setting the chicken characters and backgrounds
    if (BoolPickLChicken == TRUE) {
        [Chicken setImage:[UIImage imageNamed:@"liem.png"]];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background3.jpeg"]];
        
    }
    else if (BoolPickChicken2 == TRUE) {
        [Chicken setImage:[UIImage imageNamed:@"chicken2.png"]];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background2.jpeg"]];
        
    }
    else if (!BoolPickLChicken && !BoolPickChicken2){
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background1.png"]];
        
    }
    
    MainLabel.text = (@"Music Setting:");
    
    // Needed during the game
    LeaderBoard.hidden = YES;
    Characters.hidden = YES;
    Chicken.hidden = YES;
    Platform1.hidden = YES;
    Platform2.hidden = YES;
    Platform3.hidden = YES;
    Platform4.hidden = YES;
    Platform5.hidden = YES;
    Platform6.hidden = YES;
    Pause.hidden = YES;
    ChickenFood.hidden = YES;
    
    // Needed when the game is over
    FinalScore.hidden = YES;
    HighScore.hidden = YES;
    Exit.hidden = YES;
    PlayAgain.hidden = YES;
    Link.hidden = YES;
    StatsLabel.hidden = YES;
    
    ScoreNumber = 0;
    AddedScore = 0;
    LevelNumber = 1;
    
    Platform1Used = NO;
    Platform2Used = NO;
    Platform3Used = NO;
    Platform4Used = NO;
    Platform5Used = NO;
    Platform6Used = NO;
    ChickenFoodUsed = NO;
    Resume.hidden = YES;
    
    
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    XMovement = 0;
    YMovement = 0;
    Hops = 0;
    
    [_audioPlayer stop];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"MusicSwitchOn"]) {
        [defaults setBool:YES forKey:@"MusicSwitchOn"];
    }
    
    if (MusicOn == TRUE) {
        [MusicSwitch setOn:YES];
    }
    else {
        [MusicSwitch setOn:NO];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [super viewDidLoad];
    
}

-(void)authenticateLocalPlayer{
    
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            [self presentViewController:viewController animated:YES completion:nil];
            [self PauseMethod];
        }
        else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                gameCenterEnabled = TRUE;
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else{
                        leaderboardIdentifier = leaderboardIdentifier;
                    }
                }];
            }
            else{
                gameCenterEnabled = NO;
            }
        }
    };
}

-(void)reportScore{
    
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:leaderboardIdentifier];
    score.value = HighScoreNumber;
//    NSLog(@"%lli", score.value);
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard{
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    gcViewController.gameCenterDelegate = self;
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = leaderboardIdentifier;
    }
    else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    [self presentViewController:gcViewController animated:YES completion:nil];
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gcViewController{
    [gcViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ShowRateAlert{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Like Chicken Hop?"
                                                     message:@"Rate it on the App Store"
                                                    delegate:self
                                           cancelButtonTitle:@"No, I don't like it"
                                           otherButtonTitles: nil];
    [alert addButtonWithTitle:@"Rate!"];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0)
    {
        GameCount = 0;
    }
    else if(buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"itms-apps://itunes.apple.com/app/" stringByAppendingString: @"id993561751"]]];
    }
}
-(void)color{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    self.view.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

//
//-(IBAction)uploadNewPhotoTapped:(id)sender {
//
//    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
//
//    //You can use isSourceTypeAvailable to check
//
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        imagePickController.sourceType = UIImagePickerControllerSourceTypeCamera;
//        imagePickController.showsCameraControls = YES;
//        //  self.usingPopover = NO;
//    }
//    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
//    {
//        //Check PhotoLibrary  available or not
//        imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
//        //Check front Camera available or not
//        imagePickController.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    //else //!!!!!!!!!!!exception
//
//    imagePickController.delegate = self;
//    imagePickController.allowsEditing = NO;
//
//    uploadedBackground = TRUE;
//
//    [self presentViewController:imagePickController animated:YES completion:nil];
//}
//
//-(void)imagePickerController:(UIImagePickerController *)picker  didFinishPickingMediaWithInfo:(NSDictionary *)info {
//
//    UIImage *originalImage=[info objectForKey:UIImagePickerControllerOriginalImage];
//    data = UIImageJPEGRepresentation(originalImage, 1.0);
//
//    // Set a customizable image (originalImage -> NSDATA -> data = convert into UIImage imageWithData:data)
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithData:data]];
//    //    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
//    //                                        backgroundImageView.frame = self.view.bounds;
//    //                                        [self.view addSubview:backgroundImageView];
//    //
//    //[Chicken setImage:[UIImage imageWithData:data]];
//
//    [self dismissViewControllerAnimated: YES completion:nil];
//}
//
//

@end







