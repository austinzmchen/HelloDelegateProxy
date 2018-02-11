//
//  ViewController.swift
//  HelloDelegateProxy
//
//  Created by Austin Chen on 2018-01-13.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import UIKit
import DelegateProxy

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.delegate = self // methods will be called
        scrollView.delegateProxy.receive(selector: #selector(UIScrollViewDelegate.scrollViewWillBeginDragging(_:))) { args in
            print("ac")
        }
        
        // scrollView.delegate = self // methods methods will NOT be called
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
    }
}

final class ScrollViewDelegateProxy: DelegateProxy, UIScrollViewDelegate, DelegateProxyType {
    func resetDelegateProxy(owner: UIScrollView) {
        self.cachedPlainDelegate = owner.delegate
        owner.delegate = self
    }
}

extension UIScrollView {
    var delegateProxy: ScrollViewDelegateProxy {
        return .proxy(for: self)
    }
}


/*
@objc protocol MyDelegate: class {
    @objc optional func helloAC()
}

class MyClass {
    weak var delegate: MyDelegate?
    
    init() {
        
    }
    
    func someMethod() {
        print("helloAC")
    }
}


final class MyDelegateProxy: DelegateProxy, MyDelegate, DelegateProxyType {
    func resetDelegateProxy(owner: MyClass) {
        owner.delegate = self
    }
    
    func helloAC() {
        print("aa")
    }
    
}

extension MyClass {
    var delegateProxy: MyDelegateProxy {
        return .proxy(for: self)
    }
}
*/
