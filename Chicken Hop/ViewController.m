#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)LinkToHelp:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/manu_sooodhi"]];
}

-(IBAction)RateApp:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"itms-apps://itunes.apple.com/app/" stringByAppendingString: @"id993561751"]]];
}

@end
