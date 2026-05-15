local M = {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "VeryLazy" },
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
  end,
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },

  opts = {
    ensure_installed = require("utils.treesitter-ensure-installed"),
    auto_install = true,
  },

  config = function(_, opts)
    local ts = require("nvim-treesitter")

    ts.setup({
      auto_install = opts.auto_install,
    })

    if type(opts.ensure_installed) == "table" then
      ts.install(opts.ensure_installed)
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
      callback = function(args)
        if vim.treesitter.language.get_lang(vim.bo[args.buf].filetype) then
          pcall(vim.treesitter.start, args.buf)
        end
      end,
    })
  end,
}

return M
