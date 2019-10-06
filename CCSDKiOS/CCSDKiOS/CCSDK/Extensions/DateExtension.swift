//
//  DateExtension.swift
//

import Foundation

extension Date {
    
    // MARK: Computed Properties
    var startTime: Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day,.year,.month], from: self)
        return calendar.date(from: dateComponents)
    }
    
    var endTime: Date? {
        let calendar = Calendar.current
        if let nextDay = dateByAddingDays(daysToAdd: 1) {
            let nextDateComponents = calendar.dateComponents([.day,.year,.month], from: nextDay)
            return calendar.date(from: nextDateComponents)?.addingTimeInterval(-1)
        }
        return nil
    }
    
    var firstDayDate: Date? {
        var dateComponents = DateComponents()
        dateComponents.month = self.month
        dateComponents.year = self.year
        return Calendar.current.date(from: dateComponents)
    }
    
    var lastDayDate: Date? {
        let calendar = Calendar.current
        if let nextMonthDate = dateByAddingMonths(monthsToAdd: 1) {
            let nextMonthDateComponents = calendar.dateComponents([.year,.month], from: nextMonthDate)
            let endOfMonth = calendar.date(from: nextMonthDateComponents)?.addingTimeInterval(-1)
            return endOfMonth
        }
        return nil
    }
    
    var yesterday: Date? {
        return dateByAddingDays(daysToAdd: -1)
    }
    
    var tomorrow: Date? {
        return dateByAddingDays(daysToAdd: 1)
    }
    
    var getCurrentMillis: UInt {
        return UInt(self.timeIntervalSince1970 * 1000)
    }
    
    var getCurrentInterval: UInt {
        return UInt(self.timeIntervalSince1970)
    }
    
    // Date Components
    var year: Int {
        let calendar = NSCalendar.current
        return calendar.component(.year, from: self)
    }
    
    var month: Int {
        let calendar = NSCalendar.current
        return calendar.component(.month, from: self)
    }
    
    var day: Int {
        let calendar = NSCalendar.current
        return calendar.component(.day, from: self)
    }
    
    var lastDay: Int {
        guard let date = lastDayDate else {return 0}
        return date.day
    }
    
    var hour: Int {
        let calendar = NSCalendar.current
        return calendar.component(.hour, from: self)
    }
    
    var minute: Int {
        let calendar = NSCalendar.current
        return calendar.component(.minute, from: self)
    }
    
    var second: Int {
        let calendar = NSCalendar.current
        return calendar.component(.second, from: self)
    }
    
    var remainingMonthDays: Int {
        return self.lastDay - self.day
    }
    
    var lastMonthDate: Date? {
        let calendar = Calendar.current
        if let lastMonthDate = dateByAddingMonths(monthsToAdd: -1) {
            let lastMonthDateComponents = calendar.dateComponents([.year,.month], from: lastMonthDate)
            let startOfMonth = calendar.date(from: lastMonthDateComponents)
            return startOfMonth
        }
        return nil
    }
    
    var nextMonthDate: Date? {
        let calendar = Calendar.current
        if let nextMonthDate = dateByAddingMonths(monthsToAdd: 1) {
            let nextMonthDateComponents = calendar.dateComponents([.year,.month], from: nextMonthDate)
            let startOfMonth = calendar.date(from: nextMonthDateComponents)
            return startOfMonth
        }
        return nil
    }
    
    // MARK: Static Methods
    static func dateFromString(string: String?, format: String) -> Date? {
        if string == nil {return nil}
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = format
        return formatter.date(from: string!)
    }
    
    // MARK: Methods
    
    /// This will return the current date of last month.
    func dateByAddingDays(daysToAdd: Int) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = daysToAdd
        
        return calendar.date(byAdding: components, to: self)
    }
    
    func dateByAddingMonths(monthsToAdd: Int) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = monthsToAdd
        return calendar.date(byAdding: components, to: self)
    }
    
    
    
    // Formatting
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
    
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    func formattedDate(style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        return formatter.string(from: self)
    }
    
    func formattedDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}
