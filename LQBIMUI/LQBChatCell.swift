//
//  LQBChatCell.swift
//  LQBIMUI
//
//  Created by 李庆彬 on 3/21/16.
//  Copyright © 2016 LQB. All rights reserved.
//

import UIKit

class LQBChatCell: UITableViewCell {

    var timeLabel:UILabel?
    var avatarImageView:UIImageView?
    var contentButton:UIButton?
    var chatFrame:LQBChatCellFrame = LQBChatCellFrame() {
        didSet {
            
            self.timeLabel?.frame = chatFrame.timeLabelFrame!;
            self.avatarImageView?.frame = chatFrame.avatarImageViewFrame!;
            self.contentButton?.frame = chatFrame.contentButtonFrame!;

            let chatModel = chatFrame.chatModel;
            var backGroundImage:UIImage = UIImage();
            self.contentButton?.setTitle(chatModel.content, forState: UIControlState.Normal);
            if (chatModel.messageFrom == MessageFrom.Me) {
                self.avatarImageView?.image = UIImage.init(named: "demo_avatar_jobs");
                backGroundImage = UIImage.init(named: "chatto_bg_normal")!;
                backGroundImage = backGroundImage.resizableImageWithCapInsets(UIEdgeInsetsMake(35,20,20,25));
            }else /*if (chatModel.messageFrom == MessageFrom.Other)*/{
                self.avatarImageView?.image = UIImage.init(named: "demo_avatar_cook");
                backGroundImage = UIImage.init(named: "chatfrom_bg_normal")!;
                backGroundImage = backGroundImage.resizableImageWithCapInsets(UIEdgeInsetsMake(35, 22, 20, 20));
            }
            self.contentButton?.setBackgroundImage(backGroundImage, forState: UIControlState.Normal);
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.timeLabel = UILabel();
        self.timeLabel?.textAlignment = NSTextAlignment.Center;
        self.timeLabel?.font = UIFont.systemFontOfSize(14);
        self.avatarImageView = UIImageView();
        self.avatarImageView?.layer.cornerRadius = 20;
        self.avatarImageView?.layer.masksToBounds = true;
        self.contentButton = UIButton();
        self.contentButton?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        self.contentButton?.titleLabel?.font = UIFont.systemFontOfSize(14);
        self.contentButton?.titleLabel?.numberOfLines = 0;
        self.contentButton?.contentEdgeInsets = UIEdgeInsetsMake(15,15,15,15);
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.contentView.addSubview(self.timeLabel!);
        self.contentView.addSubview(self.avatarImageView!);
        self.contentView.addSubview(self.contentButton!);
        
        self.selectionStyle = UITableViewCellSelectionStyle.None;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
