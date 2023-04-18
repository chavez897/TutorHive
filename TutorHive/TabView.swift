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
    @State var isTutor: Bool = false
    func getDataFromFirebase() {
        if let userId = Auth.auth().currentUser?.uid {
            db.collection("tutors").document(userId)
                .getDocument { (document, error) in
                    if let document = document, document.exists {
                        self.isTutor = true
                    } else {
                        self.isTutor = false
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
            
            if(self.isTutor) {
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
        
    }
    
}
struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}

