//
//  ContactView.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-22.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct ContactView: View {
    let db = Firestore.firestore()
    var tutor: String = ""
    var tutorSkills: [String] = []
      var tutorLanguage: [String] = []

    @State var title: String = ""
    @State var selectedSkill: String = ""
    @State var selectedLanguage: String = ""
    @State var description: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Image("wise1")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)


            Text("TutorHive")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            VStack(spacing: 20) {
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                DropdownTextField(
                    placeholder: "Skills",
                    options: tutorSkills,
                    selection: $selectedSkill
                )

                DropdownTextField(
                    placeholder: "Languages",
                    options: tutorLanguage,
                    selection: $selectedLanguage
                )

                TextEditor(text: $description)
                    .frame(maxHeight: 100)
                    .border(Color.gray, width: 0.5)
                    .overlay(
                            Group {
                                if description.isEmpty {
                                    Text("Description")
                                        .foregroundColor(Color.gray)
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 8)
                                }
                            }, alignment: .topLeading)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Submit") {
                let db = Firestore.firestore()
                          let contactRef = db.collection("contacts")
                          let contact = [
                            "tutor": tutor,
                            "title": title,                    "skill": selectedSkill,                    "language": selectedLanguage,                    "description": description                ]
                          contactRef.addDocument(data: contact) { error in
                              if let error = error {
                                  print("Error adding document: \(error)")
                              } else {
                                  print("Document added with ID")
                                  // Handle success here
                              }
                          }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 30)
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(tutorSkills: ["Cooking", "Play"], tutorLanguage: ["Spanish"])
    }
}

