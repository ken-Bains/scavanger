//
//  cancelDelegate.swift
//  Geotify
//
//  Created by ken bains on 1/19/17.
//  Copyright © 2017 Ken Toh. All rights reserved.
//

import UIKit

protocol cancelDelegate: class {
  func cancelButtonPressed(by controller: UIViewController, where location: String)
}
