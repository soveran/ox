GS=./bin/gs
DEP=./bin/dep

REDIS_URL?=redis://127.0.0.1:6379

default: test

start: server

server:
	@$(GS) env $$(cat env.sh) shotgun -s puma -o 0.0.0.0

console:
	@$(GS) env $$(cat env.sh) irb -r ./cli

test:
	@$(GS) env $$(cat env.sh) cutest -r ./tests/helper.rb tests/*_test.rb

install: init update

init: .gs env.sh

# Create gemset
.gs:
	@mkdir -p ./.gs

# Environment variables
env.sh:
	@echo REDIS_URL=$(REDIS_URL) >> env.sh

# Install gems
update:
	@$(GS) $(DEP) install

help:
	@less ./doc/help
