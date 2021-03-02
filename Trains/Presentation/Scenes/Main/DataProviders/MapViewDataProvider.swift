//
//  MapViewDataProvider.swift
//  Trains
//
//  Created by Dimitar Grudev on 2.03.21.
//

import MapKit

final class MapViewDataProvider: NSObject {
    
    private var mapView: MKMapView!
    
    init(_ mapView: MKMapView) {
        super.init()
        self.mapView = mapView
        setup()
    }
    
}

private extension MapViewDataProvider {
    
    func setup() {
        mapView.delegate = self
        mapView.userTrackingMode = .none
    }
    
}

extension MapViewDataProvider: MKMapViewDelegate {
    
    
    
}
