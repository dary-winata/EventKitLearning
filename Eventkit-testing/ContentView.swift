//
//  ContentView.swift
//  Eventkit-testing
//
//  Created by dary winata nugraha djati on 25/07/23.
//

import SwiftUI

struct ContentView: View {
    @State var showEditCalendar : Bool = false
    @State var eventController = EventController()   
    
    var body: some View {
        VStack {
            Button {
                showEditCalendar.toggle()
            } label: {
                Text("Add With EvenkitUI")
            }
            
            Button {
                eventController.addEventWithoutUi()
            } label: {
                Text("Add Without EvenkitUi")
            }
        }.sheet(isPresented: $showEditCalendar, content: {
            EventViewRepresentable(eventController: $eventController)
        })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
