import Foundation
import UIKit
class GameSwift: UIViewController{
    
    
    var ChickenLeft: Bool!
    var ChickenRight: Bool!
    var StopSideMovement: Bool!
    var Platform1Used: Bool!
    var Platform2Used: Bool!
    var Platform3Used: Bool!
    var Platform4Used: Bool!
    var Platform5Used: Bool!
    var Platform1SideMovement: CGFloat!
    var Platform2SideMovement: CGFloat!
    var Platform3SideMovement: CGFloat!
    var Platform4SideMovement: CGFloat!
    var Platform5SideMovement: CGFloat!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var statsLabel: UILabel!
    @IBOutlet var Chicken: UIImageView!
    @IBOutlet var Platform1: UIImageView!
    @IBOutlet var Platform2: UIImageView!
    @IBOutlet var Platform3: UIImageView!
    @IBOutlet var Platform4: UIImageView!
    @IBOutlet var Platform5: UIImageView!
    
    var movement: NSTimer!
    @IBOutlet var startButton: UIButton!
    
    var XMovement: CGFloat!
    var YMovement: CGFloat!
    var PlatformMoveDown: CGFloat!
    var LevelNumber: CGFloat!
    var RandomPosition: CGFloat!
    var ScoreNumber: Int = 0
    var AddedScore: Int = 0
    
    override func viewDidLoad() {
        statsLabel.hidden = true
        mainLabel.hidden = true
        XMovement = 0
        YMovement = 0
        ChickenLeft = false
        ChickenRight = false
        StopSideMovement = true
        Platform1Used = false
        Platform2Used = false
        Platform3Used = false
        Platform4Used = false
        Platform5Used = false
        LevelNumber = 1
        PlatformMoveDown = 0
        Platform1SideMovement = 0
        Platform2SideMovement = 2
        Platform3SideMovement = -2
        Platform4SideMovement = 2
        Platform5SideMovement = -2
        ScoreNumber = 0
        AddedScore = 0
        
    
    }

    func scoring() {
        ScoreNumber += AddedScore;
        
        AddedScore -= 1;
        
        if (AddedScore < 0) {
            AddedScore = 0;
        }
//        var actualScore = String(ScoreNumber)
//        statsLabel.text = actualScore
        
        if (ScoreNumber > 500 && ScoreNumber < 2000){
            LevelNumber = 2;
            view.backgroundColor = UIColor(patternImage: UIImage(named: "background1.png")!)
        }
        
        if (ScoreNumber > 2000 && ScoreNumber < 3500) {
            LevelNumber = 3;
            view.backgroundColor = UIColor.blueColor()
        }
        
        if (ScoreNumber > 3500 && ScoreNumber < 5000) {
            LevelNumber = 4;
            view.backgroundColor = UIColor.whiteColor()
        }
        
        if (ScoreNumber > 5000 && ScoreNumber < 7000) {
            LevelNumber = 5;
            view.backgroundColor = UIColor.grayColor()
        }
        
        if (ScoreNumber > 7000) {
            LevelNumber = 6;
            view.backgroundColor = UIColor.yellowColor()
            
        }

    }
    
