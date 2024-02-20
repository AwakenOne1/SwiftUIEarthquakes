//
//  QuakeWidgets.swift
//  QuakeWidgets
//
//  Created by Alexey Dubovik on 14.02.24.
//

import WidgetKit
import SwiftUI


class Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> QuakeEntry {
        QuakeEntry(date: Date.now, quake: Quake(magnitude: 0.8,
                                                            place: "Shakey Acres",
                                                            time: Date(timeIntervalSinceNow: -1000),
                                                            code: "nc73649170",
                                                            detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!))
    }

    func getSnapshot(in context: Context, completion: @escaping (QuakeEntry) -> ()) {
        let entry = QuakeEntry(date: Date.now, quake: Quake(magnitude: 0.8,
                                                            place: "Shakey Acres",
                                                            time: Date(timeIntervalSinceNow: -1000),
                                                            code: "nc73649170",
                                                            detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            var entries: [QuakeEntry] = []
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                do {
                    var client = QuakeClient()
                    let entryQuake = try await client.quakes[0]
                    let entry = QuakeEntry(date: entryDate, quake: entryQuake)
                    entries.append(entry)
                } catch {
                    print("error")
                }
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct QuakeEntry: TimelineEntry {
    var date: Date
    var quake: Quake
}

struct QuakeWidgetsEntryView : View {
    var entry: Provider.Entry
    var body: some View {
        VStack {
            QuakeRow(quake: entry.quake)
        }
    }
}

struct QuakeWidgets: Widget {
    
    let kind: String = "QuakeWidgets"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                QuakeWidgetsEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                QuakeWidgetsEntryView(entry: entry)
                    .background()
            }
        }
        .configurationDisplayName("Quakes widget")
        .description("Widget for quakes extension")
    }
}

#Preview(as: .systemMedium) {
    QuakeWidgets()
} timeline: {
    QuakeEntry(date: Date.now, quake: Quake(magnitude: 0.8,
                                            place: "Shakey Acres",
                                            time: Date(timeIntervalSinceNow: -1000),
                                            code: "nc73649170",
                                            detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc73649170.geojson")!))
    QuakeEntry(date: Date.now, quake: Quake(magnitude: 2.2,
                                            place: "Rumble Alley",
                                            time: Date(timeIntervalSinceNow: -5000),
                                            code: "hv72783692",
                                            detail: URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/hv72783692")!))
}
