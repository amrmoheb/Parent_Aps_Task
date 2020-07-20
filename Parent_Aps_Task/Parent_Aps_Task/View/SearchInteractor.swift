//
//  Interactor.swift
//  Parent_Aps_Task
//
//  Created by developer on 20/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation
class SearchInteractor {
    init() {
        
    }
    func SaveMainActivity(MainActivities : [MainActivity])  {
        do{
                 
                       let jsonEncoder = JSONEncoder()
                 let  jsonData = try jsonEncoder.encode(MainActivities)
                   let JsonString = String(decoding: jsonData, as: UTF8.self)
                            UserDefaults.standard.set(JsonString , forKey: "MainActivites")
                          }
                              catch
                              {
                              print("error im parsssssing")
                              }
    }
    func RetriveMainActivites() -> [MainActivity] {
        var MainActivitesArr = [MainActivity]()
        do{
                 if let  Result =   UserDefaults.standard.string(forKey: "MainActivites")
                           {
                         if  let jsonData = Result.data(using: .utf8)
                         {
                           var DecodedResults =  try  JSONDecoder().decode([DecodeMainActivity].self, from: jsonData)
                            for item in DecodedResults {
                                MainActivitesArr.append( MainActivity(cityName: item.cityName, isDefault: item.isDefault))
                            }
                          
                return MainActivitesArr
                           
                         }
                                }
            }


                            catch{


                                print("error im parsssssing")


                            }
        return [MainActivity]()
    }
    func SaveDefaultCity(CityName : String) {
         UserDefaults.standard.set(CityName , forKey: "DefaultCity")
    }
    func GetDefaultCity() -> String {
        return   UserDefaults.standard.string(forKey: "DefaultCity") ?? ""
    }
}
