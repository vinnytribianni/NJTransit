//
//  ContentView.swift
//  NJTransit
//
//  Created by Vincent Tribianni on 10/7/23.
//

import SwiftUI
import WidgetKit



struct ContentView: View {
    // Need these 3 string variables to be passed into the widget
    @AppStorage(AppGroupUserDefaults.StorageKey.travelFrom) 
    var appStorageTravelFrom = ""
    
    @AppStorage(AppGroupUserDefaults.StorageKey.travelTo)
    var appStorageTravelTo = ""
    
    @AppStorage(AppGroupUserDefaults.StorageKey.boardingTime)
    var appStorageBoardingTime = ""
    
    @State private var selectedTravelFrom = ""
    @State private var selectedTravelTo = ""
    @State private var selectedBoardingTime = ""

    let travelFromOptions = ["", "New York Penn Station", "Secaucus Upper Lvl", "Newark Penn Station", "Newark Airport", "Metropark", "Metuchen", "Edison", "New Brunswick", "Princeton Junction", "Hamilton", "Trenton"]
    let travelToOptions = ["", "New York Penn Station", "Secaucus Upper Lvl", "Newark Penn Station", "Newark Airport", "Metropark", "Metuchen", "Edison", "New Brunswick", "Princeton Junction", "Hamilton", "Trenton"]
    let travelStart = ["", "12:00 PM", "1:00PM", "2:00PM", "3:00PM", "4:00PM", "5:00PM"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Image("njtlogo")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .position(CGPoint(x: 212.0, y: 100.0))
                Text("NJ Transit Form")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .position(CGPoint(x: 212.0, y: 0.0))
                Text("Please provide the following details. Widget will update automatically.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .position(CGPoint(x: 212.0, y: -160.0))
                Form {
                    Section(header: Text("Travel Information")) {
                        Picker("Travel From: ", selection: $selectedTravelFrom) {
                            ForEach(travelFromOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        Picker("Travel To: ", selection: $selectedTravelTo) {
                            ForEach(travelToOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        Picker("Boarding Time: ", selection: $selectedBoardingTime) {
                            ForEach(travelStart, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                .position(CGPoint(x: 212.0, y: -230))
                .navigationBarTitle("", displayMode: .inline)
                .onChange(of: selectedTravelFrom, perform: updateWidget)
                .onChange(of: selectedTravelTo, perform: updateWidget)
                .onChange(of: selectedBoardingTime, perform: updateWidget)
            }
        }
    }
    
    func updateWidget(_ input: String) {
        appStorageTravelTo = selectedTravelTo
        appStorageTravelFrom = selectedTravelFrom
        appStorageBoardingTime = selectedBoardingTime
        WidgetCenter.shared.reloadAllTimelines()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

