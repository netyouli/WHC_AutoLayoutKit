//
//  WHC_ImageDisplayView.swift
//  CRM
//
//  Created by 吴海超 on 15/10/26.
//  Copyright © 2015年 吴海超. All rights reserved.
//

/*********************************************************
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit *
 *  本人其他优秀开源库：https://github.com/netyouli          *
 *********************************************************/


import UIKit

@objc protocol WHC_GestureImageViewDelegate {
    optional func WHCGestureImageViewExit();
}

class WHC_GestureImageView: UIImageView {
    /// 退出手势
    private var exitTapGesture: UITapGestureRecognizer!;
    /// 双击手势
    private var tapGesture: UITapGestureRecognizer!;
    /// 是否已经放大
    var isZoomBig = false;
    /// 协议
    var delegate: WHC_GestureImageViewDelegate!;
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.layoutUI();
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    private func layoutUI() {
        self.userInteractionEnabled = true;
        self.exitTapGesture = UITapGestureRecognizer(target: self, action: #selector(WHC_GestureImageView.handleExitGesture(_:)));
        self.addGestureRecognizer(exitTapGesture);
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(WHC_GestureImageView.handleTapGesture(_:)));
        self.tapGesture.numberOfTapsRequired = 2;
        self.addGestureRecognizer(tapGesture);
        self.exitTapGesture.requireGestureRecognizerToFail(tapGesture);
    }
    
    func handleExitGesture(sender: UITapGestureRecognizer) {
        let scrollView = self.superview as! UIScrollView;
        scrollView.setZoomScale(1, animated: false);
        self.delegate?.WHCGestureImageViewExit?();
    }

    func handleTapGesture(sender: UITapGestureRecognizer) {
        let scrollView = self.superview as! UIScrollView;
        if self.isZoomBig {
            scrollView.setZoomScale(1, animated: true);
        }else {
            scrollView.setZoomScale(2.5, animated: true);
        }
        self.isZoomBig = !self.isZoomBig;
    }
}

class WHC_ImageDisplayView: UIView , UIScrollViewDelegate , WHC_GestureImageViewDelegate{

    private var images: [AnyObject]!;
    private var scrollView: UIScrollView!;
    private var index = 0;
    private var kZoomAniamtionTime = 0.3;
    private var currentIndex = 0;
    private var column = 0;
    private var currentImageView: WHC_GestureImageView!;
    private let kImageViewTag = 10;
    private var backView: UIView!;
    private var rect: CGRect!;
    private var kShowLabelHeight:CGFloat = 20;
    private var showLabel: UILabel!;
    class func show(images: [AnyObject] ,
                    index: Int ,
                    item: UIView ,
                    column: Int) -> WHC_ImageDisplayView {
        return WHC_ImageDisplayView(frame: UIScreen.mainScreen().bounds,
            images: images ,
            index: index,
            rect: item.convertRect(item.bounds, toView: (UIApplication.sharedApplication().delegate?.window)!),
            column: column);
    }
    
    init(frame: CGRect ,
        images: [AnyObject] ,
         index: Int ,
         rect: CGRect ,
        column: Int) {
        super.init(frame: frame);
        self.images = images;
        self.index = index;
        self.currentIndex = index;
        self.column = column;
        self.rect = rect;
        self.layoutUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    
    private func layoutUI() {
        self.backView = UIView(frame: UIScreen.mainScreen().bounds);
        self.backView.backgroundColor = UIColor.blackColor();
        self.backView.alpha = 0;
        UIApplication.sharedApplication().delegate?.window??.addSubview(self.backView);
        
        self.backgroundColor = UIColor.clearColor();
        self.scrollView = UIScrollView(frame: self.bounds);
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.showsVerticalScrollIndicator = false;
        self.addSubview(self.scrollView);
        if self.images.count > 0 {
            for (i , image) in self.images.enumerate() {
                let imageScrollView = UIScrollView(frame: CGRectMake(CGFloat(i) * self.width(), 0, self.width(), self.height()));
                let imageView = WHC_GestureImageView(frame: imageScrollView.bounds);
                imageView.delegate = self;
                if self.currentIndex == i {
                    self.currentImageView = imageView;
                }
                imageView.tag = kImageViewTag;
                imageScrollView.addSubview(imageView);
                imageScrollView.delegate = self;
                imageScrollView.multipleTouchEnabled = true;
                imageScrollView.minimumZoomScale = 1.0;
                imageScrollView.maximumZoomScale = 2.5;
                imageScrollView.backgroundColor = UIColor.clearColor();
                imageScrollView.tag = i;
                self.scrollView.addSubview(imageScrollView);
                var imageObject: UIImage!;
                if image is UIImage {
                    imageObject = image as! UIImage;
                }else if image is String {
                    let imageName: String = image  as! String;
                    imageObject = UIImage(named: imageName);
                }
                if imageObject.size.width < imageScrollView.width() {
                    imageView.setWidth(imageObject.size.width);
                }
                if imageObject.size.height < imageScrollView.height() {
                    imageView.setHeight(imageObject.size.height);
                }
                imageView.setXy(CGPointMake((imageScrollView.width() - imageView.width()) / 2.0, (imageScrollView.height() - imageView.height()) / 2.0));
                imageView.image = imageObject;
            }
            self.scrollView.pagingEnabled = true;
            self.scrollView.contentSize = CGSizeMake(CGFloat(self.images.count) * self.scrollView.width(), self.scrollView.height());
            self.scrollView.setContentOffset(CGPointMake(CGFloat(self.index) * self.width(), 0), animated: false);
            
            self.showLabel = UILabel(frame: CGRectMake(0, self.height() - kShowLabelHeight, self.width(), kShowLabelHeight));
            self.showLabel.text = "\(self.images.count) / \(self.index + 1)";
            self.showLabel.textColor = UIColor.whiteColor();
            self.showLabel.textAlignment = .Center;
            self.addSubview(self.showLabel);
            UIApplication.sharedApplication().delegate?.window??.addSubview(self);
            
            var rc = CGRectMake(0, 0, self.currentImageView.width(), self.currentImageView.height());
            rc.origin = CGPointMake((self.width() - currentImageView.width()) / 2.0, (self.height() - currentImageView.height()) / 2.0);
            self.currentImageView.frame = self.rect;
            UIView.animateWithDuration(kZoomAniamtionTime, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
                self.currentImageView.frame = rc;
                self.backView.alpha = 1.0;
                }, completion: nil);
        }
    }
    
