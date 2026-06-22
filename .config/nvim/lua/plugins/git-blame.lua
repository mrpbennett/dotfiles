-- https://github.com/f-person/git-blame.nvim
return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    enabled = true,
    message_template = " <summary> • <date> • <author> • <<sha>>",
    message_when_not_committed = "",
    date_format = "%r",
    virtual_text_column = 10,
  },
}
