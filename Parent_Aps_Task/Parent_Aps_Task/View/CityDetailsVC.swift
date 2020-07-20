//
//  CityDetailsVC.swift
//  Parent_Aps_Task
//
//  Created by developer on 19/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit

class CityForecastingVC: UIViewController {

    @IBOutlet weak var CityForecastingTable: UITableView!
    lazy var viewModel: CityDetailsViewModel = {
          return CityDetailsViewModel()
      }()
    override func viewDidLoad() {
        super.viewDidLoad()
InitSetup()
        // Do any additional setup after loading the view.
    }
    
    func InitSetup()  {
              viewModel.ReloadForecatingTable = { [weak self] () in
                      DispatchQueue.main.async {
                          self?.CityForecastingTable.reloadData()
                      }
                  }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
