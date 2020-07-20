//
//  WeatherForecastingSearchVC.swift
//  Parent_Aps_Task
//
//  Created by developer on 18/07/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit
import CoreLocation
struct Position {
    var X = 0
   var Y = 0
}
class WeatherForecastingSearchVC: UIViewController,UISearchBarDelegate,CLLocationManagerDelegate {
 let locationManager = CLLocationManager()
    @IBOutlet weak var MainActivityView: UIView!
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var MainActivityViewHight: NSLayoutConstraint!
    
    @IBOutlet weak var CityTable: UITableView!
    var CurrentCreatedBtnFrame : CGRect?
    
  //  var MainActivityBtns = [String]()
    lazy var viewModel: WeatherForeCastingViewModel = {
        return WeatherForeCastingViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         InitSetup()
   
    }
    
   
    

    @objc func MainActivityOnClick(sender: UIButton!) {
        viewModel.SearchByCityName(CityName: sender.titleLabel?.text ?? "" , loadForecasting: true)
      print( sender.titleLabel)
    }
    func labelSize(for text: String,fontSize: CGFloat, maxWidth : CGFloat,numberOfLines: Int) -> CGRect{

        let font = UIFont.systemFont(ofSize: fontSize)//(name: "HelveticaNeue", size: fontSize)!
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: maxWidth, height: CGFloat.leastNonzeroMagnitude))
        label.numberOfLines = numberOfLines
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame
    }
    func InitSetup()  {
          self.hideKeyboardWhenTappedAround() 
        viewModel.GetCahedMainActivites()
        viewModel.showAlertClosure = { [weak self] () in
                DispatchQueue.main.async {
                    if let message = self?.viewModel.alertMessage {
                        self?.showAlert( message )
                    }
                }
            }
            viewModel.ReloadCityTable = { [weak self] () in
                    DispatchQueue.main.async {
                        self?.CityTable.reloadData()
                    }
                }
        viewModel.LoadForCasting = { [weak self] () in
                          DispatchQueue.main.async {
                            self?.performSegue(withIdentifier: "ForecastingData", sender: self)
                          }
                      }
        viewModel.ReDrawMainActivites = { [weak self] () in
            DispatchQueue.main.async {
                self?.DrawMainActivityBtns()
            }
        }
        viewModel.ShowLoaderClosure = { [weak self] () in
                 DispatchQueue.main.async {
                    self?.ShowLoader()
                 }
             }
        viewModel.DissmissLoaderClosure = { [weak self] () in
            DispatchQueue.main.async {
               self?.DissmissLoader()
            }
        }
       
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locationManager.stopUpdatingLocation()
        viewModel.SearchByCityLocation(lat: String(locValue.latitude), lon: String(locValue.longitude))
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         viewModel.SetDefaultCityName()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.SearchByCityName(CityName: searchBar.text ?? "London" , loadForecasting: false)
           print(searchBar.text)
        
    }

    
    func showAlert( _ message: String ) {
         let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
         alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
         self.present(alert, animated: true, completion: nil)
     }
    func ShowLoader()  {
          let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

          let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
          loadingIndicator.hidesWhenStopped = true
          loadingIndicator.style = UIActivityIndicatorView.Style.gray
          loadingIndicator.startAnimating();

          alert.view.addSubview(loadingIndicator)
          present(alert, animated: true, completion: nil)
      }
    func DissmissLoader()  {
          self.dismiss(animated: false, completion: nil)
    }
    
    


}


extension WeatherForecastingSearchVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CityForecastingVC
        {
        vc.viewModel.CitySearchResult = self.viewModel.CitySearchResult
        }
    }
}
extension WeatherForecastingSearchVC {
    func DrawMainActivityBtns() {
           ClearMainActivityBtns()
        for btnLabel in viewModel.GetActivites() {
                CreatBtn(BtnLabel: btnLabel)
           }
           
       }
       func ClearMainActivityBtns()  {
           CurrentCreatedBtnFrame = nil
           for view in self.MainActivityView.subviews {
               view.removeFromSuperview()
           }
          UpdateMainActivityViewHight()
       }
       
       func CreatBtn(BtnLabel: String) {
           var button = UIButton(frame: labelSize(for: BtnLabel, fontSize: 25, maxWidth: 600, numberOfLines: 0))
           UIView.animate(withDuration: 0.5) {
                                 button.layoutIfNeeded()
                        }
           var Pos = GetPos(btn: button)
           button = UIButton(frame: CGRect(x: Pos.X , y: Pos.Y , width: Int(button.frame.width) , height: Int(button.frame.height)))
          
                button.backgroundColor = #colorLiteral(red: 0.1190623895, green: 0.3352510512, blue: 0.4851443588, alpha: 1)
                button.setTitle(BtnLabel, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9493890405, green: 0.9716489911, blue: 0.975132525, alpha: 1), for: .normal)
        button.layer.cornerRadius = 15
                button.addTarget(self, action: #selector(MainActivityOnClick), for: .touchUpInside)

                self.MainActivityView.addSubview(button)
         
           CurrentCreatedBtnFrame = button.frame
           UpdateMainActivityViewHight()
           
       }
       func GetPos(btn : UIButton) -> Position {
            var ScreenWidth = Int(UIScreen.main.bounds.width)
           var Pos = Position()
           let spaceing = 20
           if let CurrentBtn = CurrentCreatedBtnFrame
           {
               var requierdAreaInX = Int ( CurrentBtn.maxX ) + (spaceing * 2) + Int(btn.frame.width)
              
               if( ScreenWidth < requierdAreaInX )
               {
                      Pos.X = 0
                     Pos.Y = Int( CurrentBtn.maxY ) + spaceing
               }else
               {
                   Pos.X = Int( CurrentBtn.maxX ) + spaceing
                   Pos.Y = Int ( CurrentBtn.minY )
               }
           }else
           {
               Pos.X = 0
               Pos.Y = 0
           }
     
           return Pos
       }
       func UpdateMainActivityViewHight()  {
           var bading = 10
        if let CurrentBtn = CurrentCreatedBtnFrame
        {
            MainActivityViewHight.constant =  CurrentBtn.maxY as! CGFloat
                   MainActivityViewHight.constant += CGFloat(bading)
        }else
        {
            MainActivityViewHight.constant = CGFloat(bading)
        }
        UIView.animate(withDuration: 0.3) {
                 self.view.layoutIfNeeded()
        }
       
           
       }
       override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
             super.viewWillTransition(to: size, with: coordinator)
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:
                          {
                           self.DrawMainActivityBtns()
                       
                           })
         }
}
