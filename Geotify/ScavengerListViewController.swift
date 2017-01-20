//
//  ScavengerListViewController.swift
//  Geotify
//
//  Created by ken bains on 1/19/17.
//  Copyright © 2017 Ken Toh. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ScavengerListTableViewController: UITableViewController, cancelDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
  let locationManager = CLLocationManager()
  
  var destinations = ["San Francisco", "Cupertino", "Mountain View"]
  var destinationImages = ["san_francisco", "cupertino", "mountain_view"]
 
  @IBOutlet weak var mapView: MKMapView!
  
  @IBAction func zoomButtonPressed(_ sender: UIBarButtonItem) {
    mapView.zoomToUserLocation() 
  }
  @IBOutlet weak var sanFranCell: UITableViewCell!
    @IBOutlet weak var sanFranImg: UIImageView!
    @IBOutlet weak var sanFranGoToBtn: UIButton!
    @IBOutlet weak var sanFranCheckmark: UIImageView!
  
  
    @IBOutlet weak var mvCell: UITableViewCell!
    @IBOutlet weak var mvImg: UIImageView!
    @IBOutlet weak var mvGoToBtn: UIButton!
    @IBOutlet weak var mvCheckmark: UIImageView!
  
  
  @IBOutlet weak var cpCell: UITableViewCell!
  @IBOutlet weak var cpImg: UIImageView!
  @IBOutlet weak var cpGoToBtn: UIButton!
  @IBOutlet weak var cpCheckmark: UIImageView!
  
  
  
  @IBOutlet weak var djCell: UITableViewCell!
  @IBOutlet weak var djImg: UIImageView!
  @IBOutlet weak var djGoToBtn: UIButton!
  @IBOutlet weak var djCheckmark: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    print("did load")
    sanFranCheckmark.isHidden = true
    mvCheckmark.isHidden = true
    cpCheckmark.isHidden = true
    djCheckmark.isHidden = true

    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
    self.mapView.showsUserLocation = true
    
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations.last
    
    let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    
    self.mapView.setRegion(region, animated: true)
    self.locationManager.stopUpdatingLocation()
    
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error for location manager")
  }
  
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "sfSegue"{
      let navigationController = segue.destination as! UINavigationController
      let myController = navigationController.topViewController as! sfDestinationViewController
      myController.delegate = self
    } else if segue.identifier == "mvSegue"{
      let navigationController = segue.destination as! UINavigationController
      let myController = navigationController.topViewController as! mvDestinationViewController
      myController.delegate = self

    } else if segue.identifier == "cpSegue"{
      let navigationController = segue.destination as! UINavigationController
      let myController = navigationController.topViewController as! cpDestinationViewController
      myController.delegate = self
    } else if segue.identifier == "djSegue"{
      let navigationController = segue.destination as! UINavigationController
      let myController = navigationController.topViewController as! djDestinationViewController
      myController.delegate = self
    }
  }
  
  func cancelButtonPressed(by controller: UIViewController, where location: String) {
    print(location, "prnit location")
    if location == "sanFran"{
      sanFranCell.backgroundColor = hexStringToUIColor(hex: "#E3E3E3")
      sanFranImg.image = UIImage(named: "sanfran_gray")
      sanFranGoToBtn.isHidden = true
      sanFranCheckmark.isHidden = false

    } else if location == "mv" {
      mvCell.backgroundColor = hexStringToUIColor(hex: "#E3E3E3")
      mvImg.image = UIImage(named: "mountain_view_gray")
      mvGoToBtn.isHidden = true
      mvCheckmark.isHidden = false
    } else if location == "cp" {
      print("sssssssssssss")
      cpCell.backgroundColor = hexStringToUIColor(hex: "#E3E3E3")
      cpImg.image = UIImage(named: "cupertino_gray")
      cpGoToBtn.isHidden = true
      cpCheckmark.isHidden = false
    } else if location == "dj" {
      djCell.backgroundColor = hexStringToUIColor(hex: "#E3E3E3")
      djImg.image = UIImage(named: "dojo_gray")
      djGoToBtn.isHidden = true
      djCheckmark.isHidden = false
    }
    dismiss(animated: true, completion: nil)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
      return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
//  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return destinations.count
//  }
  
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "DestinationCell") as! DestinationCell
//    cell.destinationLabel.text = destinations[indexPath.row]
//    let img = destinationImages[indexPath.row]
//    cell.destinationImage.image = UIImage(named: "\(img)")
//    return cell
//  }
}
