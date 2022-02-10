%---------------------------------------------------------------------------%
%-                                                                         -%
%-                           Document Class                                -%
%-                                                                         -%
%---------------------------------------------------------------------------%
%- Copyright (C) Huangrui Mo <huangrui.mo@gmail.com>
%- This is free software: you can redistribute it and/or modify it
%- under the terms of the GNU General Public License as published by
%- the Free Software Foundation, either version 3 of the License, or
%- (at your option) any later version.
%---------------------------------------------------------------------------%
%->> Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{xjuthesis}[2014/10/01 v1.0 LaTeX document class]%
%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
%-
%-> Layout
%-

\newif\ifxju@singlesided \xju@singlesidedfalse
\DeclareOption{singlesided}{% enable single-sided printing
    \xju@singlesidedtrue%
}
\newif\ifxju@doublesided \xju@doublesidedfalse
\DeclareOption{doublesided}{% enable double-sided printing
    \xju@doublesidedtrue%
}
\newif\ifxju@printcopy \xju@printcopyfalse
\DeclareOption{printcopy}{% enable print copy layout
    \xju@doublesidedtrue% auto enable double-sided style
    \xju@printcopytrue%
}
%-
%-> Draft version info
%-
\newif\ifxju@versioninfo \xju@versioninfofalse
\DeclareOption{draftversion}{%
    \xju@versioninfotrue%
}
%-
%-> Handle non-implemented options
%-
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{ctexbook}%
}
%-
%-> Terminates all options processing
%-
\ProcessOptions\relax%
%---------------------------------------------------------------------------%
%->> Load class information
%---------------------------------------------------------------------------%
\ifxju@doublesided% if double-sided printing enabled
    \LoadClass[UTF8,a4paper,twoside,zihao=-4]{ctexbook}
\else% if double-sided printing isn't enabled
    \LoadClass[UTF8,a4paper,oneside,zihao=-4]{ctexbook}
\fi
%---------------------------------------------------------------------------%
%->> Required packages
%---------------------------------------------------------------------------%
\RequirePackage{ifxetex}% LaTeX engine detection
\RequirePackage{etoolbox}% a toolbox of programming facilities
\newcommand{\xjuifstreq}{\expandafter\ifstrequal\expandafter}% expansion control
\newcommand{\xjuifstrbk}{\expandafter\ifblank\expandafter}% expansion control
%---------------------------------------------------------------------------%
%->> Load class configuration
%---------------------------------------------------------------------------%
\AtEndOfPackage{% class cfg loaded after package to make preamble commands take effect
    \makeatletter
    \InputIfFileExists{Style/xjuthesis.cfg}{}{}
    \makeatother
}
%---------------------------------------------------------------------------%
%->> Page layout
%---------------------------------------------------------------------------%
%- part one -- horizontal widths
%- left side width + textwidth + right side width = paperwidth
%- binding side width + textwidth + nonbinding side width = paperwidth
%- binding side width of [odd, even] page = [left, right] side width
%- left side width of [odd, even] page = 1.0in (fixed) + hoffset + [odd, even]sidemargin
%- assuming A4 paper (210mm x 297mm)
\setlength{\textwidth}{150mm}% set required text width first
\setlength{\hoffset}{0mm}% set horizontal offset
\ifxju@printcopy% if print copy layout enabled
    \setlength{\oddsidemargin}{12.6mm}% binding side margin
    \setlength{\evensidemargin}{0mm}% ensure uniform binding side width for printing
\else
    \setlength{\oddsidemargin}{4.3mm}% left side margin
    \setlength{\evensidemargin}{4.3mm}% ensure uniform left side width for EThesis
