package com.ruin.lsp.commands.document.find

import com.ruin.lsp.*
import org.eclipse.lsp4j.Position

class FindDefinitionCommandTestCaseKt : FindDefinitionCommandTestBase() {
    override val projectName: String
        get() = KOTLIN_PROJECT

    fun `test finds superclass from subclass`() =
        checkFindsLocation(forKotlin(SUBCLASS_FILE_PATH),
            Position(6, 25), "SuperClass.kt", Position(5, 22))

    fun `test finds declaration from usage`() =
        checkFindsLocation(forKotlin(DUMMY_FILE_PATH),
            Position(43, 23), "Dummy.kt", Position(49, 15))

    fun `test finds declaration of class outside file`() =
        checkFindsLocation(forKotlin(DUMMY_FILE_PATH),
            Position(22, 21), "Problematic.kt", Position(5, 13))

    fun `test finds super method`() =
        checkFindsLocation(forKotlin(SUBCLASS_FILE_PATH),
            Position(10, 25), "SuperClass.kt", Position(9, 25))
}
