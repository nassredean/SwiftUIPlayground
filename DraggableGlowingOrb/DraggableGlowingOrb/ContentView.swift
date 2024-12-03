//
//  ContentView.swift
//  DraggableGlowingOrb
//
//  Created by Nassredean Nasseri on 11/21/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var lastPoint: CGPoint = .zero
    @State private var currentPoint: CGPoint = .zero
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
            DraggableCircle()
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          ).background(Color.black)
    }
}

#Preview {
    ContentView()
}
