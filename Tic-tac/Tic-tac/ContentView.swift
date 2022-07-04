//
//  ContentView.swift
//  Tic-tac
//
//  Created by 서원지 on 2022/06/29.
//

import SwiftUI

struct ContentView: View {
    @State private var winnerAlert = ""
    @State private var resettingGame = false
    @State private var player = "X"
    @State private var moves = ["", "", "", "", "", "", "", "", ""]
    private var ranges = [(0..<3), (3..<6), (6..<9)]
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Tic Tac Toe")
                .font(.largeTitle.bold())
                .foregroundColor(.white)

            Spacer()

            VStack() {
                ForEach(ranges, id: \.self) { range in
                    HStack {
                        ForEach(range, id: \.self) { i in
                            Button(action: {
                                playerTapped(i)
                            }, label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .foregroundColor(Color.lightBlue)
                                    .overlay(Text("\(moves[i])")
                                        .fontWeight(.bold)
                                        .font(.system(size: 100))
                                        .foregroundColor(.white))
                            })
                            .disabled(moves[i] != "" || resettingGame)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            
            Spacer()
            
            if !resettingGame {
                Text("Player \(player) Turn")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .frame(height: 100)
            }
            else {
                Text("\(winnerAlert)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .frame(height: 50)

                Button {
                    resetGame()
                } label: {
                    Text("Play Again")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [.blue, Color.lightBlue]),
                                               startPoint: .leading, endPoint: .trailing)
                            )
                            .frame(width: 180, height: 50)
                            .shadow(radius: 3))
                }
            }
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.lightPink, Color.lightPurple]),
                           startPoint: .top, endPoint: .bottom)
        )
    }
    
 private  func playerTapped(_ number: Int) {
        moves[number] = player
        let check = checkGame()
        
        if check == true {
            winnerAlert = "Player \(player) Won"
            player = "-"
            resettingGame = true
        }
        else if !moves.contains("") {
            winnerAlert = "It's a draw"
            player = "-"
            resettingGame = true
        }
        else if player == "X" {
            player = "O"
        }
        else {
            player = "X"
        }
    }
    
    func checkGame() -> Bool {
        for index in 0...2 {
            let offset = 3 * index
            
            if moves[0 + offset] == player && moves[1 + offset] == player && moves[2 + offset] == player {
                return true
            }
        }
        
        for index in 0...2 {
            let offset = 1 * index
            
            if moves[0 + offset] == player && moves[3 + offset] == player && moves[6 + offset] == player {
                return true
            }
        }
        
        for index in 0...1 {
            let offset = 2 * index
            
            if moves[0 + offset] == player && moves[4] == player && moves[8 - offset] == player {
                return true
            }
        }
        
        return false
    }
    
    func resetGame() {
        winnerAlert = ""
        resettingGame = false
        player = "X"
        moves = ["", "", "", "", "", "", "", "", ""]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
