//
//  CoreDataManager.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MoviesDataModel") // mismo nombre que el .xcdatamodeld
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("❌ Error cargando Core Data: \(error.localizedDescription)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("❌ Error al guardar contexto: \(error.localizedDescription)")
            }
        }
    }
}
