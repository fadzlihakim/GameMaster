//
//  GameView.swift
//  QuizMaster
//
//  Created by Fadzli on 15/03/2024.
//

import SwiftUI

struct GameView:View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var gameVM: GameViewModel
    @State private var data: [QuestionData] = []
    
    var body: some View {
        VStack(alignment:.center) {
            Text(userVM.name)
            Text("Score: \(userVM.score)")
            List(data) { post in
                        VStack(alignment: .leading) {
                            Text("\(post.question)")
                            Text("\(post.incorrect_answers)")
                            Text("\(post.correct_answer)")
                        }
                    }
                    .task {
                        await gameVM.fetchData()
                    }

        }
    }
}
