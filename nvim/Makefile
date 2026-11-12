CHROME ?= google-chrome

CHEATSHEET.pdf: CHEATSHEET.md cheatsheet.css
	tmp=$$(mktemp --suffix=.html) && \
	pandoc $< -s --section-divs --embed-resources -c cheatsheet.css \
		--metadata pagetitle="Neovim cheat-sheet" -o $$tmp && \
	$(CHROME) --headless --disable-gpu --no-pdf-header-footer --print-to-pdf=$@ $$tmp 2>/dev/null; \
	s=$$?; rm -f $$tmp; exit $$s
	@pdfinfo $@ | grep -q '^Pages: *1$$' || { echo "$@ no longer fits on one page" >&2; exit 1; }
