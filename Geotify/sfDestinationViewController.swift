//
//  sfDestinationViewController.swift
//  Geotify
//
//  Created by ken bains on 1/19/17.
//  Copyright © 2017 Ken Toh. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class sfDestinationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
  
  let locationManager = CLLocationManager()
  @IBOutlet weak var mapView: MKMapView!
  
  weak var delegate:cancelDelegate?
  
    @IBOutlet weak var infoLabelFinal: UILabel!
  
    @IBOutlet weak var cameraButton: UIButton!

    @IBOutlet weak var backButton: UIButton!

    
  @IBOutlet weak var imagePicked: UIImageView!
  
  var locValue: CLLocationCoordinate2D?
  
  let sfCoord = CLLocationCoordinate2D(latitude: 37.787358899999987, longitude: -122.40822700000001)
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
        print("sf coord", sfCoord.longitude)
        print("current coord", currentLoc.longitude)
        if (String(currentLoc.latitude) == String(sfCoord.latitude)){
          print("it is the same")
//          let alertController = UIAlertController(title: "Good job", message: "You have arrived in San Francisco. Watch out for the hobbos.", preferredStyle: .alert)
//          present(alertController, animated: true, completion: nil)
          infoLabelFinal.text = "Good Job!"
          cameraButton.isHidden = true
          backButton.isHidden = false
        } else {
//          let alertController = UIAlertController(title: "You suck", message: "You're not in San Francisco. Try again.", preferredStyle: .alert)
//          let cancelAction = UIAlertAction(title: "Guess Again", style: UIAlertActionStyle.default, handler: {(paramAction:UIAlertAction!) in
//            
//          })
////          let cancelAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: {(paramAction: UIAlertAction!) in)}
//          alertController.addAction(cancelAction)
//          present(alertController, animated: true, completion: nil)
          infoLabelFinal.text = "Try again you're not quite there!"

          print("it's not the same")
        }

        
      }
      
              self.dismiss(animated: true, completion: nil);
    }
  
    @IBAction func backButtonPressed(_ sender: UIButton) {
        print("back pressed?")
      delegate?.cancelButtonPressed(by: self, where: "sanFran")
    }
 
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    locValue = (manager.location?.coordinate)!
//    print("locations = \(locValue?.latitude) \(locValue?.longitude)")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("sf did load")
    backButton.isHidden = true
    
    let sfPin = destinationPin(coordinate: sfCoord , radius: 300.0, note: "Take a picture")
    print("our pin", sfPin)
    mapView.addAnnotation(sfPin as MKAnnotation)
  //  addRadiusOverlay(forDestination: sfPin)
    
    self.locationManager.requestAlwaysAuthorization()
    
    // For use in foreground
    self.locationManager.requestWhenInUseAuthorization()
    
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
