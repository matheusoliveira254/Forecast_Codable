//
//  NetworkController.swift
//  Forecast_Codable
//
//  Created by Matheus Oliveira on 10/10/22.
//

import Foundation

class NetworkController {
    private static let baseURLString = "https://api.weatherbit.io"
    
    //MARK: - CRUD
    static func fetchDays(completion: @escaping (TopLevelDictionary?) -> Void) {
        guard let baseURL = URL(string: baseURLString) else {return}
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "v2.0/forecast/daily"
        var apiQuery = URLQueryItem(name: "key", value: "dd42671717fd414aa38bc749daace27b")
        var cityQuery = URLQueryItem(name: "city", value: "Lehi")
        var unitsQuery = URLQueryItem(name: "units", value: "I")
        
        urlComponents?.queryItems = [apiQuery, cityQuery, unitsQuery]
        guard let finalURL = urlComponents?.url else {return}
        print(finalURL)
    }
}
