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
                NavigationLink(destination: GameView()){
                    Text("Start")
                }
//                Button("Start") {
//                    if(userVM.name != ""){
//                        //userVM.addUser(user: <#T##User#>)
//                        //showDetails.toggle()
//                    }
//                    else {
//                        showingAlert = true
//                    }
//                }.alert(isPresented: $showingAlert) {
//                    Alert(title: Text("Alert"), message: Text("Insert name to start"), dismissButton: .default(Text("Got it!")))
//                }
//                
//                if showDetails {
//                    Text("Hello, \(userVM.name)")
//                        .font(.title2)
//                }
            }
            .padding()
        }.environmentObject(userVM)
    }
}

#Preview {
    UserView()
}
