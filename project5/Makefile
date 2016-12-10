NAME = report2168

all: $(NAME).pdf

$(NAME).pdf: $(NAME).tex
	pdflatex $(NAME)
	pdflatex $(NAME)

clean:
	rm -rf *.log *.aux *.bbl *.blg *.spl *.toc $(NAME).pdf