\fi
\setlength{\marginparwidth}{0pt}% width of margin notes
\setlength{\marginparsep}{0pt}% width of space between body text and margin notes
%- part two -- vertical heights
%- top height + textheight + bottom height = paperheight
%- top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep
%- top height = 3.0 cm = 25.4 - 17.4 + 0 + 14 + 8
\setlength{\textheight}{230.14mm}% set required text height first
\setlength{\voffset}{-17.4mm}% set vertical offset
\setlength{\topmargin}{0mm}% vertical margin above header
\setlength{\headheight}{14mm}% header height
\setlength{\headsep}{8mm}% vertical margin between header and body text
\setlength{\footskip}{18.86mm}% vertical margin between footer and body text
%- specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%- line spacing
\linespread{1.39}% line space setting
\raggedbottom% prevent adding vertical white space in strange places
%- default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%---------------------------------------------------------------------------%
%->> Style control commands
%---------------------------------------------------------------------------%
%- redefine cleardoublepage to have page style argument
\renewcommand{\cleardoublepage}[1][plain]{%
    \clearpage\if@twoside\ifodd\c@page\else%
    \thispagestyle{#1}%
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}
%- underline
\ifxetex% use underline from xeCJKfntef
    \newcommand{\CJKunderlinecolor}{\color[rgb]{0,0,0}}% set underline color
    \newcommand{\uline}[1]{\CJKunderline{#1}}% unified name
\else% use underline from ulem
    \RequirePackage{ulem}%
\fi
\newcommand{\ulenhance}[2][1pt]{% enhanced underline
    \def\ULthickness{#1}% set thickness
    \uline{#2}}
\newcommand{\ulhshift}{-4em}% horizontal shift on underline
\newcommand{\ulextend}[2][350pt]{% extend underline length
    \hbox to #1{\hfill\hspace*{\ulhshift}#2\hfill}}
%---------------------------------------------------------------------------%
%->> Titlepage
%---------------------------------------------------------------------------%
%-
%-> Chinese item commands
%-
\def\xju@value@schoollogo{}
\newcommand{\schoollogo}[1]{\def\xju@value@schoollogo{#1}}
\def\xju@value@ctitle{}
\newcommand{\ctitle}[1]{\def\xju@value@ctitle{#1}}
\def\xju@value@etitle{}
\newcommand{\etitle}[1]{\def\xju@value@etitle{#1}}
\def\xju@value@author{}
\renewcommand{\author}[1]{\def\xju@value@author{#1}}
\def\xju@value@major{}
\newcommand{\major}[1]{\def\xju@value@major{#1}}
\def\xju@value@researchdirection{}
\newcommand{\researchdirection}[1]{\def\xju@value@researchdirection{#1}}
\def\xju@value@advisor{}
\newcommand{\advisor}[1]{\def\xju@value@advisor{#1}}

%-
%-> Redefine Chinese style
%-
\renewcommand{\maketitle}
    {%
    \cleardoublepage
    \thispagestyle{empty}

    \title{}
    %
    {\noindent\zihao{4}\bfseries\heiti {\xju@label@masthesis}}

    \begin{center}
        \linespread{1.5}

        \vspace*{\stretch{5}}

        %{\chuhao\hwxk\xju@label@universityname}
        \begin{figure}[!htbp]
            \centering
            \includegraphics{\xju@value@schoollogo}
        \end{figure}

        \vspace*{\stretch{5.5}}

        \def\tabcolsep{1pt}
        \def\arraystretch{1.3}

        \begin{tabular}{p{4.2cm}p{10cm}}
            \zihao{-3}\bfseries\songti\xju@label@ctitle & \zihao{-3}\bfseries\songti\xju@value@ctitle\\
            \zihao{-3}\bfseries\songti\xju@label@etitle & \zihao{-3}\bfseries\songti\xju@value@etitle\\
            \zihao{-3}\bfseries\songti\xju@label@author & \zihao{-3}\bfseries\songti\xju@value@author\\
            \zihao{-3}\bfseries\songti\xju@label@major & \zihao{-3}\bfseries\songti\xju@value@major\\
            \zihao{-3}\bfseries\songti\xju@label@researchdirection & \zihao{-3}\bfseries\songti\xju@value@researchdirection\\
            \zihao{-3}\bfseries\songti\xju@label@advisor & \zihao{-3}\bfseries\songti\xju@value@advisor\\
        \end{tabular}

        \vspace*{\stretch{5}}

        {\zihao{4}\heiti\xju@label@replydate}\\
        {\zihao{4}\heiti\xju@label@dateofdegreeaward}

    \end{center}
    \clearpage  %添加新的一页
    \if@twoside
        \thispagestyle{empty}
        \ifxju@versioninfo
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
        \fi
        \cleardoublepage[empty]
    \else
        \ifxju@versioninfo
            \thispagestyle{empty}
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
            \cleardoublepage[empty]
        \fi
    \fi
}
%---------------------------------------------------------------------------%
%->> New environments
%---------------------------------------------------------------------------%
%- define chinese keywords
\newcommand{\keywords}[1]{%
    \vspace{\baselineskip}
    \noindent {\bfseries \xju@label@keywords} #1}
%- define engish keywords
\newcommand{\englishkeywords}[1]{%
    \vspace{\baselineskip}
    \noindent {\bfseries \xju@label@englishkeywords} #1}
%---------------------------------------------------------------------------%
%->> Configure table of contents
%---------------------------------------------------------------------------%
%- define spacing and length
\def\@dotsep{1.5mu}% spacing for dots
\def\@pnumwidth{2em}% spacing between titles and page numbers
\def\@tocrmarg{2em}% right margin indentation
\def\@chaptervspace{1ex}% spacing between chapter titles
%- redefine dottedtocline from classes.dtx and latex.ltx
\renewcommand*{\@dottedtocline}[5]{% [<level>,<indent>,<numwidth>,<title>,<page>]
    \ifnum #1>\c@tocdepth \else
        \vskip \z@ \@plus.2\p@
        {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
        \parindent #2\relax\@afterindenttrue
        \interlinepenalty\@M
        \leavevmode \zihao{4}\sffamily
        \@tempdima #3\relax
        \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
        {#4}\nobreak
        \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}\hfill
        \nobreak
        \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
        \par\penalty\@highpenalty}%
    \fi
}
%- redefine l@part from book.cls to add dotted toc line
\renewcommand*{\l@part}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >-2\relax
        \addpenalty{-\@highpenalty}%
        \addvspace{2.25em \@plus\p@}%
        \setlength\@tempdima{3em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            {\leavevmode
            \zihao{4}\sffamily #1
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
            \nobreak
            \global\@nobreaktrue
            \everypar{\global\@nobreakfalse\everypar{}}%
        \endgroup
    \fi
}
%- redefine l@chapter from book.cls to add dotted toc line
\renewcommand*{\l@chapter}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \vskip \@chaptervspace \@plus\p@
        \setlength\@tempdima{1.5em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \zihao{4}\sffamily
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1\nobreak
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
            \penalty\@highpenalty
        \endgroup
    \fi
}
%---------------------------------------------------------------------------%
\endinput
