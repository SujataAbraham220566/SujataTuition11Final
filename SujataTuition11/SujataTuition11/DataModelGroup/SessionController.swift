//
//  SessionController.swift
//  SujataTuition11
//
//  Created by Sujata Abraham on 06/08/23.
//

import SwiftUI
import Foundation
import CoreData

class SessionController: ObservableObject{
    let container = NSPersistentContainer(name: "DataModel2")
    init(){
        print("hi session")
        container.loadPersistentStores{desc, error in
            print("mid session")
            if let error = error{
                print("failed to load the data \(error.localizedDescription)")
            }
        }
        print("end session")
    }
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data item saved!!")
        } catch {
            print("We couldnt save data.")
        }
    }
    func addSession(grade: String, subject: String, sessionno: Int16, studentid: UUID){
        //, context: NSManagedObjectContext){
        //let item = Items()
        let session = Sessions(context: container.viewContext)
        session.sessionid = UUID()
        session.grade = grade
        session.subject = subject
        session.sessionno = sessionno
        session.studentid = studentid
            //save(context: context)
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
    func editSession(session: Sessions, grade: String, subject: String, sessionno: Int16, studentid: UUID){
        //let session = Sessions(context: container.viewContext)
        session.grade = grade
        session.subject = subject
        session.sessionno = sessionno
        //session.studentid = studentid
            //save(context: context)
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
    
    func getAllSessions() -> [Sessions]{
        let fetchRequest: NSFetchRequest<Sessions> = Sessions.fetchRequest()
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteSession(session: Sessions){
        container.viewContext.delete(session)
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func updateSession(){
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
}
