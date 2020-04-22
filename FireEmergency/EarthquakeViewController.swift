//
//  EarthquakeViewController.swift
//  FireEmergency
//
//  Created by 中道忠和 on 2016/09/11.
//  Copyright © 2016年 tadakazu nakamichi. All rights reserved.
//

import UIKit

class EarthquakeViewController: UIViewController {
    //メイン画面
    let lblEarthquake   = UILabel(frame: CGRect.zero)
    let btnEarthquake1  = UIButton(frame: CGRect.zero)
    let btnEarthquake2  = UIButton(frame: CGRect.zero)
    let btnEarthquake3  = UIButton(frame: CGRect.zero)
    let btnEarthquake4  = UIButton(frame: CGRect.zero)
    let btnEarthquake5  = UIButton(frame: CGRect.zero)
    let padY1           = UIView(frame: CGRect.zero) //ボタンの間にはさむ見えないpaddingがわり
    let padY2           = UIView(frame: CGRect.zero)
    let padY3           = UIView(frame: CGRect.zero)
    let padY4           = UIView(frame: CGRect.zero)
    let padY5           = UIView(frame: CGRect.zero)
    let padY6           = UIView(frame: CGRect.zero)
    let btnEarthquakeEarthquake = UIButton(frame: CGRect.zero)
    let btnEarthquakeBlackout   = UIButton(frame: CGRect.zero)
    let btnEarthquakeRoad       = UIButton(frame: CGRect.zero)
    let btnEarthquakeTel        = UIButton(frame: CGRect.zero)
    let btnEarthquakeCaution    = UIButton(frame: CGRect.zero)
    let btnEarthquakeBousaiNet  = UIButton(frame: CGRect.zero)
    let pad21            = UIView(frame: CGRect.zero) //ボタンの間にはさむ見えないpaddingがわり
    let pad22            = UIView(frame: CGRect.zero)
    let pad23            = UIView(frame: CGRect.zero)
    let pad31            = UIView(frame: CGRect.zero) //ボタンの間にはさむ見えないpaddingがわり
    let pad32            = UIView(frame: CGRect.zero)
    let pad33            = UIView(frame: CGRect.zero)
    //別クラスのインスタンス保持用変数
    fileprivate var mEarthquakeViewController: EarthquakeViewController!
    fileprivate var mInfoDialog: InfoDialog!
    fileprivate var mBousainetDialog: BousainetDialog!
    fileprivate var mEarthSelectDialog: EarthSelectDialog!
    fileprivate var mContactLoadDialog: ContactLoadDialog2!
    fileprivate var mPassInputDialog: PassInputDialog!
    //結果表示用クラス保持用
    internal var mEarthResultDialog: EarthResultDialog!
    //データ保存用
    let userDefaults = UserDefaults.standard
    //SQLite用
    internal var mDBHelper: DBHelper!
    
