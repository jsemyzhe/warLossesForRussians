//
//  JSONManager.swift
//  InvadersCountdown
//
//  Created by Julia Semyzhenko on 7/21/22.
//

import Foundation


struct Constants {
    static let URLEquipment = URL(string: "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/5bdb33e3eacb414d0157194498feb6e074b8183a/data/russia_losses_equipment.json")
    static let URLPersonnel  = URL(string: "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json")
}

class ScreenData {
    var day: Int
    var date: String
    
    init(day: Int = 1, date: String = "2022-02-25") {
        self.day = day
        self.date = date
    }
}

var screenData = ScreenData()

final class JSONCaller {
    static let shared = JSONCaller()
    
    
    private init() {}
    
    public func getPersonnelData(completion: @escaping (Result<[BadGuysPerDay], Error>) -> Void) {
        guard let url = Constants.URLPersonnel else { return  }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(BadGuys.self, from: data)
                    completion(.success(result))
                }
                catch {
                    
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

struct BadGuysPerDay: Codable {
    let date: String
    let day, personnel: Int
    let morePersonnel: Personnel
    let POW: Int?
    
    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case morePersonnel = "personnel*"
        case POW = "POW"
    }
}

enum Personnel: String, Codable {
    case about = "about"
    case more = "more"
}


typealias BadGuys = [BadGuysPerDay]
