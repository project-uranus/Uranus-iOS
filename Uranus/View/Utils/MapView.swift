//
//  MapView.swift
//  Uranus
//
//  Created by Yuchen Cheng on 2019/12/4.
//  Copyright © 2019 Yuchen Cheng. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @State var originAirport: Airport
    @State var destinationAirport: Airport

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        let coordinate = CLLocationCoordinate2D.average(origin: self.originAirport.coordinate, destination: self.destinationAirport.coordinate)
        let span = MKCoordinateSpan(latitudeDelta: 16.0, longitudeDelta: 16.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.addAnnotations([AirportAnnotation(airport: self.originAirport), AirportAnnotation(airport: self.destinationAirport)])
        uiView.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(
            originAirport: Airport(IATA: "PVG", name: "上海浦东国际机场", position: "上海", coordinate: .init(latitude: 31.143333, longitude: 121.805278)),
            destinationAirport: Airport(IATA: "NGO", name: "中部国际机场", position: "名古屋", coordinate: .init(latitude: 34.858333, longitude: 136.805278))
        )
    }
}
