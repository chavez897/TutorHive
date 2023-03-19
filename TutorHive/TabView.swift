//
//  TabView.swift
//  TutorHive
//
//  Created by Rodrigo Chavez on 2023-03-15.
//

import SwiftUI

struct Tabs: View {
    @AppStorage("CurrentTab") var selectedTab = 1
    var sharedItems = [
            Tutor(id: 1, name: "Rodrigo", skills: "React", language: "Spanish", description: "", price: ""),
            Tutor(id: 1, name: "Rodrigo", skills: "React", language: "Spanish", description: "", price: ""),
            Tutor(id: 1, name: "Rodrigo", skills: "React", language: "Spanish", description: "", price: ""),
            Tutor(id: 1, name: "Rodrigo", skills: "React", language: "Spanish", description: "", price: ""),
            Tutor(id: 1, name: "Rodrigo", skills: "React", language: "Spanish", description: "", price: ""),
            
        ]
    var body: some View {
        TabView(selection: $selectedTab) {
            SearchTutor(items: sharedItems).tabItem{
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            SearchTutor(items: sharedItems).tabItem{
                Image(systemName: "person.crop.circle")
                Text("Profile")
            }
        }
        
    }
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}
