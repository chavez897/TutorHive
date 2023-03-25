//
//  ContentView.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("wise1")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Tutor Hive")
                .font(.system(size: 34))
                .foregroundColor(Color(red: 62/255, green: 78/255, blue: 51/255))
                .padding(.bottom, 15)
            Text("Elevate your education with top-tier tutors!")
                .font(.system(size: 19))
                .foregroundColor(Color(red: 0/255, green: 78/255, blue: 170/255))
            Spacer()
        }
        .padding(.top, 170.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
