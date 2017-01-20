//
//  destinationPin.swift
//  Geotify
//
//  Created by ken bains on 1/19/17.
//  Copyright © 2017 Ken Toh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

struct DestKey {
  static let latitude = "latitude"
  static let longitude = "longitude"
  static let radius = "radius"
  static let identifier = "identifier"
  static let note = "note"
  static let eventType = "eventTYpe"
}



class destinationPin: NSObject, NSCoding, MKAnnotation {
  
  var coordinate: CLLocationCoordinate2D
  var radius: CLLocationDistance
  var note: String
  var title: String? {
    if note.isEmpty {
      return "No Note"
    }
    return note
  }
  

  
  init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, note: String) {
    self.coordinate = coordinate
    self.radius = radius
    self.note = note

  }
  
  // MARK: NSCoding
  required init?(coder decoder: NSCoder) {
    let latitude = decoder.decodeDouble(forKey: GeoKey.latitude)
    let longitude = decoder.decodeDouble(forKey: GeoKey.longitude)
    coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    radius = decoder.decodeDouble(forKey: GeoKey.radius)
    note = decoder.decodeObject(forKey: GeoKey.note) as! String
    
  }
  
  func encode(with coder: NSCoder) {
    coder.encode(coordinate.latitude, forKey: GeoKey.latitude)
    coder.encode(coordinate.longitude, forKey: GeoKey.longitude)
    coder.encode(radius, forKey: GeoKey.radius)
    coder.encode(note, forKey: GeoKey.note)

  }
  
}
