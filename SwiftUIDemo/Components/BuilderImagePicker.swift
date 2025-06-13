import SwiftUI
import PhotosUI

struct BuilderImagePickerController: UIViewControllerRepresentable {
  @Binding var image: UIImage?

  func makeUIViewController(context: Context) -> PHPickerViewController {
    var config = PHPickerConfiguration(photoLibrary: .shared())
    config.filter = .images
    config.selectionLimit = 1

    let picker = PHPickerViewController(configuration: config)
    picker.delegate = context.coordinator
    return picker
  }

  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    // No need to update UI here
  }

  func makeCoordinator() -> BuilderImagePicker {
      BuilderImagePicker(self)
  }

  class BuilderImagePicker: NSObject, PHPickerViewControllerDelegate {
    private let parent: BuilderImagePickerController

    init(_ parent: BuilderImagePickerController) {
      self.parent = parent
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      picker.dismiss(animated: true)

      guard let provider = results.first?.itemProvider,
            provider.canLoadObject(ofClass: UIImage.self) else { return }

      provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
        guard let self = self else { return }

        if let image = object as? UIImage {
          DispatchQueue.main.async {
            self.parent.image = image
          }
        }
      }
    }
  }
}
