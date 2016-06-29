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
    
    @IBAction func squareButton(sender: AnyObject) {
        print(sender.tag)
    }
    
    @IBAction func backButton(sender: AnyObject) {
        print("Back")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        print("New game button pressed.")
    }
    
    // Create additional IBActions here.

}

