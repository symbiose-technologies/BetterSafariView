//////////////////////////////////////////////////////////////////////////////////
//
//  SYMBIOSE
//  Copyright 2023 Symbiose Technologies, Inc
//  All Rights Reserved.
//
//  NOTICE: This software is proprietary information.
//  Unauthorized use is prohibited.
//
// 
// Created by: Ryan Mckinney on 6/21/23
//
////////////////////////////////////////////////////////////////////////////////

import Foundation
#if os(iOS)
import SwiftUI
import SafariServices

/// A simple wrapper around SafariView that allows for a simple API for presenting a SafariView via
/// a fullScreenCover.

@available(iOS 14.0, *)
public struct SimpleSafariViewPresenter<Item: Identifiable>: ViewModifier  {
    
    @Binding var item: Item?
    var onDismiss: (() -> Void)? = nil
    var representationBuilder: (Item) -> SafariView_SUI
    
    public func body(content: Content) -> some View {
        content
            .fullScreenCover(item: $item, onDismiss: {
                print("onDismiss")
                self.onDismiss?()
            }) { item in
                representationBuilder(item)
            }
    }
    
}

public extension View {
    @available(iOS 14.0, *)
    func simpleSafariView<Item: Identifiable>(item: Binding<Item?>,
                                              onDismiss: (() -> Void)?,
                                              representationBuilder: @escaping (Item) -> SafariView_SUI) -> some View {
        self.modifier(SimpleSafariViewPresenter(
            item: item,
            onDismiss: onDismiss,
            representationBuilder: representationBuilder
        ))
    }

}


#endif
