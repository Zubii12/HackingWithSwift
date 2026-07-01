//
//  AstronautsHorizontalListView.swift
//  Moonshot
//
//  Created by Ionut Zubascu on 01.07.2026.
//

import SwiftUI

struct AstronautsHorizontalListView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let crew: [CrewMember]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink(value: crewMember.astronaut) {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(
                                            .white,
                                            lineWidth: 1
                                        )
                                )

                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(
                                        .white.opacity(0.5)
                                    )
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}
