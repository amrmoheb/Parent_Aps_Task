//
//  CityDetailsVC.swift
//  Parent_Aps_Task
//
//  Created by developer on 19/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit

class CityForecastingVC: UIViewController {

    @IBOutlet weak var CityNameLabel: UILabel!
    @IBOutlet weak var CityForecastingTable: UITableView!
    lazy var viewModel: CityForecastingViewModel = {
          return CityForecastingViewModel()
      }()
    override func viewDidLoad() {
        super.viewDidLoad()
       InitSetup()
        // Do any additional setup after loading the view.
    }
    
    func InitSetup()  {
        CityNameLabel.text = viewModel.CityName
              viewModel.ReloadForecatingTable = { [weak self] () in
                      DispatchQueue.main.async {
                          self?.CityForecastingTable.reloadData()
                      }
                  }
    }


}