    //スタート
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景
        self.view.backgroundColor = UIColor(red:0.9, green:0.7, blue:0.2, alpha:1.0)
        //Button生成
        //非常召集基準（震災）
        lblEarthquake.text = "非常招集基準（震災）"
        lblEarthquake.textColor = UIColor.white
        lblEarthquake.textAlignment = NSTextAlignment.center
        lblEarthquake.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lblEarthquake)
        //震度５強以上
        btnEarthquake1.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquake1.layer.masksToBounds = true
        btnEarthquake1.setTitle("震度５強以上", for: UIControl.State())
        btnEarthquake1.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquake1.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        btnEarthquake1.tag=5
        btnEarthquake1.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquake1.addTarget(self, action: #selector(self.showSelectEarthquake1(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquake1)
        //震度５弱
        btnEarthquake2.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquake2.layer.masksToBounds = true
        btnEarthquake2.setTitle("震度５弱", for: UIControl.State())
        btnEarthquake2.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquake2.tag=6
        btnEarthquake2.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquake2.addTarget(self, action: #selector(self.showSelectEarthquake2(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquake2)
        //震度４
        btnEarthquake3.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquake3.layer.masksToBounds = true
        btnEarthquake3.setTitle("震度４", for: UIControl.State())
        btnEarthquake3.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquake3.tag=7
        btnEarthquake3.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquake3.addTarget(self, action: #selector(self.showSelectEarthquake3(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquake3)
        //震度３以下
        btnEarthquake4.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquake4.layer.masksToBounds = true
        btnEarthquake4.setTitle("震度３以下", for: UIControl.State())
        btnEarthquake4.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquake4.tag=8
        btnEarthquake4.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquake4.addTarget(self, action: #selector(self.showSelectEarthquake4(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquake4)
        //東海地震に伴う非常召集
        btnEarthquake5.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquake5.layer.masksToBounds = true
        btnEarthquake5.setTitle("東海地震に伴う非常招集", for: UIControl.State())
        btnEarthquake5.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquake5.tag=9
        btnEarthquake5.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquake5.addTarget(self, action: #selector(self.showSelectEarthquake5(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquake5)
        //垂直方向のpad
        padY1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(padY1)
        padY2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(padY2)
        padY3.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(padY3)
        padY4.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(padY4)
        padY5.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(padY5)
        padY6.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(padY6)
        //情報（地震）
        btnEarthquakeEarthquake.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquakeEarthquake.layer.masksToBounds = true
        btnEarthquakeEarthquake.setTitle("情報(地震)", for: UIControl.State())
        btnEarthquakeEarthquake.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquakeEarthquake.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        btnEarthquakeEarthquake.tag=10
        btnEarthquakeEarthquake.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquakeEarthquake.addTarget(self, action: #selector(self.showInfoEarthquake(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquakeEarthquake)
        //情報（停電）
        btnEarthquakeBlackout.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquakeBlackout.layer.masksToBounds = true
        btnEarthquakeBlackout.setTitle("情報(停電)", for: UIControl.State())
        btnEarthquakeBlackout.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquakeBlackout.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        btnEarthquakeBlackout.tag=11
        btnEarthquakeBlackout.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquakeBlackout.addTarget(self, action: #selector(self.showInfoBlackout(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquakeBlackout)
        //情報（道路）
        btnEarthquakeRoad.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquakeRoad.layer.masksToBounds = true
        btnEarthquakeRoad.setTitle("情報(道路)", for: UIControl.State())
        btnEarthquakeRoad.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquakeRoad.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        btnEarthquakeRoad.tag=12
        btnEarthquakeRoad.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquakeRoad.addTarget(self, action: #selector(self.showInfoRoad(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquakeRoad)
        //連絡網
        btnEarthquakeTel.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquakeTel.layer.masksToBounds = true
        btnEarthquakeTel.setTitle("連絡網", for: UIControl.State())
        btnEarthquakeTel.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquakeTel.tag=13
        btnEarthquakeTel.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquakeTel.addTarget(self, action: #selector(self.showContactLoad(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquakeTel)
        //留意事項
        btnEarthquakeCaution.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquakeCaution.layer.masksToBounds = true
        btnEarthquakeCaution.setTitle("留意事項", for: UIControl.State())
        btnEarthquakeCaution.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquakeCaution.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
        btnEarthquakeCaution.tag=14
        btnEarthquakeCaution.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquakeCaution.addTarget(self, action: #selector(self.showInfoCaution(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquakeCaution)
        //防災ネット
        btnEarthquakeBousaiNet.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        btnEarthquakeBousaiNet.layer.masksToBounds = true
        btnEarthquakeBousaiNet.setTitle("防災ネット", for: UIControl.State())
        btnEarthquakeBousaiNet.setTitleColor(UIColor.black, for: UIControl.State())
        btnEarthquakeBousaiNet.tag=15
        btnEarthquakeBousaiNet.translatesAutoresizingMaskIntoConstraints = false
        btnEarthquakeBousaiNet.addTarget(self, action: #selector(self.showInfoBousainet(_:)), for: .touchUpInside)
        self.view.addSubview(btnEarthquakeBousaiNet)
        //pad
        pad21.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad21)
        pad22.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad22)
        pad23.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad23)
        //pad
        pad31.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad31)
        pad32.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad32)
        pad33.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pad33)
        
        //ボタン押したら表示するDialog生成
        mInfoDialog = InfoDialog(parentView: self) //このViewControllerを渡してあげる
        mBousainetDialog = BousainetDialog(parentView: self)
        mEarthResultDialog = EarthResultDialog(parentView: self) //このViewControllerを渡してあげる
        mPassInputDialog = PassInputDialog(parentView: self)
        
        //passCheckをfalseで初期化
        userDefaults.set(false, forKey: "passCheck")
    }
    
    //制約ひな型
    func Constraint(_ item: AnyObject, _ attr: NSLayoutConstraint.Attribute, to: AnyObject?, _ attrTo: NSLayoutConstraint.Attribute, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0, relate: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = UILayoutPriority.required) -> NSLayoutConstraint {
        let ret = NSLayoutConstraint(
            item:       item,
            attribute:  attr,
            relatedBy:  relate,
            toItem:     to,
            attribute:  attrTo,
            multiplier: multiplier,
            constant:   constant
        )
        ret.priority = priority
        return ret
    }
    
    override func viewDidLayoutSubviews(){
        self.view.addConstraints([
            //非常召集基準（震災）ラベル
            Constraint(lblEarthquake, .bottom, to:self.view, .top, constant:40),
            Constraint(lblEarthquake, .centerX, to:self.view, .centerX, constant:8),
            Constraint(lblEarthquake, .width, to:self.view, .width, constant:0, multiplier:1.0)
        ])
        self.view.addConstraints([
            //padY2
            Constraint(padY2, .bottom, to:btnEarthquake1, .top, constant:0),
            Constraint(padY2, .leading, to:self.view, .leading, constant:0),
            Constraint(padY2, .height, to:self.view, .height, constant:0, multiplier:0.03)
        ])
        self.view.addConstraints([
            //震度５強以上ボタン
            Constraint(btnEarthquake1, .bottom, to:padY3, .top, constant:0),
            Constraint(btnEarthquake1, .centerX, to:self.view, .centerX, constant:8),
            Constraint(btnEarthquake1, .width, to:self.view, .width, constant:0, multiplier:0.8)
        ])
        self.view.addConstraints([
            //padY3
            Constraint(padY3, .bottom, to:btnEarthquake2, .top, constant:0),
            Constraint(padY3, .leading, to:self.view, .leading, constant:0),
            Constraint(padY3, .height, to:self.view, .height, constant:0, multiplier:0.03)
        ])
        self.view.addConstraints([
            //震度５弱ボタン
            Constraint(btnEarthquake2, .bottom, to:padY4, .top, constant:0),
            Constraint(btnEarthquake2, .centerX, to:self.view, .centerX, constant:8),
            Constraint(btnEarthquake2, .width, to:self.view, .width, constant:0, multiplier:0.8)
        ])
        self.view.addConstraints([
            //padY4
            Constraint(padY4, .bottom, to:btnEarthquake3, .top, constant:0),
            Constraint(padY4, .leading, to:self.view, .leading, constant:0),
            Constraint(padY4, .height, to:self.view, .height, constant:0, multiplier:0.03)
        ])
        self.view.addConstraints([
            //震度４ボタン Y座標の中心 -72に留意
            Constraint(btnEarthquake3, .centerY, to:self.view, .centerY, constant:-72),
            Constraint(btnEarthquake3, .centerX, to:self.view, .centerX, constant:8),
            Constraint(btnEarthquake3, .width, to:self.view, .width, constant:0, multiplier:0.8)
        ])
        self.view.addConstraints([
            //padY5
            Constraint(padY5, .top, to:btnEarthquake3, .bottom, constant:0),
            Constraint(padY5, .leading, to:self.view, .leading, constant:0),
            Constraint(padY5, .height, to:self.view, .height, constant:0, multiplier:0.03)
        ])
        self.view.addConstraints([
            //震度３以下ボタン
            Constraint(btnEarthquake4, .top, to:padY5, .bottom, constant:0),
            Constraint(btnEarthquake4, .centerX, to:self.view, .centerX, constant:8),
            Constraint(btnEarthquake4, .width, to:self.view, .width, constant:0, multiplier:0.8)
        ])
        self.view.addConstraints([
            //padY6
            Constraint(padY6, .top, to:btnEarthquake4, .bottom, constant:0),
            Constraint(padY6, .leading, to:self.view, .leading, constant:0),
            Constraint(padY6, .height, to:self.view, .height, constant:0, multiplier:0.03)
        ])
        self.view.addConstraints([
            //東海地震に伴う非常招集ボタン
            Constraint(btnEarthquake5, .top, to:padY6, .bottom, constant:0),
            Constraint(btnEarthquake5, .centerX, to:self.view, .centerX, constant:8),
            Constraint(btnEarthquake5, .width, to:self.view, .width, constant:0, multiplier:0.8)
        ])
        self.view.addConstraints([
            //pad21
            Constraint(pad21, .bottom, to:btnEarthquakeTel, .top, constant:-8),
            Constraint(pad21, .leading, to:self.view, .leading, constant:0),
            Constraint(pad21, .width, to:self.view, .width, constant:0, multiplier:0.024)
        ])
        self.view.addConstraints([
            //情報(地震)ボタン
            Constraint(btnEarthquakeEarthquake, .bottom, to:btnEarthquakeTel, .top, constant:-8),
            Constraint(btnEarthquakeEarthquake, .leading, to:pad21, .trailing, constant:0),
            Constraint(btnEarthquakeEarthquake, .width, to:self.view, .width, constant:0, multiplier:0.3)
        ])
        self.view.addConstraints([
            //pad22
            Constraint(pad22, .bottom, to:btnEarthquakeTel, .top, constant:-8),
            Constraint(pad22, .leading, to:btnEarthquakeEarthquake, .trailing, constant:0),
            Constraint(pad22, .width, to:self.view, .width, constant:0, multiplier:0.024)
        ])
        self.view.addConstraints([
            //情報(停電)ボタン
            Constraint(btnEarthquakeBlackout, .bottom, to:btnEarthquakeTel, .top, constant:-8),
            Constraint(btnEarthquakeBlackout, .leading, to:pad22, .trailing, constant:0),
            Constraint(btnEarthquakeBlackout, .width, to:btnEarthquakeEarthquake, .width, constant:0)
        ])
        self.view.addConstraints([
            //pad23
            Constraint(pad23, .bottom, to:btnEarthquakeTel, .top, constant:-8),
            Constraint(pad23, .leading, to:btnEarthquakeBlackout, .trailing, constant:0),
            Constraint(pad23, .width, to:self.view, .width, constant:0, multiplier:0.024)
        ])
        self.view.addConstraints([
            //情報(道路)ボタン
            Constraint(btnEarthquakeRoad, .bottom, to:btnEarthquakeTel, .top ,constant:-8),
            Constraint(btnEarthquakeRoad, .leading, to:pad23, .trailing, constant:0),
            Constraint(btnEarthquakeRoad, .width, to:btnEarthquakeEarthquake, .width, constant:0)
        ])
        self.view.addConstraints([
            //pad31
            Constraint(pad31, .top, to:btnEarthquakeEarthquake, .bottom, constant:8),
            Constraint(pad31, .leading, to:self.view, .leading, constant:0),
            Constraint(pad31, .width, to:self.view, .width, constant:0, multiplier:0.024)
        ])
        self.view.addConstraints([
            //連絡網ボタン
            Constraint(btnEarthquakeTel, .bottom, to:self.view, .bottom, constant:-8),
            Constraint(btnEarthquakeTel, .leading, to:pad31, .trailing, constant:0),
            Constraint(btnEarthquakeTel, .width, to:self.view, .width, constant:0, multiplier:0.3)
        ])
        self.view.addConstraints([
            //pad32
            Constraint(pad32, .bottom, to:self.view, .bottom, constant:-8),
            Constraint(pad32, .leading, to:btnEarthquakeTel, .trailing, constant:0),
            Constraint(pad32, .width, to:self.view, .width, constant:0, multiplier:0.024)
        ])
        self.view.addConstraints([
            //留意事項ボタン
            Constraint(btnEarthquakeCaution, .bottom, to:self.view, .bottom, constant:-8),
            Constraint(btnEarthquakeCaution, .leading, to:pad32, .trailing, constant:0),
            Constraint(btnEarthquakeCaution, .width, to:btnEarthquakeTel, .width, constant:0)
        ])
        self.view.addConstraints([
            //pad33
            Constraint(pad33, .bottom, to:self.view, .bottom, constant:-8),
            Constraint(pad33, .leading, to:btnEarthquakeCaution, .trailing, constant:0),
            Constraint(pad33, .width, to:self.view, .width, constant:0, multiplier:0.024)
        ])
        self.view.addConstraints([
            //防災ネットボタン
            Constraint(btnEarthquakeBousaiNet, .bottom, to:self.view, .bottom ,constant:-8),
            Constraint(btnEarthquakeBousaiNet, .leading, to:pad33, .trailing, constant:0),
            Constraint(btnEarthquakeBousaiNet, .width, to:btnEarthquakeTel, .width, constant:0)
        ])
    }
    
    //震度５強以上
    @objc func showSelectEarthquake1(_ sender: UIButton){
        mEarthSelectDialog = EarthSelectDialog(index: 1, parentView: self)
        mEarthSelectDialog.showInfo()
    }
    
    //震度５弱
    @objc func showSelectEarthquake2(_ sender: UIButton){
        mEarthSelectDialog = EarthSelectDialog(index: 2, parentView: self)
        mEarthSelectDialog.showInfo()
    }
    
    //震度４
    @objc func showSelectEarthquake3(_ sender: UIButton){
        mEarthSelectDialog = EarthSelectDialog(index: 3, parentView: self)
        mEarthSelectDialog.showInfo()
    }
    
    //震度３以下
    @objc func showSelectEarthquake4(_ sender: UIButton){
        mEarthSelectDialog = EarthSelectDialog(index: 4, parentView: self)
        mEarthSelectDialog.showInfo()
    }
    
    //東海地震に伴う非常招集
    @objc func showSelectEarthquake5(_ sender: UIButton){
        mEarthSelectDialog = EarthSelectDialog(index: 5, parentView: self)
        mEarthSelectDialog.showInfo()
    }
    
    //情報(地震)
    @objc func showInfoEarthquake(_ sender: UIButton){
        mInfoDialog.showInfo("earthquake")
    }
    
    //情報（道路）
    @objc func showInfoRoad(_ sender: UIButton){
        mInfoDialog.showInfo("road")
    }
    
    //連絡網
    @objc func showContactLoad(_ sender: UIButton){
        //初期設定のままだと設定画面に遷移
        if userDefaults.string(forKey: "password") == "nil" {
            //PasViewController呼び出し
            let data:PassViewController = PassViewController()
            let nav = UINavigationController(rootViewController: data)
            nav.setNavigationBarHidden(true, animated: false) //これをいれないとNavigationBarが表示されてうざい
            self.present(nav, animated: true, completion: nil)
        } else if !userDefaults.bool(forKey: "passCheck"){
            //パスワードチェック呼び出し
            mPassInputDialog.showResult()
        } else {
            //合っていれば表示
            let data:ContactSearchViewController = ContactSearchViewController()
            let nav = UINavigationController(rootViewController: data)
            nav.setNavigationBarHidden(true, animated: false) //これをいれないとNavigationBarが表示されてうざい
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    //情報（停電）
    @objc func showInfoBlackout(_ sender: UIButton){
        mInfoDialog.showInfo("blackout")
    }

    //留意事項
    @objc func showInfoCaution(_ sender: UIButton){
        mInfoDialog.showInfo("caution")
    }
    
    //防災ネット
    @objc func showInfoBousainet(_ sender: UIButton){
        mBousainetDialog.showInfo()
    }
    
    //基礎データ入力画面遷移
    @objc func onClickbtnData(_ sender : UIButton){
        //dataViewControllerのインスタンス生成
        let data:DataViewController = DataViewController()
        //存在を保存
        isDataViewController = true
        //navigationControllerのrootViewControllerにdataViewControllerをセット
        let nav = UINavigationController(rootViewController: data)
        nav.setNavigationBarHidden(true, animated: false) //これをいれないとNavigationBarが表示されてうざい
        //画面遷移
        self.present(nav, animated: true, completion: nil)
    }
    
    //風水害画面遷移
    @objc func onClickbtnTyphoon(_ sender : UIButton){
        //インスタンス生成
        let data:TyphoonViewController = TyphoonViewController()
        //存在を保存
        isTyphoonViewController = true
        //navigationControllerのrootViewControllerにTyphoonViewControllerをセット
        let nav = UINavigationController(rootViewController: data)
        nav.setNavigationBarHidden(true, animated: false) //これをいれないとNavigationBarが表示されてうざい
        //画面遷移
        self.present(nav, animated: true, completion: nil)
    }
    
    //国民保護画面遷移
    @objc func onClickbtnKokuminhogo(_ sender : UIButton){
        //KokuminhogoViewControllerのインスタンス生成
        let data:KokuminhogoViewController = KokuminhogoViewController()
        //存在を保存
        isKokuminhogoViewController = true
        //navigationControllerのrootViewControllerにKokuminhogoViewControllerをセット
        let nav = UINavigationController(rootViewController: data)
        nav.setNavigationBarHidden(true, animated: false) //これをいれないとNavigationBarが表示されてうざい
        //画面遷移
        self.present(nav, animated: true, completion: nil)
    }
    
    //緊援隊画面遷移
    @objc func onClickbtnKinentai(_ sender : UIButton){
        //KinentaiViewControllerのインスタンス生成
        let data:KinentaiViewController = KinentaiViewController()
        //存在を保存
        isKinentaiViewController = true
        //navigationControllerのrootViewControllerにKinentaiViewControllerをセット
        let nav = UINavigationController(rootViewController: data)
        nav.setNavigationBarHidden(true, animated: false) //これをいれないとNavigationBarが表示されてうざい
        //画面遷移
        self.present(nav, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

