//
//  WeatherForeCastingModelView.swift
//  Parent_Aps_Task
//
//  Created by developer on 18/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation
struct MainActivity : Encodable , Hashable{
    var cityName = ""
    var isDefault = false
    init(cityName : String , isDefault: Bool) {
        self.cityName = cityName
        self.isDefault = isDefault
    }
}
struct DecodeMainActivity : Decodable{
    var cityName = ""
    var isDefault = false
   
}
class WeatherForeCastingViewModel
{
     var networkManger = NetworkLayer()
    var Interactor = SearchInteractor()
   var CityButtonState = ""
   
      var showAlertClosure: (()->())?
     var ReloadCityTable: (()->())?
    var LoadForCasting: (()->())?
     var ReDrawMainActivites: (()->())?
     var ShowLoaderClosure: (()->())?
    var DissmissLoaderClosure: (()->())?
    var MainActivityBtns = [MainActivity]()
    {
     didSet {
        ReDrawMainActivites?()
        Interactor.SaveMainActivity(MainActivities: MainActivityBtns)
        }
    }
    var CitySearchResult: WeatherForeCastingResponse? {
             didSet {

                self.ReloadCityTable?()
             }
         }
    var DefaultCityName = String (){
             didSet {
               MainActivityBtns = MainActivityBtns.filter { $0.cityName != DefaultCityName }
                if(MainActivityBtns.count > 0)
                {
          
                   
                    if(MainActivityBtns[0].isDefault)
                    {
                        MainActivityBtns[0] = MainActivity(cityName: DefaultCityName, isDefault: true)
                    }else
                    {
                         MainActivityBtns.insert(MainActivity(cityName: DefaultCityName, isDefault: true), at: 0)
                    }
                   
                }else
                {
                    
                    MainActivityBtns.append(MainActivity(cityName: DefaultCityName, isDefault: true))
                }
 
                
                ReDrawMainActivites?()
             }
         }
    var alertMessage: String? {
          didSet {
              self.showAlertClosure?()
          }
      }
    var numberOfCities: Int {
        if let  result = CitySearchResult
        {
           return 1
        }
        else
        {
            return 0
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
    
    func GetCahedMainActivites() {
     MainActivityBtns =  Interactor.RetriveMainActivites()
    }
    func AddOrRemoveEventTrigger() -> String{
       
      if(CityName != "NoCity" )
      {
        if( !(GetActivites().contains(CityName)) )
        {
            if(MainActivityBtns.count < 5)
            {
          AddCurrentCity()
                
            }
            else
            {
           self.alertMessage = "Main Activity Elements reached to max please remove any element first"
            }
        }else
        {
          RemoveCurrentCity()
        }
      }
        return SetAddOrRemoveBtnTitle()
    }
    func SetAddOrRemoveBtnTitle() -> String {
        if( !GetActivites().contains(CityName) )
        {
         return "Add"
        }
        else
        {
            return "Remove"
        }
       
    }
    func GetActivites() -> [String] {
        var Activites = [String]()
        for item in MainActivityBtns {
            Activites.append(item.cityName)
        }
        return Activites
    }
    func AddCurrentCity() {
        MainActivityBtns.append(MainActivity(cityName: CityName, isDefault: false))
    }
    func RemoveCurrentCity() {
        MainActivityBtns = MainActivityBtns.filter { $0.cityName != CityName }
    }
    func SearchByCityName(CityName : String , loadForecasting : Bool){
        if(CityName == "")
        {
              self.alertMessage = "Invalid Data Supplied"
            return
        }
        self.ShowLoaderClosure?()
            networkManger.Request(ResponseModel: WeatherForeCastingResponse.self, RequestConfiq: NetworkRouter.SearchForWeatherByCityName(CityName), completionHandler:   {
                                  respose,State in
                         //    print(respose)
               switch State
                {
               case .empty:
                 self.DissmissLoaderClosure?()
                 self.alertMessage = "No Data Found"
                  
                return
               case .error:
                 self.DissmissLoaderClosure?()
                  self.alertMessage = "Check your Internet Connection"
                return
               case .Success:
                print("Success")
                }
                
              
                self.CitySearchResult = respose as? WeatherForeCastingResponse
                self.DissmissLoaderClosure?()
                      if(loadForecasting)
                      {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                              self.LoadForCasting?()
                        }
                    
                       }
                          })
        }
    func SearchByCityLocation(lat : String , lon : String){
         self.ShowLoaderClosure?()
              networkManger.Request(ResponseModel: DefaultCitynameResponseModel.self, RequestConfiq: NetworkRouter.SearchForWeatherByLocation(lat, lon), completionHandler:   {
                                    respose,State in
                           //    print(respose)
                 switch State
                  {
                 case .empty:
                     self.DissmissLoaderClosure?()
                    self.SetDefaultCityName()
                   print("Empty")
                  return
                 case .error:
                     self.DissmissLoaderClosure?()
                    self.SetDefaultCityName()
                    print("Empty")
                  return
                 case .Success:
                  print("Success")
                  }
                  
                
                  var defCity = respose as? DefaultCitynameResponseModel
                if let cityName = defCity?.city_name
                {
                      self.DefaultCityName = cityName
                }else
                {
                    self.SetDefaultCityName()
                }
               self.DissmissLoaderClosure?()
                //  print(defCity?.city_name )
                        
                            })
          }
    
    func SetDefaultCityName() {
        self.DefaultCityName = "London"
    }
    func SelectCity()  {
        LoadForCasting?()
   
    }
    
    
    
    
    
}
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
