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
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct NJTransitWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
                case .systemSmall:
                    ZStack(alignment: .topLeading) {
                        Text("975638")
                            .font(.system(size: 13))
                            .frame(width: 50, height: 10)
                            .position(CGPoint(x: 32.0, y: 18.0))
                        Image("njtlogo")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding(EdgeInsets(top: -5, leading: 90, bottom: 0, trailing: 0))
                        Text("Stop: New Brunswick Station")
                            .font(.system(size:8))
                            .frame(width: 160, height: 30)
                            .position(CGPoint(x: 80.0, y: 70.0))
                        Text("Arrives: 2:03 PM")
                            .font(.system(size:8))
                            .frame(width: 160, height: 30)
                            .position(CGPoint(x: 80.0, y: 83.0))
                        Text("Route: 3065")
                            .font(.system(size:8))
                            .frame(width: 160, height: 30)
                            .position(CGPoint(x: 80.0, y: 58.0))
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 100, height: 3)
                            .position(CGPoint(x: 80.0, y: 120.0))
                        Circle()
                            .fill(.gray)
                            .frame(width: 10, height: 10)
                            .position(CGPoint(x: 30.0,  y: 120.0))
                        Circle()
                            .fill(.gray)
                            .frame(width: 10, height: 10)
                            .position(CGPoint(x: 130.0,  y: 120.0))
                        Circle()
                            .fill(.green)
                            .frame(width: 10, height: 10)
                            .position(CGPoint(x: 65, y: 18))
                    case systemMedium
                        ZStack(alignment: .topLeading) {
                            Text("975638")
                                .font(.system(size: 13))
                                .frame(width: 50, height: 10)
                                .position(CGPoint(x: 32.0, y: 18.0))
                            Image("njtlogo")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .padding(EdgeInsets(top: -5, leading: 90, bottom: 0, trailing: 0))
                            Text("Stop: New Brunswick Station")
                                .font(.system(size:8))
                                .frame(width: 160, height: 30)
                                .position(CGPoint(x: 80.0, y: 70.0))
                            Text("Arrives: 2:03 PM")
                                .font(.system(size:8))
                                .frame(width: 160, height: 30)
                                .position(CGPoint(x: 80.0, y: 83.0))
                            Text("Route: 3065")
                                .font(.system(size:8))
                                .frame(width: 160, height: 30)
                                .position(CGPoint(x: 80.0, y: 58.0))
                            Rectangle()
                                .fill(.gray)
                                .frame(width: 100, height: 3)
                                .position(CGPoint(x: 80.0, y: 120.0))
                            Circle()
                                .fill(.gray)
                                .frame(width: 10, height: 10)
                                .position(CGPoint(x: 30.0,  y: 120.0))
                            Circle()
                                .fill(.gray)
                                .frame(width: 10, height: 10)
                                .position(CGPoint(x: 130.0,  y: 120.0))
                            Circle()
                                .fill(.green)
                                .frame(width: 10, height: 10)
                                .position(CGPoint(x: 65, y: 18))
                }
                }
                .widgetURL(URL(string: "widget://myWidget"))
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
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
