//
//  ForgotPassword.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-22.
//


import SwiftUI

struct ForgotPassword: View {
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
                Text("Forgot your password?")
                    .padding(.leading, 50)
                Spacer()
            }.padding(.bottom, 10).padding(.top, 50)
            TextField("Email", text: $email)
                .frame(width: 260)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                .cornerRadius(10)
            Button("Send") {
                print("Button pressed!")
            }
            .foregroundColor(.white)
            .frame(width: 280, height: 40)
            .background(Color(red: 90/255, green: 100/255, blue: 234/255))
            .cornerRadius(10)
            .padding(.top, 30)
            Text("Click on the link provided in your email to reset the password")
                .foregroundColor(.gray)
                .font(.system(size: 12))
                .padding(.top, 10)
            Spacer()
            
        }.padding(.top, 70)
    }
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassword()
    }
}
