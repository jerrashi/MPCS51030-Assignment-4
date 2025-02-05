//
//  Grid.swift
//  Assignment 4
//
//  Created by Jerry Shi on 2/4/25.
//

import Foundation

class Grid {
    // array to represent 9 squares in grid on screen
    var squares: [String?] = Array(repeating: nil, count: 9)
    
    func isEmpty(_ index: Int) -> Bool {
        return squares[index] == nil
    }
    
    func update(_ index: Int, _ piece: String) {
        squares[index] = piece
    }
    
    func checkWin() -> String?{
        let winningCombos = [
            // rows
            [0, 1, 2], [3, 4, 5], [6, 7, 8],
            // columns
            [0, 3, 6], [1, 4, 7], [2, 5, 8],
            // diagonals
            [0, 4, 8], [2, 4, 6]
        ]
        
        // Check spots
        for combo in winningCombos{
            if squares[combo[0]] == squares[combo[1]] 
                && squares[combo[1]] == squares[combo[2]] {
                // return winning player
                return squares[combo[0]]
            }
        }
        
        // Default behavior - return none if no winner
        return nil
    }
    
    func checkTie() -> Bool {
        // all squares are full and no one won
        return !squares.contains(nil) && (checkWin() == nil)
    }
    
    func clear(){
        squares = Array(repeating:nil, count: 9)
    }
}
