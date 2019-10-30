//
//  DriftwoodHandily
//
//  Copyright (c) 2018-Present wlgemini <wangluguang@live.com>.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


/// Item
public protocol Item: AnyObject {
    
    /// superview
    var dwh_superview: Item? { get }
}


/// Item (Make, Update, Remove, Remake constraint)
public extension Item {
    
    /// make
    func make(file: String = #file, line: UInt = #line) -> ConstraintMaker {
        ConstraintMaker(item: self, location: Debug.Location(file, line))
    }
    
    /// update
    func update(file: String = #file, line: UInt = #line) -> ConstraintUpdater {
        ConstraintUpdater(item: self, location: Debug.Location(file, line))
    }
    
    /// remove
    func remove(file: String = #file, line: UInt = #line) -> ConstraintRemover {
        ConstraintRemover(item: self, location: Debug.Location(file, line))
    }
    
    /// remake
    func remake(file: String = #file, line: UInt = #line) -> ConstraintMaker {
        self.storage.deactivateAll()
        return ConstraintMaker(item: self, location: Debug.Location(file, line))
    }
}


/// Item (Attribute)
public extension Item {
    
    //===========================================
    // AttributeX
    //===========================================
    //
    /// left
    var left: AttributeX { .left(self) }
    
    /// right
    var right: AttributeX { .right(self) }
    
    /// leading
    var leading: AttributeX { .leading(self) }
    
    /// trailing
    var trailing: AttributeX { .trailing(self) }
    
    /// centerX
    var centerX: AttributeX { .centerX(self) }
    
    #if os(iOS) || os(tvOS)
    /// leftMargin
    var leftMargin: AttributeX { .leftMargin(self) }
    
    /// rightMargin
    var rightMargin: AttributeX { .rightMargin(self) }
    
    /// leadingMargin
    var leadingMargin: AttributeX { .leadingMargin(self) }
    
    /// trailingMargin
    var trailingMargin: AttributeX { .trailingMargin(self) }
    
    /// centerXWithinMargins
    var centerXWithinMargins: AttributeX { .centerXWithinMargins(self) }
    #endif
    
    //===========================================
    // AttributeY
    //===========================================
    //
    /// top
    var top: AttributeY { .top(self) }
    
    /// bottom
    var bottom: AttributeY { .bottom(self) }
    
    /// centerY
    var centerY: AttributeY { .centerY(self) }
    
    /// lastBaseline
    var lastBaseline: AttributeY { .lastBaseline(self) }
    
    /// firstBaseline
    var firstBaseline: AttributeY { .firstBaseline(self) }
    
    #if os(iOS) || os(tvOS)
    /// topMargin
    var topMargin: AttributeY { .topMargin(self) }
    
    /// bottomMargin
    var bottomMargin: AttributeY { .bottomMargin(self) }
    
    /// centerYWithinMargins
    var centerYWithinMargins: AttributeY { .centerYWithinMargins(self) }
    #endif
    
    //===========================================
    // AttributeSize
    //===========================================
    //
    /// width
    var width: AttributeSize { .width(self) }
    
    /// height
    var height: AttributeSize { .height(self) }
}


/// Item (Debugging)
public extension Item {
    
    /// attaching a debug-label for current View/LayoutGuide
    @discardableResult
    func labeled(_ lb: String) -> Self {
        self.storage.labeled = lb
        return self
    }
}


/// Item (ConstraintsStorage)
extension Item {
    
    /// storage
    var storage: ConstraintsStorage {
        if let s = self._storage {
            return s
        } else {
            let s = ConstraintsStorage()
            self._storage = s
            return s
        }
    }
    
    /// _storage
    var _storage: ConstraintsStorage? {
        get { objc_getAssociatedObject(self, &_storageKey) as? ConstraintsStorage }
        set { objc_setAssociatedObject(self, &_storageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}


/// _storage Key
private var _storageKey: Void?
