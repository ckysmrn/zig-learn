
REPO=$(git config remote.origin.url |
	# https://github.com/usr/repo -> usr/repo
	sed -e 's/https:\/\/github\.com\///' |
	# git@mayhavesubdomain.github.com:usr/repo -> usr/repo
	sed -e 's/git@[^:]\+://' |
	# usr/repo.git -> usr/repo
	sed -e 's/\.git$//'
)
BASENAME=$(basename $REPO) # usr/repo -> repo
