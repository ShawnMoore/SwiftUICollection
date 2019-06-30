// Copyright 2004-present Facebook. All Rights Reserved.

import SwiftUI

// MARK: - CollectionBuilder
@_functionBuilder
struct CollectionBuilder {
  // MARK: Type Specific
  static func buildBlock(_ views: Text...) -> [CollectionSection<Text>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock(_ views: TextField...) -> [CollectionSection<TextField>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock(_ views: SecureField...) -> [CollectionSection<SecureField>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock(_ views: Image...) -> [CollectionSection<Image>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Label>(_ views: Button<Label>...) -> [CollectionSection<Button<Label>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Label, Destination>(_ views: PresentationButton<Label, Destination>...) -> [CollectionSection<PresentationButton<Label, Destination>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock(_ views: EditButton...) -> [CollectionSection<EditButton>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Label>(_ views: Toggle<Label>...) -> [CollectionSection<Toggle<Label>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Label, SelectionValue, Content>(_ views: Picker<Label, SelectionValue, Content>...) -> [CollectionSection<Picker<Label, SelectionValue, Content>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Label>(_ views: DatePicker<Label>...) -> [CollectionSection<DatePicker<Label>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock(_ views: Slider...) -> [CollectionSection<Slider>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Label>(_ views: Stepper<Label>...) -> [CollectionSection<Stepper<Label>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<SelectionValue, Content>(_ views: SegmentedControl<SelectionValue, Content>...) -> [CollectionSection<SegmentedControl<SelectionValue, Content>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Selection, Content>(_ views: List<Selection, Content>...) -> [CollectionSection<List<Selection, Content>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Content>(_ views: Form<Content>...) -> [CollectionSection<Form<Content>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Content>(_ views: Group<Content>...) -> [CollectionSection<Group<Content>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Parent, Content, Footer>(_ views: Section<Parent, Content, Footer>...) -> [CollectionSection<Section<Parent, Content, Footer>>] {
    return [CollectionSection(content: views)]
  }

  static func buildBlock<Data, Content>(_ views: ForEach<Data, Content>...) -> [CollectionSection<Content>] {
    return views.reduce(into: Array<CollectionSection<Content>>()) { (result, forEach) in
      let views = forEach.data.map({ forEach.content($0.identifiedValue) })
      let section = CollectionSection(content: views)

      result.append(section)
    }
  }

  static func buildBlock<Content>(_ views: CollectionSection<Content>...) -> [CollectionSection<Content>] {
    return views
  }

  static func buildBlock(_ views: AnyView...) -> [CollectionSection<AnyView>] {
    return [CollectionSection(content: views)]
  }
}
