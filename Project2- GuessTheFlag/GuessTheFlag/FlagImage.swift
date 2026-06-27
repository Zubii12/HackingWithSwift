//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Ionut Zubascu on 28.06.2026.
//

import SwiftUI

struct FlagImage: View {
    var flag: String
    
    init(_ flag: String) {
        self.flag = flag
    }
    
    var body: some View {
        Image(flag)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

