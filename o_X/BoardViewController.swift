//
//  BoardViewController.swift
//  o_X
//

import UIKit

var gameObject: OXGame = OXGame()

class BoardViewController: UIViewController {
    
    var networkMode = false

    @IBOutlet weak var newGameButton: UIButton!
    // Create additional IBOutlets here.
    
    @IBOutlet weak var boardView: UIView!
    
    @IBAction func squareButton(sender: UIButton) {
        print(sender.tag)
        let cellType = OXGameController.sharedInstance.playMove(sender.tag)
        sender.setTitle(cellType.rawValue, forState: .Normal)
        sender.enabled = false
        
        let currentState = OXGameController.sharedInstance.getCurrentGame().state()
        
        var winner = ""
        
        if (OXGameController.sharedInstance.getCurrentGame().whoseTurn() == .X) {
                winner = "X"
        }
        else if (OXGameController.sharedInstance.getCurrentGame().whoseTurn() == .O) {
                winner = "O"
        }
        
        
        if (currentState == .Won) {
            let alert = UIAlertController(title: "Congratulations " + winner + "!", message: "You won the game", preferredStyle: .Alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
            alert.addAction(dismiss)
            presentViewController(alert, animated: true, completion: nil)
            if networkMode == false {
                newGameButton.hidden = false
            }
        }
        
        // CellType.rawvalue
        
        if (currentState == .Tie) {
            let alert = UIAlertController(title: "You tied!", message: "Keep trying", preferredStyle: .Alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
            alert.addAction(dismiss)
            presentViewController(alert, animated: true, completion: nil)
            if networkMode == false {
                newGameButton.hidden = false
            }
        }
        
    }
    
    @IBAction func backButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        let application = UIApplication.sharedApplication()
        let window = application.keyWindow
        window?.rootViewController = viewController
        
        UserController.sharedInstance.logout { string in
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        if networkMode == false {
            newGameButton.hidden = true
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func updateUI() {
        let board = OXGameController.sharedInstance.getCurrentGame().board
        for subview in containerView.subviews {
            if let button = subview as? UIButton {
                button.setTitle(board[button.tag].rawValue, forState: .Normal)
            }
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        
        if networkMode == false {
            newGameButton.hidden = true
        }
        
        OXGameController.sharedInstance.restartGame()
    
        print("New game button pressed.")
        
        for subview in containerView.subviews {
            if let button = subview as? UIButton {
                button.setTitle("", forState: .Normal)
                button.enabled = true
            }
        }
    }
    
    // Create additional IBActions here.

}