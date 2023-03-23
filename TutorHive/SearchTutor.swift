//
//  SearchTutor.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-22.
//



import SwiftUI

struct SearchTutor: View {
    @State var search: String = ""
    var items: [Tutor]
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
                TextField("Search", text: $search)
                    .frame(width: 280)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color(red: 227/255, green: 229/255, blue: 232/255))
                    .cornerRadius(10)
                Divider().padding(.top, 15)
            }
            List(items) { item in
                TutorItem()
            }
            .onAppear {
                UITableView.appearance().tableFooterView = .none
                UITableView.appearance().separatorStyle = .none
            }
            .frame(width: 450)
            .padding(.vertical, 0)
        }
    }
}

struct SearchTutor_Previews: PreviewProvider {
    static var sharedItems = [
            Tutor(id: 1, name: "Rodrigo", skills: "React", language: "Spanish", description: "", price: ""),
            Tutor(id: 1, name: "Rodrigo", skills: "React", language: "Spanish", description: "", price: ""),
            Tutor(id: 1, name: "Rodrigo", skills: "React", language: "Spanish", description: "", price: ""),
            Tutor(id: 1, name: "Rodrigo", skills: "React", language: "Spanish", description: "", price: ""),
            Tutor(id: 1, name: "Rodrigo", skills: "React", language: "Spanish", description: "", price: ""),
            
        ]
    static var previews: some View {
        SearchTutor(items: sharedItems)
    }
}
