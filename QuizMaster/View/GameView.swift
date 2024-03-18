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
    var message: String
    
    @State var timeRemaining = 10
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            Text(message).textCase(.uppercase).font(.title3).foregroundColor(message == "easy" ? .blue : message == "medium" ? .yellow : .red)
            HStack(spacing: 100){
                VStack(alignment:.leading) {
                    Text(userVM.name)
                    Text("Score: \(userVM.score)")
                }.frame(maxWidth: .infinity)
                VStack(alignment:.trailing) {
                    Text("\(timeRemaining)").onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        }
                    }.font(.largeTitle).foregroundColor(timeRemaining > 3 ? .blue : .red)
                }.frame(maxWidth: .infinity)
            }.padding().overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(timeRemaining > 0 ? .blue : .red, lineWidth: 4)
            )
            List(data) { post in
                        VStack(alignment: .leading) {
                            Text("\(post.question)")
                            Button("\(post.incorrect_answers)"){
                                
                            }
                            Button("\(post.correct_answer)"){
                                userVM.score += 1 + timeRemaining;
                            }
                        }
                    }
                    .task {
                        await fetchData()
                    }

        }
    }
    
    func fetchData() async {
        let url = URL(string: "https://opentdb.com/api.php?amount=10&category=10&difficulty=\(message)&type=multiple&encode=url3986")!
        do {
            let (res, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(Post.self, from: res)
            print(decodedResponse)
            DispatchQueue.main.async {
                self.data = decodedResponse.results
            }
        }
        catch {
            print("Invalid data")
        }
    }
}
