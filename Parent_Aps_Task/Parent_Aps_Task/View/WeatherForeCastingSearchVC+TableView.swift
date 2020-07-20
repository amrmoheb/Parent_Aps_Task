//
//  WeatherForeCastingSearchVC+TableView.swift
//  Parent_Aps_Task
//
//  Created by developer on 19/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation
import UIKit
extension WeatherForecastingSearchVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCities
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell  = tableView.dequeueReusableCell(withIdentifier: "CityCell") as! CityCell
        cell.AddOrRemoveEvent = { [weak self] ()  in
           // DispatchQueue.main.async {
            return  (self?.viewModel.AddOrRemoveEventTrigger() ?? "")
             
            //}
             // return ""
        }
        cell.SetAddOrRemoveBtnTitle(Title: self.viewModel.SetAddOrRemoveBtnTitle() ?? "")
        cell.SetCityName(CityName: viewModel.CityName)
             
              return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.SelectCity()
    }
    
    
}
