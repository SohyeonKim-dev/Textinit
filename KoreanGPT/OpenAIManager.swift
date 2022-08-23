//
//  OpenAIManager.swift
//  KoreanGPT
//
//  Created by 김소현 on 2022/08/23.
//  출처: https://github.com/jeffreality/swift-gpt3
//

import UIKit

let openAIKey = "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"

enum OpenAIEngine: String {
    case davinci
    case curie
    case babbage
    case ada
    
    case instructcurie = "instruct-curie"
    case instructdavinci = "instruct-davinci"
}

class OpenAIManager {
    
    static let shared = OpenAIManager()
    
    var engine: OpenAIEngine = .babbage

    func makeRequest(json: [String: Any], completion: @escaping (String)->()) {
        guard let url = URL(string: "https://api.openai.com/v1/engines/\(engine)/completions"),
              let payload = try? JSONSerialization.data(withJSONObject: json) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(openAIKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = payload
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { completion("Error::\(String(describing: error?.localizedDescription))"); return }
            guard let data = data else { completion("Error::Empty data"); return }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            
            if let json = json,
               let choices = json["choices"] as? [[String: Any]],
               let str = choices.first?["text"] as? String {
                completion (str)
            } else {
                completion("Error::nothing returned")
            }
        }.resume()
    }
}
