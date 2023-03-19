//
//  LoginScreen.swift
//  TutorHive
//
//  Created by Rodrigo Chavez on 2023-03-15.
//

import SwiftUI

struct LoginScreen: View {
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            Image("wise1")
                .resizable()
                .frame(width: 150, height: 150)
            Text("Tutor Hive")
                .font(.system(size: 28))
                .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
            HStack{
                Text("Account Infromation")
                    .padding(.leading, 50)
                Spacer()
            }.padding(.bottom, 10).padding(.top, 50)
            TextField("Email", text: $email)
                .frame(width: 260)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                .cornerRadius(10)
            TextField("Password", text: $password)
                .frame(width: 260)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                .cornerRadius(10)
            HStack{
                Text("Forgot your password?")
                    .font(.system(size: 14))
                    .padding(.leading, 50)
                    .foregroundColor(.blue)
                Spacer()
            }.padding(.bottom, 30).padding(.top, 10)
            Button("Login") {
                print("Button pressed!")
            }
            .foregroundColor(.white)
            .frame(width: 280, height: 40)
            .background(Color(red: 90/255, green: 100/255, blue: 234/255))
            .cornerRadius(10)
            Spacer()
            
        }.padding(.top, 70)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
