# set terminal title to passed argument 
settitle() {
	x=$1
	PROMPT_COMMAND='echo -ne "\033]0;${x}\007"'
}

# go to main galaxy dev directory, and display pwd
galaxydev() {
	cd $GALAXYDEV;
	pwd;
}

# swap venv + clean python cache for current dir
# args: python version corresponding to a venv in $GALAXYVENVS
galaxyswap() {
	VENV=.venv

	# if current venv exists, remove it
	if [ -d $VENV ]; then
		rm -r $VENV
	fi

	# check that the argument is an existing venv
	NEW_VENV_PATH=$GALAXYVENVS/$1
	if ! [ -d $NEW_VENV_PATH ]; then
		echo "ERROR: argument not an existing venv"
		return
	fi

	# clean out python cache, etc.
	find . -name '*.pyc'       -exec rm -f {} +
	find . -name '*.pyo'       -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

	# delete compiled templates
	rm -rf database/compiled_templates

	# copy new venv
	cp -r $NEW_VENV_PATH $VENV
}
