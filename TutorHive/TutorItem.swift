//
//  TutorItem.swift
//  TutorHive
//
//  Created by Darshit Patel on 2023-03-22.
//

import SwiftUI

struct TutorItem: View {
    var body: some View {
            HStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Rodrigo Chavez Mercado")
                            .font(.system(size: 20))
                            .bold()
                        Text("ReactJS, NodeJS, Springboot")
                            .font(.callout)
                        Text("Spanish, English")
                            .font(.callout)
                    }
                    Spacer()
                    VStack {
                        Text("CAD $25/hr")
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
        TutorItem()
    }
}
