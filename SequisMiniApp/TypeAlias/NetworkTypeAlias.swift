//
//  NetworkTypeAlias.swift
//  SequisMiniApp
//
//  Created by Hashfi Alfian Ciyuda on 3/10/26.
//

import Foundation

public typealias NetworkSuccessHandler = (URLResponse?, Data?) -> Void
public typealias NetworkFailureHandler = (Error?) -> Void
