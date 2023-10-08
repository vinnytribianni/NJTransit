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
    var body: some View {
        ZStack(alignment: .topLeading) {
            Group {
                Text("975638")
                    .font(.system(size: 13))
                    .frame(width: 60, height: 20)
                    .position(CGPoint(x: 75.0, y: 18.0))
                Image("njtlogo")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(EdgeInsets(top: -1, leading: 10, bottom: 0, trailing: 0))
                Text("Destination: New Brunswick Station")
                    .font(.system(size:15))
                    .frame(width: 250, height: 30)
                    .position(CGPoint(x: 180.0, y: 50.0))
                Text("Arrives: 2:03 PM")
                    .font(.system(size:14))
                    .frame(width: 160, height: 30)
                    .position(CGPoint(x: 180.0, y: 70.0))
            }
            Group {
                Text("3:55 PM")
                    .font(.system(size:10))
                    .frame(width: 160, height: 30)
                    .position(CGPoint(x: 30.0, y: 135.0))
                Rectangle()
                    .fill(.gray)
                    .frame(width: 300, height: 3)
                    .position(CGPoint(x: 180.0, y: 120.0))
                Circle()
                    .fill(.gray)
                    .frame(width: 10, height: 10)
                    .position(CGPoint(x: 27.0,  y: 120.0))
                Circle()
                    .fill(.gray)
                    .frame(width: 10, height: 10)
                    .position(CGPoint(x: 330.0,  y: 120.0))
                RoundedRectangle(cornerRadius: 20)
                    .fill(.green)
                    .frame(width: 60, height: 18)
                    .position(CGPoint(x: 320, y: 18))
                Text("ON TIME")
                    .font(
                        .system(size:10)
                        .weight(.bold)
                    )
                    .foregroundColor(.white)
                    .position(x: 320, y: 18)
            }
            Group {
                Text("need variable here")
                    .font(.system(size:8))
                    .multilineTextAlignment(.center)
                    .frame(width: 60, height: 30)
                    .position(CGPoint(x: 26.0, y: 102.0))
                Text("need variable here")
                    .font(.system(size:8))
                    .multilineTextAlignment(.center)
                    .frame(width: 50, height: 30)
                    .position(CGPoint(x: 330.0, y: 98.0))
                Text("need variable here")
                    .font(.system(size:10))
                    .frame(width: 160, height: 30)
                    .position(CGPoint(x: 330.0, y: 135.0))
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
