//
//  StorageManager.swift
//  Todoey
//
//  Created by Irina Moiseeva on 23.03.2021.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private let defaults = UserDefaults.standard
    private let taskKey = "tasksKey"
    
    private init() {}
    
    func save(task: Task) {
        var tasks = fetchTasks()
        tasks.append(task)
        guard let data = try? JSONEncoder().encode(tasks) else { return }
        defaults.setValue(data, forKey: taskKey)
    }
    
    func fetchTasks() -> [Task] {
        
        guard let data = defaults.object(forKey: taskKey) as? Data else {return [] }
        guard let tasks = try? JSONDecoder().decode([Task].self, from: data) else { return []}
        return tasks
    }
    
    func deleteTask(at index: Int) {
        var tasks = fetchTasks()
        tasks.remove(at: index)
        guard let data = try? JSONEncoder().encode(tasks) else { return }
        defaults.setValue(data, forKey: taskKey)
    }
    
}
