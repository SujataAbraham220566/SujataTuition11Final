//
//  StudentController.swift
//  SujataTuition11
//
//  Created by Sujata Abraham on 06/08/23.
//
import SwiftUI
import Foundation
import CoreData

class StudentController: ObservableObject{
    let container = NSPersistentContainer(name: "DataModel2")
    init(){
        print("hi items")
        container.loadPersistentStores{desc, error in
            if let error = error{
                print("failed to laod the data \(error.localizedDescription)")
            }
        }
    }
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data item saved!!")
        } catch {
            print("We couldnt save data.")
        }
    }
    func addStudent(name: String, phone: String, email: String, photo: UIImage, doj: Date)-> UUID{
        //, context: NSManagedObjectContext){
        //let item = Items()
        let student = Students(context: container.viewContext)
        student.studentid = UUID()
        student.name = name
        student.phone = phone
        student.email = email
        student.photo = photo
        student.doj = doj
            //save(context: context)
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
        return student.studentid
    }
    func editstudent(student: Students, name: String, phone: String, email: String, photo: UIImage, doj: Date){
        //let student = Students(context: container.viewContext)
        student.name = name
        student.phone = phone
        student.email = email
        student.photo = photo
        student.doj = doj
            //save(context: context)
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
    
    func getAllStudents() -> [Students]{
        let fetchRequest: NSFetchRequest<Students> = Students.fetchRequest()
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteStudent(student: Students){
        container.viewContext.delete(student)
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func updateStudent(){
        do{
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
        }
    }
}
