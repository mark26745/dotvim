{

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  opts = {
    clipboard = "unnamedplus";
    number = true;
    relativenumber = true;
    ttimeoutlen = 10;
    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;
    smartindent = true;
    ignorecase = true;
    smartcase = true;
    incsearch = true;
    backup = false;
    writebackup = false;
    updatetime = 250;
    timeoutlen = 300;
    redrawtime = 1500;
    synmaxcol = 300;
    lazyredraw = false;
    swapfile = false;
    undofile = true;
    completeopt = [
      "menu"
      "menuone"
      "noselect"
    ];
    pumheight = 15;
    scrolloff = 8;
    sidescrolloff = 8;
    signcolumn = "yes";
    termguicolors = true;
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
