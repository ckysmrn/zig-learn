This repo dedicated to learn [Zig](https://ziglang.org) and provide remote [Zls](https://github.com/zigtools/zls) in Github Codespace to use with neovim locally.


- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

```lua

local zls_json = vim.fn.getcwd() .. "/zls.json"
zls_json = vim.fn.filereadable(zls_json) == 1 and zls_json or nil
lspconfig.zls.setup{
  on_new_config = function (config)
     config.cmd = vim.lsp.rpc.connect('127.0.0.1', 9000)

  end,
  cmd = vim.lsp.rpc.connect('127.0.0.1', 9000),
  settings = {
     config_path = zls_json,
  }
}
```


- [cli.github.com](https://cli.github.com)

```sh nohup gh cs ports forward 9000:9000 > $TMPDIR/ports.log 2>&1 &```

- [./scripts/zls](./scripts/zls)

```sh ./scripts/zls```




## Don't ask me, I just learn.
