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
public extension ConstraintItem {
    
    /// make
    func make(file: String = #file, line: UInt = #line) -> ConstraintMaker {
        return ConstraintMaker(item: self, location: Debug.Location(file, line))
    }
    
    /// update
    func update(file: String = #file, line: UInt = #line) -> ConstraintUpdater {
        return ConstraintUpdater(item: self, location: Debug.Location(file, line))
    }
    
    /// remove
    func remove(file: String = #file, line: UInt = #line) -> ConstraintRemover {
        return ConstraintRemover(item: self, location: Debug.Location(file, line))
    }
    
    /// remake
    func remake(file: String = #file, line: UInt = #line) -> ConstraintMaker {
        self.storage.deactivateAll()
        return ConstraintMaker(item: self, location: Debug.Location(file, line))
    }
}


/// ConstraintItem (ConstraintAttribute)
public extension ConstraintItem {
    
    //===========================================
    // ConstraintAttributeX
    //===========================================
    //
    /// left
    var left: ConstraintAttributeX { return .left(self) }
    
    /// right
    var right: ConstraintAttributeX { return .right(self) }
    
    /// leading
    var leading: ConstraintAttributeX { return .leading(self) }
    
    /// trailing
    var trailing: ConstraintAttributeX { return .trailing(self) }
    
    /// centerX
    var centerX: ConstraintAttributeX { return .centerX(self) }
    
    #if os(iOS) || os(tvOS)
    /// leftMargin
    var leftMargin: ConstraintAttributeX { return .leftMargin(self) }
    
    /// rightMargin
    var rightMargin: ConstraintAttributeX { return .rightMargin(self) }
    
    /// leadingMargin
    var leadingMargin: ConstraintAttributeX { return .leadingMargin(self) }
    
    /// trailingMargin
    var trailingMargin: ConstraintAttributeX { return .trailingMargin(self) }
    
    /// centerXWithinMargins
    var centerXWithinMargins: ConstraintAttributeX { return .centerXWithinMargins(self) }
    #endif
    
    //===========================================
    // ConstraintAttributeY
    //===========================================
    //
    /// top
    var top: ConstraintAttributeY { return .top(self) }
    
    /// bottom
    var bottom: ConstraintAttributeY { return .bottom(self) }
    
    /// centerY
    var centerY: ConstraintAttributeY { return .centerY(self) }
    
    /// lastBaseline
    var lastBaseline: ConstraintAttributeY { return .lastBaseline(self) }
    
    /// firstBaseline
    var firstBaseline: ConstraintAttributeY { return .firstBaseline(self) }
    
    #if os(iOS) || os(tvOS)
    /// topMargin
    var topMargin: ConstraintAttributeY { return .topMargin(self) }
    
    /// bottomMargin
    var bottomMargin: ConstraintAttributeY { return .bottomMargin(self) }
    
    /// centerYWithinMargins
    var centerYWithinMargins: ConstraintAttributeY { return .centerYWithinMargins(self) }
    #endif
    
    //===========================================
    // ConstraintAttributeSize
    //===========================================
    //
    /// width
    var width: ConstraintAttributeSize { return .width(self) }
    
    /// height
    var height: ConstraintAttributeSize { return .height(self) }
}


/// ConstraintItem (Debugging)
public extension ConstraintItem {
    
    /// attaching a debug-label for current View/LayoutGuide
    func labeled(_ lb: String) -> ConstraintItem {
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
