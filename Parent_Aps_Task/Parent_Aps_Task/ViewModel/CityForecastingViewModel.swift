//
//  CityDetailsViewModel.swift
//  Parent_Aps_Task
//
//  Created by developer on 19/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation
class CityForecastingViewModel {
    var ForcastingElements =  [CityForcastingCellViewModel]()
    
    var ReloadForecatingTable: (()->())?
    
    
   
    var CitySearchResult: WeatherForeCastingResponse? {
                didSet {
                    self.FillForecastingElments()
                }
            }
    
    var CityName: String {
         if let CityName = CitySearchResult?.city_name
           {
           return CityName
           }
           else
           {
           return "NoCity"
           }
       }
    var numberOfForcasting: Int {
        return ForcastingElements.count 
      
    }
    func FillForecastingElments()  {
        if let result = CitySearchResult
        {
            if let data = result.data
            {
                for forecast in data {
                    
                    if let temperature = forecast.app_temp
                    {
                   
                        let TimeStr = GetTime(str: forecast.timestamp_utc ?? "")
                        let DateStr = GetDate(str: forecast.timestamp_utc ?? "")
                        let vm = CityForcastingCellViewModel(Date: DateStr , Time:  TimeStr , Tempreature: "\(temperature) c"  , Sky: forecast.weather?.description ?? "No Value" )
                         ForcastingElements.append(vm)
                    }

                }
            }
             self.ReloadForecatingTable?()
        }
        else
        {
            return
        }
    }
    func GetTime(str : String) -> String {
        
          let dateFormatter = DateFormatter()
          let tempLocale = dateFormatter.locale
          dateFormatter.locale = Locale(identifier: "en_US_POSIX")
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
          let date = dateFormatter.date(from: str)!
          dateFormatter.dateFormat = "HH:mm:ss"
           dateFormatter.locale = tempLocale
          let timeStr = dateFormatter.string(from: date)
        return timeStr
    }
    func GetDate(str : String) -> String {
          
            let dateFormatter = DateFormatter()
            let tempLocale = dateFormatter.locale
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: str)!
            dateFormatter.dateFormat = "yyyy-MM-dd"
             dateFormatter.locale = tempLocale 
            let timeStr = dateFormatter.string(from: date)
          return timeStr
      }
    func GetForecastingCellViewModel(index : Int) -> CityForcastingCellViewModel {
        return ForcastingElements[index]
    }
    
    
}
