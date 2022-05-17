#!/usr/bin/env ksh93

# Traité de la tabula: HTML (and maybe PDF?) generator for Markdown
# documentation in a "tabula-style".

# Include the global configuration file.
. /usr/etc/traite.conf

# Include some libraries that we will be using. 
. "${ADDERE}/posix-alt.shi"

# Cuz We're real
documents="$(realpath "$DOCUMENTS")"
www_output_directory="$(realpath "$WWW_DIRECTORY")"

# Cheap hack for getting a list for all the directories in the $documents
# directory, containing or not a valid tabula.
# This probably isn't bad-name safe, be aware.
docdir=( $(cd "$documents"; echo *) )

# This will be used when we will generate a custom HTML footer for the document
# in question.

traite_version='0.1-a'
ksh_version="${.sh.version}"
pandoc_version="$(pandoc -v | sed 1q)"
kernel_name="$(uname -s)"
kernel_release="$(uname -r)"
machine_host="$(uname -n)"

function main {
	generate_html_documents
}

function generate_html_documents {
	output="${OUTPUT:-index.html}"
	owd="$PWD"
	current_time="$(date +%F)"

	for ((i=0; i < $(n ${docdir[@]}); i++)); do
		# First of all: check if tabula.conf exist in all the
		# directories; if not, it's not a tabula.
		test -f "$documents/${docdir[$i]}/tabula.conf" \
			|| { printL 'ERROR: %s is not a tabula\n' \
		       	"${docdir[$i]}"; continue; } \
			&&  cd "$documents/${docdir[$i]}" \
		&& printL 'ACTION: Entered directory %s\n' "$documents/${docdir[$i]}"
		printL 'ACTION: Reading tabula.conf\n'
		. ./tabula.conf
		printL 'INFO:\nTitle: %s\nNumber of files: %s\nFiles: %s\n' \
			"$title" $(n ${files[@]}) "${files[@]}"

		# Determine absolute paths for files listed in tabula.conf
		for ((j=0; j < $(n ${files[@]}); j++)); do
			realfiles+=$(realpath "${files[$j]}")
		done
		printL 'ACTION: realpath'\''d files.\n'
		printL 'INFO:\nOriginal files: %s\nrealpath'\''d files: %s\n' \
			"${files[@]}" "${realfiles[@]}"
	
		deploy_directory="$www_output_directory/${docdir[$i]}"
		printL 'ACTION: Creating directory %s for the compiled files\n' \
		       	"$deploy_directory"
		test -d "$deploy_directory" -a -w "$deploy_directory" \
			|| mkdir -pv "$deploy_directory" 2>&1 | tee "$LOG"
		
		echo "$USE_FOOTER" | grep -i '^y' && generate_html_footer
		printL 'ACTION: Compiling documentation\n'
		md2html "${realfiles[@]}" "$deploy_directory/$output" "$title" \
			"$lang"
		
		# Go back to that same old place...
	        # Oh, sweet home old working directory!
		cd "$owd"
	done
}

function nuke_html_documents {
	# This function shall clean a specific directory that already contains
	# a built tabula --- in other words, that is already in HTML.
	return 0 # TODO: A safe rm'ng of files at $www_output_dir.
}

# Just a boilerplate for calling Pandoc, of course.
function md2html {
	files="$1"
	output="$2"
	title="$3"
	lang="$4"
	pandoc --highlight-style="$THEME" \
		--metadata title="$title" \
			--metadata lang="$lang"\
		"$files" \
		--output "$output" \
		--table-of-contents \
		-s --self-contained \
		--pdf-engine="${pdfengine:-xelatex}" \
		--verbose \
		${pandoc_opts[@]} \
		2>&1 | tee "$LOG"
}

function generate_html_footer {
	# I really hope all this works (in fact, it does).
	footer="$(realpath "$FOOTER")"
	tmpfooter="$(mktemp footer.XXXXXX.html)"
 
	printL \
	'ACTION: Generating a footer for the final HTML at %s, using %s as a base\n' \
	"$tmpfooter" "$footer"

	sed -e "s@%%author%%@$author@" \
	-e "s@%%project%%@$project@" \
	-e "s@%%copyright_year%%@$copyright_year@" \
	-e "s@%%date%%@$date@" \
	-e "s@%%pandoc_version%%@$pandoc_version@" \
	-e "s@%%ksh_version%%@$ksh_version@" \
	-e "s@%%machine_host%%@$machine_host@" \
       	-e "s@%%kernel_name%%@$kernel_name@" \
	-e "s@%%kernel_release%%@$kernel_release@" < "$footer" > "$tmpfooter"

	pandoc_opts+="-A "$tmpfooter""
}

# printL - print to log
# I did not put this into another file (library) because I don't think it's
# worth for now.

function printL { printf "$@" | tee "$LOG"; }

main $@
