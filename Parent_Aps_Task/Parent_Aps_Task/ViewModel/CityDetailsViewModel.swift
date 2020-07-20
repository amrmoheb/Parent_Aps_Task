//
//  CityDetailsViewModel.swift
//  Parent_Aps_Task
//
//  Created by developer on 19/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation
class CityForecastingViewModel {
    
    var ReloadForecatingTable: (()->())?
    
    var CitySearchResult: WeatherForeCastingResponse? {
                didSet {
                 
                }
            }
    
    
}
