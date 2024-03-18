//
//  Game.swift
//  QuizMaster
//
//  Created by Fadzli on 18/03/2024.
//

import SwiftUI

struct Post: Codable, Identifiable {
    let id: Int
    let response_code: Int
    let results: [QuestionData]
}

struct QuestionData: Codable, Identifiable {
    let id: Int
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: String
}
