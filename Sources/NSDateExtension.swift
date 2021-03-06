// NSDateExtension.swift
//
// Copyright (c) 2016 Tom Baranes
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

// MARK: - Format

public extension NSDate {
    
    public convenience init?(fromString string: String, format: String) {
        let formatter = DateFormatter.sharedInstance
        formatter.dateFormat = format
        guard let date = formatter.dateFromString(string) else {
            return nil
        }

        self.init(timeInterval: 0, sinceDate: date)
    }
    
    public func toString(dateStyle dateStyle: NSDateFormatterStyle = .MediumStyle, timeStyle: NSDateFormatterStyle = .MediumStyle) -> String {
        let formatter = DateFormatter.sharedInstance
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.stringFromDate(self)
    }
    
    public func toString(format format: String) -> String {
        let formatter = DateFormatter.sharedInstance
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }
    
}

// MARK: - InBetweenDate

public extension NSDate {
    
    public func daysInBetweenDate(date: NSDate) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff / 86400)
        return diff
    }
    
    public func hoursInBetweenDate(date: NSDate) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff / 3600)
        return diff
    }
    
    public func minutesInBetweenDate(date: NSDate) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff / 60)
        return diff
    }
    
    public func secondsInBetweenDate(date: NSDate) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff)
        return diff
    }
    
}

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.isEqualToDate(rhs)
}

public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

public func > (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedDescending
}
