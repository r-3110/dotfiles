--@see https://github.com/eetann/editprompt.nvim

---@module "lazy"
---@type LazyPluginSpec
return {
	"eetann/editprompt.nvim",
	dependencies = {
		"folke/snacks.nvim",
	},
	cmd = "Editprompt",
  -- stylua: ignore
  keys = {
    {
      "<leader>pi",
      "<Cmd>Editprompt input --auto-send<CR>",
      desc = "Editprompt: Input and send",
    },
    {
      "<leader>pI",
      "<Cmd>Editprompt input<CR>",
      desc = "Editprompt: Input",
    },
    {
      "<leader>pi",
      "<Cmd>Editprompt input --visual --auto-send<CR>",
      mode = "x",
      desc = "Editprompt: Visual input and send",
    },
    {
      "<leader>pI",
      "<Cmd>Editprompt input --visual<CR>",
      mode = "x",
      desc = "Editprompt: Visual input",
    },
    {
      "<leader>pp",
      "<Cmd>Editprompt history prev<CR>",
      desc = "Editprompt: Previous history",
    },
    {
      "<leader>pn",
      "<Cmd>Editprompt history next<CR>",
      desc = "Editprompt: Next history",
    },
    {
      "<leader>pd",
      "<Cmd>Editprompt dump<CR>",
      desc = "Editprompt: Dump",
    },
    {
      "<leader>ps",
      "<Cmd>Editprompt stash pop<CR>",
      desc = "Editprompt: Stash pop",
    },
    {
      "<leader>pS",
      "<Cmd>Editprompt stash push<CR>",
      desc = "Editprompt: Stash push",
    },
    {
      "<leader>pk",
      "<Cmd>Editprompt press_mode<CR>",
      desc = "Editprompt: Press mode",
    },
    {
      "<leader>k1",
      function() require("editprompt").press("1") end,
      desc = "Editprompt: Press 1"
    },
    {
      "<leader>k2",
      function() require("editprompt").press("2") end,
      desc = "Editprompt: Press 2"
    },
    {
      "<leader>k3",
      function() require("editprompt").press("3") end,
      desc = "Editprompt: Press 3"
    },
    {
      "<leader>k4",
      function() require("editprompt").press("4") end,
      desc = "Editprompt: Press 4"
    },
    {
      "<leader>k<CR>", function() require("editprompt").press("<CR>") end,
      desc = "Editprompt: Press <CR>"
    },
    {
      "<leader>kk",
      function() require("editprompt").press_mode() end,
      desc = "Editprompt: Press mode"
    },
  },
	---@module "editprompt"
	---@type editprompt.Config
	---@diagnostic disable-next-line: missing-fields
	opts = {},
}
