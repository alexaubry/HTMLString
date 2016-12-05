/*
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   HTMLStringTests.swift
 *  Project         :   HTMLString
 *  Author          :   ALEXIS AUBRY RADANOVIC
 *
 *  License         :   The MIT License (MIT)
 *
 * ==---------------------------------------------------------------------------------==
 *
 *	The MIT License (MIT)
 *	Copyright (c) 2016 ALEXIS AUBRY RADANOVIC
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy of
 *	this software and associated documentation files (the "Software"), to deal in
 *	the Software without restriction, including without limitation the rights to
 *	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 *	the Software, and to permit persons to whom the Software is furnished to do so,
 *	subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in all
 *	copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 *	FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 *	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 *	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ==---------------------------------------------------------------------------------==
 */

import XCTest
@testable import HTMLString

///
/// Tests HTML escaping/unescaping.
///

class HTMLStringTests: XCTestCase {

    // MARK: - Escaping

    ///
    /// Tests escaping a character for ASCII.
    ///

    func testCharacterASCIIEscape() {

        let namedEscape = Character("&").escapingForASCII
        XCTAssertTrue(namedEscape == "&AMP;" || namedEscape == "&amp;")

        let namedDualEscape = Character("⪰̸").escapingForASCII
        XCTAssertEqual(namedDualEscape, "&nsucceq;")

        let emojiEscape = Character("🙃").escapingForASCII
        XCTAssertEqual(emojiEscape, "&#128579;")

        let doubleEmojiEscape = Character("🇺🇸").escapingForASCII
        XCTAssertEqual(doubleEmojiEscape, "&#127482;&#127480;")

        let basicCharacterEscape = Character("A").escapingForASCII
        XCTAssertEqual(basicCharacterEscape, "A")

    }

    ///
    /// Tests escaping a character for Unicode.
    ///

    func testCharacterUnicodeEscape() {

        let requiredEscape = Character("&").escapingForUnicode
        XCTAssertTrue(requiredEscape == "&AMP;" || requiredEscape == "&amp;")

        let namedDualEscape = Character("⪰̸").escapingForUnicode
        XCTAssertEqual(namedDualEscape, "⪰̸")

        let emojiEscape = Character("🙃").escapingForUnicode
        XCTAssertEqual(emojiEscape, "🙃")

        let doubleEmojiEscape = Character("🇺🇸").escapingForUnicode
        XCTAssertEqual(doubleEmojiEscape, "🇺🇸")

        let basicCharacterEscape = Character("A").escapingForUnicode
        XCTAssertEqual(basicCharacterEscape, "A")

    }

    ///
    /// Tests escaping a string for ASCII.
    ///

    func testStringASCIIEscaping() {

        let namedEscape = ("Fish & Chips").escapingForASCIIHTML
        XCTAssertTrue(namedEscape == "Fish &AMP; Chips" || namedEscape == "Fish &amp; Chips")

        let namedDualEscape = ("a ⪰̸ b").escapingForASCIIHTML
        XCTAssertEqual(namedDualEscape, "a &nsucceq; b")

        let emojiEscape = ("Hey 🙃").escapingForASCIIHTML
        XCTAssertEqual(emojiEscape, "Hey &#128579;")

        let doubleEmojiEscape = ("Going to the 🇺🇸 next June").escapingForASCIIHTML
        XCTAssertEqual(doubleEmojiEscape, "Going to the &#127482;&#127480; next June")

    }

    ///
    /// Tests escaping a string for Unicode.
    ///

    func testStringUnicodeEscaping() {

        let requiredEscape = ("Fish & Chips").escapingForUnicodeHTML
        XCTAssertTrue(requiredEscape == "Fish &AMP; Chips" || requiredEscape == "Fish &amp; Chips")

        let namedDualEscape = ("a ⪰̸ b").escapingForUnicodeHTML
        XCTAssertEqual(namedDualEscape, "a ⪰̸ b")

        let emojiEscape = ("Hey 🙃!").escapingForUnicodeHTML
        XCTAssertEqual(emojiEscape, "Hey 🙃!")

        let doubleEmojiEscape = ("Going to the 🇺🇸 next June").escapingForUnicodeHTML
        XCTAssertEqual(doubleEmojiEscape, "Going to the 🇺🇸 next June")

    }

    // MARK: - Unescaping

    func testUnescaping() {

        let withoutMarker = "Hello, world.".unescapingFromHTML
        XCTAssertEqual(withoutMarker, "Hello, world.")

        let noSemicolon = "Fish & Chips"
        XCTAssertEqual(noSemicolon, "Fish & Chips")

        let decimal = "My phone number starts with a &#49;".unescapingFromHTML
        XCTAssertEqual(decimal, "My phone number starts with a 1")

        let invalidDecimal = "My phone number starts with a &#4_9;!".unescapingFromHTML
        XCTAssertEqual(invalidDecimal, "My phone number starts with a &#4_9;!")

        let hex = "Let's meet at the caf&#xe9;".unescapingFromHTML
        XCTAssertEqual(hex, "Let's meet at the café")

        let invalidHex = "Let's meet at the caf&#xzi;!".unescapingFromHTML
        XCTAssertEqual(invalidHex, "Let's meet at the caf&#xzi;!")

        let invalidUnicodePoint = "What is this character ? -> &#xd8ff;".unescapingFromHTML
        XCTAssertEqual(invalidHex, "What is this character ? -> &#xd8ff;")

        let badSequence = "I love &swift;".unescapingFromHTML
        XCTAssertEqual(badSequence, "I love &swift;")

        let goodSequence = "Do you know &aleph;?".unescapingFromHTML
        XCTAssertEqual(goodSequence, "Do you know ℵ?")

        let twoSequences = "a &amp;&amp; b".unescapingFromHTML
        XCTAssertEqual(twoSequences, "a && b")

    }

}

extension HTMLStringTests {

    static var allTests : [(String, (HTMLStringTests) -> () throws -> Void)] {
        return [
            ("testCharacterASCIIEscape", testCharacterASCIIEscape),
            ("testCharacterUnicodeEscape", testCharacterUnicodeEscape),
            ("testStringASCIIEscaping", testStringASCIIEscaping),
            ("testStringUnicodeEscaping", testStringUnicodeEscaping),
            ("testUnescaping", testUnescaping)
        ]
    }

}
