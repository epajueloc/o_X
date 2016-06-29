//
//  BoardViewController.swift
//  o_X
//

import UIKit

var gameObject: OXGame = OXGame()

class BoardViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    // Create additional IBOutlets here.
    
    @IBOutlet weak var boardView: UIView!
    
    @IBAction func squareButton(sender: UIButton) {
        print(sender.tag)
        let cellType = OXGameController.sharedInstance.playMove(sender.tag)
        sender.setTitle(cellType.rawValue, forState: .Normal)
        
        if (OXGameController.sharedInstance.getCurrentGame().state() == .Won) {
            let alert = UIAlertController(title: "Congratulations!", message: "You won the game", preferredStyle: .Alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
            alert.addAction(dismiss)
            presentViewController(alert, animated: true, completion: nil)
        }
        
        if (OXGameController.sharedInstance.getCurrentGame().state() == .Tie) {
            let alert = UIAlertController(title: "You tied!", message: "Keep trying", preferredStyle: .Alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
            alert.addAction(dismiss)
            presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func backButton(sender: AnyObject) {
        print("Back")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        
        OXGameController.sharedInstance.restartGame()
        
        print("New game button pressed.")
        
        for subview in containerView.subviews {
            if let button = subview as? UIButton {
                button.setTitle("", forState: .Normal)
            }
        }
    }
    
    // Create additional IBActions here.

}