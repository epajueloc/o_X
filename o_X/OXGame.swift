//
//  OXGame.swift
//  o_X
//
//  Created by Enrique Pajuelo on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGame {
    var board: [CellType] = [CellType] (count: 9, repeatedValue: CellType.Empty)
    
    var ID: Int = 0
    var host: String = ""
    
    
    func turnCount() -> Int {
        return board.filter{$0 != .Empty}.count
    }
    
    func whoseTurn() -> CellType {
        if turnCount() % 2 == 0 {
            return CellType.X
        }
        else {
            return CellType.O
        }
    }
    
    func playMove(cellNumber: Int) -> CellType {
        board[cellNumber] = whoseTurn()
        return board[cellNumber]
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
    }
    
    init()  {
    }
    
    func deserialiseBoard(boardString: String) {
        var newBoard:[CellType] = []
        for char in boardString.characters {
            if char == "x" {
                newBoard.append(CellType.X)
            }
            else if (char == "o") {
                newBoard.append(CellType.O)
            }
            else {
                newBoard.append(CellType.Empty)
            }
        }
        board = newBoard
    }
    
    func serialiseBoard() -> String {
        
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
    case Open
    case Abandoned
}