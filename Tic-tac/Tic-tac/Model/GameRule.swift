//
//  GameRule.swift
//  Tic-tac
//
//  Created by 서원지 on 2022/06/29.
//

import SwiftUI

struct GameRule{
    static var winnerAlert: String = ""
    static var resettingGame: Bool = false
    static var player = "X"
    static var moves = ["", "", "", "", "", "", "", "", ""]
    static var ranges = [(0..<3), (3..<6), (6..<9)]
}
