import Testing
import AppKit
@testable import Ghostty

struct EditableTextFieldTests {
    @Test func cmdCReturnsCopy() {
        let event = makeKeyEvent(key: "c", modifiers: .command)
        #expect(EditableTextField.editAction(for: event) == .copy)
    }

    @Test func cmdXReturnsCut() {
        let event = makeKeyEvent(key: "x", modifiers: .command)
        #expect(EditableTextField.editAction(for: event) == .cut)
    }

    @Test func cmdCWithCapsLockReturnsCopy() {
        let event = makeKeyEvent(characters: "C", charactersIgnoringModifiers: "c", modifiers: [.command, .capsLock])
        #expect(EditableTextField.editAction(for: event) == .copy)
    }

    @Test func cmdXWithCapsLockReturnsCut() {
        let event = makeKeyEvent(characters: "X", charactersIgnoringModifiers: "x", modifiers: [.command, .capsLock])
        #expect(EditableTextField.editAction(for: event) == .cut)
    }

    @Test func cmdVReturnsNil() {
        let event = makeKeyEvent(key: "v", modifiers: .command)
        #expect(EditableTextField.editAction(for: event) == nil)
    }

    @Test func cmdZReturnsNil() {
        let event = makeKeyEvent(key: "z", modifiers: .command)
        #expect(EditableTextField.editAction(for: event) == nil)
    }

    @Test func cmdShiftCReturnsNil() {
        let event = makeKeyEvent(key: "c", modifiers: [.command, .shift])
        #expect(EditableTextField.editAction(for: event) == nil)
    }

    @Test func cmdOptionCReturnsNil() {
        let event = makeKeyEvent(key: "c", modifiers: [.command, .option])
        #expect(EditableTextField.editAction(for: event) == nil)
    }

    @Test func controlCReturnsNil() {
        let event = makeKeyEvent(key: "c", modifiers: .control)
        #expect(EditableTextField.editAction(for: event) == nil)
    }

    @Test func plainCReturnsNil() {
        let event = makeKeyEvent(key: "c", modifiers: [])
        #expect(EditableTextField.editAction(for: event) == nil)
    }

    private func makeKeyEvent(
        characters: String,
        charactersIgnoringModifiers: String,
        modifiers: NSEvent.ModifierFlags
    ) -> NSEvent {
        NSEvent.keyEvent(with: .keyDown, location: .zero,
                         modifierFlags: modifiers, timestamp: 0,
                         windowNumber: 0, context: nil,
                         characters: characters,
                         charactersIgnoringModifiers: charactersIgnoringModifiers,
                         isARepeat: false, keyCode: 0)!
    }

    private func makeKeyEvent(key: String, modifiers: NSEvent.ModifierFlags) -> NSEvent {
        makeKeyEvent(characters: key, charactersIgnoringModifiers: key, modifiers: modifiers)
    }
}
