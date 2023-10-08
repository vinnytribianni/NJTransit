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

    let travelFromOptions = ["New York Penn Station", "Secaucus Upper Lvl", "Newark Penn Station", "Newark Airport", "Metropark", "Metuchen", "Edison", "New Brunswick", "Princeton Junction", "Hamilton", "Trenton"]
    let travelToOptions = ["New York Penn Station", "Secaucus Upper Lvl", "Newark Penn Station", "Newark Airport", "Metropark", "Metuchen", "Edison", "New Brunswick", "Princeton Junction", "Hamilton", "Trenton"]
    let travelStart = ["12:00 PM", "1:00PM", "2:00PM", "3:00PM", "4:00PM", "5:00PM"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("NJ Transit Form")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                
                Text("Please provide the following details. Widget will update automatically.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(EdgeInsets(top: -1, leading: 10, bottom: 0, trailing: 0))
                
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
                .padding()
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

