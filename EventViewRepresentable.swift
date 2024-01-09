//
//  EventViewRepresentable.swift
//  Eventkit-testing
//
//  Created by dary winata nugraha djati on 26/07/23.
//

import SwiftUI
import EventKitUI

struct EventViewRepresentable: UIViewControllerRepresentable {
    @Binding var eventController : EventController
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    @Environment(\.presentationMode) var presentationMode
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let eventEditViewController = EKEventEditViewController()
        eventEditViewController.event = eventController.addEventWithUiWithoutPermission()
        eventEditViewController.eventStore = eventController.store
        eventEditViewController.editViewDelegate = context.coordinator
        
        return eventEditViewController
    }
    
    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = EKEventEditViewController
    
    class Coordinator: NSObject, EKEventEditViewDelegate {
        var parent: EventViewRepresentable

        init(_ controller: EventViewRepresentable) {
            self.parent = controller
        }

        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditView Action) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct EventViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        EventViewRepresentable(eventController: .constant(EventController()))
    }
}
