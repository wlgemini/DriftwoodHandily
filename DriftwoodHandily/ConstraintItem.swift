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


/// ConstraintItem (ConstraintAttribute)
public extension ConstraintItem {
    
    //===========================================
    // ConstraintAttributeX
    //===========================================
    //
    /// left
    var left: ConstraintAttributeX { .left(self) }
    
    /// right
    var right: ConstraintAttributeX { .right(self) }
    
    /// leading
    var leading: ConstraintAttributeX { .leading(self) }
    
    /// trailing
    var trailing: ConstraintAttributeX { .trailing(self) }
    
    /// centerX
    var centerX: ConstraintAttributeX { .centerX(self) }
    
    #if os(iOS) || os(tvOS)
    /// leftMargin
    var leftMargin: ConstraintAttributeX { .leftMargin(self) }
    
    /// rightMargin
    var rightMargin: ConstraintAttributeX { .rightMargin(self) }
    
    /// leadingMargin
    var leadingMargin: ConstraintAttributeX { .leadingMargin(self) }
    
    /// trailingMargin
    var trailingMargin: ConstraintAttributeX { .trailingMargin(self) }
    
    /// centerXWithinMargins
    var centerXWithinMargins: ConstraintAttributeX { .centerXWithinMargins(self) }
    #endif
    
    //===========================================
    // ConstraintAttributeY
    //===========================================
    //
    /// top
    var top: ConstraintAttributeY { .top(self) }
    
    /// bottom
    var bottom: ConstraintAttributeY { .bottom(self) }
    
    /// centerY
    var centerY: ConstraintAttributeY { .centerY(self) }
    
    /// lastBaseline
    var lastBaseline: ConstraintAttributeY { .lastBaseline(self) }
    
    /// firstBaseline
    var firstBaseline: ConstraintAttributeY { .firstBaseline(self) }
    
    #if os(iOS) || os(tvOS)
    /// topMargin
    var topMargin: ConstraintAttributeY { .topMargin(self) }
    
    /// bottomMargin
    var bottomMargin: ConstraintAttributeY { .bottomMargin(self) }
    
    /// centerYWithinMargins
    var centerYWithinMargins: ConstraintAttributeY { .centerYWithinMargins(self) }
    #endif
    
    //===========================================
    // ConstraintAttributeSize
    //===========================================
    //
    /// width
    var width: ConstraintAttributeSize { .width(self) }
    
    /// height
    var height: ConstraintAttributeSize { .height(self) }
}


/// ConstraintItem (Debugging)
public extension ConstraintItem {
    
    /// attaching a debug-label for current View/LayoutGuide
    @discardableResult
    func labeled(_ lb: String) -> Self {
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
        get { objc_getAssociatedObject(self, &_storageKey) as? ConstraintsStorage }
        set { objc_setAssociatedObject(self, &_storageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}


/// _storage Key
fileprivate var _storageKey: Void?
