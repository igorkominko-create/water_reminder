import SwiftUI
import WidgetKit

// MARK: - Design tokens (match Flutter AppTheme)

private enum WaterPalette {
    static let deep = Color(red: 0.04, green: 0.24, blue: 0.36)
    static let mid = Color(red: 0.10, green: 0.50, blue: 0.71)
    static let light = Color(red: 0.49, green: 0.83, blue: 0.99)
    static let foam = Color(red: 0.91, green: 0.96, blue: 0.99)
}

// MARK: - Home Screen (systemSmall)

struct HomeSmallWaterView: View {
    let entry: HydrationEntry

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(
                    LinearGradient(
                        colors: [WaterPalette.foam, .white],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(spacing: 10) {
                ProgressRingView(progress: entry.progress, lineWidth: 10)
                    .frame(width: 88, height: 88)
                    .overlay {
                        Text("\(entry.percent)%")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundStyle(WaterPalette.deep)
                    }

                if entry.goalReached {
                    Text("Goal reached")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(WaterPalette.mid)
                } else {
                    Text("\(entry.remainingMl) ml left")
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(WaterPalette.mid)
                }
            }
            .padding(12)
        }
        .widgetURL(URL(string: "waterreminder://home"))
    }
}

// MARK: - Lock Screen circular (accessoryCircular)

struct LockCircularWaterView: View {
    let entry: HydrationEntry

    var body: some View {
        Gauge(value: entry.progress) {
            Image(systemName: "drop.fill")
                .font(.caption2)
        } currentValueLabel: {
            Text("\(entry.percent)")
                .font(.system(size: 11, weight: .bold, design: .rounded))
        }
        .gaugeStyle(.accessoryCircular)
        .tint(WaterPalette.mid)
        .widgetURL(URL(string: "waterreminder://home"))
    }
}

// MARK: - Lock Screen rectangular (accessoryRectangular)

struct LockRectangularWaterView: View {
    let entry: HydrationEntry

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "drop.fill")
                .font(.body)
                .foregroundStyle(WaterPalette.mid)

            VStack(alignment: .leading, spacing: 2) {
                Text(entry.goalReached ? "Hydration complete" : "\(entry.remainingMl) ml to go")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .lineLimit(1)

                ProgressView(value: entry.progress)
                    .tint(WaterPalette.mid)
            }

            Spacer(minLength: 0)

            Text("\(entry.percent)%")
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(WaterPalette.deep)
        }
        .widgetURL(URL(string: "waterreminder://home"))
    }
}

// MARK: - Shared ring

struct ProgressRingView: View {
    let progress: Double
    var lineWidth: CGFloat = 12

    var body: some View {
        ZStack {
            Circle()
                .stroke(WaterPalette.foam, lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: min(1, max(0, progress)))
                .stroke(
                    AngularGradient(
                        colors: [WaterPalette.light, WaterPalette.mid],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
        }
    }
}

// MARK: - Family router

struct WaterWidgetEntryView: View {
    @Environment(\.widgetFamily) private var family
    var entry: HydrationEntry

    var body: some View {
        switch family {
        case .systemSmall:
            HomeSmallWaterView(entry: entry)
        case .accessoryCircular:
            LockCircularWaterView(entry: entry)
        case .accessoryRectangular:
            LockRectangularWaterView(entry: entry)
        default:
            HomeSmallWaterView(entry: entry)
        }
    }
}
