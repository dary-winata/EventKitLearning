//
//  EventController.swift
//  Eventkit-testing
//
//  Created by dary winata nugraha djati on 26/07/23.
//

import EventKit

class EventController {
    let store = EKEventStore()
    var authorized = false
    
    required init() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized :
            authorized = true
        case .notDetermined:
            store.requestAccess(to: .event) { granted, err in
                if granted {
                    self.authorized.toggle()
                }
            }
        case .denied:
            print("please accept the test")
        default :
            print("error")
        }
    }
    
    func addEventWithoutUi() {
        let event = EKEvent(eventStore: store)
        event.calendar = store.defaultCalendarForNewEvents
        event.title = "Testing Event With UI"
        let startDateComponent = DateComponents(year: 2023, month: 7, day: 27, hour: 15)
        let startDate = Calendar.current.date(from: startDateComponent)
        event.startDate = startDate
        event.endDate = Calendar.current.date(byAdding: .hour, value: 2,to: startDate!)
        event.timeZone = TimeZone(identifier: "Asia/Jakarta")
        event.location = "CitraLand CBD Boulevard, Made, Kec. Sambikerep, Surabaya, Jawa Timur 60219"
        event.notes = "kerja woy"
        
        
        
        do {
            try self.store.save(event, span: .thisEvent)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addEventWithUiWithoutPermission() -> EKEvent {
        
        let event = EKEvent(eventStore: store)
        event.title = "Testing Event With UI"
        let startDateComponent = DateComponents(year: 2023, month: 7, day: 27, hour: 15)
        let startDate = Calendar.current.date(from: startDateComponent)
        event.startDate = startDate
        event.endDate = Calendar.current.date(byAdding: .hour, value: 2,to: startDate!)
        event.timeZone = TimeZone(identifier: "Asia/Jakarta")
        event.location = "CitraLand CBD Boulevard, Made, Kec. Sambikerep, Surabaya, Jawa Timur 60219"
        event.notes = "kerja woy"
        
        return event
    }
}
