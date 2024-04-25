//
//  DateFormat.swift
//
//  Created on 8/4/24.
//

import Foundation

// MARK: - Dates management

class DateFormatManager {
    lazy var dateFormatter: DateFormatter = {
        return DateFormatter()
    }()
    
    var locale: Locale?
    
    init(locale: Locale? = Locale.current) {
        self.locale = locale
    }
    
    static let ddMMyyyy = "dd-MM-yyyy" // 01-11-2023
    static let yyyyMMdd = "yyyy-MM-dd" // 2023-11-01
    static let MMddyyyy = "MM-dd-yyyy" // 11-01-2023
    static let ddMMMMyyyy = "dd MMMM yyyy" // 01 noviembre 2023
    static let EEEEddMMMMyyyy = "EEEE, dd MMMM yyyy" // miércoles, 01 noviembre 2023
    static let MMMdyyyy = "MMM d, yyyy" // nov 1, 2023
    static let yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss" // 2023-11-01 12:30:45
    static let HHmmss = "HH:mm:ss" // 12:30:45
    static let hmma = "h:mm a" // 1:30 PM
    static let yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss" // 2023-11-10T15:30:45
    static let yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ" // 2023-11-10T15:30:45+0000
    
    func date(dateString: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
    
    func string(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func customFormattedString(date: Date, stringFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = stringFormat
        return dateFormatter.string(from: date)
    }
}
