//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by vili on 15.10.2025.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherLiveActivity()
    }
}
