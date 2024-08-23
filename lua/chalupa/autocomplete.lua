local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Insert
    }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Insert
    }),
    ['<CR>'] = cmp.mapping.confirm({
      select = true
    })
  },
  sources = cmp.config.sources({ {
    name = 'nvim_lsp'
  }, {
    name = 'luasnip'
  } }, { {
    name = 'buffer'
  } })
})

cmp.setup.cmdline('/', {
  sources = { {
    name = 'buffer'
  } }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({ {
    name = 'path'
  } }, { {
    name = 'cmdline'
  } })
})
