//
//  LQBViewController.swift
//  LQBIMUI
//
//  Created by 李庆彬 on 3/21/16.
//  Copyright © 2016 LQB. All rights reserved.
//

import UIKit

let reuseIdentifier = "chatCell";

class LQBViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,LQBInputViewDelegate{
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    var chatModelArray:[LQBChatCellFrame] = [];
    var input:LQBInputView?
    @IBOutlet weak var tableView: UITableView!
    func makeData() {
        let chatModel1 = LQBChatModel();
        chatModel1.messageFrom = MessageFrom.Me;
        chatModel1.content = "hello cook";
        let chatFrame1 = LQBChatCellFrame();
        chatFrame1.chatModel = chatModel1;
        let chatModel2 = LQBChatModel();
        chatModel2.messageFrom = MessageFrom.Other;
        chatModel2.content = "hello jobskhxcvdhfuihxcuvhufhvudvbuvufdhvuvufdvudvufbvubduvbduvbdfuvbdfuvbfvfvd";
        let chatFrame2 = LQBChatCellFrame();
        chatFrame2.chatModel = chatModel2;
        self.chatModelArray.append(chatFrame1);
        self.chatModelArray.append(chatFrame2);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false;
        self.navigationItem.title = "消息列表";
        self.makeData();
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = UIView();
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.tableView.registerClass(LQBChatCell.classForCoder(), forCellReuseIdentifier: reuseIdentifier);
        self.input = LQBInputView.init(frame: CGRectMake(0, HEIGHT - 44 - 64, WIDTH, 44));
        self.input?.delegate = self;
        self.view.addSubview(self.input!);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardFrameWillChange:"), name: UIKeyboardWillChangeFrameNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardFrameWillChange:"), name: UIKeyboardWillHideNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("tableViewScrollToBottom"), name: UIKeyboardDidShowNotification, object: nil);
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatModelArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)as!LQBChatCell;
        cell.chatFrame = self.chatModelArray[indexPath.row];
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let chatFrame = self.chatModelArray[indexPath.row];
        return chatFrame.cellHeight!;
    }
    
    func keyboardFrameWillChange(notification:NSNotification) {
        if (notification.name == UIKeyboardWillHideNotification) {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.input?.frame = CGRectMake(0, HEIGHT - 44 - 64, WIDTH, 44);
                self.tableViewBottomConstraint.constant = 44;
            })
        }else if (notification.name == UIKeyboardWillChangeFrameNotification){
            let userInfo = notification.userInfo;
            if let keyboardHeight = userInfo![UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size.height {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.input?.frame = CGRectMake(0, HEIGHT - 64 - keyboardHeight - 44, WIDTH, 44);
                    self.tableViewBottomConstraint.constant = keyboardHeight + 44;
                })
            }
        }
    }
    
    func tableViewScrollToBottom() {
        if (self.chatModelArray.count==0) {
            return;
        }
        let indexPath = NSIndexPath.init(forRow: self.chatModelArray.count - 1, inSection: 0);
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true);
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true);
    }
    
    func sendButtonClicked() {
        self.tableViewScrollToBottom();
        let chatModel = LQBChatModel();
        chatModel.messageFrom = MessageFrom.Me;
        chatModel.content = self.input?.textView?.text;
        let frame = LQBChatCellFrame();
        frame.chatModel = chatModel;
        self.chatModelArray.append(frame);
        self.tableView.reloadData();
        self.tableViewScrollToBottom();
    }
}
