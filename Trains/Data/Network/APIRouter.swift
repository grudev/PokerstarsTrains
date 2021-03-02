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
    case getCurrentTrains(request: GetCurrentTrainsRequest)
    case getStationDataByName(request: GetStationDataByNameRequest)
    case getStationDataByCode(request: GetStationDataByCodeRequest)
    case getStationsFilter(request: GetStationsFilterRequest)
    case getTrainMovements(request: GetTrainMovementsRequest)
    
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
        case .getCurrentTrains(let request):
            guard let _ = request.type else {
                return "getCurrentTrainsXML"
            }
            return "getCurrentTrainsXML_WithTrainType"
        case .getStationDataByName:
            return "getStationDataByNameXML"
        case .getStationDataByCode(let request):
            guard let _ = request.minutes else {
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
            
        case .getCurrentTrains(let request):
            
            guard let type = request.type else { return nil }
            return ["TrainType": type.rawValue]
            
        case .getStationDataByName(let request):
            
            var params: [String: String] = ["StationDesc": request.name]
            guard let _minutes = request.minutes else { return params }
            params.updateValue("\(_minutes)", forKey: "NumMins")
            return params
            
        case .getStationDataByCode(let request):
            
            var params: [String: String] = ["StationCode": request.code]
            guard let _minutes = request.minutes else { return params }
            params.updateValue("\(_minutes)", forKey: "NumMins")
            return params
            
        case .getStationsFilter(let request):
            
            return ["StationText": request.filter]
        
        case .getTrainMovements(let request):
            
            var params: [String: String] = ["TrainId": request.id]
            params.updateValue(request.date, forKey: "TrainDate")
            return params
            
        }
    }
    
    func addDefaultHeaders(_ request: inout URLRequest) {
        // request.addValue("Client-ID client-id-here", forHTTPHeaderField: "Authorization")
    }
    
}
