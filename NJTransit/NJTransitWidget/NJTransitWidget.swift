//
//  NJTransitWidget.swift
//  NJTransitWidget
//
//  Created by Vincent Tribianni on 10/7/23.
//
import WidgetKit
import SwiftUI
import Intents


struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            _ = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            entries.append(getEntry())
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func getEntry() -> SimpleEntry {
        let userDefaults = AppGroupUserDefaults.shared
        let travelFrom = userDefaults.string(forKey: AppGroupUserDefaults.StorageKey.travelFrom)
        let travelTo = userDefaults.string(forKey: AppGroupUserDefaults.StorageKey.travelTo)
        let boardingTime = userDefaults.string(forKey: AppGroupUserDefaults.StorageKey.boardingTime)
        return SimpleEntry(
            date: Date(),
            configuration: ConfigurationIntent(),
            travelFrom: travelFrom,
            travelTo: travelTo,
            boardingTime: boardingTime
        )
    }
}


struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    
    var travelFrom: String?
    var travelTo: String?
    var boardingTime: String?
}

struct NJTransitWidgetEntryView : View {
    
    var entry: Provider.Entry
    
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            Group {
                Text("975638")
                    .font(.system(size: 19))
                    .frame(width: 80, height: 20)
                    .position(CGPoint(x: 105.0, y: 23.0))
                Image("njtlogo")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(EdgeInsets(top: -1, leading: 20, bottom: 0, trailing: 0))
            }
            Group {
                Text("6:00PM")
                    .font(.system(size:15))
                    .frame(width: 160, height: 30)
                    .position(CGPoint(x: 290.0, y: 140.0))
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.green)
                    .frame(width: 90, height: 25)
                    .position(CGPoint(x: 295, y: 25))
                Text("ON TIME")
                    .font(
                        .system(size:19)
                        .weight(.bold)
                    )
                    .foregroundColor(.white)
                    .position(x: 295, y: 25)
            }
                Group {
                    Image("arrow")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .position(CGPoint(x: 180, y: 100))
                    if let travelFrom = entry.travelFrom {
                    Text(travelFrom)
                        .font(.system(size:20))
                        .multilineTextAlignment(.center)
                        .frame(width: 120, height: 100)
                        .position(CGPoint(x: 70.0, y: 90.0))
                    }
                    if let travelTo = entry.travelTo {
                    Text(travelTo)
                        .font(.system(size:20))
                        .multilineTextAlignment(.center)
                        .frame(width: 100, height: 100)
                        .position(CGPoint(x: 290.0, y: 90.0))
                    }
                    if let boardingTime = entry.boardingTime {
                    Text(boardingTime)
                        .font(.system(size:15))
                        .frame(width: 120, height: 30)
                        .position(CGPoint(x: 70.0, y: 140.0))
                    }
                    
                }
            }
            .widgetURL(URL(string: "widget://myWidget"))
        }
    }
    
    struct NJTransitWidget: Widget {
        let kind: String = "NJTransitWidget"
        
        var body: some WidgetConfiguration {
            IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
                NJTransitWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("My Widget")
            .description("This is an example widget.")
        }
    }
    
    struct NJTransitWidget_Previews: PreviewProvider {
        static var previews: some View {
            NJTransitWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }

