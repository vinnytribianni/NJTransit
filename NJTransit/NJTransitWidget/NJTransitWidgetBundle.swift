//
//  NJTransitWidgetBundle.swift
//  NJTransitWidget
//
//  Created by Vincent Tribianni on 10/7/23.
//

import WidgetKit
import SwiftUI

@main
struct NJTransitWidgetBundle: WidgetBundle {
    var body: some Widget {
        NJTransitWidgetLiveActivity()
        NJTransitWidget()
    }
}
