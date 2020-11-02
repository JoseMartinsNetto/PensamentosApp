//
//  QuoteService.swift
//  Pensamentos
//
//  Created by Jose Martins on 30/10/20.
//

import Foundation

class QuoteService {
    static let instance = QuoteService()
    private let quotes: [Quote]
    private var previousIndex: Int?
    private var currentIndex: Int?
    private var currentAuthor: String?
    private var previousAuthor: String?
    
    private init() {
        let fileURL = Bundle.main.url(forResource: "quotes", withExtension: "json")!
        let jsonData = try! Data(contentsOf: fileURL)
        
        let jsonDecoder = JSONDecoder()
        quotes = try! jsonDecoder.decode([Quote].self, from: jsonData)
    }
    
    func getRandomQuote() -> Quote {
        currentIndex = Int(arc4random_uniform(UInt32(quotes.count)))
        let quote = quotes[currentIndex!]
        
        currentAuthor = quote.author
        
        if currentIndex == previousIndex || currentAuthor == previousAuthor {
            return getRandomQuote()
        }
        
        previousIndex = currentIndex
        previousAuthor = currentAuthor
        
        return quote
    }
    
}
