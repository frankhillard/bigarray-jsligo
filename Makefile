ligo_compiler=docker run --rm -v "$$PWD":"$$PWD" -w "$$PWD" ligolang/ligo:next
# ligo_compiler=../../../ligo
PROTOCOL_OPT=--protocol hangzhou
JSON_OPT=--michelson-format json

help:
	@echo  'Usage:'
	@echo  '  all             - Remove generated Michelson files, recompile smart contracts and lauch all tests'
	@echo  '  clean           - Remove generated Michelson files'
	@echo  '  compile         - Compiles smart contract Random'
	@echo  '  test            - Run integration tests (written in Ligo)'
	@echo  '  dry-run         - Simulate execution of entrypoints (with the Ligo compiler)'
	@echo  '  deploy          - Deploy smart contracts advisor & indice (typescript using Taquito)'
	@echo  ''

all: test

# compile: random

# random: random.tz random.json

# random.tz: contracts/main.mligo
# 	@echo "Compiling smart contract to Michelson"
# 	@$(ligo_compiler) compile contract $^ -e main $(PROTOCOL_OPT) > compiled/$@

# random.json: contracts/main.mligo
# 	@echo "Compiling smart contract to Michelson in JSON format"
# 	@$(ligo_compiler) compile contract $^ $(JSON_OPT) -e main $(PROTOCOL_OPT) > compiled/$@

# clean:
# 	@echo "Removing Michelson files"
# 	@rm compiled/*.tz compiled/*.json

test: test_ml_ligo_js test_js_ligo_js

test_ml_ligo_js: test/bigarray.test.forjs.mligo 
	@echo "Running integration tests"
	@$(ligo_compiler) run test $^ $(PROTOCOL_OPT)

test_js_ligo_js: test/bigarray.test.forjs.jsligo 
	@echo "Running integration tests"
	@$(ligo_compiler) run test $^ $(PROTOCOL_OPT)
