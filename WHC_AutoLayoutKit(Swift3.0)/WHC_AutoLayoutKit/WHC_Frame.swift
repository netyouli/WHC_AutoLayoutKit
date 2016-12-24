//
//  WHC_ViewExtension.swift
//  WHC_AutoLayoutKit(Swift)
//  Created by WHC on 16/7/7.
//  Copyright © 2016年 吴海超. All rights reserved.

//  Github <https://github.com/netyouli/WHC_AutoLayoutKit>

//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import UIKit

public extension UIView {
    
    public var whc_ScreenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var whc_ScreenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public var whc_Width: CGFloat {
        set {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
        
        get {
            return self.frame.width
        }
    }
    
    public var whc_Height: CGFloat {
        set {
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
        
        get {
            return self.frame.height
        }
    }
    
    public var whc_X: CGFloat {
        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
        
        get {
            return self.frame.minX
        }
    }
    
    public var whc_Y: CGFloat {
        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
        
        get {
            return self.frame.minY
        }
    }
    
    public var whc_MaxX: CGFloat {
        set {
            self.whc_Width = newValue - self.whc_X
        }
        
        get {
            return self.frame.maxX
        }
    }
    
    public var whc_MaxY: CGFloat {
        set {
            self.whc_Height = newValue - self.whc_Y
        }
        
        get {
            return self.frame.maxY
        }
    }
    
    public var whc_MidX: CGFloat {
        set {
            self.whc_Width = newValue * 2
        }
        
        get {
            return self.frame.minX + self.frame.width / 2
        }
    }
    
    public var whc_MidY: CGFloat {
        set {
            self.whc_Height = newValue * 2
        }
        
        get {
            return self.frame.minY + self.frame.height / 2
        }
    }
    
    public var whc_CenterX: CGFloat {
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
        
        get {
            return self.center.x
        }
    }
    
    public var whc_CenterY: CGFloat {
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
        
        get {
            return self.center.y
        }
    }
    
    public var whc_Xy: CGPoint {
        set {
            var rect = self.frame
            rect.origin = newValue
            self.frame = rect
        }
        
        get {
            return self.frame.origin
        }
    }
    
    public var whc_Size: CGSize {
        set {
            var rect = self.frame
            rect.size = newValue
            self.frame = rect
        }
        
        get {
            return self.frame.size
        }
    }
}
