//
//  FileTools.swift
//  ChartsSample-1
//
//  Created by Anthony Da cruz on 26/09/2022.
//

import Foundation

public class FileReader {
    static func getContent(ofFileName fileName:String, withExtension type: String = "json") -> String? {
        let bundle = Bundle.main
        
        guard let pathOfFile = bundle.path(forResource: fileName, ofType: type) else {
            print("[FILE][ERROR] Cannot find file for path : \(fileName).\(type)")
            return nil
        }
        
        guard let contentString = try? String(contentsOfFile: pathOfFile, encoding: String.Encoding.utf8) else {
            print("[FILE][ERROR] Cannot read file : \(fileName).\(type)")
            return nil
        }
        
        return contentString
        
    }
}
