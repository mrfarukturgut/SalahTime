//
//  ContentView.swift
//  SalahApp
//
//  Created by Faruk Turgut on 11.11.2019.
//  Copyright © 2019 Faruk Turgut. All rights reserved.
//

import SwiftUI

struct PrayerView: View {
    
    @State private var timeRemaining: Int = 0
    let date = Date(timeInterval: 100000, since: Date())
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let calendar = Calendar.current
    
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Text("\(timeRemaining)")
                    .font(.system(size: 15))
                    .multilineTextAlignment(.leading)
                    .padding(5)
                    .onReceive(timer) { (timer) in
                        self.timeRemaining = self.calendar.dateComponents([.second], from: timer, to: self.date).second ?? 0
                }
                Spacer()
            }
            
        }.frame(width: 200, height: 30)
            .padding(.leading, 30)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerView()
    }
}
