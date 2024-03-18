//
//  DifficultyView.swift
//  QuizMaster
//
//  Created by Fadzli on 18/03/2024.
//

import SwiftUI

struct DifficultyView: View {
    @ObservedObject var difficultyVM = DifficultyViewModel()
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30){
            NavigationLink(destination: GameView(message: "easy")){
                Text("Easy")
            }
            NavigationLink(destination: GameView(message: "medium")){
                Text("Medium")
            }
            NavigationLink(destination: GameView(message: "hard")){
                Text("Hard")
            }
        }
    }
}
