package com.ruin.intel.commands.hover

import com.ruin.intel.DUMMY_FILE_PATH
import com.ruin.intel.JAVA_PROJECT
import com.ruin.intel.values.Position
import com.ruin.intel.values.TextDocumentIdentifier
import org.intellivim.FileEditingTestCase

abstract class HoverCommandTestBase : FileEditingTestCase() {
    override val projectName: String
        get() = JAVA_PROJECT

    override val filePath: String
        get() = DUMMY_FILE_PATH

    protected fun checkHoverEquals(line: Int, char: Int, expected: String?) {
        val command = HoverCommand(TextDocumentIdentifier(file.url), Position(line, char))
        val result = command.execute()
        if (result.component2() != null)
            throw result.component2()!!
        assertEquals("Expected \"$expected\" but got: \n${result.get()}",
            expected, result.get())
        command.dispose()
    }
}
