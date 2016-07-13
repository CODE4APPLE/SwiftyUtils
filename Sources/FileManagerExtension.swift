//
//  Created by Tom Baranes on 24/04/16.
//  Copyright © 2016 Tom Baranes. All rights reserved.
//

import Foundation

// MARk: - Getter

public extension FileManager {

    public static func document() -> NSURL {
        return self.default.document()
    }

    public func document() -> NSURL {
        #if os(OSX)
            // On OS X it is, so put files in Application Support. If we aren't running
            // in a sandbox, put it in a subdirectory based on the bundle identifier
            // to avoid accidentally sharing files between applications
            var defaultURL = FileManager.default.urlsForDirectory(.applicationSupportDirectory, inDomains: .userDomainMask).first
            if ProcessInfo.processInfo.environment["APP_SANDBOX_CONTAINER_ID"] == nil {
                var identifier = Bundle.main.bundleIdentifier
                if identifier?.length == 0 {
                    identifier = Bundle.main.executableURL?.lastPathComponent
                }
                defaultURL = try! defaultURL?.appendingPathComponent(identifier ?? "", isDirectory: true)
            }
            return defaultURL ?? NSURL()
        #else
            // On iOS the Documents directory isn't user-visible, so put files there
            return FileManager.default.urlsForDirectory(.documentDirectory, inDomains: .userDomainMask)[0]
        #endif
    }

}

// MARK: - Create

public extension FileManager {

    public static func createDirectory(at directoryURL: NSURL) throws {
        return try self.default.createDirectory(at: directoryURL)
    }

    public func createDirectory(at directoryURL: NSURL) throws {
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        let fileExists = fileManager.fileExists(atPath: directoryURL.path!, isDirectory: &isDir)
        if fileExists == false || isDir {
            try fileManager.createDirectory(at: directoryURL as URL, withIntermediateDirectories: true, attributes: nil)
        }
    }

}

// MARK: - Delete

public extension FileManager {

    public static func deleteAllTemporaryFiles(path: String) throws {
        return try self.default.deleteAllTemporaryFiles()
    }

    public func deleteAllTemporaryFiles() throws {
        let contents = try contentsOfDirectory(atPath: NSTemporaryDirectory())
        for file in contents {
            try removeItem(atPath: NSTemporaryDirectory() + file)
        }
    }

    public static func deleteAllDocumentFiles(path: String) throws {
        return try self.default.deleteAllDocumentFiles()
    }

    public func deleteAllDocumentFiles() throws {
        let documentPath = document().path ?? ""
        let contents = try contentsOfDirectory(atPath: documentPath)
        for file in contents {
            try removeItem(atPath: documentPath + file)
        }
    }
}
