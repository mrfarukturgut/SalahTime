//
//  SettingsView.swift
//  SalahApp
//
//  Created by Faruk Turgut on 12.11.2019.
//  Copyright © 2019 Faruk Turgut. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(alignment: .trailing) {
            VStack(alignment: .trailing) {
                OptionView(label: "City")
                OptionView(label: "Method")
                OptionView(label: "Calendar")
            }
            HStack() {
                Button(action: {
                   
                }) {
                    Text("Cancel")
                }
                Button(action: {
                    
                }) {
                    Text("OK")
                }
            }
        }
        .frame(width: 350, height: 200)
        .padding()
    }
}

struct OptionView: View {
    @State var label: String
    
    
    var body: some View {
        HStack(alignment: .center){
            Text("\(self.label):").fixedSize()
            ComboBox()
                .frame(width: 200)
        }
    }
}

struct ComboBox: NSViewRepresentable {
    
    typealias NSViewType = NSComboBox
    
    func makeNSView(context: NSViewRepresentableContext<ComboBox>) -> NSComboBox {
        return NSComboBox()
    }
    
    func updateNSView(_ nsView: NSComboBox, context: NSViewRepresentableContext<ComboBox>) {
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
