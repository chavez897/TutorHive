//
//  SearchTutor.swift
//  TutorHive
//
//  Created by Rodrigo Chavez on 2023-03-15.
//

import SwiftUI
import FirebaseFirestore

struct SearchTutor: View {
    let db = Firestore.firestore()
    @State var search: String = ""
    @State var items: [Tutor] = []
    var body: some View {
        VStack{
            Group{
                HStack{
                    Image("wise1")
                        .resizable()
                        .frame(width: 80, height: 80)
                    VStack{
                        Text("Find a tutor")
                            .font(.system(size: 22))
                            .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                        Text("In Any Topic That You Want")
                            .font(.system(size: 22))
                            .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                    }
                }
                TextField("Search", text: $search, onCommit: {filterData()})
                    .frame(width: 280)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                Divider().padding(.top, 15)
            }
            List(items) { item in
                TutorItem(tutor: item)
            }
            .onAppear {
                UITableView.appearance().tableFooterView = .none
                UITableView.appearance().separatorStyle = .none
            }
            .frame(width: 450)
            .padding(.vertical, 0)
        }.onAppear {
            getDataFromFirebase()
        }
    }
    
    func getDataFromFirebase() {
        db.collection("tutors")
            //.whereField("skills", arrayContains: "")
            .limit(to: 25)
            .getDocuments{(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for doc in querySnapshot!.documents {
                    let tutorData: Dictionary<String, Any> = doc.data()
                    self.items.append(Tutor(id: doc.documentID ,
                                            name: tutorData["name"] as! String,
                                            lastName: tutorData["lastName"] as! String,
                                            skills: tutorData["skills"] as! [String],
                                            language: tutorData["languages"] as! [String],
                                            description: tutorData["description"] as! String,
                                            price: tutorData["price"] as! Float
                                           ))
                }
            }
        }
    }
    
    func filterData() {
        self.items = []
        db.collection("tutors")
            .whereField("skills", arrayContains: self.search)
            .limit(to: 25)
            .getDocuments{(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for doc in querySnapshot!.documents {
                    let tutorData: Dictionary<String, Any> = doc.data()
                    self.items.append(Tutor(id: doc.documentID ,
                                            name: tutorData["name"] as! String,
                                            lastName: tutorData["lastName"] as! String,
                                            skills: tutorData["skills"] as! [String],
                                            language: tutorData["languages"] as! [String],
                                            description: tutorData["description"] as! String,
                                            price: tutorData["price"] as! Float
                                           ))
                }
            }
        }
    }
}


struct SearchTutor_Previews: PreviewProvider {
    static var previews: some View {
        SearchTutor()
    }
}