    private func getExitRect() -> CGRect {
        var rc = CGRectMake(0, 0, CGRectGetWidth(self.rect), CGRectGetHeight(self.rect));
        var startRect = CGRectMake(0, 0, CGRectGetWidth(self.rect), CGRectGetHeight(self.rect));
        if self.index < self.column {
            startRect.origin.x = CGRectGetMinX(self.rect) - CGFloat(self.index) * CGRectGetWidth(self.rect);
            startRect.origin.y = CGRectGetMinY(self.rect);
        }else {
            let row = ((self.index + 1) / self.column + ((self.index + 1) % self.column != 0 ? 1 : 0) - 1);
            let col = ((self.index + 1) % self.column == 0 ? self.column : (self.index + 1) % self.column) - 1;
            startRect.origin.x = CGRectGetMinX(self.rect) - CGFloat(col) * CGRectGetWidth(self.rect);
            startRect.origin.y = CGRectGetMinY(self.rect) - CGFloat(row) * CGRectGetHeight(self.rect);
        }
        if self.currentIndex < self.column {
            rc.origin.x = CGRectGetMinX(startRect) + CGFloat(self.currentIndex) * CGRectGetWidth(self.rect);
            rc.origin.y = CGRectGetMinY(startRect);
        }else {
            let row = ((self.currentIndex + 1) / self.column + ((self.currentIndex + 1) % self.column != 0 ? 1 : 0) - 1);
            let col = ((self.currentIndex + 1) % self.column == 0 ? self.column : (self.currentIndex + 1) % self.column) - 1;
            rc.origin.x = CGRectGetMinX(startRect) + CGFloat(col) * CGRectGetWidth(self.rect);
            rc.origin.y = CGRectGetMinY(startRect) + CGFloat(row) * CGRectGetHeight(self.rect);
        }
        return rc;
    }
    
    //MARK: - WHC_GestureImageViewDelegate
    func WHCGestureImageViewExit() {
        let subView = self.scrollView.viewWithTag(self.currentIndex)!;
        self.currentImageView = subView.viewWithTag(kImageViewTag) as! WHC_GestureImageView;
        let rc = self.getExitRect();
        UIView.animateWithDuration(kZoomAniamtionTime, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.backView.alpha = 0;
            self.currentImageView.frame = rc;
            }) { (finish) -> Void in
                self.backView.removeFromSuperview();
                self.removeFromSuperview();
        }
    }
    
    //MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if self.scrollView === scrollView {
            self.currentIndex = Int(floor((scrollView.contentOffset.x - scrollView.width() / 2.0) / scrollView.width())) + 1;
            if self.currentIndex < 0 {
                self.currentIndex = 0;
            }else if self.currentIndex > self.images.count {
                self.currentIndex = self.images.count - 1;
            }
            self.showLabel.text = "\(self.images.count) / \(self.currentIndex + 1)";
        }
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        if scrollView !== self.scrollView {
            let offsetX = (scrollView.width() > scrollView.contentSize.width) ?
            (scrollView.width() - scrollView.contentSize.width) / 2.0 : 0.0;
            let offsetY = (scrollView.height() > scrollView.contentSize.height) ?
            (scrollView.height() - scrollView.contentSize.height) / 2.0 : 0.0;
            self.currentImageView.center = CGPointMake(scrollView.contentSize.width / 2.0 + offsetX,
            scrollView.contentSize.height / 2.0 + offsetY);
        }
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        if scale <= 1 {
            self.currentImageView.isZoomBig = false;
        }else {
            self.currentImageView.isZoomBig = true;
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        if scrollView !== self.scrollView {
            let subView = self.scrollView.viewWithTag(self.currentIndex)!;
            self.currentImageView = subView.viewWithTag(kImageViewTag) as! WHC_GestureImageView;
            return self.currentImageView;
        }
        return nil;
    }
}
