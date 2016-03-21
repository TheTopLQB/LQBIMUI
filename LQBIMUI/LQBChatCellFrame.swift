//
//  LQBChatCellFrame.swift
//  LQBIMUI
//
//  Created by 李庆彬 on 3/21/16.
//  Copyright © 2016 LQB. All rights reserved.
//

import UIKit

let avatarWH:CGFloat = 40.0;
let inset:CGFloat = 10.0;

class LQBChatCellFrame: NSObject {
    var timeLabelFrame:CGRect?
    var avatarImageViewFrame:CGRect?
    var contentButtonFrame:CGRect?
    var cellHeight:CGFloat?
    var chatModel:LQBChatModel = LQBChatModel() {
        didSet {
            self.timeLabelFrame = CGRectMake(0, 5, WIDTH, 30);
            let contentSize = self.sizeFromString(chatModel.content!, font:UIFont.systemFontOfSize(14) , width: 180);
            if (chatModel.messageFrom == MessageFrom.Me) {
                self.avatarImageViewFrame = CGRectMake(WIDTH - avatarWH - inset, CGRectGetMaxY(self.timeLabelFrame!) + inset, avatarWH, avatarWH);
                let contentX = WIDTH - (avatarWH + inset) - contentSize.width - 30 - 10;
                self.contentButtonFrame = CGRectMake(contentX, CGRectGetMinY(self.avatarImageViewFrame!), contentSize.width + 30, contentSize.height+20);
            }else{
                self.avatarImageViewFrame = CGRectMake(inset, CGRectGetMaxY(self.timeLabelFrame!) + inset, avatarWH, avatarWH)
                let contentX = CGRectGetMaxX(self.avatarImageViewFrame!) + 15;
                self.contentButtonFrame = CGRectMake(contentX, CGRectGetMinY(self.avatarImageViewFrame!), contentSize.width+30, contentSize.height+20);
            }
            self.cellHeight = max(CGRectGetMaxY(self.contentButtonFrame!) + inset, CGRectGetMaxY(self.avatarImageViewFrame!) + inset)
        }
    }

    func sizeFromString(str:NSString,font:UIFont,width:CGFloat) -> CGSize {
        let options:NSStringDrawingOptions = [.UsesLineFragmentOrigin,.UsesFontLeading];
        let attribute = [NSFontAttributeName:UIFont.systemFontOfSize(14)];
        let size = str.boundingRectWithSize(CGSizeMake(width,CGFloat(MAXFLOAT)), options: options, attributes: attribute, context: nil).size;
        return size;
    }

}
