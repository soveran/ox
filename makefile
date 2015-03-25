default: test

start: server

server:
	@env $$(cat env.sh) ./bin/gs shotgun -s puma -o 0.0.0.0

console:
	@env $$(cat env.sh) ./bin/gs irb -r ./cli

test:
	@env $$(cat env.sh) ./bin/gs cutest -r ./tests/helper.rb tests/*_test.rb tests/*/*_test.rb

install: init update

init: .gs env.sh

# Create gemset
.gs:
	@mkdir -p ./.gs

# Environment variables
env.sh:
	@echo REDIS_URL=redis://127.0.0.1:6379 >> env.sh

# Install gems
update:
	@./bin/gs ./bin/dep install

help:
	@less ./doc/help
