//
//  File.swift
//  MREC
//
//  Created by developer on 06/05/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation

enum NetworkRouter
{  static let baseURLString = "https://api.weatherbit.io/v2.0/forecast/hourly?"
    static let AppID = "&key=4165309f76694275a0230c271506a1dd"
    case SearchForWeatherByCityName(String)
    case SearchForWeatherByLocation(String , String)
   

    func GetUrl() -> String {
  
        var relativePath = ""
        switch self {
     
        case .SearchForWeatherByCityName(let CityName):
             relativePath = "city=" + String (CityName)
            case .SearchForWeatherByLocation(let lat, let lon):
            relativePath = "&lat=" + String (lat) + "&lon=" + String (lon)
        
        }
        return NetworkRouter.baseURLString + relativePath + NetworkRouter.AppID
    }
    func GetMethod() -> String {
        switch self {
        
        case .SearchForWeatherByCityName,.SearchForWeatherByLocation:
             return "Get"
       
        }
    }

  
    
}
