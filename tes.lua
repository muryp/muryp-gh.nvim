---pasing variable into env var in vim.fn.system
local foo = 'hello world\ndhfal"hello"'
vim.env.FOO = foo
print(vim.inspect(vim.fn.system 'echo $FOO'))
