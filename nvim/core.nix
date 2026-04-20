{ ... }:

{

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  opts = {
clipboard = "unnamedplus";
    # --- UI basics ---
    number = true;
    relativenumber = true;
    termguicolors = true;
    signcolumn = "yes";

    # --- responsiveness ---
    updatetime = 200;
    timeoutlen = 300;
    ttimeoutlen = 10;

    # --- editing feel ---
    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;
    smartindent = true;

    # --- search behavior ---
    ignorecase = true;
    smartcase = true;
    incsearch = true;

    # --- performance-oriented ---
    swapfile = false;
    backup = false;
    writebackup = false;
    undofile = true;

    # reduces redraw overhead
    lazyredraw = true;

    # smoother scrolling behavior
    scrolloff = 8;
    sidescrolloff = 8;
  };

  # --- essential performance autocmd tweaks ---
  autoCmd = [
    {
      event = "BufEnter";
      pattern = "*";
      command = "setlocal formatoptions-=cro";
    }
  ];
}
