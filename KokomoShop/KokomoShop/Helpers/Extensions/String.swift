//
//  String.swift
//  KokomoShop
//
//  Created by Diego Ernst on 9/7/16.
//  Copyright © 2016 'Kokomo'. All rights reserved.
//

import Foundation
import XLSwiftKit

extension String: ParametrizedString {

    public var parameterFormat: String { return "{i}" }

}
