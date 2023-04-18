//
//  TutorItem.swift
//  TutorHive
//
//  Created by Rodrigo Chavez on 2023-03-15.
//

import SwiftUI

struct TutorItem: View {
    var tutor: Tutor
    
    var body: some View {
            HStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(tutor.name)  \(tutor.lastName)")
                            .font(.system(size: 20))
                            .bold()
                        Text(tutor.skills.joined(separator: ", "))
                            .font(.callout)
                        Text(tutor.language.joined(separator: ", "))
                            .font(.callout)
                    }
                    Spacer()
                    VStack {
                        Text((String(format: "CAD $%.2f/hr ", tutor.price)))
                    }
                }
                .padding()
                .background(Rectangle().fill(Color.white))
                .cornerRadius(10)
                .shadow(color: .gray, radius: 3, x: 2, y: 2)
            }
    }
}

struct TutorItem_Previews: PreviewProvider {
    static var previews: some View {
        TutorItem(tutor: Tutor(id: "", name: "Rodrigo", lastName: "Chavez Mercado", skills: ["ReactJS"], language: ["Spanish"], description: "", price: 25.0, image: ":"))
    }
}

