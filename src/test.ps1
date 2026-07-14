Describe 'app.js' {
    BeforeAll {
        $scriptPath = Join-Path $PSScriptRoot 'app.js'
        $node = (Get-Command node -ErrorAction SilentlyContinue).Source
        $jsPath = $scriptPath.Replace('\', '/')
    }

    Context 'greet() function' {
        It 'returns Hello, World! for greet("World")' {
            $result = & $node -e "const g = require('$jsPath'); console.log(g('World'));"
            $result | Should -Be 'Hello, World!'
        }

        It 'returns Hello, Mohamed! for greet("Mohamed")' {
            $result = & $node -e "const g = require('$jsPath'); console.log(g('Mohamed'));"
            $result | Should -Be 'Hello, Mohamed!'
        }
    }

    Context 'CLI mode' {
        It 'prints Hello, World! when no args' {
            $result = & $node $scriptPath
            $result | Should -Be 'Hello, World!'
        }

        It 'prints Hello, Ahmed! when passed Ahmed' {
            $result = & $node $scriptPath 'Ahmed'
            $result | Should -Be 'Hello, Ahmed!'
        }
    }

    Context 'prerequisites' {
        It 'has Node.js installed' {
            $node | Should -Not -BeNullOrEmpty
        }
    }
}
