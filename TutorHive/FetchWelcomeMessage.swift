//
//  FetchWelcomeMessage.swift
//  TutorHive
//
//  Created by Rodrigo Chavez on 2023-04-18.
//

import Foundation

class apiCall {
    func getMessage(completion:@escaping (Message) -> ()) {
        guard let url = URL(
            string: "https://2j3zy.wiremockapi.cloud/json-ios-project"
        )
        else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let message = try! JSONDecoder().decode(Message.self, from: data!)
            print(message)
            DispatchQueue.main.async {
                completion(message)
            }
            
        }.resume()
        
    }
}
