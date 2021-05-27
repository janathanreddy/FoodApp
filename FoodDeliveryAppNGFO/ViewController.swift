//
//  ViewController.swift
//  FoodDeliveryAppNGFO
//
//  Created by Admin Macappstudio on 27/05/21.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate,GMSMapViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var backbtn: UIButton!
    var locationManager:CLLocationManager!
    var marker = GMSMarker()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "watermark")!)
      
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! Cell1
            tableView.rowHeight = 220
                return cell1
        }else if indexPath.row == 1{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! Cell2
            tableView.rowHeight = 560
            return cell2
        }
        return UITableViewCell()
    }
           
   
   
 
    @IBAction func BackAction(_ sender: Any) {
    }
    
    @IBAction func homeAction(_ sender: Any) {
    }
    
}



