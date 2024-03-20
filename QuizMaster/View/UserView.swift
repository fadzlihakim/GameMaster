//
//  ContentView.swift
//  QuizMaster
//
//  Created by Fadzli on 15/03/2024.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var userVM = UserViewModel()
    @State private var selection:String? = nil
    @State private var showDetails = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView{
            VStack() {
                TextField("Enter Name", text:$userVM.name).multilineTextAlignment(.center)
                NavigationLink(destination: DifficultyView()){
                    Text("Start")
                }
            }
            .padding()
        }.environmentObject(userVM)
    }
}

#Preview {
    UserView()
}
