//
//  MissionView.swift
//  Moonshot
//
//  Created by Ionut Zubascu on 01.07.2026.
//

import SwiftUI

struct MissionView: View {
    var mission: Mission
    var astronauts: [String: Astronaut]

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)

                HorizontalDivider()

                Text(mission.formattedLaunchDateLong)

                HorizontalDivider()

                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)

                    Text(mission.description)
                }
                .padding(.horizontal)

                HorizontalDivider()
                
                Text("Crew")
                    .font(.title.bold())
                    .padding(.bottom, 5)

                AstronautsHorizontalListView(
                    mission: mission,
                    astronauts: astronauts
                )
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
