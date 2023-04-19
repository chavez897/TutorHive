//
//  Statistics.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

class CountViewModel: ObservableObject {
    
    private let db = Firestore.firestore()
    
    @Published var count = 0
    @State private var title = ""
    @State private var skill = ""
    
    func calculateCount() {
        let collectionRef = db.collection("contacts")
        let valueToQuery = "UApFAQO1Poyy0g5bJm6f"
        collectionRef.whereField("tutor", isEqualTo: valueToQuery).getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.count = querySnapshot?.documents.count ?? 0
            }
        }
        
    }
    
        
    
}

struct Statistics: View {
    
    @StateObject var viewModel = CountViewModel()
    
    //@State var documentData: [String: Any] = [:]
    @State var title: String = ""
    @State var lastname: String = ""
    @State var skills: [String] = []
    private let db = Firestore.firestore()
    
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
                    Text("\(title) \(lastname)")
                        .font(.system(size: 40))
                        .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                        .offset(y:-10)
                    
                    
                }
            }.onAppear {
                let documentRef = db.collection("tutors").document("UApFAQO1Poyy0g5bJm6f")
                documentRef.getDocument() { (documentSnapshot, error) in
                    if let error = error {
                        print("Error getting document: \(error)")
                    } else if let document = documentSnapshot?.data() {
                            title=document["name"] as? String ?? ""
                            lastname=document["lastName"] as? String ?? ""
                    } else {
                        print("Document does not exist")
                    }
                }
            }
        
            HStack{
                Text("Statistics / week")
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                    
            }
            HStack{
                Text("Contacted no of times: ")
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                Text("\(viewModel.count) times")
                    .font(.system(size: 40))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                  
            }.onAppear {
                viewModel.calculateCount()
            }
            HStack{
                Text("Skills")
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                    
            }
            HStack{
                List {
                                ForEach(skills, id: \.self) { item in
                                    Text(item)
                                .padding()
                                }
                
                            }
                            .listStyle(InsetGroupedListStyle())
                    
            }.onAppear {
                let documentRef = db.collection("tutors").document("UApFAQO1Poyy0g5bJm6f")
                documentRef.getDocument() { (documentSnapshot, error) in
                    if let error = error {
                        print("Error getting document: \(error)")
                    } else if let document = documentSnapshot?.data(),let skill = document["skills"] as? [String] {
                        self.skills = skill
                    }  else {
                        print("Document does not exist")
                    }
                }
            }
        }
    }
}

struct Statistics_Previews: PreviewProvider {
    static var previews: some View {
        Statistics()
    }
}
