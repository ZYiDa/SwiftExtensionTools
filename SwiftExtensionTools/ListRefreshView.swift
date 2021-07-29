//
//  ListRefreshView.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/29.
//

import UIKit
import Foundation
import MJRefresh

/*
public enum MJRefreshFooterType {
    case normal
    case back
    case auto
    case backNormal
    case autoNormal
    case gif
    case autoGif
    case backGif
}

public enum MJRefreshHeaderType {
    case normal
    case gif
}
*/

public extension UIScrollView{
    
    //MARK: - block样式的下拉刷新
    func showBlockRefreshHeader(withAction action:@escaping(()->Void)){
        if let footer = self.mj_footer {
            footer.resetNoMoreData()
        }
        self.mj_header = MJRefreshNormalHeader(refreshingBlock: action)
        self.mj_header?.beginRefreshing()
    }
    
    //MARK: - 通用形式的下拉刷新
    func showNormalRefreshHeader(withTarget target:Any,action:Selector){
        if let footer = self.mj_footer {
            footer.resetNoMoreData()
        }
        self.mj_header = MJRefreshNormalHeader(
            refreshingTarget: target,
            refreshingAction: action
        )
        self.mj_header?.beginRefreshing()
    }
    
    //MARK: - block形式的下拉刷新
    func showBlockRefreshFooter(withAction action:@escaping(()->Void)){
        self.mj_footer = MJRefreshBackFooter(refreshingBlock: action)
    }
    
    //MARK: - 通用形式的下拉刷新
    func showNormalRefreshFooter(withTarget target:Any,action:Selector){
        self.mj_footer = MJRefreshBackFooter(
            refreshingTarget: target,
            refreshingAction: action
        )
    }
    
    func endHeaderRefresh(){
        self.mj_header?.endRefreshing()
    }
    
    func endFooterRefresh(){
        self.mj_footer?.endRefreshing()
    }
    
    func endFooterRefreshWithNoMoreData(){
        self.mj_footer?.endRefreshingWithNoMoreData()
    }
    
}
