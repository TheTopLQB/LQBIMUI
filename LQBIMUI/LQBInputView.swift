//
//  LQBInputView.swift
//  LQBIMUI
//
//  Created by 李庆彬 on 3/21/16.
//  Copyright © 2016 LQB. All rights reserved.
//

import UIKit

protocol LQBInputViewDelegate {
    func sendButtonClicked();
}

class LQBInputView: UIView {
    var textView:UITextView?
    var sendButton:UIButton?
    var delegate:LQBInputViewDelegate?
    override init(frame: CGRect) {
        self.textView = UITextView.init(frame: CGRectMake(30, 5, frame.size.width - 100, frame.size.height - 10));
        self.textView?.layer.borderColor = UIColor.lightGrayColor().CGColor;
        self.textView?.layer.borderWidth = 0.5;
        self.sendButton = UIButton(type:UIButtonType.Custom);
        self.sendButton?.frame = CGRectMake(frame.size.width - 60, 5, 40, frame.size.height - 10);
        self.sendButton?.setTitle("发送", forState: UIControlState.Normal);
        self.sendButton?.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal);
        super.init(frame: frame);
        self.addSubview(self.textView!);
        self.addSubview(self.sendButton!);
        self.sendButton?.addTarget(self, action: Selector("sendButtonClicked"), forControlEvents: UIControlEvents.TouchUpInside);
        self.layer.borderColor = UIColor.grayColor().CGColor;
        self.layer.borderWidth = 0.5;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sendButtonClicked() {
        self.delegate?.sendButtonClicked();
    }

}
