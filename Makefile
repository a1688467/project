all:
	Rscript -e "targets::tar_make()"
	#open report.html and Readme.html
	#open doesn't work on Linux so find something else

