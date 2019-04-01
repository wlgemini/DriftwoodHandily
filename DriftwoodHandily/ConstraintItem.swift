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


/// ConstraintItem
public protocol ConstraintItem: AnyObject {
    
    /// superview
    var dwh_superview: ConstraintItem? { get }
    
    /// hashValue
    var dwh_hashValue: Int { get }
}


/// ConstraintItem (Make, Update, Remove, Remake constraint)
extension ConstraintItem {
    
    /// make
    public func make(file: String = #file, line: UInt = #line) -> ConstraintMaker {
        return ConstraintMaker(item: self, location: Debug.Location(file, line))
    }
    
    /// update
    public func update(file: String = #file, line: UInt = #line) -> ConstraintUpdater {
        return ConstraintUpdater(item: self, location: Debug.Location(file, line))
    }
    
    /// remove
    public func remove(file: String = #file, line: UInt = #line) -> ConstraintRemover {
        return ConstraintRemover(item: self, location: Debug.Location(file, line))
    }
    
    /// remake
    public func remake(file: String = #file, line: UInt = #line) -> ConstraintMaker {
        self.storage.deactivateAll()
        return ConstraintMaker(item: self, location: Debug.Location(file, line))
    }
}


/// ConstraintItem (ConstraintAttribute)
extension ConstraintItem {
    
    //===========================================
    // ConstraintAttributeX
    //===========================================
    //
    /// left
    public var left: ConstraintAttributeX { return .left(self) }
    
    /// right
    public var right: ConstraintAttributeX { return .right(self) }
    
    /// leading
    public var leading: ConstraintAttributeX { return .leading(self) }
    
    /// trailing
    public var trailing: ConstraintAttributeX { return .trailing(self) }
    
    /// centerX
    public var centerX: ConstraintAttributeX { return .centerX(self) }
    
    #if os(iOS) || os(tvOS)
    /// leftMargin
    public var leftMargin: ConstraintAttributeX { return .leftMargin(self) }
    
    /// rightMargin
    public var rightMargin: ConstraintAttributeX { return .rightMargin(self) }
    
    /// leadingMargin
    public var leadingMargin: ConstraintAttributeX { return .leadingMargin(self) }
    
    /// trailingMargin
    public var trailingMargin: ConstraintAttributeX { return .trailingMargin(self) }
    
    /// centerXWithinMargins
    public var centerXWithinMargins: ConstraintAttributeX { return .centerXWithinMargins(self) }
    #endif
    
    //===========================================
    // ConstraintAttributeY
    //===========================================
    //
    /// top
    public var top: ConstraintAttributeY { return .top(self) }
    
    /// bottom
    public var bottom: ConstraintAttributeY { return .bottom(self) }
    
    /// centerY
    public var centerY: ConstraintAttributeY { return .centerY(self) }
    
    /// lastBaseline
    public var lastBaseline: ConstraintAttributeY { return .lastBaseline(self) }
    
    /// firstBaseline
    public var firstBaseline: ConstraintAttributeY { return .firstBaseline(self) }
    
    #if os(iOS) || os(tvOS)
    /// topMargin
    public var topMargin: ConstraintAttributeY { return .topMargin(self) }
    
    /// bottomMargin
    public var bottomMargin: ConstraintAttributeY { return .bottomMargin(self) }
    
    /// centerYWithinMargins
    public var centerYWithinMargins: ConstraintAttributeY { return .centerYWithinMargins(self) }
    #endif
    
    //===========================================
    // ConstraintAttributeSize
    //===========================================
    //
    /// width
    public var width: ConstraintAttributeSize { return .width(self) }
    
    /// height
    public var height: ConstraintAttributeSize { return .height(self) }
}


/// ConstraintItem (Debugging)
extension ConstraintItem {
    
    /// attaching a debug-label for current View/LayoutGuide
    public func labeled(_ lb: String) -> ConstraintItem {
        self.storage.labeled = lb
        return self
    }
}


/// ConstraintItem (ConstraintsStorage)
extension ConstraintItem {
    
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
        get { return objc_getAssociatedObject(self, &_storageKey) as? ConstraintsStorage }
        set { objc_setAssociatedObject(self, &_storageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}


/// _storage Key
fileprivate var _storageKey: Void?
