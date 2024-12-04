-- LuaSnip setup --
require("luasnip.loaders.from_lua").lazy_load({paths = "$HOME\\.vim\\LuaSnip/"})

require("luasnip").config.set_config({ 
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
})
