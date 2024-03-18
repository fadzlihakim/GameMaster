//
//  GameViewModel.swift
//  QuizMaster
//
//  Created by Fadzli on 18/03/2024.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var data: [QuestionData] = []
    
    func fetchData() async {
        let url = URL(string: "https://opentdb.com/api.php?amount=10&category=10&difficulty=easy&type=multiple&encode=url3986")!
        do {
            let (res, _) = try await URLSession.shared.data(from: url)
            print(res)
            let decodedResponse = try JSONDecoder().decode(Post.self, from: res)
            DispatchQueue.main.async {
                self.data = decodedResponse.results
            }
        }
        catch {
            print("Invalid data")
        }
    }
}
