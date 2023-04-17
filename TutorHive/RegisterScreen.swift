//
//  RegisterScreen.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-22.
//


import SwiftUI

struct RegisterScreen: View {
    @State var name: String = ""
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var terms: Bool = false
    @EnvironmentObject var authModel: AuthenticationModel
    @State private var showLogin = false
    @State private var signUpError: String?
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Tutor Hive")
                    .font(.system(size: 25))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                Image("wise1")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 50)
            }
            Divider()
            Spacer()
            HStack{
                Text("Name")
                    .padding(.leading, 50)
                Spacer()
            }
            Group{
                TextField("Name", text: $name)
                    .frame(width: 260)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                
                HStack{
                    Text("Email")
                        .padding(.leading, 50)
                    Spacer()
                }.padding(.top, 20)
                TextField("Email", text: $emailAddress)
                    .frame(width: 260)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                HStack{
                    Text("Password")
                        .padding(.leading, 50)
                    Spacer()
                }.padding(.top, 20)
                SecureField("Password", text: $password)
                    .frame(width: 260)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                Toggle(isOn: $terms) {
                    Text("I agree with terms and conditions")
                        .font(.system(size: 12))
                }.padding(.horizontal, 50).padding(.top, 20)
                
                Button("Sign Up") {
                    authModel.signUp(name: name, emailAddress: emailAddress, password: password)
                }
                .foregroundColor(.white)
                .frame(width: 280, height: 40)
                .background(Color(red: 90/255, green: 100/255, blue: 234/255))
                .cornerRadius(10)
                .padding(.top, 20)
                
            }
            Spacer()
            NavigationLink(
                               destination: Tabs(),
                               isActive: $authModel.signUpSuccessful, // Use the published property
                               label: { EmptyView() }
                           )
            Divider()
            VStack{
                Text("Already have an account?")
                NavigationLink(destination: LoginScreen(), isActive: $showLogin) {
                                        Button(action: {
                                            self.showLogin = true
                                        }) {
                                            Text("LOG IN").padding()
                                        }
                                    }
            }
            
                
        }
    }
}


struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
