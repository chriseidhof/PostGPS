//
//  AppDelegate.swift
//  PostGPS
//
//  Created by Chris Eidhof on 19/10/14.
//  Copyright (c) 2014 Chris Eidhof. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    
    var locationManager: CLLocationManager!


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if !CLLocationManager.locationServicesEnabled() {
            println("No location services")
        }
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.startMonitoringSignificantLocationChanges()
        println("\(locationManager.location)")
        return true
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation location: CLLocation!, fromLocation oldLocation: CLLocation!) {
        
        let data : [String:AnyObject] = [
            "latitude": location.coordinate.latitude,
            "longitude": location.coordinate.longitude,
            "timestamp": location.timestamp.timeIntervalSince1970,
            "altitude": location.altitude,
            "horizontal_accuracy": location.horizontalAccuracy,
            "vertical_accuracy": location.verticalAccuracy,
            "speed": location.speed,
            "course": location.course,
        ]
        let body = "&".join(map(data) { (key,value) in "\(key)=\(value)" })
        let url = YOUR_URL_HERE 
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, respons, error) -> Void in
            println("sent \(error)")
        }).resume()
    }
    
}

