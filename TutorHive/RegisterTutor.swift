//
//  RegisterTutor.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-22.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

struct RegisterTutor: View {
    
    @State var fname: String = ""
    @State var lname: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var skills: String = ""
    @State var language: String = ""
    @State var hcost: String=""
    @State var selectedcurrency: String = ""
    @State var description: String = ""
    let db = Firestore.firestore()
   
    let currency = ["USD", "CAD", "EUR"]
     
    var body: some View {
        VStack(alignment:.center,spacing:30) {
            HStack {
                Spacer()
                Image("wise1")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.trailing, 100)
                Text("TutorHive")
                    .font(.system(size: 35))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                    .offset(x:-100)
                
                
            }
            Divider()
            Spacer()
            
            HStack{
                VStack{
                    Text("Register As Tutor")
                        .font(.system(size: 28))
                        .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                        .offset(y:-30)
                    HStack{
                        
                        TextField("Firstname", text: $fname)
                            .frame(width: 140)
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                            .cornerRadius(10)
                        
                        TextField("Lastname", text: $lname)
                            .frame(width: 140)
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                        .cornerRadius(10)
                        
                    }
                }
            }
            
            HStack{
                TextField("Email", text: $email)
                    .frame(width: 140)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                    
                TextField("Phone no.", text: $phone)
                    .frame(width: 140)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                    
            }
            HStack{
                TextField("Skills", text: $skills)
                    .frame(width: 320)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
            }
            HStack{
                TextField("Languages", text: $language)
                    .frame(width: 140)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                TextField("Hourly Cost",text:$hcost)
                    .frame(width: 140)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
            }
            HStack{
                DropdownTextField(
                    placeholder: "Currency",
                    options: currency,
                    selection: $selectedcurrency
                ).frame(width: 320)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                
            }
            HStack{
                TextEditor(text: $description)
                    .frame(maxHeight: 100)
                    .border(Color.gray, width: 0.5)
                    .overlay(
                            Group {
                                if description.isEmpty {
                                    Text("Tell us something about yourself")
                                        .foregroundColor(Color.gray)
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 8)
                                    
                                }
                            }, alignment: .topLeading
                    )
            }
            .padding(.horizontal)
            .frame(width: 350)
            
            .background(Color(red: 227/255, green: 229/255, blue: 232/255))
            .cornerRadius(10)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Button("Submit") {
                    // Handle submission here
                }
                .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(50)
            }
        }
    }
}

struct RegisterTutor_Previews: PreviewProvider {
    static var previews: some View {
        RegisterTutor()
    }
}
