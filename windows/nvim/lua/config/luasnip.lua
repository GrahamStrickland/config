-- LuaSnip setup --
require("luasnip.loaders.from_lua").lazy_load({paths = "~\\AppData\\Local\\nvim\\LuaSnip\\"})

require("luasnip").config.set_config({ 
    enable_autosnippets = true,
    store_selection_keys = "<CR>",
})
