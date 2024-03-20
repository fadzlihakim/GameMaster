//
//  GameView.swift
//  QuizMaster
//
//  Created by Fadzli on 15/03/2024.
//

import SwiftUI
import UIKit

struct GameView: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var gameVM: GameViewModel
    @State private var qData: [QuestionData] = []
    @State private var resDate = [Post]()
    @State private var showingAlert = false
    var message: String

    @State var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text(message).textCase(.uppercase).font(.title3).foregroundColor(message == "easy" ? .blue : message == "medium" ? .yellow : .red)
            HStack(spacing: 100) {
                VStack(alignment: .leading) {
                    Text(userVM.name)
                    Text("Score: \(userVM.score)")
                }.frame(maxWidth: .infinity)
                VStack(alignment: .trailing) {
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
            List {
                ForEach(qData, id: \.self) { post in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)

                        VStack {
                            Text("\(post.question)")

                            Text("\(post.correct_answer)")
                        }
                        .padding(20)
                        .multilineTextAlignment(.center)
                    }
                    .frame(width: 450, height: 250)
                }
//                VStack(alignment: .leading) {
//                    Text("\(post.question)")
//                    HStack(alignment: .center) {
//                        ForEach(post.incorrect_answers, id: \.self) { wrong in
//                            Button("\(wrong)") {
//                                timeRemaining -= 5
//                                if timeRemaining < 0 { return showingAlert = true }
//                            }.alert("You lose", isPresented: $showingAlert) {
//                                NavigationLink(destination: UserView()) {
//                                    Text("Ok")
//                                }
//                            }.frame(maxWidth: .infinity).buttonStyle(.borderedProminent)
//                        }
//                        Button("\(post.correct_answer)") {
//                            userVM.score += 1
//                        }.frame(maxWidth: .infinity).buttonStyle(.borderedProminent)
//                    }
//                }
            }
            .onAppear {
                fetchData { resDate in self.resDate = resDate }
            }
        }.navigationBarBackButtonHidden(true)
    }

    func fetchData(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&difficulty=\(message)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let res = try! JSONDecoder().decode(Post.self, from: data!)
            qData = res.results
        }.resume()
    }
}

extension String {
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString.string)
    }
}
