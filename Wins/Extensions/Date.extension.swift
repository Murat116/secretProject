//
//  Date.extension.swift
//  Wins
//
//  Created by Мурат Камалов on 02.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    static let failDate = Date(timeIntervalSince1970: 0 )
    
    
    // --------------------------------------
    
    static var now:Date {
        return Date().addingSecounds( TimeZone.current.secondsFromGMT() )
    }
    
    
    static let iso8601Calendar = Calendar.iso8601()
    // --------------------------------------
    
    static var ts:Int64 { return Date().ts }

    // --------------------------------------

    static var srvDeltaTS:Int64 = 0
    
    // ------------------------------------------------------------------------------------------------
    
    static var srvTS:Int64  { return Int64( Int64( Date().timeIntervalSince1970 * 1000 ) + Date.srvDeltaTS ) }
    var srvTS:Int64  { return Int64( Int64( self.timeIntervalSince1970 * 1000 ) + Date.srvDeltaTS ) }

    // ------------------------------------------------------------------------------------------------
    
    static var srvTsRounded:Int64  { return Int64( floor( Double( Date.srvTS ) / 1000 ) * 1000 ) }
    
    // ISO8601 Parser --------------------------------------------------------------------------------
    
    private static var ISO8601components:DateComponents = DateComponents( timeZone: TimeZone.current )
    
    private static let ISO8601year = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    private static let ISO8601month = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    private static let ISO8601day = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    private static let ISO8601hour = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    private static let ISO8601minute = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    private static let ISO8601second = UnsafeMutablePointer<Float>.allocate(capacity: 1)
    
    // ------------------------------------------------------------------------------------------------
    
    init(_ val: Any? ){
        guard let value = val else { self = Date.failDate; return }
        
        switch value {
        case let wrapedValue as Date:
            self = wrapedValue
            
        case let wrapedValue as TimeInterval:
            self = Date( timeIntervalSince1970: wrapedValue )
            
        case let wrapedValue as Int:
            self = Date( wrapedValue )
            
        case let wrapedValue as String:
            self = Date( wrapedValue )
            
        case let wrapedValue as [String:Any]:
            self = Date( wrapedValue )
            
            
        default:
            self = Date.failDate
        }
        
    }
    
    // ------------------------------------------------------------------------------------------------
    
    init(_ dict: [String:Any] ){
        
        if let ts = dict["ts"] as? Int {
            self = Date( ts )
            return
        }
        
        if let date = dict["dt"] as? Date {
            self = date
            return
        }
        
        if let isoStr = dict["dt"] as? String {
            self = Date( isoStr )
            return
        }
        
        self = Date.failDate
    }
    
    // ------------------------------------------------------------------------------------------------
    
    init(_ ts: Int) {
        self = Date( Int64(ts) )
    }
    
    init(_ ts:Int64 ){
        
        if( ts >= 10000000 && ts < 99999999 ){ // KEY
            let key = ts
            let year    = Int( key / 1_0000 )
            let month   = Int( ( key % 1_0000 ) / 1_00 )
            let day     = Int( ( key % 1_0000  ) % 1_00 )
            
            var components:DateComponents?
            
            if month != 0 {
                components = DateComponents( year:year, month:month, day:day )
            }
            else{
                components = DateComponents( year:year, weekday:Date.iso8601Calendar.firstWeekday, weekOfYear:day )
            }
            
            guard
                components != nil,
                let date = Date.iso8601Calendar.date(from: components! )
                else {self = Date.failDate; return}
            
            self = date
            return
        }
        if( Int64(ts) > 90_000_000_000 ){    // timestamp in milisecounds
            self =  Date(timeIntervalSince1970: TimeInterval(ts) / 1000 )
            return
        }
        
        // timestamp in secounds
        self =  Date( timeIntervalSince1970: TimeInterval( ts ) )
        
    }
    
    init(_ dayOffset:Int, in dayKey:Int ) {
        self = Date(dayKey).addingTimeInterval(TimeInterval(dayOffset))
    }
        
    // ------------------------------------------------------------------------------------------------
    
    
    var ts:Int64  {
        return Int64( self.timeIntervalSince1970 * 1000 )
    }
    

    
    // --------------------------------------------
    
    func addingDays(_ days:Int ) -> Date {
        return self.addingTimeInterval( TimeInterval( days * 86_400 ) )
    }
    
    func addingMinutes(_ min:Int ) -> Date {
        return self.addingTimeInterval( TimeInterval( min * 60 ) )
    }
    
    func addingSecounds(_ secs:Int ) -> Date {
        return self.addingTimeInterval( TimeInterval( secs ) )
    }
    
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var string: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd:MM:yyyy"
        let string = formatter.string(from: self)
        return string
    }
    
}

extension Calendar {
    static func iso8601() -> Calendar {
        var cal = Calendar( identifier: .iso8601 )
        cal.timeZone    = TimeZone(secondsFromGMT: 0)!
        cal.locale      = Locale(identifier: "en_US_POSIX")
        return cal
    }
    
}
