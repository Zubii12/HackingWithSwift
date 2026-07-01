//
//  ContentView.swift
//  Moonshot
//
//  Created by Ionut Zubascu on 01.07.2026.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showGridLayout = true

    var body: some View {
        NavigationStack {
            ScrollView {
                if showGridLayout {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(action: { showGridLayout.toggle() }) {
                    Image(
                        systemName: showGridLayout
                            ? "list.bullet" : "square.grid.2x2"
                    )
                }
            }
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
            .navigationDestination(for: Astronaut.self) { astronaut in
                AstronautView(astronaut: astronaut)
            }
        }
    }
}

#Preview {
    ContentView()
}
