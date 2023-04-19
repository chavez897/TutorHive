//
//  TabView.swift
//  TutorHive
//
//  Created by Rodrigo Chavez on 2023-03-15.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

struct Tabs: View {
    let db = Firestore.firestore()
    @EnvironmentObject var authModel: AuthenticationModel
    func getDataFromFirebase() {
        if let userId = Auth.auth().currentUser?.uid {
            db.collection("tutors").whereField("user", isEqualTo: userId)
                .getDocuments { (querySnapshot, err) in
                    if querySnapshot?.documents.isEmpty == false {
                        self.authModel.setIsTutor(value: true)
                    } else {
                        self.authModel.setIsTutor(value: false)
                    }
            }
        }
    }
    var body: some View {
        TabView {
            NavigationView {
                SearchTutor()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
            
            ProfileView()
            .tabItem {
                Image(systemName: "person.crop.circle")
                Text("Proile")
            }
            
            if(self.authModel.isTutor) {
                    Statistics()
                        .tabItem {
                            Image(systemName: "chart.bar")
                            Text("Statistics")
                        }
            } else {
                RegisterTutor()
                    .tabItem {
                        Image(systemName: "chart.bar")
                        Text("Tutor")
                    }
            }
            
        }.navigationBarBackButtonHidden(true)
            .onAppear() {
                getDataFromFirebase()
            }
        
    }
    
}
struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}

