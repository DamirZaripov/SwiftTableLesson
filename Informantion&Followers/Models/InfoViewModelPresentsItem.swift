//
//  InfoViewModelPresentsItem.swift
//  Informantion&Followers
//
//  Created by Дамир Зарипов on 25.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

struct InfoViewModelPresentsItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .presents
    }
    
    var sectionType: String {
        return "Подарки"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var presentsNumbers: String
}
