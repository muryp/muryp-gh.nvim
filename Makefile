stylua:
	stylua --color always lua/
styluaCheck:
	stylua --color always --check lua/
lint:
	luacheck lua
init:
	cd .git && rm -rf hooks && ln -s ../.hooks && mv .hooks hooks