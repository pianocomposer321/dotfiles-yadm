return {
  {
    'fgheng/winbar.nvim',
    event = "BufReadPre",
    -- enabled = false,
    opts = {
      enabled = true,
      show_file_path = true,
      exclude_filetype = {
        "minifiles",
      },
    }
  },
}
