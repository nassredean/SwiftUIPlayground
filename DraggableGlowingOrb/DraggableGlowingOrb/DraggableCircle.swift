//
//  DraggableCircle.swift
//  GuitarZen
//
//  Created by Nassredean Nasseri on 11/21/24.
//

import SwiftUI

struct DraggableCircle: View {
    @State private var lastPoint: CGPoint = .zero
    @State private var currentPoint: CGPoint = .zero
    @State private var timer: Timer? = nil

    @State private var phase: Double = 0 // Phase for animating the undulation

    private let size: CGFloat

    init(size: CGFloat = 120) {
        self.size = size
    }

    var body: some View {
        TimelineView(.animation) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            let yOffset = calculateYOffset(for: time)

            ZStack {
                GlowSphere(
                    position: CGPoint(x: currentPoint.x, y: currentPoint.y + yOffset),
                    scale: 1.2 + 0.1 * sin(time * .pi * 2 / 1.4),
                    opacity: 0.8 + 0.1 * cos(time * .pi * 2 / 1.4),
                    yOffset: yOffset
                )
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        lastPoint = value.location
                        ensureTimerIsRunning()
                    }
                    .onEnded { _ in
                        timer?.invalidate()
                        withAnimation(.easeOut(duration: 0.3)) {
                            currentPoint = lastPoint
                        }
                    }
            )
            .onAppear {
                initializePosition()
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }

    private func initializePosition() {
        currentPoint = CGPoint(x: UIScreen.main.bounds.width / 2,
                                y: UIScreen.main.bounds.height / 2)
        lastPoint = currentPoint
        ensureTimerIsRunning()
    }

    private func calculateYOffset(for time: TimeInterval) -> CGFloat {
        return 4 * sin(time * .pi * 2 / 1.4)
    }

    private func interpolatePosition() {
        let distance = hypot(lastPoint.x - currentPoint.x, lastPoint.y - currentPoint.y)
        if distance < 0.1 {
            timer?.invalidate()
            timer = nil
        } else {
            withAnimation(.linear(duration: 0.016)) {
                currentPoint = CGPoint(
                    x: currentPoint.x + (lastPoint.x - currentPoint.x) * 0.07,
                    y: currentPoint.y + (lastPoint.y - currentPoint.y) * 0.07
                )
            }
        }
    }

    private func ensureTimerIsRunning() {
        if timer == nil || !(timer?.isValid ?? false) {
            timer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
                interpolatePosition()
            }
        }
    }
}



struct DraggableCircle_Previews: PreviewProvider {
    static var previews: some View {
        DraggableCircle()
            .background(Color.black.edgesIgnoringSafeArea(.all)) // Dark background to highlight the glow
    }
}
