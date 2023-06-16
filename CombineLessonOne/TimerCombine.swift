//
//  TimerCombine.swift
//  CombineLessonOne
//
//  Created by David Malicke on 6/11/23.
//

import SwiftUI

struct TimerCombine: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    
    @State var count: Int = 10
    @State var finishedText: String? = nil
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    @State var animationCount: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [.black, .blue]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            VStack {
                Text(dateFormatter.string(from: currentDate))
                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                Text(finishedText ?? "\(count)")
                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                Text(timeRemaining)
                    .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                HStack(spacing: 15) {
                    Circle()
                        .offset(y: animationCount == 1 ? -20 : 0)
                    Circle()
                        .offset(y: animationCount == 2 ? -20 : 0)
                    Circle()
                        .offset(y: animationCount == 3 ? -20 : 0)
                }
                .foregroundColor(.white)
                .frame(width: 100)
            }
            
        }
        .onReceive(timer, perform: { value in
            currentDate = value
            updateTimeRemaining()
        })
        .onReceive(timer, perform: { _ in
            if count <= 1 {
                finishedText = "Wow!"
            } else {
                count -= 1
            }
        })
        .onReceive(timer, perform: { _ in
            withAnimation(.easeInOut(duration: 1.0)) {
                animationCount = animationCount == 3 ? 0 : count + 1
            }
        })
    }
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour): \(minute) : \(second)"
    }
}

#Preview {
    TimerCombine()
}
