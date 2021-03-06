//
//  ErrorMessage.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation

public struct ErrorMessage: Error {

  // MARK: - Properties
  public let id: UUID
  public let title: String
  public let message: String

  // MARK: - Methods
  public init(title: String, message: String) {
    self.id = UUID()
    self.title = title
    self.message = message
  }
}

extension ErrorMessage: Equatable {
  
  public static func ==(lhs: ErrorMessage, rhs: ErrorMessage) -> Bool {
    return lhs.id == rhs.id
  }
}
