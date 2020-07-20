//
//  WeatherForeCastingResponse.swift
//  Parent_Aps_Task
//
//  Created by developer on 18/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation


// MARK: - MarkPhotosResponseModel
public struct WeatherForeCastingResponse :Decodable{
 
    public var city_name: String?
    public var lon: String?
    public var timezone: String?
    public var lat: String?
    public var country_code: String?
    public var state_code: String?
   public var data: [Datum]?
    public init() {
      
    }
}

// Datum.swift


// MARK: - Datum
public struct Datum :Decodable {
   public var wind_cdir: String?
    public var rh: Int?
    public var pod: String?
    public var timestamp_utc: String?
    public var pres: Double?
    public var solar_rad: Double?
    public var ozone: Double?
    public var weather: Weather?
     public var wind_gust_spd: Double?
    public var timestamp_local: String?
    public var snow_depth: Int?
    public var clouds: Int?
   public var ts: Int?
    public var wind_spd: Double?
    public var pop: Int?
    public var wind_cdir_full: String?
    public var slp: Double?
     public var dni: Double?
    public var dewpt: Double?
    public var snow: Int?
    public var uv: Double?
    public var wind_dir: Int?
    public var clouds_hi: Int?
//    public var precip: Int?
    public var vis: Double?
    public var dhi: Double?
    public var app_temp: Double?
    public var datetime: String?
    public var temp: Double?
    public var ghi: Double?
    public var clouds_mid: Int?
    public var clouds_low: Int?

    public init() {
     
    }
}

// Weather.swift


// MARK: - Weather
public struct Weather :Decodable{
    public var icon: String?
    public var code: Int?
    public var description: String?

    public init() {
   
    }
}
