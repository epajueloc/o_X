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