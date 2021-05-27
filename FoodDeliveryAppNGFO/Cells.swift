//
//  Cells.swift
//  FoodDeliveryAppNGFO
//
//  Created by Admin Macappstudio on 27/05/21.
//

import Foundation
import UIKit
import GoogleMaps
import CoreLocation

class Cell1:UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate,GMSMapViewDelegate{
   
    @IBOutlet weak var collectionView1: UICollectionView!
    var image_1 = [images]()
    var locationManager:CLLocationManager!
    var marker = GMSMarker()
    var geoname,geolocalityString,geoadministrativeArea,geocountry,geoCountryCode,geopastalcode:String?
    private let spacing:CGFloat = 16.0

    override func awakeFromNib() {
        collectionView1.delegate = self
        collectionView1.dataSource = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
            }
        retrieve()
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker,coordinate: CLLocationCoordinate2D) -> Bool {
        marker.position = coordinate
            print("position \(marker.position.latitude)")
            print("position marker \(marker.position.longitude)")
            return true
        }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        print("GMSMapView : \(position.target.latitude) \(position.target.longitude)")
         }
   
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        print("You have lat and long")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation

        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { [self] (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                
                geoname = placemark.name
                geopastalcode = placemark.postalCode
                geocountry = placemark.country
                geolocalityString = placemark.locality
                geoCountryCode = placemark.isoCountryCode
                geoadministrativeArea = placemark.administrativeArea
                collectionView1.reloadData()
                print("name : \(placemark.name!)")
                print("locality \(placemark.locality!)")
                print("administrativeArea : \(placemark.administrativeArea!)")
                print("country \(placemark.country!)")
                print("CountryCode: \(placemark.isoCountryCode!)")
                print(placemark.postalCode!)

            }
        }

        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image_1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView1.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell1", for: indexPath) as! CollectionViewCell1
        let radius: CGFloat = 2

        cell.imagecell1.image = UIImage(named: "res")
        cell.label1.text = geoname
        cell.label2.text = "\(geolocalityString ?? "waiting"),\(geoadministrativeArea ?? "waiting"),\(geocountry ?? "waiting")"
        cell.label3.text = "\(geoCountryCode ?? "waiting"),\(geopastalcode ?? "waiting")"
        cell.viewcell1.layer.cornerRadius = radius
        cell.viewcell1.layer.masksToBounds = true
        cell.viewcell1.layer.shadowColor = UIColor.darkGray.cgColor
        cell.viewcell1.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.viewcell1.layer.shadowRadius = 3.0
        cell.viewcell1.layer.shadowOpacity = 0.5
        cell.viewcell1.layer.masksToBounds = false
        cell.viewcell1.layer.cornerRadius = radius
        return cell
    }
    func retrieve(){
        let urlstring: String = "https://ordering.api.olosandbox.com/v1.1/restaurants/66020/menu?key=NsilV5nU1fYKEvjNAWVuOJBAc7viHCJL"
           guard let url = URL(string: urlstring) else {
            print("Error: cannot create URL")
            return
           }
           let urlRequest = URLRequest(url: url)
           let config = URLSessionConfiguration.default
           let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest) { [self]
            (data, response, error) in
            guard error == nil else {
             print("error calling GET")
             print(error!)
             return
            }
            guard let responseData = data else {
             print("Error: did not receive data")
             return
            }
            do {
             guard let jsonElement = try JSONSerialization.jsonObject(with: responseData, options:JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
             else {
               print("error trying to convert data to JSON")
               return
             }
                image_1.append(images(image: jsonElement["imagepath"] as? String))
                print("real : \(image_1)")
            DispatchQueue.main.async(execute: { [self] () -> Void in
                collectionView1.reloadData()
              })
           }catch {
             print("error trying to convert data to JSON")
             return
            }
           }
          task.resume()
          }
}


class Cell2: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
    @IBOutlet weak var CollectionView2: UICollectionView!
    private let spacing:CGFloat = 16.0

    var foods = [food]()

    
    override func awakeFromNib() {
        CollectionView2.delegate = self
        CollectionView2.dataSource = self
        retrieve()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.CollectionView2?.collectionViewLayout = layout
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionView2.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell2", for: indexPath) as! CollectionViewCell2
        cell.imagecell2.image = UIImage(named: foods[indexPath.row].images ?? "food")
        cell.labelcell2.text = foods[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let numberOfItemsPerRow:CGFloat = 2
            let spacingBetweenCells:CGFloat = 30
            
            let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) 
            
            if let collection = self.CollectionView2{
                let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
                return CGSize(width: width, height: width)
            }else{
                return CGSize(width: 0, height: 0)
            }
        }
    func retrieve(){
        let urlstring: String = "https://ordering.api.olosandbox.com/v1.1/restaurants/66020/menu?key=NsilV5nU1fYKEvjNAWVuOJBAc7viHCJL"
           guard let url = URL(string: urlstring) else {
            print("Error: cannot create URL")
            return
           }
           let urlRequest = URLRequest(url: url)
           // set up the session
           let config = URLSessionConfiguration.default
           let session = URLSession(configuration: config)
           // make the request
        let task = session.dataTask(with: urlRequest) { [self]
            (data, response, error) in
            // check for any errors
            guard error == nil else {
             print("error calling GET")
             print(error!)
             return
            }
            // make sure we got data
            guard let responseData = data else {
             print("Error: did not receive data")
             return
            }
            // parse the result as JSON, since that's what the API provides
            do {
             guard let jsonElement = try JSONSerialization.jsonObject(with: responseData, options:JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
             else {
               print("error trying to convert data to JSON")
               return
             }
              let real = jsonElement["categories"] as! [[String:Any]]
                    for i in real{
                      print("the new real : \(i["name"] as! String)")
                        foods.append(food(name: i["name"] as? String, images: i["images"] as? String))
                    }
            DispatchQueue.main.async(execute: { [self] () -> Void in
                CollectionView2.reloadData()
              })
           }catch {
             print("error trying to convert data to JSON")
             return
            }
           }
          task.resume()
          }
 
    
}

struct food {
    var name:String?
    var images:String?
}

struct images {
    var image:String?
}


