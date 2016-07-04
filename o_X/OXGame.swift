//
//  OXGame.swift
//  o_X
//
//  Created by Enrique Pajuelo on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGame {
    private var board: [CellType] = [CellType] (count: 9, repeatedValue: CellType.Empty)
    private var startType = CellType.X
    var ID: Int = 0
    var host: String = ""
    
    var count = 0
    
    func turnCount() -> Int {
        return count
    }
    
    func whoseTurn() -> CellType {
        if (count % 2 == 0) {
            return CellType.O
        }
        else {
            return CellType.X
        }
    }
    
    func playMove(cellNumber: Int) -> CellType {
        count += 1
        board[cellNumber] = whoseTurn()
        return whoseTurn()
    }
    
    func gameWon() -> Bool {
        if  (board[0] == board[1] && board[1] == board[2] && board[0] != .Empty) ||
            (board[3] == board[4] && board [4] == board [5] && board[3] != .Empty) ||
            (board[6] == board[7] && board [7] == board [8] && board[6] != .Empty) ||
            (board[0] == board[4] && board [4] == board [8] && board[0] != .Empty) ||
            (board[2] == board[4] && board [4] == board [6] && board[2] != .Empty) ||
            (board[0] == board[3] && board [3] == board [6] && board[0] != .Empty) ||
            (board[1] == board[4] && board [4] == board [7] && board[1] != .Empty) ||
            (board[2] == board[5] && board [5] == board [8] && board[2] != .Empty) {
            return true
        }
        return false
    }
    
    func state() -> OXGameState {
        if gameWon() == true {
            return OXGameState.Won
        }
        else if turnCount() == 9 {
            return OXGameState.Tie
        }
        else {
            return OXGameState.InProgress
        }
    }
    
    func reset() {
        board = [CellType] (count: 9, repeatedValue: CellType.Empty)
        count = 0
    }
    
    init()  {
        //we are simulating setting our board from the internet
        let simulatedBoardStringFromNetwork = "o________" //update this string to different values to test your model serialisation
        self.board = deserialiseBoard(simulatedBoardStringFromNetwork) //your OXGame board model should get set here
        if(simulatedBoardStringFromNetwork == serialiseBoard())    {
            print("Start\n------------------------------------")
            print("Congratulations, you successfully deserialised your board and serialized it again correctly. You can send your data model over the internet with this code. 1 step closer to network OX ;)")
            
            print("Done\n------------------------------------")
        }   else    {
            print("Start\n------------------------------------")
            print ("Your board deserialisation and serialization was not correct :( carry on coding on those functions")
            
            print("Done\n------------------------------------")
        }
    }
    
    private func deserialiseBoard(boardString: String) -> [CellType] {
        var board:[CellType] = []
        for char in boardString.characters {
            if char == "x" {
                board.append(CellType.X)
            }
            else if (char == "o") {
                board.append(CellType.O)
            }
            else {
                board.append(CellType.Empty)
            }
        }
        return board
    }
    
    private func serialiseBoard() -> String {
        
        var boardString: String = ""
        
        for cell in board {
            if (cell == CellType.X) {
                boardString = boardString + "x"
            }
            else if (cell == CellType.O) {
                boardString = boardString + "o"
            }
            else {
                boardString = boardString + "_"
            }
        }
        return boardString
    }
    
}

enum CellType:String {
    case O = "O"
    case X = "X"
    case Empty = ""
}

enum OXGameState {
    case InProgress
    case Tie
    case Won
}