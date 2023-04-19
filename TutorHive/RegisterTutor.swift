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
    @EnvironmentObject var authModel: AuthenticationModel
   
    let currency = ["USD", "CAD", "EUR"]
     
    var body: some View {
        ScrollView {
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
            HStack{
                VStack{
                    Text("Register As Tutor")
                        .font(.system(size: 28))
                        .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                        .offset(y:-30)
                        .padding(.top, 50)
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color.black)
                        .clipShape(Circle())
                    
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
                        
                    }.padding(.top, 20)
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
                    .frame(height: 100)
                    .border(Color.gray, width: 0.5)
                    .overlay(
                        Group {
                            if description.isEmpty {
                                Text("Tell us something about yourself")
                                    .foregroundColor(Color.gray)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 8)
                                
                            }
                        }
                    )
            }
            .padding(.horizontal)
            .frame(width: 350)
            
            .background(Color(red: 227/255, green: 229/255, blue: 232/255))
            .cornerRadius(10)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Button("Submit") {
                    let db = Firestore.firestore()
                    let contactRef = db.collection("tutors")
                    let tutor = [
                        "user": Auth.auth().currentUser!.uid,
                        "name": fname,
                        "lastName": lname,
                        "email": email,
                        "languages": language.split(separator: ","),
                        "skills": skills.split(separator: ","),
                        "price": Float(hcost) ?? 15,
                        "description": description,
                        "image": ""
                    ] as [String : Any]
                              contactRef.addDocument(data: tutor) { error in
                                  if let error = error {
                                      print("Error adding document: \(error)")
                                  } else {
                                      authModel.setIsTutor(value: true)
                                  }
                              }
                }
                .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(50)
            }
        }
    }
        }
    
}

struct RegisterTutor_Previews: PreviewProvider {
    static var previews: some View {
        RegisterTutor()
    }
}
