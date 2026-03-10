//
//  OnboardPage.swift
//  OnboardKit
//

import Foundation
import UIKit

public typealias OnboardPageCompletion = ((_ success: Bool, _ error: Error?) -> Void)
public typealias OnboardPageAction = (@escaping OnboardPageCompletion) -> Void

protocol ImgResource {
  func getImage() -> UIImage
}
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension ImageResource: ImgResource {
  func getImage() -> UIImage {
    UIImage(resource: self)
  }
}

public struct OnboardPage {
  enum ImageReference {
    case named(String)
    case resource(ImgResource)

    var image: UIImage? {
      switch self {
      case .named(let name): UIImage(named: name)
      case .resource(let resource): resource.getImage()
      }
    }
  }

  /// The title text used for the top label of the onboarding page
  let title: String

  /// An optional image to be used in the onboarding page
  ///
  /// - note: If no image is used, the description label will adjust fill the empty space
  let imageReference: ImageReference?

  /// An optional description text to be used underneath the image
  ///
  /// - note: If no description text is used, the image will adjust fill the empty space
  let description: String?

  /// The title text to be used for the secondary button that is used to advance to the next page
  let advanceButtonTitle: String

  /// The title text to be used for the optional action button on the page
  ///
  /// - note: If no action button title is set, the button will not appear
  let actionButtonTitle: String?

  /// The action to be called when tapping the action button on the page
  ///
  /// - note: calling the completion on the action will advance the onboarding to the next page
  let action: OnboardPageAction?

  public init(title: String,
              imageName: String? = nil,
              description: String?,
              advanceButtonTitle: String = NSLocalizedString("Next", comment: ""),
              actionButtonTitle: String? = nil,
              action: OnboardPageAction? = nil) {
    self.title = title
    self.imageReference = imageName.map { .named($0) }
    self.description = description
    self.advanceButtonTitle = advanceButtonTitle
    self.actionButtonTitle = actionButtonTitle
    self.action = action
  }

  @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
  public init(title: String,
              imageResrouce: ImageResource?,
              description: String?,
              advanceButtonTitle: String = NSLocalizedString("Next", comment: ""),
              actionButtonTitle: String? = nil,
              action: OnboardPageAction? = nil) {
    self.title = title
    self.imageReference = imageResrouce.map { .resource($0) }
    self.description = description
    self.advanceButtonTitle = advanceButtonTitle
    self.actionButtonTitle = actionButtonTitle
    self.action = action
  }
}
