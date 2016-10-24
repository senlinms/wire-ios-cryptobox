//
// Wire
// Copyright (C) 2016 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//


import Foundation

extension EncryptionSession {

    /// Logs the content of the session file. 
    /// To be used for debugging purposes.
    func dumpSessionContent(function: String = #function) {
        zmLog.ifDebug {
            let path = self.cryptoboxPath.appendingPathComponent("sessions").appendingPathComponent(self.id)
            guard let data = try? Data(contentsOf: path) else {
                zmLog.debug("Failed to dump content of session \(self.id)")
                return
            }
            zmLog.debug("Content of session \(self.id) [\(function)]: \(data.base64Dump) >>")
        }
    }
}

extension Data {
    
    /// Returns a human-readable base 64 encoded version split over multiple lines
    var base64Dump : String {
        return "\n--START--\n" +
        self.base64EncodedString().split(bySize: 40).joined(separator: "\n") +
        "\n--END--"
    }
}

extension String {
    
    /// Splits a string in array of strings each with a length not exceding the given size
    func split(bySize size: Int) -> [String] {
        var original = self
        var finalArray : [String] = []
        while !original.isEmpty {
            let chunkLength = min(size, original.characters.count)
            let chunkIndex = original.index(original.startIndex, offsetBy: chunkLength)
            finalArray.append(original.substring(to: chunkIndex))
            original = original.substring(from: chunkIndex)
        }
        return finalArray
    }
}
