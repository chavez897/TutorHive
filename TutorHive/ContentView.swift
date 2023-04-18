//
//  ContentView.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-22.
//

import SwiftUI

struct ContentView: View {
    @State private var isRegisterScreenPresented = false
    @State private var message = "testing"
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.isRegisterScreenPresented = true
                }, label: {
                    Image("wise1")
                        .imageScale(.large)
                                      .foregroundColor(.accentColor)
                })
                
                NavigationLink(destination: RegisterScreen(), isActive: $isRegisterScreenPresented) {
                    EmptyView()
                }
                
                Text("Tutor Hive")
                    .font(.system(size: 34))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                    .padding(.bottom, 15)
                Text(self.message)
                    .font(.system(size: 19))
                    .foregroundColor(Color(red: 0/255, green: 78/255, blue: 170/255))
                    .onAppear{
                        apiCall().getMessage(completion: {
                            (message) in
                            print(message)
                            self.message = message.message
                        })
                    }
                Spacer()
            }
            .padding(.top, 170.0)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
