// Copyright 2004-present Facebook. All Rights Reserved.

import SwiftUI

// MARK: - CollectionBuilder
@_functionBuilder
struct CollectionBuilder {
  // MARK: Type Specific
  static func buildBlock(_ views: Text...) -> [CollectionSection<EmptyView, EmptyView, Text>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock(_ views: TextField...) -> [CollectionSection<EmptyView, EmptyView, TextField>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock(_ views: SecureField...) -> [CollectionSection<EmptyView, EmptyView, SecureField>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock(_ views: Image...) -> [CollectionSection<EmptyView, EmptyView, Image>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Label>(_ views: Button<Label>...) -> [CollectionSection<EmptyView, EmptyView, Button<Label>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Label, Destination>(_ views: PresentationButton<Label, Destination>...) -> [CollectionSection<EmptyView, EmptyView, PresentationButton<Label, Destination>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock(_ views: EditButton...) -> [CollectionSection<EmptyView, EmptyView, EditButton>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Label>(_ views: Toggle<Label>...) -> [CollectionSection<EmptyView, EmptyView, Toggle<Label>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Label, SelectionValue, Content>(_ views: Picker<Label, SelectionValue, Content>...) -> [CollectionSection<EmptyView, EmptyView, Picker<Label, SelectionValue, Content>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Label>(_ views: DatePicker<Label>...) -> [CollectionSection<EmptyView, EmptyView, DatePicker<Label>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock(_ views: Slider...) -> [CollectionSection<EmptyView, EmptyView, Slider>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Label>(_ views: Stepper<Label>...) -> [CollectionSection<EmptyView, EmptyView, Stepper<Label>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<SelectionValue, Content>(_ views: SegmentedControl<SelectionValue, Content>...) -> [CollectionSection<EmptyView, EmptyView, SegmentedControl<SelectionValue, Content>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Selection, Content>(_ views: List<Selection, Content>...) -> [CollectionSection<EmptyView, EmptyView, List<Selection, Content>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Content>(_ views: Form<Content>...) -> [CollectionSection<EmptyView, EmptyView, Form<Content>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Content>(_ views: Group<Content>...) -> [CollectionSection<EmptyView, EmptyView, Group<Content>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Parent, Content, Footer>(_ views: Section<Parent, Content, Footer>...) -> [CollectionSection<EmptyView, EmptyView, Section<Parent, Content, Footer>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Data, Content>(_ views: ForEach<Data, Content>...) -> [CollectionSection<EmptyView, EmptyView, Content>] {
    return views.reduce(into: Array<CollectionSection<EmptyView, EmptyView, Content>>()) { (result, forEach) in
      let views = forEach.data.map({ forEach.content($0.identifiedValue) })
      let section = CollectionSection(content: views)

      result.append(section)
    }
  }

  static func buildBlock<Parent, Footer, Content>(_ views: CollectionSection<Parent, Footer, Content>...) -> [CollectionSection<Parent, Footer, Content>] {
    return views
  }

  static func buildBlock(_ views: AnyView...) -> [CollectionSection<EmptyView, EmptyView, AnyView>] {
    return [CollectionSection(content: views)]
  }
}

// MARK: - CollectionSectionBuilder
@_functionBuilder
struct CollectionSectionBuilder {
  // MARK: Type Specific
  static func buildBlock(_ views: Text...) -> [Text] {
    return views
  }

  static func buildBlock(_ views: TextField...) -> [TextField] {
    return views
  }

  static func buildBlock(_ views: SecureField...) -> [SecureField] {
    return views
  }

  static func buildBlock(_ views: Image...) -> [Image] {
    return views
  }

  static func buildBlock<Label>(_ views: Button<Label>...) -> [Button<Label>] {
    return views
  }

  static func buildBlock<Label, Destination>(_ views: PresentationButton<Label, Destination>...) -> [PresentationButton<Label, Destination>] {
    return views
  }

  static func buildBlock(_ views: EditButton...) -> [EditButton] {
    return views
  }

  static func buildBlock<Label>(_ views: Toggle<Label>...) -> [Toggle<Label>] {
    return views
  }

  static func buildBlock<Label, SelectionValue, Content>(_ views: Picker<Label, SelectionValue, Content>...) -> [Picker<Label, SelectionValue, Content>] {
    return views
  }

  static func buildBlock<Label>(_ views: DatePicker<Label>...) -> [DatePicker<Label>] {
    return views
  }

  static func buildBlock(_ views: Slider...) -> [Slider] {
    return views
  }

  static func buildBlock<Label>(_ views: Stepper<Label>...) -> [Stepper<Label>] {
    return views
  }

  static func buildBlock<SelectionValue, Content>(_ views: SegmentedControl<SelectionValue, Content>...) -> [SegmentedControl<SelectionValue, Content>] {
    return views
  }

  static func buildBlock<Selection, Content>(_ views: List<Selection, Content>...) -> [List<Selection, Content>] {
    return views
  }

  static func buildBlock<Content>(_ views: Form<Content>...) -> [Form<Content>] {
    return views
  }

  static func buildBlock<Content>(_ views: Group<Content>...) -> [Group<Content>] {
    return views
  }

  static func buildBlock<Parent, Content, Footer>(_ views: Section<Parent, Content, Footer>...) -> [Section<Parent, Content, Footer>] {
    return views
  }

  static func buildBlock<Data, Content>(_ views: ForEach<Data, Content>...) -> [Content] {
    return views.reduce(into: [Content]()) { (result, forEach) in
      let views = forEach.data.map({ forEach.content($0.identifiedValue) })

      result.append(contentsOf: views)
    }
  }

  static func buildBlock(_ views: AnyView...) -> [AnyView] {
    return views
  }
}

// MARK: - CollectionGroupBuilder
@_functionBuilder
struct CollectionGroupBuilder {
  static func buildBlock<Content>(_ views: Content...) -> [Content] {
    return views
  }
}