    @IBAction func startGame(sender: AnyObject) {
        statsLabel.hidden = false
        startButton.hidden = true
        movement = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "moving", userInfo: nil, repeats: true)
    }
    
    func moving() {
        
        if (Chicken.center.y < 250)
        {
            Chicken.center = CGPointMake(Chicken.center.x, 250);
        }
        
        platformMovement()
        scoring()
        Chicken.center = CGPointMake(Chicken.center.x + YMovement, Chicken.center.y - XMovement);
        
        if((CGRectIntersectsRect(Chicken.frame, Platform1.frame)) && (XMovement <= -1))
        {
            bounce()
            platformFall()
            
            if (Platform1Used == false) {
                AddedScore = 10;
                Platform1Used = true;
            }
        }
        if((CGRectIntersectsRect(Chicken.frame, Platform2.frame)) && (XMovement <= -1))
        {
            bounce()
            platformFall()
            if (Platform2Used == false) {
                AddedScore = 10;
                Platform2Used = true;
                Platform1SideMovement = -Platform2SideMovement
            }
        }
        if((CGRectIntersectsRect(Chicken.frame, Platform3.frame)) && (XMovement <= -1))
        {
            bounce()
            platformFall()
            if (Platform3Used == false) {
                AddedScore = 10;
                Platform3Used = true;
            }
        }
        if((CGRectIntersectsRect(Chicken.frame, Platform4.frame)) && (XMovement <= -1))
        {
            bounce()
            platformFall()
            if (Platform4Used == false) {
                AddedScore = 10;
                Platform4Used = true;
            }
        }
        if((CGRectIntersectsRect(Chicken.frame, Platform5.frame)) && (XMovement <= -1))
        {
            bounce()
            platformFall()
            if (Platform5Used == false) {
                AddedScore = 10;
                Platform5Used = true;
                
            }
        }

        
        XMovement = XMovement - 0.1;
        
        if (ChickenLeft == true)
        {
            YMovement = YMovement - 0.3;
            if (YMovement < -5) {
                YMovement = -5;
            }
        }
        
        
        if (ChickenRight == true)
        {
            YMovement = YMovement + 0.3;
            if (YMovement > 5) {
                YMovement = 5;
            }
        }
        
        
        if(StopSideMovement == true && YMovement > 0)
        {
            YMovement = YMovement - 0.1;
            if (YMovement < 0) {
                YMovement = 0;
                StopSideMovement = false;
            }
        }
        
        if (StopSideMovement == true && YMovement < 0)
        {
            YMovement = YMovement + 0.1;
            if (YMovement > 0) {
                YMovement = 0;
                StopSideMovement = false;
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
        // Game over
        if (Chicken.center.y > 580)
        {
            gameOver()
        }

    
    }
    
    func gameOver() {
        mainLabel.text = "Game Over"
        mainLabel.hidden = false
        Chicken.hidden = true
        movement.invalidate()

    }
    
    func platformMovement() {
        Platform1.center = CGPointMake(Platform1.center.x + Platform1SideMovement, Platform1.center.y + PlatformMoveDown);
        Platform2.center = CGPointMake(Platform2.center.x + Platform2SideMovement, Platform2.center.y + PlatformMoveDown);
        Platform3.center = CGPointMake(Platform3.center.x + Platform3SideMovement, Platform3.center.y + PlatformMoveDown);
        Platform4.center = CGPointMake(Platform4.center.x + Platform4SideMovement, Platform4.center.y + PlatformMoveDown);
        Platform5.center = CGPointMake(Platform5.center.x + Platform5SideMovement, Platform5.center.y + PlatformMoveDown);
        
        
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

        
        
        PlatformMoveDown = PlatformMoveDown - 0.11;
        
        if (PlatformMoveDown < 0) {
            PlatformMoveDown = 0;
        }
        
        
        if (Platform1.center.y > 575) {
            RandomPosition = CGFloat(arc4random()%248);
            RandomPosition = RandomPosition + 36;
            Platform1.center = CGPointMake(RandomPosition, -6);
            Platform1Used = false;
        }
        
        if (Platform2.center.y > 575) {
            RandomPosition = CGFloat(arc4random()%248);
            RandomPosition = RandomPosition + 36;
            Platform2.center = CGPointMake(RandomPosition, -6);
            Platform2Used = false;
        }
        if (Platform3.center.y > 575) {
            RandomPosition = CGFloat(arc4random()%248)
            RandomPosition = RandomPosition + 36;
            Platform3.center = CGPointMake(RandomPosition, -6);
            Platform3Used = false;
        }
        
        if (Platform4.center.y > 575) {
            RandomPosition = CGFloat(arc4random()%248)
            RandomPosition = RandomPosition + 36;
            Platform4.center = CGPointMake(RandomPosition, -6);
            Platform4Used = false;
        }
        if (Platform5.center.y > 575) {
            RandomPosition = CGFloat(arc4random()%248)
            RandomPosition = RandomPosition + 36;
            Platform5.center = CGPointMake(RandomPosition, -6);
            Platform5Used = false;
        }
    }
    
    func platformFall() {
    
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
    
    
    func bounce() {
        
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.locationInView(view)
            
            if position.x < 160 {
                ChickenLeft = true;
            }
            else{
                ChickenRight = true;
            }
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        ChickenLeft = false;
        ChickenRight = false;
        StopSideMovement = true;
        }
    
}