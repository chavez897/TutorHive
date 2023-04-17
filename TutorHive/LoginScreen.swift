//
//  LoginScreen.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-22.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth
struct LoginScreen: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var authModel: AuthenticationModel
    @Environment(\.dismiss) var dismiss
    private func signInWithGoogle() {
      Task {
        if await authModel.signInWithGoogle() == true {
            NavigationLink(
                               destination: Tabs(),
                               isActive: $authModel.isSignedIn, // Use the published property
                               label: { EmptyView() }
                           )
        }
      }
    }
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
            SecureField("Password", text: $password)
                .frame(width: 260)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                .cornerRadius(10)
            NavigationLink(destination: ForgotPassword()) {
                HStack{
                    Text("Forgot your password?")
                        .font(.system(size: 14))
                        .padding(.leading, 50)
                        .foregroundColor(.blue)
                    Spacer()
                }.padding(.bottom, 30).padding(.top, 10)}
            Button("Login") {
                          authModel.signIn(emailAddress: email, password: password)
                      }
            .foregroundColor(.white)
            .frame(width: 280, height: 40)
            .background(Color(red: 90/255, green: 100/255, blue: 234/255))
            .cornerRadius(10)
            Spacer()
            NavigationLink(
                               destination: Tabs(),
                               isActive: $authModel.isSignedIn, // Use the published property
                               label: { EmptyView() }
                           )
        }.padding(.top, 70)
        Button(action:signInWithGoogle){
            Text("Sign in with Google")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(alignment: .leading){
                    Image("Google")
                        .frame(width: 30, alignment: .center)
                }
        }
        .buttonStyle(.bordered)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

 
