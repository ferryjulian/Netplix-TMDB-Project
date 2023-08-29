//
//  ViewState+Extensions.swift
//  NetplixMiniProject
//
//  Created by Ferry Julian on 22/08/23.
//

import Foundation

extension ViewState {
    func simplify() -> SimpleViewState<T> {
        switch self {
        case is ViewState<T>.Loading:
            return .loading
        case is ViewState<T>.Success<T>:
            return .success(data: self.value!)
        case let x where x is ViewState<T>.Failed:
            return .error(error: self.error!)
        default:
            return .initiate
        }
    }
}
