//
//  MapViewController.swift
//  MobileMapper
//
//  Created by Kristin Kamenar on 6/22/16.
//  Copyright © 2016 Kristin Kamenar. All rights reserved.
//

import UIKit

//MapKit framework
import MapKit

//add new protocol: MKMapViewDeleate

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    //create a custom annotation, contains coordinates
    let mobileMakersAnnotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        //permission to get current location while app is running in the foreground
        //permission from info.plist
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        //create annotation using coordinates of Mobile Makers
        let latitude : Double = 41.89373984
        let longitude : Double = -87.63532979
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        //set coordinates for Mobile Makers
        mobileMakersAnnotation.coordinate = coordinate
        
        //set title; viewable when you click on the red pin
        mobileMakersAnnotation.title = "Mobile Makers"
        
        //display pin on map in Mobile Makers location
        mapView.addAnnotation(mobileMakersAnnotation)
        
        //center map on Mobile Makers Location
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let center = mobileMakersAnnotation.coordinate
        
        //let center = mapView.userLocation.coordinate
        
        let region = MKCoordinateRegion(center: center, span: span)
        
        //apply region to map
        mapView.setRegion(region, animated: false)
        
        //find Grand Canyon on map
        showNewPlace("Grand Canyon")
        
    }
    
    //converts string name for address to coordinates, place on map
    func showNewPlace(address: String)
    {
        //create new GeoCoder object
        let geoCoder = CLGeocoder()
        
        //get String location as coordinates
        //geoCoder takes the string from above and returns an array of "placemarks" for 
        //different locations of string
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            for place in placemarks!
            {
                let annotation = MKPointAnnotation()
                annotation.coordinate = place.location!.coordinate
                
                //set pin title
                annotation.title = place.name
                
                //add to map
                self.mapView.addAnnotation(annotation)
            }
        }
        
    }
    
    //for every pin on the map, add an annotation
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        //customize pin and return it to the map
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        
        
        //add info button; can customize this button to do something
        let button = UIButton(type: UIButtonType.DetailDisclosure)
        
        //add button to pin view when clicked
        pin.rightCalloutAccessoryView = button
        
        //add image to pin view when clicked
        pin.detailCalloutAccessoryView = UIImageView(image: UIImage(named: "MMLogo"))
        
        //send pin back to the map
        return pin
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
