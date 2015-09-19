#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreData/CoreData.h>
#import <AudioToolbox/AudioToolbox.h>
#import <GameKit/GameKit.h>

float XMovement;
float YMovement;
float PlatformMoveDown;
float TimerSpeed;
float newTime;

int Hops;
int ScoreNumber;
int AddedScore;
int LevelNumber;
int RandomPosition;
int DifLevel;
int Platform1SideMovement;
int Platform2SideMovement;
int Platform3SideMovement;
int Platform4SideMovement;
int Platform5SideMovement;
int Platform6SideMovement;
int GameCount;

BOOL gameCenterEnabled;
BOOL MusicOn;
BOOL ChickenLeft;
BOOL ChickenRight;
BOOL StopSideMovement;
BOOL Platform1Used;
BOOL Platform2Used;
BOOL Platform3Used;
BOOL Platform4Used;
BOOL Platform5Used;
BOOL Platform6Used;
BOOL BoolPickLChicken;
BOOL BoolPickChicken2;
BOOL uploadedBackground;
BOOL ChickenFoodUsed;

NSString *leaderboardIdentifier = @"998349682";
NSInteger HighScoreNumber;
NSData *data;
NSString *DifString;

@interface Game : UIViewController <GKGameCenterControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ADBannerViewDelegate>
{
    
    
    AVAudioPlayer *_audioPlayer;
    NSTimer *Movement;
    IBOutlet UIButton *Exit;
    IBOutlet UIButton *PlayAgain;
    IBOutlet UIButton *Start;
    IBOutlet UIButton *Link;
    //IBOutlet UIButton *ImagePickerButton;
    IBOutlet UIButton *PickChicken1;
    IBOutlet UIButton *PickChicken2;
    IBOutlet UIButton *Pause;
    IBOutlet UIButton *Resume;
    IBOutlet UIButton *Characters;
    IBOutlet UIButton *EasyButton;
    IBOutlet UIButton *MedButton;
    IBOutlet UIButton *HardButton;
    IBOutlet UIButton *ExpertButton;
    IBOutlet UIButton *LeaderBoard;
    
    IBOutlet UIImageView *Chicken;
    IBOutlet UIImageView *Platform1;
    IBOutlet UIImageView *Platform2;
    IBOutlet UIImageView *Platform3;
    IBOutlet UIImageView *Platform4;
    IBOutlet UIImageView *Platform5;
    IBOutlet UIImageView *Platform6;
    IBOutlet UIImageView *ChickenFood;
    
    IBOutlet UILabel *MusicLabel;
    IBOutlet UILabel *StatsLabel;
    IBOutlet UILabel *MainLabel;
    IBOutlet UILabel *FinalScore;
    IBOutlet UILabel *HighScore;

    IBOutlet UISwitch *MusicSwitch;
    

}
-(void)ShowRateAlert;
-(IBAction)StartGame:(id)sender;
-(IBAction)Link:(id)sender;
-(IBAction)LeaderBoard:(id)sender;
-(IBAction)Pause:(id)sender;
-(IBAction)Resume:(id)sender;
-(IBAction)Easy:(id)sender;
-(IBAction)Medium:(id)sender;
-(IBAction)Hard:(id)sender;
-(IBAction)Expert:(id)sender;
//-(IBAction)uploadNewPhotoTapped:(id)sender;
-(IBAction)ChangeToChicken2:(id)sender;
-(IBAction)ChangeToDefaultChicken:(id)sender;
-(IBAction)ChangeToLChicken:(id)sender;
-(IBAction)MusicControl:(id)sender;
-(void)Moving;
-(void)PauseMethod;
-(void)Bounce;
-(void)PlatformMovement;
-(void)PlatformFall;
-(void)Scoring;
-(void)GameOver;
-(void)authenticateLocalPlayer;
-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard;


@end
