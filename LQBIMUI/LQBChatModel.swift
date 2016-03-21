//
//  LQBChatModel.swift
//  LQBIMUI
//
//  Created by 李庆彬 on 3/21/16.
//  Copyright © 2016 LQB. All rights reserved.
//

import UIKit

enum MessageType : Int{
    case Text
    case Image
    case Voice
    case Video
}

enum MessageFrom : Int{
    case Me
    case Other
}

class LQBChatModel: NSObject {
    var messageType:MessageType?
    var messageFrom:MessageFrom?
    var content:String?
    
}
