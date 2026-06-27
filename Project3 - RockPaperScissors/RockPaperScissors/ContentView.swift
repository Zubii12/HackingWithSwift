//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Ionut Zubascu on 28.06.2026.
//

import SwiftUI

struct ContentView: View {
    private let moves = ["rock", "paper", "scissors"]
    private let winningMoves = [
        "rock": "paper",
        "paper": "scissors",
        "scissors": "rock"
    ]
    
    @State private var appMove = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var userScore = 0
    @State private var gamesPlayed = 0
    
    @State private var showGameEnded = false
    
    func decreaseScore() {
        if userScore > 0 {
            userScore -= 1
        }
    }
    
    func onUserTap(_ move: Int) {
        let userMove = self.moves[move]
        let appMove = self.moves[self.appMove]
        let winningMove = winningMoves[appMove]
        
        if self.shouldWin {
            if userMove == winningMove {
                self.userScore += 1
            }
        } else {
            if userMove != winningMove {
                self.userScore += 1
            }
        }
        
        if userMove == appMove {
            decreaseScore()
        }
        
        self.gamesPlayed += 1
        
        if gamesPlayed == 3 {
            return showGameEnded = true
        }
        
        self.appMove = Int.random(in: 0..<3)
        self.shouldWin = Bool.random()
    }
    
    func reset() {
        self.appMove = Int.random(in: 0..<3)
        self.shouldWin = Bool.random()
        self.userScore = 0
        self.gamesPlayed = 0
        self.showGameEnded = false
    }
    
    var body: some View {
        VStack {
            Text("Score: \(userScore)")
            Text("App move: \(moves[appMove])")
            Text("You should \(shouldWin ? "Win" : "Lose")")
            
            HStack {
                ForEach(0..<3) { move in
                    Button(action: {
                        onUserTap(move)
                    }) {
                        Text(self.moves[move])
                    }
                    .frame(minWidth: 100, maxWidth: 200)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.2))
                    .padding(10)
                }
            }
        }
        .padding()
        .alert("Game Ended",isPresented: $showGameEnded ) {
            Button("OK") {
                reset();
            }
        } message: {
            Text("Your score is \(userScore)")
        }
    }
}

#Preview {
    ContentView()
}
