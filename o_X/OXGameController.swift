//
//  OXGameController.swift
//  o_X
//
//  Created by Enrique Pajuelo on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class OXGameController: WebService {
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
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode == 200)   {
                
                var array = [OXGame]()
                for game in json.arrayValue {
                    let oxgame = OXGame()
                    oxgame.ID = game["id"].intValue
                    oxgame.host = game["host_user"]["uid"].stringValue
                    array.append(oxgame)
                }

                onCompletion(array,nil)
            } else {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(nil,errorMessage)
            }
        })
    }
    
//    func joinGames(gameId: Int, onCompletion onCompletion: (OXGame?, String?) -> Void) {
//        
//        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(gameId)/join"), method: "GET", parameters: nil)
//        
//        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
//            
//            if (responseCode == 200) {
//                var newGame:OXGame = OXGame()
//                newGame.ID = json["id"].intValue
//                newGame.host = json["host_user"]["uid"].stringValue
//                onCompletion(newGame,nil)
//                }
//            else {
//                onCompletion(nil,"error")
//                }
//            })
//        }
}
