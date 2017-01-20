//
//  djDestinationViewController.swift
//  Geotify
//
//  Created by ken bains on 1/20/17.
//  Copyright © 2017 Ken Toh. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class djDestinationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
  
  let locationManager = CLLocationManager()
  
  weak var delegate:cancelDelegate?
  
  
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var cameraButton: UIButton!
  @IBOutlet weak var goBackBtn: UIButton!
  @IBOutlet weak var infoLabel: UILabel!
  @IBOutlet weak var imagePicked: UIImageView!
  
  
  
  
  
  var locValue: CLLocationCoordinate2D?
  
  let djCoord = CLLocationCoordinate2D(latitude: 37.375402, longitude: -121.910024)
  
  @IBAction func camera(_ sender: UIButton) {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
      imagePicker.allowsEditing = false
      self.present(imagePicker, animated: true, completion: nil)
    }

  }
  

  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    print("entered")
    let chosenImage = info[UIImagePickerControllerOriginalImage]
    imagePicked.contentMode = .scaleAspectFit
    imagePicked.image = chosenImage as! UIImage?
    if let currentLoc = locValue {
      print("cp coord", djCoord.longitude, djCoord.latitude)
      print("current coord", currentLoc.longitude)
      if (String(currentLoc.latitude) == String(djCoord.latitude)){
        print("it is the same")
        //          let alertController = UIAlertController(title: "Good job", message: "You have arrived in San Francisco. Watch out for the hobbos.", preferredStyle: .alert)
        //          present(alertController, animated: true, completion: nil)
        infoLabel.text = "Good Job!"
        cameraButton.isHidden = true
        goBackBtn.isHidden = false
      } else {
        //          let alertController = UIAlertController(title: "You suck", message: "You're not in San Francisco. Try again.", preferredStyle: .alert)
        //          let cancelAction = UIAlertAction(title: "Guess Again", style: UIAlertActionStyle.default, handler: {(paramAction:UIAlertAction!) in
        //
        //          })
        ////          let cancelAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: {(paramAction: UIAlertAction!) in)}
        //          alertController.addAction(cancelAction)
        //          present(alertController, animated: true, completion: nil)
        infoLabel.text = "Try again you're not quite there!"
        
        print("it's not the same")
      }
      
      
    }
    
    self.dismiss(animated: true, completion: nil);
  }
  
  
  @IBAction func goBackPressed(_ sender: UIButton) {
    delegate?.cancelButtonPressed(by: self, where: "dj")

  }
  
  
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    locValue = (manager.location?.coordinate)!
     //print("locations = \(locValue?.latitude) \(locValue?.longitude)")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("mv did load")
    goBackBtn.isHidden = true
    
    let djPin = destinationPin(coordinate: djCoord , radius: 300.0, note: "Take a picture")
    print("mv our pin", djPin)
    mapView.addAnnotation(djPin as MKAnnotation)
    print("something 1")
    //  addRadiusOverlay(forDestination: sfPin)
    
    self.locationManager.requestAlwaysAuthorization()
    print("something 2")
    
    // For use in foreground
    self.locationManager.requestWhenInUseAuthorization()
    print("something 3")
    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    }
    
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
    delegate?.cancelButtonPressed(by: self, where: "other")

  }
  
  
  
  //  func addRadiusOverlay(forDestination destinationPin: destinationPin) {
  //    print("Overlay has been passed", destinationPin)
  //    mapView?.add(MKCircle(center: destinationPin.coordinate, radius: destinationPin.radius))
  //  }
  
}

