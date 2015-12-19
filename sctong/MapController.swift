//
//  MapController.swift
//  sctong
//
//  Created by   himi on 15/12/19.
//  Copyright © 2015年 mmmm. All rights reserved.
//

import UIKit

class MapController: UIViewController,BMKMapViewDelegate,BMKLocationServiceDelegate {
    
    var mapView:BMKMapView!
    var locationService:BMKLocationService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = BMKMapView(frame: self.view.frame)
        mapView.showsUserLocation = true
        //地图缩放级别
        mapView.zoomLevel=16;
        
        locationService = BMKLocationService()
        locationService.delegate = self
        locationService.startUserLocationService()
        
        self.view = mapView
    }
    
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        mapView.updateLocationData(userLocation)
    }
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        mapView.updateLocationData(userLocation)
        mapView.setCenterCoordinate(userLocation.location.coordinate, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mapView?.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.showsUserLocation = false
        mapView?.delegate = nil
    }
    
}
