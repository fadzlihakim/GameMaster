//
//  Game.swift
//  QuizMaster
//
//  Created by Fadzli on 18/03/2024.
//

import SwiftUI

struct Post: Codable, Hashable {
    let response_code: Int
    let results: [QuestionData]
}

struct QuestionData: Codable, Hashable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}
