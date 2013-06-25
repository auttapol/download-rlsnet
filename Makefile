TPL=smarty
DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#


#
# BUILD DOCS
#

def: all

all: server finish

server: node-app node-routes

finish:
	@echo "\nSuccessfully built at ${DATE}."


node-app:
	@echo "\n app... \n"
	@coffee -cbjvp ./script/app*.coffee > ./app

node-routes:
	@echo "\n routes... \n"
	@rm -fR ./public
	@mkdir -p ./public
	@coffee -o ./public -cb ./node_routes/

