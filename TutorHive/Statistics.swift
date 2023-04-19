//
//  Statistics.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct Statistics: View {
    @State private var contactCount = 0
    var name: String = ""
    var id: String = ""
    @State private var skills: [String] = []
    func getContactCountAndSkillsForTutor(tutorId: String) async -> (Int, [String]) {
        let db = Firestore.firestore()
        let now = Date()
        // get the start and end of the current week
        let calendar = Calendar.current
        var startOfWeek = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: now) + 1, to: now)!
        startOfWeek = calendar.startOfDay(for: startOfWeek)
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        let contactRef = db.collection("contacts").whereField("tutor", isEqualTo: tutorId)
            .whereField("createdAt", isGreaterThanOrEqualTo: startOfWeek).whereField("createdAt", isLessThanOrEqualTo: endOfWeek)
        print(startOfWeek, endOfWeek)
        let snapshot = try! await contactRef.getDocuments()
        let contactCount = snapshot.documents.count
        let skills = Set(snapshot.documents.compactMap { document -> String? in
            let data = document.data()
            return data["skill"] as? String
        })
        print(contactCount, skills)
        return (contactCount, Array(skills))
    }


    
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
                    Text("\(name)")
                        .font(.system(size: 40))
                        .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                        .offset(y:-10)
                    
                    
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
                    
                Text("\(contactCount)")
                    .font(.system(size: 40))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                  
            }
            HStack{
                Text("Skills")
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                    
            }
            HStack{
                            List {
                                ForEach(skills, id: \.self) { skill in
                                    Text(skill)
                                }
                            }
                            .listStyle(InsetGroupedListStyle())
                        }
        }.onAppear {
            Task {
                (contactCount, skills) = await getContactCountAndSkillsForTutor(tutorId: id)
            }
        }
    }
}

struct Statistics_Previews: PreviewProvider {
    static var previews: some View {
        Statistics(name:"Tom", id:"UApFAQO1Poyy0g5bJm6f")
    }
}
