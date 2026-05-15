local M = {
  name = "leap.nvim",
  url = "https://codeberg.org/andyg/leap.nvim",
  lazy = false,
  dependencies = {
    "tpope/vim-repeat",
  },

  opts = {
    max_phase_one_targets = nil,
    highlight_unlabeled_phase_one_targets = false,
    max_highlighted_traversal_targets = 10,
    case_sensitive = false,
    equivalence_classes = { " \t\r\n" },
    substitute_chars = {},
    safe_labels = "sfnut/SFNLHMUGTZ?",
    labels = "sfnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?",
  },

  config = function(_, opts)
    local leap = require("leap")

    for k, v in pairs(opts) do
      leap.opts[k] = v
    end

    leap.opts.on_beacons = function(targets, _, _)
      for _, t in ipairs(targets) do
        if t.label and t.beacon then
          t.beacon[1] = 0
        end
      end
    end

    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })

    vim.api.nvim_set_keymap(
      "n",
      "f",
      '<Cmd>lua require("leap").leap({ target = vim.fn.expand("<cword>") })<CR>',
      { noremap = true, silent = true }
    )

    vim.api.nvim_set_keymap(
      "n",
      "F",
      '<Cmd>lua require("leap").leap({ target = vim.fn.expand("<cword>"), backward = true })<CR>',
      { noremap = true, silent = true }
    )
  end,
}

return M
