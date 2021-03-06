//
//  PassInputDialog.swift
//  FireEmergency
//
//  Created by 中道忠和 on 2017/03/14.
//  Copyright © 2017年 tadakazu nakamichi. All rights reserved.
//

import UIKit

class PassInputDialog : UITextField {
    //ボタン押したら出るUIWindow
    fileprivate var parent: UIViewController!
    fileprivate var win1: UIWindow!
    fileprivate var text1: UITextView!
    fileprivate var textField1: UITextField!
    fileprivate var btnClose: UIButton!
    fileprivate var btnInput: UIButton!
    //データ保存用
    let userDefaults = UserDefaults.standard
    
    //UITextFieldを便宜的に親として継承しているため。UIViewControllerを継承したくないための策。
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //コンストラクタ
    init(parentView: UIViewController){
        super.init(frame: CGRect.zero)
        
        parent      = parentView
        win1        = UIWindow()
        text1       = UITextView()
        textField1  = UITextField()
        btnClose    = UIButton()
        btnInput   = UIButton()
    }
    
    //デコンストラクタ
    deinit{
        parent      = nil
        win1        = nil
        text1       = nil
        textField1  = nil
        btnClose    = nil
        btnInput    = nil
    }
    
    //表示
    func showResult(){
        //元の画面を暗く
        parent.view.alpha = 0.1
        mViewController.view.alpha = 0.1
        mViewController2.view.alpha = 0.1
        //初期設定
        //Win1
        win1.backgroundColor = UIColor.white
        win1.frame = CGRect(x: 80,y: 10,width: parent.view.frame.width-40,height: 200)
        win1.layer.position = CGPoint(x: parent.view.frame.width/2, y: 200)
        win1.alpha = 1.0
        win1.layer.cornerRadius = 10
        //KeyWindowにする
        win1.makeKey()
        //表示
        self.win1.makeKeyAndVisible()
        
        //１セット目
        //text1生成
        text1.frame = CGRect(x: 10,y: 10, width: self.win1.frame.width - 20, height: 40)
        text1.backgroundColor = UIColor.clear
        text1.font = UIFont.systemFont(ofSize: CGFloat(14))
        text1.textColor = UIColor.black
        text1.textAlignment = NSTextAlignment.left
        text1.isEditable = false
        text1.isScrollEnabled = true
        text1.text = "パスワードを入力してください"
        self.win1.addSubview(text1)
        //textField1
        textField1.frame = CGRect(x: 10,y: 60, width: self.win1.frame.width - 20, height: 40)
        textField1.backgroundColor = UIColor.clear
        textField1.font = UIFont.systemFont(ofSize: (CGFloat(14)))
        textField1.textAlignment = NSTextAlignment.center
        textField1.placeholder = "パスワードを入力してください"
        textField1.borderStyle = UITextField.BorderStyle.roundedRect
        self.win1.addSubview(textField1)
        
        //閉じるボタン生成
        btnClose.frame = CGRect(x: 0,y: 0,width: 100,height: 30)
        btnClose.backgroundColor = UIColor.orange
        btnClose.setTitle("閉じる", for: UIControl.State())
        btnClose.setTitleColor(UIColor.white, for: UIControl.State())
        btnClose.layer.masksToBounds = true
        btnClose.layer.cornerRadius = 10.0
        btnClose.layer.position = CGPoint(x: self.win1.frame.width/2-60, y: self.win1.frame.height-20)
        btnClose.addTarget(self, action: #selector(self.onClickClose(_:)), for: .touchUpInside)
        self.win1.addSubview(btnClose)
        
        //入力ボタン生成
        btnInput.frame = CGRect(x: 0,y: 0,width: 100,height: 30)
        btnInput.backgroundColor = UIColor.red
        btnInput.setTitle("入力", for: UIControl.State())
        btnInput.setTitleColor(UIColor.white, for: UIControl.State())
        btnInput.layer.masksToBounds = true
        btnInput.layer.cornerRadius = 10.0
        btnInput.layer.position = CGPoint(x: self.win1.frame.width/2+60, y: self.win1.frame.height-20)
        btnInput.addTarget(self, action: #selector(self.onClickInput(_:)), for: .touchUpInside)
        self.win1.addSubview(btnInput)
    }
    
    //閉じる
    @objc func onClickClose(_ sender: UIButton){
        win1.isHidden = true      //win1隠す
        text1.text = ""         //使い回しするのでテキスト内容クリア
        parent.view.alpha = 1.0 //元の画面明るく
        mViewController.view.alpha = 1.0
        mViewController2.view.alpha = 1.0
    }
    
    //判定
    @objc func onClickInput(_ sender: UIButton){
        win1.isHidden = true      //win1隠す
        text1.text = ""         //使い回しするのでテキスト内容クリア
        parent.view.alpha = 1.0 //元の画面明るく
        mViewController.view.alpha = 1.0
        mViewController2.view.alpha = 1.0
        //対応の結果であるアクションプランを表示
        if textField1.text == userDefaults.string(forKey: "password") {
            userDefaults.set(true, forKey: "passCheck")
            //遷移 parentで実行
            let data:ContactSearchViewController = ContactSearchViewController()
            let nav = UINavigationController(rootViewController: data)
            nav.setNavigationBarHidden(true, animated: false) //これをいれないとNavigationBarが表示されてうざい
            parent.present(nav, animated: true, completion: nil)
        } else {
            //誤りならfalseに
            userDefaults.set(false, forKey: "passCheck")
        }
    }
}
