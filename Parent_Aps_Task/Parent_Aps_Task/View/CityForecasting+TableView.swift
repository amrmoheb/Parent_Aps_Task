//
//  CityForecasting+TableView.swift
//  Parent_Aps_Task
//
//  Created by developer on 19/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation
import  UIKit

extension CityForecastingVC : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  viewModel.numberOfForcasting
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell  = tableView.dequeueReusableCell(withIdentifier: "CityForecasting") as! CityForecastingCell
                cell.viewModel = viewModel.GetForecastingCellViewModel(index: indexPath.row)
                   return cell
    }
    
    
    
}
