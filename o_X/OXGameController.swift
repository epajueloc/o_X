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
            
            if (responseCode / 100 == 2)   {
                
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
    
    func joinGames(gameId: Int, onCompletion: (OXGame?, String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(gameId)/join"), method: "GET", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode / 100 == 2) {
                let newGame:OXGame = OXGame()
                newGame.ID = json["id"].intValue
                newGame.host = json["host_user"]["uid"].stringValue
                self.currentGame = newGame
                onCompletion(newGame,nil)
                }
            else {
                onCompletion(nil,"Couldn't join game")
                }
            })
        }
    
    func createNewGame(onCompletion: (OXGame?, String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/"), method: "POST", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
        
            if (responseCode / 100 == 2) {
                let newGame: OXGame = OXGame()
                newGame.ID = json["id"].intValue
                newGame.host = json["host_user"]["uid"].stringValue
                self.currentGame = newGame
                onCompletion(newGame,nil)
                }
            else {
                onCompletion(nil,"Couldn't create a new game")
                }
        })
    }
    
    func makeMove(gameId: Int, onCompletion: (OXGame?, String?) -> Void) {
        
        let board = ["board": getCurrentGame().serialiseBoard() ]
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(gameId)"), method: "PUT", parameters: board)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            print(json)
            if (responseCode / 100 == 2) {
                onCompletion(self.currentGame,nil)
            }
            
            })
    }
    
    func viewGame(onCompletion: (String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(self.currentGame.ID)"), method: "GET", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            print(json)
            
            if (responseCode / 100 == 2) {
                self.currentGame.deserialiseBoard(json["board"].stringValue)
                onCompletion(nil)
            }
            else {
                onCompletion("Couldn't get game")
            }
        })
    }
    
    func cancelGame(onCompletion: (String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(self.currentGame.ID)"), method: "DELETE", parameters: nil)
        
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            print(json)
            
            if (responseCode / 100 == 2) {
                self.currentGame.reset()
                onCompletion(nil)
            }
            else {
                onCompletion("Couldn't cancel game")
            }
        })
    }

}
