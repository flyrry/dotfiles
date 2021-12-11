local ls = require"luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.snippets = {
    cpp = {
        s("aoc", {
            t({"#include \"aoc.h\"", "", "using namespace std;", "", "int main() {", "\t"}),
            i(1),
            t({"", "", "\treturn 0;", "}"}),
        })
    }
}
