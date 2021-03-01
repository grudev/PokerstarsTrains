//
//  APIRouter.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import Foundation

enum APIRouter {
    
    static let baseUrl = "http://api.irishrail.ie/realtime/realtime.asmx/"
    
    // MARK: - Endpoints -
    
    case getAllStations(request: GetAllStationsRequest)
    case getCurrentTrains(type: TrainType?)
    case getStationDataByName(name: String, minutes: Int?)
    case getStationDataByCode(code: String, minutes: Int?)
    case getStationsFilter(filter: String)
    case getTrainMovements(id: String, date: String)
    
    // MARK: - Convert to url request -
    
    func asURLRequest() throws -> URLRequest {
        
        guard var components = URLComponents(string: APIRouter.baseUrl) else {
            fatalError(.failedToResolveBaseUrl)
        }
        
        var urlQueryItems = components.queryItems ?? [URLQueryItem]()
        parameters?.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        components.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = components.url else { throw AppDomainError.failedToResolveBaseUrl }
        
        var urlRequest = URLRequest(url: url.absoluteURL.appendingPathComponent(path))
        urlRequest.httpMethod = method
        addDefaultHeaders(&urlRequest)
        return urlRequest
        
    }
    
}

// MARK: - Private Logic -

private extension APIRouter {
    
    var method: String {
        switch self {
        // TODO: - handle more http methods
        default:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .getAllStations(let request):
            guard let _ = request.type else {
                return "getAllStationsXML"
            }
            return "getAllStationsXML_WithStationType"
        case .getCurrentTrains(let type):
            guard let _ = type else {
                return "getCurrentTrainsXML"
            }
            return "getCurrentTrainsXML_WithTrainType"
        case .getStationDataByName:
            return "getStationDataByNameXML"
        case .getStationDataByCode(_, let minutes):
            guard let _ = minutes else {
                return "getStationDataByCodeXML_WithNumMins"
            }
            return "getStationDataByCodeXML"
        case .getStationsFilter:
            return "getStationsFilterXML"
        case .getTrainMovements:
            return "getTrainMovementsXML"
        }
    
    }
    
    var parameters: [String: String]? {
        switch self {
        case .getAllStations(let request):
            
            guard let type = request.type else { return nil }
            return ["StationType": type.rawValue]
            
        case .getCurrentTrains(let type):
            
            guard let _type = type else { return nil }
            return ["TrainType": _type.rawValue]
            
        case .getStationDataByName(let name, let minutes):
            
            var params: [String: String] = ["StationDesc": name]
            guard let _minutes = minutes else { return params }
            params.updateValue("\(_minutes)", forKey: "NumMins")
            
        case .getStationDataByCode(let code, let minutes):
            
            var params: [String: String] = ["StationCode": code]
            guard let _minutes = minutes else { return params }
            params.updateValue("\(_minutes)", forKey: "NumMins")
            
        case .getStationsFilter(let filter):
            
            return ["StationText": filter]
        
        case .getTrainMovements(let id, let date):
            
            var params: [String: String] = ["TrainId": id]
            params.updateValue(date, forKey: "TrainDate")
            return params
            
        }
        return nil
    }
    
    func addDefaultHeaders(_ request: inout URLRequest) {
        // request.addValue("Client-ID client-id-here", forHTTPHeaderField: "Authorization")
    }
    
}
