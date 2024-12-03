import SwiftUI

struct GlowSphere: View {
    var position: CGPoint
    var scale: CGFloat
    var opacity: Double
    var yOffset: CGFloat

    var body: some View {
        ZStack {
            // Outer glow with animation
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.cyan.opacity(0.4),
                            Color.blue.opacity(0.2),
                            Color.clear
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )
                .frame(width: 300, height: 300)
                .blur(radius: 40)
                .scaleEffect(scale)
                .opacity(opacity)

            // Inner glow with animation
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.cyan.opacity(0.7),
                            Color.blue.opacity(0.5),
                            Color.clear
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 100
                    )
                )
                .frame(width: 200, height: 200)
                .blur(radius: 20)
                .scaleEffect(scale)
                .opacity(opacity)

            // Core circle with shadow
            Circle()
                .fill(Color.white)
                .frame(width: 120, height: 120)
                .shadow(color: Color.cyan.opacity(0.8), radius: 40, x: 0, y: 0)
                .shadow(color: Color.blue.opacity(0.6), radius: 80, x: 0, y: 0)
        }
        .offset(y: yOffset) // Apply vertical offset for undulating effect
        .position(position)
    }
}

struct GlowSphere_Previews: PreviewProvider {
    static var previews: some View {
        GlowSphere(
            position: CGPoint(x: 200, y: 200),
            scale: 1.2,
            opacity: 0.8,
            yOffset: 10
        )
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Dark background to highlight the glow
    }
}
