//
//  SportsOrganizerModel.swift
//  SportsOrganizer
//
//  Created by Bratislav Ljubisic on 3/31/17.
//  Copyright © 2017 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import Starscream
import RxSwift
import Contacts

final class SportsOrganizerModel: SOModelProtocol {
    
    var store = CNContactStore()
    var communicationPortal: CommunicationProtocol
    var textSubject: Variable<CommMessage>
    var state: State
    private let disposeBag = DisposeBag()
    
    init() {

        communicationPortal = WebSocketCommunication(withURL: URL(string: "wss://localhost:8444/ws/app")!, shouldReconnect: true)
        self.communicationPortal.connect()
        self.state = .idle
        self.textSubject = Variable<CommMessage>(CommMessage())
        
        self.communicationPortal.messagesData.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { (message) -> Bool in
                print("Message!!!")
                return (message != Data())
            }.subscribe(onNext: { (message) in
            do {
                let appMessage = try Com_Sportorganizer_Proto_Msgs_AppMessage(serializedData: message)
                if(self.state == .validateToken) {
                    let keychainItemWrapper = KeychainItemWrapper(identifier: "sportsOrganizer", accessGroup: "sportsOrganizer")
                    keychainItemWrapper[appMessage.registrationResponse.phoneNumber] = appMessage.registrationResponse.password as String as AnyObject
                }
                self.state.changeState(from: self.state, type: appMessage.channelID, message: appMessage)
                self.textSubject.value = CommMessage(message: message, state: self.state)
            } catch(let error) {
                print(error)
            }
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }) {
            print("Something")
        }.addDisposableTo(disposeBag)
        /*
        textSubject = self.modelState.asObservable().withLatestFrom(messagesDataFiltered, resultSelector: { (state, message) -> CommMessage in
            print("Message received: \(message) and state is \(state)")
            if(state == .confirmed) {
                let appMessage =  try Com_Sportorganizer_Proto_Msgs_AppMessage(serializedData: message)
                let keychainItemWrapper = KeychainItemWrapper(identifier: "sportsOrganizer", accessGroup: "sportsOrganizer")
                keychainItemWrapper[appMessage.registrationResponse.phoneNumber] = appMessage.registrationResponse.password as AnyObject?
            }
            return CommMessage(message: message, state: state)
        })
        */
        communicationPortal.set(Model: self)
    }
    
    func collectAddressBookInfoWith(completion: ([AddressBook]) -> Bool) {
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactBirthdayKey, CNContactPhoneNumbersKey]
        let predicate: NSPredicate = NSPredicate(value: true)
        do {
            let contacts = try self.store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as [CNKeyDescriptor])
            let result: [AddressBook] = contacts.map({ (contact) -> AddressBook in
                let phoneNumbers = contact.phoneNumbers.map({ (phoneNumber) -> String in
                    return phoneNumber.value.stringValue
                })
                return AddressBook(name: contact.givenName + " " + contact.familyName, phoneNum: phoneNumbers)
            })
            _ = completion(result)
        } catch _ {
            print("Error")
        }
    }
    
    func send(message: CommMessage) {
        _ = self.communicationPortal.send(Message: message)
    }
    
    func sendRegistration(message: RegMessage) {
        _ = self.communicationPortal.sendRegistration(Message: message)
    }
    
    func sendToken(message: TokenMessage) {
        _ = self.communicationPortal.sendToken(Message: message)
    }
    
    func create(message: Message) -> Bool {
        return true
    }
    
    func changeState(from state: State, to: State) {
        
    }
    
}

