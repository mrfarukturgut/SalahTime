//
//  API.swift
//  SalahApp
//
//  Created by Faruk Turgut on 23.05.2020.
//  Copyright © 2020 Faruk Turgut. All rights reserved.
//

import Foundation
import Moya

enum PrayerService {
    case prayerTimeMethods
}

extension PrayerService: TargetType {
    
    var baseURL: URL { return URL(string: "https://api.aladhan.com/v1")! }
    
    var path: String {
        switch self {
        case .prayerTimeMethods:
            return "/methods"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .prayerTimeMethods:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .prayerTimeMethods:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        return .init()
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

enum NetworkError: Error {
    case badUrl
}

class PrayerTimesManager {
    
    static let shared = PrayerTimesManager()
    private init(){}
    
    let provider = MoyaProvider<PrayerService>()
    
    func makeRequest<T: Codable>(_ endpoint: PrayerService, completion: @escaping (T) -> ()) {
        self.provider.request(endpoint) { (result) in
            switch result {
            case .success(let response):
                self.responseParser(for: endpoint, response: response) { (codable) in
                    completion(codable)
                }
            case .failure(let error):
                //network fail
                print(error)
            }
        }
    }
    
    func responseParser<T: Codable>(for endpoint: PrayerService, response: Response, completion: @escaping (T) -> ()) {
        guard response.statusCode == 200 else {
            //request fail
            print(response.statusCode)
            print("request fail")
            return
        }
        
        let data = response.data
        
        switch endpoint {
        case .prayerTimeMethods:
            print("completion 1")
            let decoded = try! JSONDecoder().decode(PrayerMethodsResponse.self, from: data)
            if let values = decoded as? T { completion(values) }
            //if let value = Test(name: "asd") as? T { completion(value) }
        }
    }
    
    func loadData<T: Decodable>(of type: T.Type = T.self, completion: @escaping (Result<T, Error>) -> Void) {
        //if let value = Test(name: "faruk") as? T { completion(.success(value))}
        //completion(.success(Test(name: "faruk")))
    }
}

struct PrayerMethodsResponse: Codable {
    var code: Int
    var status: String
    var data: [PrayerMethod]
    
    enum CodingKeys: CodingKey {
        case code, status, data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(Int.self, forKey: .code)
        self.status  = try container.decode(String.self, forKey: .status)
        var methods = try container.decode([String:PrayerMethod].self, forKey: .data)
        methods.removeValue(forKey: "CUSTOM")
        self.data = Array(methods.values)
    }
    
    struct PrayerMethod: Codable {
        var id: Int
        var name: String
        
        enum CodingKeys: CodingKey {
            case id, name
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        }
    }
}


