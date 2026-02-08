import AppKit

/// NSTextField subclass that ensures Cmd+C and Cmd+X reach the field editor
/// when used inside NSAlert accessory views. Ghostty's SurfaceView intercepts
/// these as terminal bindings before the sheet's text field can handle them.
class EditableTextField: NSTextField {

    enum EditAction {
        case copy, cut
    }

    /// Determines whether the given key event is a Cmd+C or Cmd+X that should
    /// be intercepted and forwarded to the field editor.
    static func editAction(for event: NSEvent) -> EditAction? {
        guard event.modifierFlags.intersection(.deviceIndependentFlagsMask)
                .subtracting(.capsLock) == .command else {
            return nil
        }

        switch event.charactersIgnoringModifiers?.lowercased() {
        case "c": return .copy
        case "x": return .cut
        default: return nil
        }
    }

    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        guard let action = Self.editAction(for: event),
              let editor = currentEditor() else {
            return super.performKeyEquivalent(with: event)
        }

        switch action {
        case .copy: editor.copy(nil)
        case .cut: editor.cut(nil)
        }

        return true
    }
}
