server:
	env $$(cat env.sh) shotgun -o 0.0.0.0

console:
	env $$(cat env.sh) irb -r ./app -r ./cli

test:
	env $$(cat env.sh) cutest -r ./tests/helper.rb tests/*_test.rb tests/*/*_test.rb
