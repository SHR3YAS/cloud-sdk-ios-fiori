//
//  TableRow.swift
//  FioriIntegrationCards
//
//  Created by Ma, Xiao on 3/10/20.
//

import Foundation

public struct TableRow: Identifiable, Decodable, Hashable {
    public let columns: [TableColumn]?
    public let actions: [Action]?
    public let id: UUID = UUID()
}

extension TableRow: Placeholding {
    public func replacingPlaceholders(withValuesIn object: Any) -> TableRow {
        let _columns = columns?.map { $0.replacingPlaceholders(withValuesIn: object) }
        let _actions = actions?.map { $0.replacingPlaceholders(withValuesIn: object) }
        return TableRow(columns: _columns, actions: _actions/*, id: id*/)
    }
    
}
