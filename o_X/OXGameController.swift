//
//  OXGameController.swift
//  o_X
//
//  Created by Enrique Pajuelo on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class OXGameController: NSObject {
    static let sharedInstance = OXGameController()
    private var currentGame = OXGame()
    
    func getCurrentGame() -> OXGame {
        return currentGame
    }
    
    func restartGame() {
        currentGame.reset()
    }
    
    func playMove(cellNumber: Int) -> CellType {
        return currentGame.playMove(cellNumber)
    }
    
    func getGames(onCompletion onCompletion: ([OXGame]?, String?) -> Void) {
        
        let a = OXGame()
        let b = OXGame()
        let c = OXGame()
        let d = OXGame()
        let e = OXGame()
        
        a.ID = 1
        a.host = "Enrique"
        
        b.ID = 2
        b.host = "Marky"
        
        c.ID = 3
        c.host = "Eli"
        
        d.ID = 4
        d.host = "Andre"
        
        e.ID = 5
        e.host = "Riley"
        
        onCompletion([a,b,c,d,e],nil)
        
    }
    
}
