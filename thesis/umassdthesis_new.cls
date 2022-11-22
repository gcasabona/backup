%%
%%  umassdthesis.cls 
%%      A LaTeX2e class for UMass Dartmouth Theses & Dissertations.
%%
%%  Grant O'Rielly
%%  grant.orielly@umassd.edu
%%
%%    CREATED
%%                                                        November 2007
%%    modified to produce undergraduate honors theses
%%                                                        January  2010
%%    modified to produce undergraduate (senior) theses
%%                                                        January  2014
%%    modified to correctly produce signature page for Ph.D. programs
%%                                                        May      2014
%%    modified based on Spring 2015 thesis guideline
%%                                                        May      2015
%%    modified to use titlesec and tocloft packages
%%      these provide fine-grain control re. the appearance
%%      of the chapter and section headings and the TOC pages
%%                                                        August   2016
%%    modified to use caption package
%%      this provides control re. appearance of Figure & Table captions
%%      set spacing above/below captions to 20 pt 
%%      set left/right margins for captions to 0.05\textwidth
%%                                                        December 2016
%%    modified to have three readers on the signature page
%%    for Ph.D dissertations
%%                                                        June     2017
%%
%%    added *penalty 500 to minimize orphan (at bottom)
%%    & widow (at top) lines on pages
%%    modfied tocloft to indent 2nd line of figure & title captions
%%                                                        August   2017
%%
%%  =========================================================================
%%
%%  Modified from the...
%%  Thesis.cls - LaTeX2e class for CU Theses.
%%  John Weiss, 1997
%%
%%  Modified from the...
%%  THESIS DOCUMENT STYLE -- 29 Feb 1987, substantially similar to the
%%  REPORT DOCUMENT STYLE -- Released 9 June 1987 for LaTeX version
%%  2.09, Copyright (C) 1987 by Leslie Lamport
%%
%%
%%  \CharacterTable
%%   {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%    Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%    Digits        \0\1\2\3\4\5\6\7\8\9
%%    Exclamation   \!     Double quote  \"     Hash (number) \#
%%    Dollar        \$     Percent       \%     Ampersand     \&
%%    Acute accent  \'     Left paren    \(     Right paren   \)
%%    Asterisk      \*     Plus          \+     Comma         \,
%%    Minus         \-     Point         \.     Solidus       \/
%%    Colon         \:     Semicolon     \;     Less than     \<
%%    Equals        \=     Greater than  \>     Question mark \?
%%    Commercial at \@     Left bracket  \[     Backslash     \\
%%    Right bracket \]     Circumflex    \^     Underscore    \_
%%    Grave accent  \`     Left brace    \{     Vertical bar  \|
%%    Right brace   \}     Tilde         \~}
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{umassdthesis}[2015/06/01 v2.0a Document Style `umassdthesis' 
for University of Massachusetts Dartmouth theses and dissertations <2015>.
For comments, assistance and modifications please contact the author:
Prof. Grant O'Rielly grant.orielly@umassd.edu]

%%  Modern LaTeX allows you to import a base class.  Since the original
%%  thesis.sty file is a modified version of a LaTeX ``report'', we use
%%  the 2e command \LoadClass to load the report.cls.  This comes later,
%%  though....

%%  Certain options are not handled here but are passed on to report.cls
%%  by \PassOptionToClass.
%%
\DeclareOption{fleqn}{%
  \PassOptionsToClass{fleqn}{report}%
}
\DeclareOption{leqno}{%
  \PassOptionsToClass{leqno}{report}%
}
\DeclareOption{openbib}{%
  \PassOptionsToClass{openbib}{report}%
}
\DeclareOption{draft}{%
  \PassOptionsToClass{draft}{report}%
}
\DeclareOption{final}{%
  \PassOptionsToClass{final}{report}%
}
\DeclareOption{openright}{%
  \PassOptionsToClass{openright}{report}%
}
\DeclareOption{openany}{%
  \PassOptionsToClass{openany}{report}%
}
\DeclareOption{10pt}{%
  \PassOptionsToClass{10pt}{report}%
}
\DeclareOption{11pt}{%
  \PassOptionsToClass{11pt}{report}%
}
\DeclareOption{12pt}{%
  \PassOptionsToClass{12pt}{report}%
}

%%  Invalid options - normally used in report.cls and others, but not
%%  here.
%%
\DeclareOption{titlepage}{%
  \ClassWarning{thesis}{Title page always generated.  Option ignored.}%
}
\DeclareOption{notitlepage}{%
  \ClassWarning{thesis}{Option 'notitlepage' not available for this class.}%
}
\DeclareOption{twoside}{%
  \ClassWarning{thesis}{Option 'twoside' not available for this class.}%
}
\DeclareOption{twocolumn}{%
  \ClassWarning{thesis}{Option 'twocolumn' not available for this class.}%
}
\DeclareOption{landscape}{%
  \ClassWarning{thesis}{Option 'landscape' not available for this class.}%
}
\DeclareOption{legalpaper}{%
  \ClassWarning{thesis}{Option 'legalpaper' not available for this class.}%
}
\DeclareOption{a4paper}{%
  \ClassWarning{thesis}{Option 'a4paper' not available for this class.}%
}
\DeclareOption{a5paper}{%
  \ClassWarning{thesis}{Option 'a5paper' not available for this class.}%
}
\DeclareOption{executivepaper}{%
  \ClassWarning{thesis}{Option 'executivepaper' not available for this class.}%
}
\DeclareOption{b5paper}{%
  \ClassWarning{thesis}{Option 'b5paper' not available for this class.}%
}
\DeclareOption{letterpaper}{%
  \ClassWarning{thesis}{Option 'letterpaper' superfluous.  Ignored.}%
}
\DeclareOption{onecolumn}{%
  \ClassWarning{thesis}{Option 'onecolumn' superfluous.  Ignored.}%
}
\DeclareOption{oneside}{%
  \ClassWarning{thesis}{Option 'oneside' superfluous.  Ignored.}%
}

%%
%%  Custom options.
%%  Options for no decimal numbering, or decimal number nested 
%%  over three (3) deep
%%
\newif\if@UndergradThesis \@UndergradThesisfalse
\newif\if@HonorThesis \@HonorThesisfalse
\newif\if@MasterThesis \@MasterThesisfalse
\newif\if@PhdThesis \@PhdThesisfalse
\newif\if@doneDean \@doneDeanfalse
\newif\if@doneChair \@doneChairfalse
\newif\if@doneGraddirector \@doneGraddirectorfalse
\newif\if@doneHonorsdirector \@doneHonorsdirectorfalse
%% 
%%  define formating options & default settings
%% 
\newif\if@AllHeadings \@AllHeadingsfalse
\newif\if@NumberStdHeadings \@NumberStdHeadingstrue
\newif\if@PerChptrNumbering \@PerChptrNumberingtrue
\newif\if@emphisbold \@emphisboldtrue
\newif\if@boldhead \@boldheadtrue
\newif\if@fixedHeadSz \@fixedHeadSzfalse
\newif\if@headSizeTwelvePt \@headSizeTwelvePttrue
\newif\if@centerChapter \@centerChaptertrue
\newif\if@centerSection \@centerSectionfalse
\newif\if@AlwaysFalse \@AlwaysFalsefalse
\newif\if@CenterHeading \@CenterHeadingfalse
\newif\if@UseStarCmd \@UseStarCmdfalse
\newif\if@inlineSubSubSection \@inlineSubSubSectionfalse
\newif\if@numberSubSubSection \@numberSubSubSectiontrue
\newif\if@chapterCaps \@chapterCapsfalse
\newif\if@thInHeading \@thInHeadingfalse
\newif\if@appendix \@appendixfalse
\newif\if@singleappendix \@singleappendixfalse
\newif\if@ChapterDefault
\newif\if@SectionDefault
\newif\if@SubSectionDefault
\newif\if@OtherHeadingDefault
%%
%%  set defaults
%%
\DeclareOption{consecutivenumbering}{%
  \@PerChptrNumberingfalse%
}
\DeclareOption{inlineh4}{%
  \@inlineSubSubSectiontrue%
}
\DeclareOption{nonumh4}{%
  \@numberSubSubSectionfalse%
}
\DeclareOption{centerh1}{%
  \@centerSectiontrue%
}
\DeclareOption{chapleft}{%
  \@centerSectiontrue%
}
\DeclareOption{chapup}{%
  \@chapterCapstrue%
}
\DeclareOption{emph2underline}{%
  \@emphisboldfalse%
}
\DeclareOption{plainhead}{%
  \@boldheadfalse%
}
\DeclareOption{fixedheadsize}{%
  \@fixedHeadSztrue%
}
\DeclareOption{varheadsize}{% Hidden option.  Don't use.
  \@headSizeTwelvePtfalse%
}
\DeclareOption{numberchapteronly}{%
  \@PerChptrNumberingfalse\@NumberStdHeadingsfalse\@AllHeadingsfalse%
  \@CenterChaptertrue\@centerSectiontrue%
  \@inlineSubSubSectiontrue\@numberSubSubSectionfalse%
}
\DeclareOption{allheadings}{%
  \@PerChptrNumberingtrue\@NumberStdHeadingstrue\@AllHeadingstrue%
  \@centerChaptertrue\@centerSectionfalse%
  \@inlineSubSubSectionfalse\@numberSubSubSectiontrue%
}
\DeclareOption{typewriterstyle}{%
  \@emphisboldfalse%
  \@PerChptrNumberingfalse\@NumberStdHeadingsfalse\@AllHeadingsfalse%
  \@centerChaptertrue\@centerSectiontrue\@chapterCapstrue%
  \@inlineSubSubSectiontrue\@numberSubSubSectionfalse%
  \@boldheadfalse\@fixedHeadSztrue%
}
\DeclareOption{modernstyle}{%
  \@emphisboldfalse%
  \@PerChptrNumberingtrue\@NumberStdHeadingstrue\@AllHeadingsfalse%
  \@centerChaptertrue\@centerSectionfalse\@chapterCapsfalse%
  \@inlineSubSubSectionfalse\@numberSubSubSectionfalse%
  \@boldheadtrue\@fixedHeadSzfalse%
}
\DeclareOption{defaultstyle}{%
  \@emphisboldtrue%
  \@PerChptrNumberingtrue\@NumberStdHeadingstrue\@AllHeadingsfalse%
  \@centerChapterfalse\@centerSectionfalse\@chapterCapsfalse%
  \@inlineSubSubSectionfalse\@numberSubSubSectionfalse%
  \@boldheadtrue\@fixedHeadSzfalse%
}
%%
%%  Load the report class with certain options by default.
%%  It will process any other options specified.
%%  Then, process the options for this class file.  
%%  Finally, load in the font option file for the given font size.
%%
\ProcessOptions
\LoadClass[letterpaper,oneside,onecolumn]{report}[1996/10/31]

%%  OTHER REQUIRED LaTeX2e PACKAGES
%%  ===============================

\RequirePackage{setspace}%[1996/02/06]
\RequirePackage{ifthen}%[2014/09/29]
\RequirePackage{geometry}%[2010/09/12]
%%\RequirePackage[ULforem,normalbf]{ulem}%[2012/06/01]
%%\RequirePackage{indentfirst}%[1995/11/23]

%%  these provide fine-grain control re. the appearance of
%%  sectional headings, captions & TOC material.
\RequirePackage{tocloft}%[2013/05/02]
\RequirePackage{titlesec}%[2016/03/21]
\RequirePackage{caption}%[2016/05/22]

%%  LaTeX code to create forloop
%%  from http://mathematics.nsetzer.com/latex/latex_for_loop.html
\newcommand{\forloop}[5][1] {%
  \setcounter{#2}{#3}%
  \ifthenelse{#4} {%
    #5%
    \addtocounter{#2}{#1}%
    \forloop[#1]{#2}{\value{#2}}{#4}{#5}%
  }%
  {}%
}% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Special internal commands.  Needed by later routines.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Create a command to be used for default arguments.
\newcommand*{\th@DefArg}{aWfdRvV11f66GL00K5}

%%  Now create a command to check for the default argument, and call the
%%  command [in the first arg] appropriately.  Used for section heading
%%  commands.
\newcommand{\th@ExecChkOptArg}[3]{%
  \ifthenelse{\equal{\th@DefArg}{#2}}{%
    #1{#3}%
  }{%
    #1[#2]{#3}%
  }%
}%

%%  Controls the heading styles.  Change the size to suit your needs.
%%  Set to \large which gives 14.4pt per the UMASSD thesis guidelines
\if@fixedHeadSz
  \newcommand*{\th@ChSz}{\large}%
  \newcommand*{\th@ScSz}{\normalsize}%
  \newcommand*{\th@SscSz}{\normalsize}%
\else
  \if@headSizeTwelvePt
    \newcommand*{\th@ChSz}{\large}%
    \newcommand*{\th@ScSz}{\normalsize}%
    \newcommand*{\th@SscSz}{\normalsize}%
  \else
    \newcommand*{\th@ChSz}{\large}%
    \newcommand*{\th@ScSz}{\normalsize}%
    \newcommand*{\th@SscSz}{\normalsize}%
  \fi
\fi

\if@boldhead
  \newcommand*{\th@HdFnt}{\normalfont\bfseries \boldmath}%
\else
  \newcommand*{\th@HdFnt}{\normalfont}%
\fi

%%  The style commands proper.  Controlled by a flag.

%%  N.B. - forcibly setting '\normalsize\normalfont' when we're not in a
%%  heading appears to make an utter mess out of cross-references in
%%  footnotes, so I've removed them.

%%  Re-define the emphasis commands to use either boldface or
%%  underlining, depending on the startup flags.
\newcommand*{\EmphReset}{%
  \if@emphisbold
    \let\em\bfseries%
    \let\emph\textbf%
  \else
    %\ULforem%
    \let\em\it%
    \let\emph\textit%
  \fi
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Here, we set the overall document properties, such as page
%%  numbering, margins, etc.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%  Initialize several global document properties, but do so *before*
%%  the beginning of the document to forces these changes.

\setlength{\headsep}{0.10in}
% for online use 1.0in margins on all sides.  This is the DEFAULT option
\geometry{%
  verbose,letterpaper,includeheadfoot,
  tmargin=1.0in,bmargin=1.0in,lmargin=1.00in,rmargin=1.0in  % for online
}
%% % for printed document increase left margin to account for binding
%% \geometry{%
%%   verbose,letterpaper,includeheadfoot,
%%   tmargin=1.0in,bmargin=1.0in,lmargin=1.50in,rmargin=1.0in % for printing
%% }

\AtBeginDocument{%
%% 
%%   the titlesec package is used to set the look and spacing of chapter and
%%   sectioning titles
%% 
%%   \titlespacing{\chapter}{0pt}{1ex plus .3ex minus .06ex}{1ex plus .1ex} is
%%   the "standard" spacing
%% 

\if@centerChapter
  \titleformat{\chapter}
    {\normalfont\th@ChSz\th@HdFnt\boldmath\centering}{\chaptername\ \thechapter}{1em}{\th@ChSz}
  \titlespacing*{\chapter}{0pt}{*-2}{*2}
  % ... and the starred version
  \titleformat{name=\chapter,numberless}
    {\normalfont\th@ChSz\th@HdFnt\centering}{}{0em}{\th@ChSz}
  \titlespacing*{name=\chapter,numberless}{0pt}{*-2}{*2}
  % the "above" & "below" spacing ensure numbered & unnunmbered
  % (the starred-version) headings appear in the same place on the page.
\else
  \titleformat{\chapter}
    {\normalfont\th@ChSz\th@HdFnt}{\chaptername\ \thechapter}{1em}{\th@ChSz}
  \titlespacing*{\chapter}{0pt}{*-2}{*2}
  % ... and the starred version
  \titleformat{name=\chapter,numberless}
    {\normalfont\th@ChSz\th@HdFnt}{}{0em}{\th@ChSz}
  \titlespacing*{name=\chapter,numberless}{0pt}{*-2}{*2}
  % the "above" & "below" spacing ensure numbered & unnunmbered
  % (the starred-version) headings appear in the same place on the page.
\fi

\if@centerSection
  \titleformat{\section}
    {\normalfont\normalsize\th@HdFnt \boldmath \centering}{\thesection}{1em}{\normalsize}
  \titlespacing*{\section}{0pt}{*1}{*1}
\else
  \titleformat{\section}
    {\normalfont\normalsize\th@HdFnt \boldmath}{\thesection}{1em}{\normalsize}
  \titlespacing*{\section}{0pt}{*1}{*1}
\fi

\titleformat{\subsection}
  {\normalfont\normalsize\th@HdFnt \boldmath}{\thesubsection}{1em}{\normalsize}
\titlespacing*{\subsection}{0pt}{*1}{*1}

%%
%%  allow for various styles for subsubsections; 
%%  with/without numbers & inline or not
%%
\if@numberSubSubSection
  \if@inlineSubSubSection
    \titleformat{\subsubsection}[runin]
      {\normalfont\normalsize\it}{\thesubsubsection}{1em}{\normalsize}
    \titlespacing*{\subsubsection}{0pt}{*1}{*1}
  \else
    \titleformat{\subsubsection}
      {\normalfont\normalsize\it}{\thesubsubsection}{1em}{\normalsize}
    \titlespacing*{\subsubsection}{0pt}{*1}{*1}
  \fi
\else
  \if@inlineSubSubSection
    \titleformat{\subsubsection}[runin]
      {\normalfont\normalsize\it}{}{0em}{\normalsize}
    \titlespacing*{\subsubsection}{0pt}{*1}{*1}
  \else
    \titleformat{\subsubsection}
      {\normalfont\normalsize\it}{}{0em}{\normalsize}
    \titlespacing*{\subsubsection}{0pt}{*1}{*1}
  \fi
\fi

%%
%%  allow for all levels of headings to be shown.
%%  set font style & size and inlining for paragraph and subparagraph 
%%  to match subsubsection formating
%%
\if@AllHeadings
  \if@inlineSubSubSection
    \titleformat{\subsubsection}[runin]
      {\normalfont\normalsize\it}{\thesubsubsection}{1em}{\normalsize}
    \titlespacing*{\subsubsection}{0pt}{*1}{*1}
    \titleformat{\paragraph}[runin]
      {\normalfont\normalsize\it}{\theparagraph}{1em}{\normalsize}
    \titlespacing*{\paragraph}{0pt}{*1}{*1}
    \titleformat{\subparagraph}[runin]
      {\normalfont\normalsize\it}{\thesubparagraph}{1em}{\normalsize}
    \titlespacing*{\subparagraph}{0pt}{*1}{*1}
  \else
    \titleformat{\subsubsection}
      {\normalfont\normalsize\it}{\thesubsubsection}{1em}{\normalsize}
    \titlespacing*{\subsubsection}{0pt}{*1}{*1}
    \titleformat{\paragraph}
      {\normalfont\normalsize\it}{\theparagraph}{1em}{\normalsize}
    \titlespacing*{\paragraph}{0pt}{*1}{*1}
    \titleformat{\subparagraph}
    {\normalfont\normalsize\it}{\thesubparagraph}{1em}{\normalsize}
    \titlespacing*{\subparagraph}{0pt}{*1}{*1}
  \fi
\else
  \if@inlineSubSubSection
    \titleformat{\paragraph}[runin]
      {\normalfont\normalsize\it}{}{0em}{\normalsize}
    \titlespacing*{\paragraph}{0pt}{*1}{*1}
    \titleformat{\subparagraph}[runin]
      {\normalfont\normalsize\it}{}{0em}{\normalsize}
    \titlespacing*{\subparagraph}{0pt}{*1}{*1}
  \else
    \titleformat{\paragraph}
      {\normalfont\normalsize\it}{}{0em}{\normalsize}
    \titlespacing*{\paragraph}{0pt}{*1}{*1}
    \titleformat{\subparagraph}
      {\normalfont\normalsize\it}{}{0em}{\normalsize}
    \titlespacing*{\subparagraph}{0pt}{*1}{*1}
  \fi
\fi

%%
%%  tocloft package sets title size & font for ToC, LoF, LoT pages
%%  change these to match local settings
%% 
%%  sets no dotleader for Chapters in ToC
\renewcommand{\cftchapdotsep}{\cftnodots}
\renewcommand{\cftchapfont}{\normalsize }
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}
%%
%%  sets raggedright for (sectional) ToC entries
\renewcommand{\@tocrmarg}{2.55em plus1fil}
%%
%%  remove indentation from left margin for each entry in LoF & LoT
\setlength{\cftfigindent}{0em}
\setlength{\cfttabindent}{0em}
%%
%%  modify Figures and Tables to use label defined in classfile and
%%  add a colon (:) after the number for each entry in LoF & LoT
\renewcommand{\cftfigpresnum}{\figurename~}
\renewcommand{\cftfigaftersnum}{:}

\renewcommand{\cfttabfont}{Table }
\renewcommand{\cfttabaftersnum}{:}

%%
%%  align lines for long caption entries in LoF & LoT
\newlength{\loftlabelwidth}

\settowidth{\loftlabelwidth}{\cftfigpresnum\cftfigaftersnum}
\addtolength{\cftfignumwidth}{\loftlabelwidth}

\settowidth{\loftlabelwidth}{\cfttabpresnum\cfttabaftersnum}
\addtolength{\cfttabnumwidth}{\loftlabelwidth}




%%
%%  set spacing before title to match standard chapter spacing ....
\if@centerChapter
  \setlength{\cftbeforetoctitleskip}{-1ex plus -.3ex minus -.06ex}
  \setlength{\cftbeforeloftitleskip}{-1ex plus -.3ex minus -.06ex}
  \setlength{\cftbeforelottitleskip}{-1ex plus -.3ex minus -.06ex}
  \renewcommand*{\cfttoctitlefont}{\hfill\th@HdFnt\th@ChSz} %
  \renewcommand*{\cftaftertoctitle}{\hfill\null}%
  \renewcommand{\cftloftitlefont}{\hfill\th@HdFnt\th@ChSz} %
  \renewcommand{\cftafterloftitle}{\hfill\null}%
  \renewcommand{\cftlottitlefont}{\hfill\th@HdFnt\th@ChSz} %
  \renewcommand{\cftafterlottitle}{\hfill\null}%
\else 
  \setlength{\cftbeforetoctitleskip}{-1ex plus -.3ex minus -.06ex}
  \setlength{\cftbeforeloftitleskip}{-1ex plus -.3ex minus -.06ex}
  \setlength{\cftbeforelottitleskip}{-1ex plus -.3ex minus -.06ex}
  \renewcommand{\cfttoctitlefont}{\th@HdFnt\th@ChSz} %
  \renewcommand{\cftloftitlefont}{\th@HdFnt\th@ChSz} %
  \renewcommand{\cftlottitlefont}{\th@HdFnt\th@ChSz} %
\fi
%%
%%  set spacing after title to match standard chapter spacing ....
\setlength{\cftaftertoctitleskip}{0pt}
\setlength{\cftafterloftitleskip}{2ex plus .1ex}
\setlength{\cftafterlottitleskip}{2ex plus .1ex}

%%
%% Spacing, Numbering, Font and Columns
%%
\pagestyle{plain}%
\onecolumn%
\raggedbottom%
%%  set *penalty values to minized orphan/widow lines 
\clubpenalty 10000
\widowpenalty 10000
%\brokenpenalty 10000
%\predisplaypenalty 10000
%\postdisplaypenalty 10000
%\displaywidowpenalty 10000

\normalsize%
\normalfont%
%% 
%%  Sets the spacing to double-space.  Keeps spacing single-spaced
%%  in footnotes and table/figure floats.  Also fixes up spacing in
%%  math mode.
%%
\doublespacing%
%%  set level displayed in ToC (3 shows down to subsections: eg. 1.2.3  )
%%
\setcounter{secnumdepth}{\value{th@SecNum}}%
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Here, we re-define some formatting commands to produce lists, labels
%%  and numberings that are more to the Graduate Office's liking.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 
%%  Set up some titles for the table of contents page.
%% 
\if@chapterCaps
  \renewcommand*{\figurename}{FIGURE}
  \renewcommand*{\tablename}{TABLE}
  \renewcommand*{\contentsname}{{CONTENTS}}
  \renewcommand*{\listfigurename}{{LIST OF \figurename S}}
  \renewcommand*{\listtablename}{{LIST OF \tablename S}}
  \newcommand*{\LoFnameToC}{{LIST OF \figurename S}}
  \newcommand*{\LoTnameToC}{{LIST OF \tablename S}}
  \renewcommand*{\appendixname}{{APPENDIX}}
  \renewcommand*{\bibname}{{REFERENCES}}
  \renewcommand*{\chaptername}{{CHAPTER}}
\else
  \renewcommand*{\figurename}{Figure}
  \renewcommand*{\tablename}{Table}
  \renewcommand*{\contentsname}{{Contents}}
  \renewcommand*{\listfigurename}{{List of \figurename s}}
  \renewcommand*{\listtablename}{{List of \tablename s}}
  \newcommand*{\LoFnameToC}{{List of \figurename s}}
  \newcommand*{\LoTnameToC}{{List of \tablename s}}
  \renewcommand*{\appendixname}{{Appendix}}
  \renewcommand*{\bibname}{{References}}
  \renewcommand*{\chaptername}{{Chapter}}
\fi

\newcommand*{\chapternameToC}{%
  \normalsize\normalfont\chaptername\normalfont%
}%
\newcommand*{\appendixnameToC}{%
  \normalsize\normalfont\appendixname\normalfont%
}%
\newcommand*{\bibnameToC}{%
  \normalsize\normalfont\bibname\normalfont%
}%

%%  Redefine the bibliography command here, just in case someone uses
%%  a custom *.sty file that redefines the bibliography command too.
%%
\let\th@OldBib\thebibliography%
\let\endth@OldBib\endthebibliography%
\renewenvironment*{thebibliography}[1]{%
  \begin{th@OldBib}{#1}%
    \begin{singlespace}%
      \addcontentsline{toc}{chapter}{\th@HdFnt \bibnameToC}%
  }{%
  \end{singlespace}%
  \end{th@OldBib}%
}%



}% end AtBeginDocument


%%
%%  Additional definitions
%% 
%%  make footnotes use symbols rather than numbers.  This is
%%  to avoid confusion between reference labels or math superscripts.
\renewcommand{\thefootnote}{\fnsymbol{footnote}}
\setcounter{tocdepth}{2}%
\newcommand*{\@normalsize}{\normalsize}
\doublespacing%

%%  Figures and Tables
%%
\setcounter{topnumber}{2}%
\renewcommand*{\topfraction}{.7}%
\setcounter{bottomnumber}{1}%
\renewcommand*{\bottomfraction}{.3}%
\setcounter{totalnumber}{3}%
\renewcommand*{\textfraction}{.2}%
\renewcommand*{\floatpagefraction}{.5}%
\setcounter{dbltopnumber}{1}%
\renewcommand*{\dbltopfraction}{.4}%
\renewcommand*{\dblfloatpagefraction}{.3}%
\setlength{\abovecaptionskip}{20pt plus 3pt minus 2pt}
\setlength{\belowcaptionskip}{20pt plus 3pt minus 2pt}
\setlength{\captionmargin}{0.05\textwidth}


%% 
%%  TOC numbering
%% 
%%  Numbering styles, default values.  We may need to alter the actual
%%  '\the' commands later on, tacking things on the front.  The LaTeX
%%  internals gag when we do this, due to the reuse of prior '\the'
%%  commands.  
%% 
\newcounter{th@SecNum}
\if@AllHeadings%
  % show everything in the ToC
  \setcounter{th@SecNum}{5}
\else
  \if@numberSubSubSection%
    % show the subsubsections in the ToC
    \setcounter{th@SecNum}{4}
  \else
    % default -- show the subsections in the ToC
    \setcounter{th@SecNum}{3}
  \fi
\fi

%%
%%  Figure, Table, and Equation numbering.
%%
\if@PerChptrNumbering%
\else%
  \newcounter{th@SaveFigure}
  \newcounter{th@SaveTable}
  \newcounter{th@SaveEquation}
  \renewcommand*{\thefigure}{\arabic{figure}}%
  \renewcommand*{\thetable}{\arabic{table}}%
  \renewcommand*{\theequation}{\arabic{equation}}%
\fi
%%
%%  Enumerated List labels
%%
\renewcommand*{\theenumi}{\arabic{enumi}}
\renewcommand*{\theenumii}{\Alph{enumii}}
\renewcommand*{\theenumiii}{\roman{enumiii}}
\renewcommand*{\theenumiv}{\alph{enumiv}}     

\renewcommand*{\labelenumi}{\theenumi.}    
\renewcommand*{\labelenumii}{\theenumii.}
\renewcommand*{\labelenumiii}{\theenumiii.}
\renewcommand*{\labelenumiv}{\theenumiv.}
%%
%%  Itemized list labels.
%%
\renewcommand*{\labelitemi}{\textbullet}
\renewcommand*{\labelitemii}{\textasteriskcentered}
\renewcommand*{\labelitemiii}{\normalfont \bfseries \textendash}
\renewcommand*{\labelitemiv}{\textperiodcentered}
%%
%%  Margins for lists
%%
\setlength{\leftmargini}{3.5em}
\setlength{\leftmarginiii}{2.2em}
\setlength{\leftmarginiv}{2.2em}
\setlength{\leftmarginv}{2.2em}
\setlength{\leftmarginvi}{2.2em}
\setlength{\leftmargin}{\leftmargini}
\setlength{\labelwidth}{1.5em}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Now, we need to redefine certain commands and environments from
%%  report.cls.  This is where things get messy.  We rename each command
%%  we modify, then redefine the command using the old version as a
%%  subset.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 
%%  Verse, Quotation, and Quote must be single-spaced.
%% 

%%  These rename the internal commands for the \begin{...} and \end{...}
%%  environment commands.
\let\th@OldVerse\verse
\let\th@OldQuotation\quotation
\let\th@OldQuote\quote
\let\endth@OldVerse\endverse
\let\endth@OldQuotation\endquotation
\let\endth@OldQuote\endquote

%%  Note - the ``\begin{singlespace}'' and ``\end{singlespace}'' are
%%  defined in setspace.sty.
\renewenvironment*{verse}{%
  \begin{th@OldVerse}%
  \begin{singlespace}%
}{%
  \end{singlespace}%
  \end{th@OldVerse}%
}
\renewenvironment*{quotation}{%
  \begin{th@OldQuotation}%
  \begin{singlespace}%
}{%
  \end{singlespace}%
  \end{th@OldQuotation}%
}
\renewenvironment*{quote}{%
  \begin{th@OldQuote}%
  \begin{singlespace}%
}{%
  \end{singlespace}%
  \end{th@OldQuote}%
}

%% 
%%  Theorems and Axioms:  They must NOT be italicized.  To do this
%%  robustly, I've needed to use some in-depth TeXnology.  Check out a
%%  good LaTeX book for info on the \@namedef and \@nameuse commands.
%% 
\let\th@OldNewtheorem\newtheorem
% Check for the calling format: \newtheorem{}[]{}
\def\newtheorem#1{%
\@ifnextchar[{\th@nuthrmOM{#1}}{\th@newtheoremTwo{#1}}%]
}
%%  Calling format: \newtheorem{}{}[].  This checks for the optional arg
%%  at the end.
\def\th@newtheoremTwo#1#2{%
\@ifnextchar[{\th@nuthrmO{#1}{#2}}{\th@nuthrm{#1}{#2}}%]
}
%%  Standard call.  No optional args.
\def\th@nuthrm#1#2{%
  \th@OldNewtheorem{th@#1}{#2}%
  \th@correctTheorem{end#1}{#1}{endth@#1}{th@#1}%
}
%%  Optional arg at end.
\def\th@nuthrmO#1#2[#3]{%
  \th@OldNewtheorem{th@#1}{#2}[#3]%
  \th@correctTheorem{end#1}{#1}{endth@#1}{th@#1}%
}
%%  Optional arg in the middle.
\def\th@nuthrmOM#1[#2]#3{%
  \th@OldNewtheorem{th@#1}[th@#2]{#3}%
  \th@correctTheorem{end#1}{#1}{endth@#1}{th@#1}%
}
\def\th@execThrmOpt#1[#2]{%
  \@nameuse{#1}[#2] \normalsize\normalfont%
}
\newcommand*{\th@correctTheorem}[4]{%
  \@namedef{#1}{\@nameuse{#3}}%
  \@namedef{#2}{\@ifnextchar[{\th@execThrmOpt{#4}}{%
  \@nameuse{#4} \normalsize\normalfont} }%
}

%% 
%%  APPENDIX commands
%% 
%%  for multiple appendices
\newcounter{th@SectionSave}%
\let\th@OldAppCmd\appendix%
\renewcommand{\appendix}{%
  \setcounter{th@SectionSave}{\value{section}}%
  \th@OldAppCmd%
  \if@NumberStdHeadings\else%
    \setcounter{section}{\value{th@SectionSave}}%
  \fi%
  \renewcommand*{\chaptername}{Appendix}
  \renewcommand*{\thechapter}{\Alph{chapter}}%
  \@appendixtrue%
}
%% 
%%  for single appendix
\newcommand{\singleappendix}{%
  \setcounter{th@SectionSave}{\value{section}}%
  \th@OldAppCmd%
  \if@NumberStdHeadings\else%
    \setcounter{section}{\value{th@SectionSave}}%
  \fi%
  \renewcommand*{\chaptername}{Appendix}
  \renewcommand*{\thechapter}{}%
  \@singleappendixtrue%
}
%%
%%  Special if-s; used internally for chapters.
\newif\if@THshortChapter
\@THshortChapterfalse

%% 
%%  Unavailable commands
%% 
\renewcommand*{\theindex}{%
  \ClassWarning{thesis}{Indexing not available in this class.}%
}
\renewcommand*{\twocolumn}{%
  \ClassWarning{thesis}{Twocolumn not available in this class.}%
}
\renewcommand*{\thepart}{%
  \ClassWarning{thesis}{``thepart'' not available in this class.}%
}
\renewcommand*{\part}{%
  \ClassWarning{thesis}{``part'' not available in this class.}%
}

%% 
%%  New commands.
%% 

%%  This forces a page number on the first page of a chapter, etc.
\newcommand*{\forcepageno}{\thispagestyle{myheadings}}
\newcommand*{\OnePageChapter}{\forcepageno}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%	The Thesis Prologue Pages
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Stores the second arg in the command specified by the first arg.
\newcommand{\th@StoreIn}[2]{%
  \gdef#1{#2}%
}

%%  Default values of storage variables. 
%%  Issues an error message if not present.
%%  This part of the classfile is long ...
\newcommand*{\th@title}{%
  \ClassError{thesis}%
  {You must specify a title!}%
  {Use the \protect\title{} command in the preamble.}%
}
%
\newcommand*{\th@degree}{%
  \ClassError{thesis}
  {You must specify the degree!}%
  {Use the \protect\degree{}{} command in the preamble.  \MessageBreak%
    The first argument is the unabbreviated name of the degree itself, \MessageBreak%
    eg.  'Master of Science' or 'Master of Fine Art' or 'Doctor of Philosophy'.  \MessageBreak%
    The second argument is the degree abbreviation, \MessageBreak%
    eg 'M.S.' or 'M.F.A.', or 'Ph.D.'.

  }%
}
%
\newcommand*{\th@degreetitle}{%
  \ClassError{thesis}
  {You must specify the degree!}%
  {Use the \protect\degree{}{} command in the preamble.  \MessageBreak%
    The first argument is the unabbreviated name of the degree itself, \MessageBreak%
    eg.  'Master of Science' or 'Master of Fine Art' or 'Doctor of Philosophy'.  \MessageBreak%
    The second argument is the degree abbreviation, \MessageBreak%
    eg 'M.S.' or 'M.F.A.', or 'Ph.D.'.

  }%
}
%
\newcommand*{\th@fulldegree}{%
  \ClassError{thesis}
  {You must specify the degree!}%
  {Use the \protect\degree{}{} command in the preamble.  \MessageBreak%
    The first argument is the unabbreviated name of the degree itself, \MessageBreak%
    eg.  'Master of Science' or 'Master of Fine Art' or 'Doctor of Philosophy'.  \MessageBreak%
    The second argument is the degree abbreviation, \MessageBreak%
    eg 'M.S.' or 'M.F.A.', or 'Ph.D.'.
  }%
}
%
\newcommand*{\th@abrvdegree}{%
  \ClassError{thesis}
  {You must specify the degree!}%
  {Use the \protect\degree{}{} command in the preamble.  \MessageBreak%
    The first argument is the unabbreviated name of the degree itself, \MessageBreak%
    eg.  'Master of Science' or 'Master of Fine Art' or 'Doctor of Philosophy'.  \MessageBreak%
    The second argument is the degree abbreviation, \MessageBreak%
    eg 'M.S.' or 'M.F.A.', or 'Ph.D.'.
  }%
}
%
\newcommand*{\th@phdprogram}{%
  \ClassError{thesis}
  {You must specify the phdprogram!}%
  {Use the \protect\phdprogram{}{} command in the preamble.  \MessageBreak%
    The first argument is the name of the Ph.D. program, \MessageBreak%
    eg.  'EAS' or 'ECE' or 'CHM' \MessageBreak%
    The second argument is the program option, \MessageBreak%
    eg 'Computational Science and Engineering' or 'Electrical Engineering'
  }%
}
%
\newcommand*{\th@phdname}{%
  \ClassError{thesis}
  {You must specify the phdprogram!}%
  {Use the \protect\phdprogram{}{} command in the preamble.  \MessageBreak%
    The first argument is the name of the Ph.D. program, \MessageBreak%
    eg.  'EAS' or 'ECE' or 'CHM' \MessageBreak%
    The second argument is the program option, \MessageBreak%
    e.g 'Computational Science and Engineering' or 'Electrical Engineering'
  }%
}
%
\newcommand*{\th@phdoption}{%
  \ClassError{thesis}
  {You must specify the phdprogram!}%
  {Use the \protect\phdprogram{}{} command in the preamble.  \MessageBreak%
    The first argument is the name of the Ph.D. program, \MessageBreak%
    eg.  'EAS' or 'ECE' or 'CHM' \MessageBreak%
    The second argument is the program option, \MessageBreak%
    e.g 'Computational Science and Engineering' or 'Electrical Engineering'
  }%
}
%
\newcommand*{\th@fwdname}{%
  \ClassError{thesis}
  {You must specify your name!}%
  {Use the \protect\author{}{} command in the preamble.  \MessageBreak%
    The first argument is your first name and middle initial or name.  \MessageBreak%
    The second argument is your surname.
  }%
}
%
\newcommand*{\th@revname}{%
  \ClassError{thesis}
  {You must specify your name!}%
  {Use the \protect\author{}{} command in the preamble.  \MessageBreak%
    The first argument is your first name and middle initial or name.  \MessageBreak%
    The second argument is your surname.
  }%
}
%
\newcommand*{\th@deptname}{%
  \ClassError{thesis}
  {You must specify the department!}%
  {Use the \protect\dept{}{} command in the preamble.  \MessageBreak%
    The first argument is the department's official designation, \MessageBreak%
    eg. 'Department of', 'School of', etc.  \MessageBreak%
    The second argument is the name of the department.
  }%
}
%
\newcommand*{\th@programname}{%
  \ClassError{thesis}
  {You must specify the program!}%
  {Use the \protect\program{} command in the preamble.  \MessageBreak%
    The argument is the name of the program, often this is the same as the department name.
  }%
}
%
\newcommand*{\th@deptorg}{%
  \ClassError{thesis}
  {You must specify the department!}%
  {Use the \protect\dept{}{} command in the preamble.  \MessageBreak%
    The first argument is the department's official designation, \MessageBreak%
    eg. 'Department of', 'School of', etc.  \MessageBreak%
    The second argument is the name of the department.
  }%
}
%
\newcommand*{\th@collegename}{%
  \ClassError{thesis}
  {You must specify the college!}%
  {Use the \protect\college{}{} command in the preamble.  \MessageBreak%
    The first argument is the college's official designation, \MessageBreak%
    eg. 'College of', 'School of', etc.  \MessageBreak%
    The second argument is the name of the college.
  }%
}
%
\newcommand*{\th@collegeorg}{%
  \ClassError{thesis}
  {You must specify the college!}%
  {Use the \protect\college{}{} command in the preamble.  \MessageBreak%
    The first argument is the college's official designation, \MessageBreak%
    eg. 'College of', 'School of', etc.  \MessageBreak%
    The second argument is the name of the college.
  }%
}
%
\newcommand*{\th@advisor}{%
  \ClassError{thesis}
  {You must specify your advisor's name, title, department and affiliation.}%
  {Use the \protect\advisor{}{}{} command in the preamble.  \MessageBreak%
    The first argument is your advisor's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is your advisor's full name, \MessageBreak%
    eg. 'John Smith' or 'Abigal M. Adams'.  \MessageBreak%
    The third argument is your advisor's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is your advisor's affiliation, \MessageBreak%
    ie. 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@advisortitle}{%
  \ClassError{thesis}
  {You must specify your advisor's name, title, department and affiliation.}%
  {Use the \protect\advisor{}{}{} command in the preamble.  \MessageBreak%
    The first argument is your advisor's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is your advisor's full name, \MessageBreak%
    eg. 'John Smith' or 'Abigal M. Adams'.  \MessageBreak%
    The third argument is your advisor's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is your advisor's affiliation, \MessageBreak%
    ie. 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@advisordept}{%
  \ClassError{thesis}
  {You must specify your advisor's name, title, department and affiliation.}%
  {Use the \protect\advisor{}{}{} command in the preamble.  \MessageBreak%
    The first argument is your advisor's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is your advisor's full name, \MessageBreak%
    eg. 'John Smith' or 'Abigal M. Adams'.  \MessageBreak%
    The third argument is your advisor's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is your advisor's affiliation, \MessageBreak%
    ie. 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@advisoraffil}{%
  \ClassError{thesis}
  {You must specify your advisor's name, title, department and affiliation.}%
  {Use the \protect\advisor{}{}{} command in the preamble.  \MessageBreak%
    The first argument is your advisor's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is your advisor's full name, \MessageBreak%
    eg. 'John Smith' or 'Abigal M. Adams'.  \MessageBreak%
    The third argument is your advisor's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is your advisor's affiliation, \MessageBreak%
    ie. 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@readerone}{%
  \ClassError{thesis}
  {You must specify the name, title and affiliation \MessageBreak%
    of the committee members reviewing your thesis.}%
  {Use the \protect\readerone{}{}{} command in the preamble.  \MessageBreak%
    The first argument is the readers's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is the readers's full name, \MessageBreak%
    eg. 'Will Rogers' or 'Sam L. Spade'.  \MessageBreak%
    The third argument is the readers's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is the readers's affiliation, \MessageBreak%
    eg. 'The University of Big Ideas' or 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@readeronetitle}{%
  \ClassError{thesis}
  {You must specify the name, title and affiliation \MessageBreak%
    of the committee members reviewing your thesis.}%
  {Use the \protect\readerone{}{}{} command in the preamble.  \MessageBreak%
    The first argument is the readers's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is the readers's full name, \MessageBreak%
    eg. 'Will Rogers' or 'Sam L. Spade'.  \MessageBreak%
    The third argument is the readers's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is the readers's affiliation, \MessageBreak%
    eg. 'The University of Big Ideas' or 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@readeronedept}{%
  \ClassError{thesis}
  {You must specify the name, title and affiliation \MessageBreak%
    of the committee members reviewing your thesis.}%
  {Use the \protect\readerone{}{}{} command in the preamble.  \MessageBreak%
    The first argument is the readers's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is the readers's full name, \MessageBreak%
    eg. 'Will Rogers' or 'Sam L. Spade'.  \MessageBreak%
    The third argument is the readers's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is the readers's affiliation, \MessageBreak%
    eg. 'The University of Big Ideas' or 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@readeroneaffil}{%
  \ClassError{thesis}
  {You must specify the name, title and affiliation \MessageBreak%
    of the committee members reviewing your thesis.}%
  {Use the \protect\readerone{}{}{} command in the preamble.  \MessageBreak%
    The first argument is the readers's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is the readers's full name, \MessageBreak%
    eg. 'Will Rogers' or 'Sam L. Spade'.  \MessageBreak%
    The third argument is the readers's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is the readers's affiliation, \MessageBreak%
    eg. 'The University of Big Ideas' or 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@readertwo}{%
  \ClassError{thesis}
  {You must specify the name, title and affiliation \MessageBreak%
    of the committee members reviewing your thesis.}%
  {Use the \protect\readertwo{}{}{} command in the preamble.  \MessageBreak%
    The first argument is the readers's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is the readers's full name, \MessageBreak%
    eg. 'Will Rogers' or 'Sam L. Spade'.  \MessageBreak%
    The third argument is the readers's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is the readers's affiliation, \MessageBreak%
    eg. 'The University of Big Ideas' or 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@readertwotitle}{%
  \ClassError{thesis}
  {You must specify the name, title and affiliation \MessageBreak%
    of the committee members reviewing your thesis.}%
  {Use the \protect\readertwo{}{}{} command in the preamble.  \MessageBreak%
    The first argument is the readers's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is the readers's full name, \MessageBreak%
    eg. 'Will Rogers' or 'Sam L. Spade'.  \MessageBreak%
    The third argument is the readers's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is the readers's affiliation, \MessageBreak%
    eg. 'The University of Big Ideas' or 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@readertwodept}{%
  \ClassError{thesis}
  {You must specify the name, title and affiliation \MessageBreak%
    of the committee members reviewing your thesis.}%
  {Use the \protect\readertwo{}{}{} command in the preamble.  \MessageBreak%
    The first argument is the readers's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is the readers's full name, \MessageBreak%
    eg. 'Will Rogers' or 'Sam L. Spade'.  \MessageBreak%
    The third argument is the readers's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is the readers's affiliation, \MessageBreak%
    eg. 'The University of Big Ideas' or 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@readertwoaffil}{%
  \ClassError{thesis}
  {You must specify the name, title and affiliation \MessageBreak%
    of the committee members reviewing your thesis.}%
  {Use the \protect\readertwo{}{}{} command in the preamble.  \MessageBreak%
    The first argument is the readers's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is the readers's full name, \MessageBreak%
    eg. 'Will Rogers' or 'Sam L. Spade'.  \MessageBreak%
    The third argument is the readers's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is the readers's affiliation, \MessageBreak%
    eg. 'The University of Big Ideas' or 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@readerthree}{%
  \ClassError{thesis}
  {You must specify the name, title and affiliation \MessageBreak%
    of the committee members reviewing your thesis.}%
  {Use the \protect\readerthree{}{}{} command in the preamble.  \MessageBreak%
    The first argument is the readers's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is the readers's full name, \MessageBreak%
    eg. 'Will Rogers' or 'Sam L. Spade'.  \MessageBreak%
    The third argument is the readers's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is the readers's affiliation, \MessageBreak%
    eg. 'The University of Big Ideas' or 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@readerthreetitle}{%
  \ClassError{thesis}
  {You must specify the name, title and affiliation \MessageBreak%
    of the committee members reviewing your thesis.}%
  {Use the \protect\readerthree{}{}{} command in the preamble.  \MessageBreak%
    The first argument is the readers's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is the readers's full name, \MessageBreak%
    eg. 'Will Rogers' or 'Sam L. Spade'.  \MessageBreak%
    The third argument is the readers's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is the readers's affiliation, \MessageBreak%
    eg. 'The University of Big Ideas' or 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@readerthreedept}{%
  \ClassError{thesis}
  {You must specify the name, title and affiliation \MessageBreak%
    of the committee members reviewing your thesis.}%
  {Use the \protect\readerthree{}{}{} command in the preamble.  \MessageBreak%
    The first argument is the readers's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is the readers's full name, \MessageBreak%
    eg. 'Will Rogers' or 'Sam L. Spade'.  \MessageBreak%
    The third argument is the readers's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is the readers's affiliation, \MessageBreak%
    eg. 'The University of Big Ideas' or 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@readerthreeaffil}{%
  \ClassError{thesis}
  {You must specify the name, title and affiliation \MessageBreak%
    of the committee members reviewing your thesis.}%
  {Use the \protect\readerthree{}{}{} command in the preamble.  \MessageBreak%
    The first argument is the readers's full professorial title.  \MessageBreak%
    eg. 'Assistant Professor', 'Professor', etc.  \MessageBreak%
    DO NOT include earned degrees such as Dr.  \MessageBreak%
    The second argument is the readers's full name, \MessageBreak%
    eg. 'Will Rogers' or 'Sam L. Spade'.  \MessageBreak%
    The third argument is the readers's department, \MessageBreak%
    eg. 'Physics' DON'T INCUDE Department OR School here.  \MessageBreak%
    The forth argument is the readers's affiliation, \MessageBreak%
    eg. 'The University of Big Ideas' or 'University of Massachusetts Dartmouth'.
  }%
}
%
\newcommand*{\th@graddirector}{%
  \ClassError{thesis}
  {You must specify the Graduate Program Director!}
  {Use the \protect\graddirector{} command in the preamble.  \MessageBreak%
    The argument is the Graduate Program Director's full name.  \MessageBreak%
    eg. 'Will I. Am' or 'Sam Spade'.
  }%
}
%
\newcommand*{\th@deptchair}{%
  \ClassError{thesis}
  {You must specify the Department Chair!}
  {Use the \protect\deptchair{} command in the preamble.  \MessageBreak%
    The argument is the Department Chair's full name.  \MessageBreak%
    eg. 'Will I. Am' or 'Sam Spade'.
  }%
}
%
\newcommand*{\th@collegedean}{%
  \typeout{gred} \ClassError{thesis}
  {You must specify the College Dean!}%
  {Use the \protect\collegedean{} command in the preamble.  \MessageBreak%
    The argument is the College Dean's full name.  \MessageBreak%
    eg. 'Robert Peck' or 'Sam L. Spade'.
  }%
}
%
\newcommand*{\th@honorsdirector}{
  \ClassError{thesis}
  {You must specify the Honors Program Director!}%
  {Use the \protect\honorsdirector{} command in the preamble.  \MessageBreak%
    The argument is the Honors Program Director's full name.  \MessageBreak%
    eg. 'Robert Darst' or 'Sam L. Spade'.
  }%
}
%
\newcommand*{\th@gradstudies}{%
  \ClassError{thesis}
  {You must specify the Associate Provost for Graduate Studies}%
  {Use the \protect\gradstudies{} command in the preamble \MessageBreak%
    The argument is the Associate Provost for Graduate Studies' name. \MessageBreak%
  }%
}
%
\newcommand{\th@otherdegrees}{%
\ClassError{thesis}
  {You must specify other degrees you hold!}%
  {Use the \protect\otherdegrees{} command in the \MessageBreak%
    preamble.  Break each line using the \protect command.%
  }%
}
%
\newcommand{\th@abstractStash}{%
  \ClassError{thesis}
  {You must specify an abstract!}%
  {Use the \protect\abstract[]{} command in the preamble.  \MessageBreak%
    If your abstract runs over a page, use the optional argument 'long'.
  }%
}
%
\newcommand{\th@conferraldate}{%
  \ClassError{thesis}
  {You must specify the degree conferral date!}%
  {Use the \protect\conferraldate{}{} command in the preamble.  \MessageBreak%
    The first argument is the unabbreviated month name, eg. "September".  \MessageBreak%
    The second argument is the year, eg. "2010".
  }%
}
%
\newcommand{\th@degreeyear}{%
  \ClassError{thesis}
  {You must specify the degree conferral date!}%
  {Use the \protect\conferraldate{}{} command in the preamble.  \MessageBreak%
    The first argument is the unabbreviated month name, eg. "September".  \MessageBreak%
    The second argument is the year, eg. "2008".%
  }%
}
%
\newcommand{\th@degreemonth}{%
  \ClassError{thesis}
  {You must specify the degree conferral date!}%
  {Use the \protect\conferraldate{}{} command in the preamble.  \MessageBreak%
    The first argument is the unabbreviated month name, eg. "September".  \MessageBreak%
    The second argument is the year, eg. "2008".
  }%
}
%%
%%  labels for the thesis/disertation advisor
%%
\newcommand*{\th@coadvisor}{}
\newcommand*{\th@coadvisortitle}{}
\newcommand*{\th@coadvisordept}{}
\newcommand*{\th@coadvisoraffil}{}
%%
%%  these labels are used internally with a forloop 
%%  to process the thesis/disertation committee members
%%
\newcommand*{\person}{}
\newcommand*{\personrole}{}
\newcommand*{\persontitle}{}
\newcommand*{\persondeptorg}{}
\newcommand*{\persondeptname}{}
\newcommand*{\personaffil}{}

\newcommand*{\phdfullname}{}
%%
%%  These next commands are internal, but needed for
%%  generating the prologue pages.
%%
\newlength{\lwidth}
\newlength{\twidth}
\newlength{\thislinewidth}

\newcommand*{\th@signatureline}{%
  \noindent \vrule width 4.00in height 0.4pt
}
\newlength{\siglinewidth}
\settowidth{\siglinewidth}{\th@signatureline}

\newcommand*{\th@leftsignature}[1]{%
  \normalsize
  \vspace{1.00in}
  \noindent
  \vrule width \siglinewidth height 0.4pt\\
  #1
}

\newcommand*{\th@rightsignature}[1]{%
  {%
  \normalsize
  \vspace{1.00in}
  \mbox{} \hfill \vrule width \siglinewidth height 0.4pt \\%
  \mbox{} \hfill \makebox[\siglinewidth][l]{ #1}
  }
}
\newcommand*{\th@signature}[1]{%
  \begin{center}
    \normalsize
    \vspace{.75in}
    \vrule width \siglinewidth height 0.4pt\\
    #1
  \end{center}
}

\newlength{\datelinewidth}
\settowidth{\datelinewidth}{Date of Signature \hspace{10pt}}
\newcommand*{\th@dateline}{%
  \noindent \vrule width \datelinewidth height 0.4pt
}

\newcommand{\th@AbstractPageStyle}{\relax}%
\newcommand{\th@AcknowledgementsPageStyle}{\relax}%
\newcommand{\th@acknowledgementsStash}{\relax}%
\newcommand{\th@prefaceStash}{\relax}%
\newcommand{\th@prefaceTitleStash}{\relax}%

\newif\if@shortLoF
\newif\if@shortLoT
\newif\if@shortToC
\newif\if@makenoLoF
\newif\if@makenoLoT
\newif\if@makeAcknowledgements
\newif\if@makePreface
\newif\if@makeEpigraph
\newif\if@makePrologue
\@shortLoFfalse
\@shortLoTfalse
\@shortToCfalse
\@makenoLoFfalse
\@makenoLoTfalse
\@makeAcknowledgementsfalse
\@makePrefacefalse
\@makeEpigraphfalse
\@makeProloguetrue

%%
%%  The base commands that make all of the prologue pages.
%%

%%
%% create the TITLE PAGE
%%
\newcommand*{\th@Titlepage}{%
%%
%%  From the UMass Dartmouth Thesis Guide
%%  "Requirements for Theses and Dissertations" (Spring 2015) 
%%
%%  Requires 1.5" margin on all sides for the title page
  \newgeometry{tmargin=1.50in,bmargin=1.50in,lmargin=1.50in,rmargin=1.50in}
%
  \doublespace
  \thispagestyle{empty}%
  \@thInHeadingtrue%
  {\centering%
    % header
    University of Massachusetts Dartmouth \\ %
    \ifthenelse{%
      \equal{\th@fulldegree}{Undergraduate} \OR%
        \equal{\th@fulldegree}{Honors} \OR%
        \equal{\th@fulldegree}{Master of Science} \OR%
        \equal{\th@fulldegree}{Master of Arts} \OR%
        \equal{\th@fulldegree}{Master of Fine Arts} \OR%
        \equal{\th@fulldegree}{Master of Art Education} }%
    {%
     %\hfill \break
     \th@deptorg\ \th@deptname\ \\%
    }
    {
      \ifthenelse{\equal{\th@fulldegree}{Doctor of Philosophy}} {% 
        \ifthenelse{\equal{\th@phdname}{BMEBT}} {%
          Biomedical Engineering and Biotechnology\\\vfill%
        }{}%
        \ifthenelse{\equal{\th@phdname}{EAS}} {%
          Engineering and Applied Science\\\vfill%
        }{}%
        \ifthenelse{\equal{\th@phdname}{ECE}} {%
          Department of Electrical and Computer Engineering\\\vfill%
        }{}%
      }%
    }
  %%  title
    \vfill%
    {\th@HdFnt\th@ChSz %
      \if@chapterCaps%
        \uppercase\expandafter{\th@title}\\%
      \else%
        \th@title\\%
      \fi%
    }%
  %%  body
    \vfill%
    \ifthenelse{\equal{\th@fulldegree}{Undergraduate}}%
    {%
      An Undergraduate Thesis in \\%
      \th@programname \\%
    }{}%
    \ifthenelse{\equal{\th@fulldegree}{Honors}}%
    {%
      An Honors Thesis in \\%
      \th@programname \\%
    }{}%
    \ifthenelse{%
      \equal{\th@fulldegree}{Master of Science} \OR%
      \equal{\th@fulldegree}{Master of Arts} \OR%
      \equal{\th@fulldegree}{Master of Fine Arts} \OR%
      \equal{\th@fulldegree}{Master of Art Education} }%
    {%
      A Thesis in \\%
      \th@programname \\%
    }{}%
  %
    \ifthenelse{\equal{\th@fulldegree}{Doctor of Philosophy}}%
    {%
      A Dissertation in \\%
      \th@phdoption\\%
    }{}%
    by \\%
    \if@chapterCaps%
      \uppercase\expandafter{\th@fwdname}\\%
    \else%
      \th@fwdname\\%
    \fi%
%%  % copyright notice
%%    \vfill%
%%    \copyright\ \th@degreeyear\ by %
%%    \if@chapterCaps%
%%      \uppercase\expandafter{\th@fwdname}\\%
%%    \else%
%%      \th@fwdname\\%
%%    \fi%
  % footer 
    \vfill%
    \ifthenelse{\equal{\th@fulldegree}{Undergraduate}}%
    {%
      Submitted in Partial Fulfillment of the \\%
      Requirements for an Undergraduate Thesis%
      }{}%
    \ifthenelse{\equal{\th@fulldegree}{Honors}}%
    {%
      Submitted in Partial Fulfillment of the \\%
      Requirements for the \\%
      Commonwealth Honors Program%
    }{}%
    \ifthenelse{%
      \equal{\th@fulldegree}{Master of Science} \OR%
      \equal{\th@fulldegree}{Master of Arts} \OR%
      \equal{\th@fulldegree}{Master of Fine Arts} \OR%
      \equal{\th@fulldegree}{Master of Art Education} }%
    {%
      Submitted in Partial Fulfillment of the \\%
      Requirements for the Degree of\\%
      \th@fulldegree%
    }{}%
    %
    \ifthenelse{\equal{\th@fulldegree}{Doctor of Philosophy}}%
    {%
      Submitted in Partial Fulfillment of the \\%
      Requirements for the Degree of\\%
      \th@fulldegree%
    }{}%
    \vfill%
    \th@degreemonth\ \th@degreeyear \\%
  }% end centering 
  \vspace{0.000in} \null%
  \@thInHeadingfalse%
  \restoregeometry
  % restore page margins 
}
%%  completed the title page !!

%%
%%  create the PERMISSIONS PAGE
%%
\newcommand*{\th@CopyPermissionPage}{%
  \onehalfspacing%
  \clearpage%
  \thispagestyle{empty}%
  \vspace*{1.00in}%
  \noindent%
  I grant the University of Massachusetts Dartmouth the non-exclusive %
  right to use the work for the purpose of making single copies of the %
  work available to the public on a not-for-profit basis if the %
  University's circulating copy is lost or destroyed. %

  \vspace{0.50in}%
  \setlength{\thislinewidth}{2.50in}%
  \null \hfill \vrule width \thislinewidth height 0.4pt\\%
  \null\hfill\makebox[\thislinewidth][l]\th@fwdname%

  \vspace{0.50in}%
%%  The  next line begins with Date and ends at the same point as the signature
%%  line above. Need to set the length of the line to account for this.
  \setlength{\lwidth}{\thislinewidth}%
  \settowidth{\twidth}{Date}%
  \addtolength{\lwidth}{-\twidth}%
  \null\hfill\makebox[\thislinewidth][l]{Date \vrule width \lwidth height 0.4pt}%
}
%%  completed the permissions page !!

%%
%%  create the APPROVAL PAGE
%%
%%  The approval page is potentially complicated.  If the same person has
%%  multiple roles (eg. reader and Department Chair) then their name should 
%%  appear only once, with both roles acknowledged
%%
%%  This part of the classfile is very long and makes use of a forloop to
%%  test for various combinations of multiple roles ...
%%  yes, LaTeX is a programming language !!
%%
\newcommand*{\th@Approvalpage}{%
  \clearpage%
  \singlespacing%
  \thispagestyle{empty}%
%%
%%  this is the approval page for an UNDERGRADUATE THESIS
  \ifthenelse{ \equal{\th@fulldegree}{Undergraduate}} {% 
    \noindent%
    This undergraduate thesis has been submitted, defended and
    approved in accordance with the policies of
    the University of Massachusetts Dartmouth.
    %
    \noindent We approve the\ %
    \lowercase\expandafter{\th@fulldegree}\ %
    \lowercase\expandafter{\th@degreetitle}\ %
    of \th@fwdname \\ \\
    %
    \null\hfill\makebox[\datelinewidth][l]{Date of Signature}%
    %
    \newcounter{ct} \forloop{ct}{1}{\value{ct} < 5}%
    % creates a forloop over advisor, co-advisor, readerone and readertwo
    % and checks for all combinations of multiple roles for these people.
    {%
      \ifthenelse{\equal{\value{ct}}{1}} {%
        \renewcommand{\person}{\th@advisor}%
        \ifthenelse{ \equal{\th@coadvisor}{}}
          { \renewcommand{\personrole}{Advisor} }% when no co-advisor
          { \renewcommand{\personrole}{Co-Advisor} }% when co-advisor
        \renewcommand{\persontitle}{\th@advisortitle}%
        \renewcommand{\persondeptname}{\th@advisordept}%
        \renewcommand{\persondeptorg}{\th@deptorg}%
        \renewcommand{\personaffil}{}%
      }{}%
      \ifthenelse{ \equal{\value{ct}}{2}} {%
        \ifthenelse{ \equal{\th@coadvisor}{}}
        {\setcounter{ct}{3} }
        % print nothing and advance counter if coadvisor empty
        {% if co-advisor is set
          \renewcommand{\person}{\th@coadvisor}%
          \renewcommand{\personrole}{Co-Advisor}%
          \renewcommand{\persontitle}{\th@coadvisortitle}%
          \renewcommand{\persondeptname}{\th@coadvisordept}%
          \renewcommand{\persondeptorg}{\th@deptorg}%
          \renewcommand{\personaffil}{}%
        }
      }{}%
      \ifthenelse{\equal{\value{ct}}{3}} {%
        \ifthenelse{ \equal{\th@readerone}{}}
        {\setcounter{ct}{4} }
        % print nothing and advance counter if readerone empty
        {% if readerone is set
        \renewcommand{\person}{\th@readerone}%
        \renewcommand{\personrole}{Committee}%
        \renewcommand{\persontitle}{\th@readeronetitle}%
        \renewcommand{\persondeptname}{\th@readeronedept}%
        \renewcommand{\persondeptorg}{\th@deptorg}%
        \renewcommand{\personaffil}{\th@readeroneaffil}%
        }
      }{}%
      \ifthenelse{\equal{\value{ct}}{4}} {%
        \ifthenelse{ \equal{\th@readertwo}{}}
        {\setcounter{ct}{5} }
        % print nothing and advance counter if readertwo empty
        {% if readertwo is set
        \renewcommand{\person}{\th@readertwo}%
        \renewcommand{\personrole}{Committee}%
        \renewcommand{\persontitle}{\th@readertwotitle}%
        \renewcommand{\persondeptname}{\th@readertwodept}%
        \renewcommand{\persondeptorg}{\th@deptorg}%
        \renewcommand{\personaffil}{\th@readertwoaffil}%
        }
      }{}%

      % for each committee member entry
      % create correct affiliation entry for external readers
      \ifthenelse{\equal{\persondeptname}{}} {%
        \renewcommand{\persondeptorg}{}%
      }{}
         
      % test for dual roles
      \vfill \th@signatureline \hfill \th@dateline\\%
      % test whether the person is also Chair or Dean (acting Chair)
      \ifthenelse{\equal{\person}{\th@deptchair}} {%
        \@doneChairtrue
        \ifthenelse{\equal{\person}{\th@collegedean}} {%
          \person \\%
          Dean, \th@collegeorg\ \th@collegename\ and Acting Chairperson, \th@deptorg\ \th@deptname%
        }%
        {
          \ifthenelse{\equal{\persondeptname}{\th@deptname}} {%
            \person\\%
            \persontitle\ and Chairperson, \th@deptorg\ \th@deptname%
          }
          {
            % if Chair is from another department ...
            \person\\%
            \persontitle\ of \persondeptname\\%
            Chairperson, \th@deptorg\ \th@deptname%
          }
        }
      } {%
        % test whether the person is the Dean (but not acting Chair)
        \ifthenelse{\equal{\person}{\th@collegedean}} {%
          \person \\%
          Dean, \th@collegeorg\ \th@collegename%
        } {%
          \person%
          % test for empty department/professorial title entry
          \ifthenelse{\equal{\persondeptname}{}} {
          }{
            \\ \persontitle, \persondeptorg\ \persondeptname%
          }
          % test for non-blank affiliation
          \ifthenelse{\equal{\personaffil}{}} {%
          } {%
            \ifthenelse{\equal{\personaffil}{University of Massachusetts Dartmouth}}%
            { }% blank
            {%
            \\ \personaffil% external affiliation
            }%
          }%
        }%
      }
      \\ \th@degreetitle\ \personrole
    }% end loop over committee members
    %
    \if@doneChair
    \else
      \vfill \th@signatureline \hfill \th@dateline\\%
      \ifthenelse{\equal{\th@deptchair}{\th@collegedean}} {%
        \th@deptchair \\%
        Dean \th@collegeorg\ \th@collegename\ and Acting Chairperson, \th@deptorg\ \th@deptname%
      } {%
        \th@deptchair\\%
        Chairperson,\ \th@deptorg\ \th@deptname
        \vfill\vfill\null% push signatures up
      }
    \fi
  }%
  {}%
  %% finished approval page for UNDERGRADUATE THESIS

%%
%%  this is the approval page for an HONORS THESIS
  \ifthenelse{ \equal{\th@fulldegree}{Honors}} {% 
    \noindent%
    This Commonwealth Honors thesis has been submitted,
    defended and approved in accordance with the policies of the
    Honors Program at the University of Massachusetts Dartmouth.
    %
    %\vfill%
    \noindent We approve the\ %
    \lowercase\expandafter{\th@fulldegree}\ %
    \lowercase\expandafter{\th@degreetitle}\ %
    of \th@fwdname \\ \\
    %
    \null\hfill\makebox[\datelinewidth][l]{Date of Signature}%
    %
    \newcounter{ct} \forloop{ct}{1}{\value{ct} < 5}%
    % creates a forloop over advisor, co-advisor, readerone and readertwo
    % and checks for all combinations of multiple roles for these people.
    {%
      \ifthenelse{\equal{\value{ct}}{1}} {%
        \renewcommand{\person}{\th@advisor}%
        \ifthenelse{ \equal{\th@coadvisor}{}}
          { \renewcommand{\personrole}{Advisor} }% when no co-advisor
          { \renewcommand{\personrole}{Co-Advisor} }% when co-advisor
        \renewcommand{\persontitle}{\th@advisortitle}%
        \renewcommand{\persondeptname}{\th@advisordept}%
        \renewcommand{\persondeptorg}{\th@deptorg}%
        \renewcommand{\personaffil}{}%
      }{}%
      \ifthenelse{ \equal{\value{ct}}{2}} {%
        \ifthenelse{ \equal{\th@coadvisor}{}}
        {\setcounter{ct}{3} }
        % print nothing and advance counter if coadvisor empty
        {% if co-advisor is set
          \renewcommand{\person}{\th@coadvisor}%
          \renewcommand{\personrole}{Co-Advisor}%
          \renewcommand{\persontitle}{\th@coadvisortitle}%
          \renewcommand{\persondeptname}{\th@coadvisordept}%
          \renewcommand{\persondeptorg}{\th@deptorg}%
          \renewcommand{\personaffil}{}%
        }
      }{}%
      \ifthenelse{\equal{\value{ct}}{3}} {%
        \ifthenelse{ \equal{\th@readerone}{}}
        {\setcounter{ct}{4} }
        % print nothing and advance counter if readerone empty
        {% if readerone is set
        \renewcommand{\person}{\th@readerone}%
        \renewcommand{\personrole}{Committee}%
        \renewcommand{\persontitle}{\th@readeronetitle}%
        \renewcommand{\persondeptname}{\th@readeronedept}%
        \renewcommand{\persondeptorg}{\th@deptorg}%
        \renewcommand{\personaffil}{\th@readeroneaffil}%
        }
      }{}%
      \ifthenelse{\equal{\value{ct}}{4}} {%
        \ifthenelse{ \equal{\th@readertwo}{}}
        {\setcounter{ct}{5} }
        % print nothing and advance counter if readertwo empty
        {% if readertwo is set
        \renewcommand{\person}{\th@readertwo}%
        \renewcommand{\personrole}{Committee}%
        \renewcommand{\persontitle}{\th@readertwotitle}%
        \renewcommand{\persondeptname}{\th@readertwodept}%
        \renewcommand{\persondeptorg}{\th@deptorg}%
        \renewcommand{\personaffil}{\th@readertwoaffil}%
        }
      }{}%

      % for each committee member entry
      % create correct affiliation entry for external readers
      \ifthenelse{\equal{\persondeptname}{}} {%
        \renewcommand{\persondeptorg}{}%
      }{}
         
      % test for dual roles
      \vfill \th@signatureline \hfill \th@dateline\\%
      % test whether the person is also Honors Director,
      % Chair or Dean as acting Chair
      \ifthenelse{\equal{\person}{\th@honorsdirector}} {%
        \@doneHonorsdirectortrue%
        \ifthenelse{\equal{\person}{\th@deptchair}} {%
          \@doneChairtrue
          \ifthenelse{\equal{\person}{\th@collegedean}} {%
            \person \\%
            Dean,\th@collegeorg\ \th@collegename\ and Acting Chairperson, \th@deptorg\ \th@deptname \\%
            Honors Program Director%
          }%
          {
            \ifthenelse{\equal{\persondeptname}{\th@deptname}} {%
              \person\\%
              \persontitle\ and Chairperson, \th@deptorg\ \th@deptname\\%
              Honors Program Director%
            }
            {
              % if the Chair is from another department ...
              \person\\%
              \persontitle\ of \persondeptname\\%
              Chairperson, \th@deptorg\ \th@deptname\\%
              Honors Program Director%
            }
          }
        }
        {%
          \person\\%
          \persontitle, \th@deptorg\ \persondeptname \\%
          Honors Program Director%
        }
      }
      {
        \ifthenelse{\equal{\person}{\th@deptchair}} {%
          \@doneChairtrue
          \ifthenelse{\equal{\person}{\th@collegedean}} {%
            \person \\%
            Dean, \th@collegeorg\ \th@collegename\ and Acting Chairperson, \th@deptorg\ \th@deptname%
          }%
          {
            \ifthenelse{\equal{\persondeptname}{\th@deptname}} {%
              \person\\%
              \persontitle\ and Chairperson, \th@deptorg\ \th@deptname%
            }
            {
              % if acting Chair is from another department ...
              \person\\%
              \persontitle\ of \persondeptname\\%
              Chairperson, \th@deptorg\ \th@deptname%
            }
          }
        } {%
          % test whether the person is the Dean (but not acting Chair)
          \ifthenelse{\equal{\person}{\th@collegedean}} {%
            \person \\%
            Dean, \th@collegeorg\ \th@collegename%
          } {%
            \person%
            % test for empty department/professorial title entry
            \ifthenelse{\equal{\persondeptname}{}} {
            }{
              \\ \persontitle, \persondeptorg\ \persondeptname%
            }
            % test for non-blank affiliation
            \ifthenelse{\equal{\personaffil}{}} {%
            } {%
              \ifthenelse{\equal{\personaffil}{University of Massachusetts Dartmouth}}%
              { }% blank
              {%
              \\ \personaffil% external affiliation
              }%
            }%
          }%
        }
      }
      \\ \th@degreetitle\ \personrole
    }% end loop over committee members
    %
    \if@doneChair
    \else
      \vfill \th@signatureline \hfill \th@dateline\\%
      \ifthenelse{\equal{\th@deptchair}{\th@collegedean}} {%
        \th@deptchair\\%
        Dean, \th@collegeorg\ \th@collegename\ and Acting Chairperson, \th@deptorg\ \th@deptname \\%
      } {%
        \ifthenelse{\equal{\th@deptchair}{\th@honorsdirector}} {%
          \@doneHonorsdirectortrue%
          \th@deptchair\\%
          Chairperson,\ \th@deptorg\ \th@deptname\\%
          Honors Program Director%
        } {
        \th@deptchair\\%
        Chairperson,\ \th@deptorg\ \th@deptname\\%
        }
      }
    \fi
    %
    \if@doneHonorsdirector
    \else
      \vfill \th@signatureline \hfill \th@dateline\\%
      \th@honorsdirector\\%
      Honors Program Director%
    \fi
  }%
  {}%
  %% finished approval page for an HONORS THESIS

%%
%%  this is the approval page for a MASTERS THESIS 
%%
  \ifthenelse{
    \equal{\th@fulldegree}{Master of Science} \OR
    \equal{\th@fulldegree}{Master of Arts} \OR
    \equal{\th@fulldegree}{Master of Fine Arts} \OR
    \equal{\th@fulldegree}{Master of Art Education} }
  {% 
  %
    \typeout{GRADUATE THESIS}%
    \noindent We approve the \lowercase\expandafter{\th@degreetitle}\ of \th@fwdname \\ \\
    %
    \null\hfill\makebox[\datelinewidth][l]{Date of Signature}%
    %
    \newcounter{ct} \forloop{ct}{1}{\value{ct} < 5}%
    % creates a forloop over advisor, co-advisor, readerone and readertwo
    % and checks for all combinations of multiple roles for these people.
    {%
      \ifthenelse{\equal{\value{ct}}{1}} {%
        \renewcommand{\person}{\th@advisor}%
        \ifthenelse{ \equal{\th@coadvisor}{}}
          { \renewcommand{\personrole}{Advisor} }% when no co-advisor
          { \renewcommand{\personrole}{Co-Advisor} }% when co-advisor
        \renewcommand{\persontitle}{\th@advisortitle}%
        \renewcommand{\persondeptname}{\th@advisordept}%
        \renewcommand{\persondeptorg}{\th@deptorg}%
        \renewcommand{\personaffil}{}%
      }{}%
      \ifthenelse{ \equal{\value{ct}}{2}} {%
        \ifthenelse{ \equal{\th@coadvisor}{}}
        {\setcounter{ct}{3} }
        % print nothing and advance counter if coadvisor empty
        {% if co-advisor is set
          \renewcommand{\person}{\th@coadvisor}%
          \renewcommand{\personrole}{Co-Advisor}%
          \renewcommand{\persontitle}{\th@coadvisortitle}%
          \renewcommand{\persondeptname}{\th@coadvisordept}%
          \renewcommand{\persondeptorg}{\th@deptorg}%
          \renewcommand{\personaffil}{}%
        }
      }{}%
      \ifthenelse{\equal{\value{ct}}{3}} {%
        \ifthenelse{ \equal{\th@readerone}{}}
        {\setcounter{ct}{4} }
        % print nothing and advance counter if readerone empty
        {% if readerone is set
        \renewcommand{\person}{\th@readerone}%
        \renewcommand{\personrole}{Committee}%
        \renewcommand{\persontitle}{\th@readeronetitle}%
        \renewcommand{\persondeptname}{\th@readeronedept}%
        \renewcommand{\persondeptorg}{\th@deptorg}%
        \renewcommand{\personaffil}{\th@readeroneaffil}%
        }
      }{}%
      \ifthenelse{\equal{\value{ct}}{4}} {%
        \ifthenelse{ \equal{\th@readertwo}{}}
        {\setcounter{ct}{5} }
        % print nothing and advance counter if readertwo empty
        {% if readertwo is set
        \renewcommand{\person}{\th@readertwo}%
        \renewcommand{\personrole}{Committee}%
        \renewcommand{\persontitle}{\th@readertwotitle}%
        \renewcommand{\persondeptname}{\th@readertwodept}%
        \renewcommand{\persondeptorg}{\th@deptorg}%
        \renewcommand{\personaffil}{\th@readertwoaffil}%
        }
      }{}%

      % for each committee member entry
      % create correct affiliation entry for external readers
      \ifthenelse{\equal{\persondeptname}{}} {%
        \renewcommand{\persondeptorg}{}%
      }{}
         
      % test for dual roles
      \vfill \th@signatureline \hfill \th@dateline\\%
      % test whether the person is also Grad. Director, Chair or
      % Dean or some permutations thereof ...
      \ifthenelse{\equal{\person}{\th@graddirector}} {%
        \@doneGraddirectortrue
        \ifthenelse{\equal{\person}{\th@deptchair}} {%
          \@doneChairtrue
          \ifthenelse{\equal{\person}{\th@collegedean}} {%
            \@doneDeantrue
            \person\\%
            Dean, \th@collegeorg\ \th@collegename\\ %
            Acting Chairperson and Acting Graduate Program Director, \th@deptorg\ \th@deptname%
          }%
          {
            \ifthenelse{\equal{\persondeptname}{\th@deptname}} {%
              \person\\%
              \persontitle\ and Chairperson, \th@deptorg\ \th@deptname\\%
              Acting Graduate Program Director, \th@deptorg\ \th@deptname%
            }
            {
              % from another department
              \person\\%
              \persontitle\ \th@deptorg\ \th@deptname\\%
              Chairperson and Acting Graduate Program Director, \th@deptorg\ \th@deptname%
            }%
          }%
        }%
        {
          \ifthenelse{\equal{\person}{\th@collegedean}} {%
            \@doneDeantrue
            \person\\%
            Dean, \th@collegeorg\ \th@collegename\ and %
            Acting Graduate Program Director, \persondeptorg\ \persondeptname%
          }%
          {
            \ifthenelse{\equal{\persondeptname}{\th@deptname}} {%
              \person\\%
              \persontitle\\
	       Graduate Program Director, \th@deptname % \th@deptorg\ \th@deptname%
            }
            {
              \person\\%
              \persontitle, \persondeptorg\ \persondeptname \\%
              Graduate Program Director, \th@deptorg\ \th@deptname%
            }%
          }%
        }%
      }%
%%  done Graduate Director, Chair, Dean combinations
      {
        \ifthenelse{\equal{\person}{\th@deptchair}}%
        {
          \@doneChairtrue
          \ifthenelse{\equal{\person}{\th@collegedean}}% 
          {
            \@doneDeantrue
            \person\\%
            Dean, \th@collegeorg\ \th@collegename\ and %
            Acting Chairperson, \persondeptorg\ \persondeptname%
          }%
          {
            \ifthenelse{\equal{\persondeptname}{\th@deptname}} {%
              \person\\%
              \persontitle\ and Chairperson, \th@deptorg\ \th@deptname%
            }
            {
              \person\\%
              \persontitle, \persondeptorg\ \persondeptname\\%
              Chairperson,\ \th@deptorg\ \th@deptname%
            }%
          }
        }
        {
          \ifthenelse{\equal{\person}{\th@collegedean}} {%
            \@doneDeantrue
            \person\\%
            Dean, \th@collegeorg\ \th@collegename%
          } {%
            \person%
            % test for empty department/professorial title entry
            \ifthenelse{\equal{\persondeptname}{}} {
            }{
            \\ \persontitle, \persondeptorg\ \persondeptname%
            }
            % test for non-blank affiliation
            \ifthenelse{\equal{\personaffil}{}}
            { }% leave blank
            {%
              \ifthenelse{\equal{\personaffil}{University of Massachusetts Dartmouth}}%
              { }% leave blank
              {%
                \\ \personaffil% external affiliation
              }%
            }%
          }%
        }%
      }%
      \\ \th@degreetitle\ \personrole
    }% end loop over committee members
    %
    % test to see if each of Graduate Director, Chair and Dean have been done.
    % If not, generate line, name & title
    %
    \if@doneGraddirector
    \else
      \vfill \th@signatureline \hfill \th@dateline\\%
      % test whether Graduate Director is also Chair or Dean
      \ifthenelse{\equal{\th@graddirector}{\th@deptchair}} {%
        \@doneChairtrue
        \ifthenelse{\equal{\th@graddirector}{\th@collegedean}} {%
          \@doneDeantrue
          \th@graddirector\\%
          Dean, \th@collegeorg\ \th@collegename\\%
          Acting Chairperson and Acting Graduate Program Director, \th@deptorg\ \th@deptname%
        } {%
          \th@graddirector\\%
          Chairperson and Acting Graduate Program Director, \th@deptorg\ \th@deptname%
        }%
      } {%
        \ifthenelse{\equal{\th@graddirector}{\th@collegedean}} {%
          \@doneDeantrue
          \th@graddirector\\%
          Dean, \th@collegeorg\ \th@collegename\ and %
          Acting Graduate Program Director, \th@deptorg\ \th@deptname%
        } {%
          \th@graddirector\\%
          Graduate Program Director,  \th@deptorg\ \th@deptname
        }%
      }%
    \fi
    %
    \if@doneChair
    \else
      \vfill \th@signatureline \hfill \th@dateline\\%
      \ifthenelse{\equal{\th@deptchair}{\th@collegedean}} {%
        \@doneDeantrue
        \th@deptchair\\%
        Dean, \th@collegeorg\ \th@collegename\ and %
        Acting Chairperson, \th@deptorg\ \th@\deptname%
      } {%
        \th@deptchair\\%
        Chairperson,\ \th@deptorg\ \th@deptname%
      }%
    \fi
    %
    \if@doneDean
    \else
      \vfill \th@signatureline \hfill \th@dateline\\%
      \th@collegedean\\%
      Dean, \th@collegeorg\ \th@collegename
    \fi
    %
    \vfill \th@signatureline \hfill \th@dateline\\%
    \th@gradstudies\\%
    Associate Provost for Graduate Studies%
  \vfill
  }% 
  %% finished approval page for a MASTERS THESIS

%%
%%  this is the approval page for a Ph.D DISSERTATION
  \ifthenelse{\equal{\th@fulldegree}{Doctor of Philosophy}}
  {% 
    \typeout{GRADUATE Ph.D. DISSERTATION}%
    \noindent We approve the \lowercase\expandafter{\th@degreetitle}\ of \th@fwdname \\ \\
    \null\hfill\makebox[\datelinewidth][l]{Date of Signature}\\%
    %
    % now this gets complicated, some Ph.Ds are done through departments
    % these follow the format of M.S. thesis with department Graduate Director
    % & Chair signatures.
    % Others are non-department programs and have a program Graduate Director
    % but no Chair signature.
    %
    \ifthenelse{
%%
%%  Include other non-department Ph.D. programs here as required using
%%  \equal{\th@phdname}{abbrvname} \OR%
%%
      %\equal{\th@phdname}{abbrvname} \OR%
      \equal{\th@phdname}{BMEBT} \OR%
      \equal{\th@phdname}{EAS} }%
    {%
      \ifthenelse{\equal{\th@phdname}{BMEBT}} {%
        \renewcommand*{\phdfullname}{Biomedical Engineering and Biotechnology}
      }{}%
      \ifthenelse{\equal{\th@phdname}{EAS}} {%
        \renewcommand{\phdfullname}{Engineering and Applied Science}%
      }{}%
  
      % these dissertation have a program Graduate Director and no Chair
      \newcounter{ct} \forloop{ct}{1}{\value{ct} < 6}% 
      % creates a forloop over advisor, co-advisor (if present), readerone,
      % readertwo and readerthree and checks for all combinations of
      % multiple roles for these people.
      {%
        \ifthenelse{\equal{\value{ct}}{1}} {%
          \renewcommand{\person}{\th@advisor}%
          \ifthenelse{ \equal{\th@coadvisor}{}}
          { \renewcommand{\personrole}{Advisor} }% when no co-advisor
          { \renewcommand{\personrole}{Co-Advisor} }% when co-advisor
          \renewcommand{\persontitle}{\th@advisortitle}%
          \renewcommand{\persondeptname}{\th@advisordept}%
          \renewcommand{\persondeptorg}{\th@deptorg}%
          \renewcommand{\personaffil}{}%
        }{}%
        \ifthenelse{ \equal{\value{ct}}{2}} {%
          \ifthenelse{ \equal{\th@coadvisor}{}}
          {\setcounter{ct}{3} }
          % print nothing and advance counter if coadvisor empty
          {% if co-advisor is set
            \renewcommand{\person}{\th@coadvisor}%
            \renewcommand{\personrole}{Co-Advisor}%
            \renewcommand{\persontitle}{\th@coadvisortitle}%
            \renewcommand{\persondeptname}{\th@coadvisordept}%
            \renewcommand{\persondeptorg}{\th@deptorg}%
            \renewcommand{\personaffil}{}%
          }
        }{}%
        \ifthenelse{\equal{\value{ct}}{3}} {%
          \ifthenelse{ \equal{\th@readerone}{}}
          {\setcounter{ct}{4} }
          % print nothing and advance counter if readerone empty
          {% if readerone is set
          \renewcommand{\person}{\th@readerone}%
          \renewcommand{\personrole}{Committee}%
          \renewcommand{\persontitle}{\th@readeronetitle}%
          \renewcommand{\persondeptname}{\th@readeronedept}%
          \renewcommand{\persondeptorg}{\th@deptorg}%
          \renewcommand{\personaffil}{\th@readeroneaffil}%
          }
        }{}%
        \ifthenelse{\equal{\value{ct}}{4}} {%
          \ifthenelse{ \equal{\th@readertwo}{}}
          {\setcounter{ct}{5} }
          % print nothing and advance counter if readertwo empty
          {% if readertwo is set
          \renewcommand{\person}{\th@readertwo}%
          \renewcommand{\personrole}{Committee}%
          \renewcommand{\persontitle}{\th@readertwotitle}%
          \renewcommand{\persondeptname}{\th@readertwodept}%
          \renewcommand{\persondeptorg}{\th@deptorg}%
          \renewcommand{\personaffil}{\th@readertwoaffil}%
          }
        }{}%
        \ifthenelse{\equal{\value{ct}}{5}} {%
          \ifthenelse{ \equal{\th@readerthree}{}}
          {\setcounter{ct}{6} }
          % print nothing and advance counter if readerthree empty
          {% if readerthree is set
          \renewcommand{\person}{\th@readerthree}%
          \renewcommand{\personrole}{Committee}%
          \renewcommand{\persontitle}{\th@readerthreetitle}%
          \renewcommand{\persondeptname}{\th@readerthreedept}%
          \renewcommand{\persondeptorg}{\th@deptorg}%
          \renewcommand{\personaffil}{\th@readerthreeaffil}%
          }
        }{}%

        % for each committee member entry
        % create correct affiliation entry for external readers
        \ifthenelse{\equal{\persondeptname}{}} {%
          \renewcommand{\persondeptorg}{}%
        }{}
         
        \vfill \th@signatureline \hfill \th@dateline\\%
        % test whether the person is also Graduate Director,
        % Dean or some permutations thereof
        \ifthenelse{\equal{\person}{\th@graddirector}} {%
          \@doneGraddirectortrue
          \ifthenelse{\equal{\person}{\th@collegedean}}% 
          {
            \@doneDeantrue
            \person\\%
            Dean, \th@collegeorg\ \th@collegename\\ %
            Acting Graduate Program Director, \phdfullname%
            \ifthenelse{\equal{\th@phdname}{EAS}} {%
              Engineering and Applied Science%
            }{}%
          }%
          {
            \person\\%
            \persontitle, \persondeptorg\ \persondeptname \\%
            Graduate Program Director, \phdfullname%
          }%
        }%
        % done Graduate Director and Dean combinations
        {
          \ifthenelse{\equal{\person}{\th@collegedean}} {%
            \@doneDeantrue
  	    \person\\%
            Dean, \th@collegeorg\ \th@collegename%
          } {%
            \person%
            % test for empty department/professorial title entry
            \ifthenelse{\equal{\persondeptname}{}} {
            }{
            \\ \persontitle, \persondeptorg\ \persondeptname%
            }
            % test for non-blank affiliation
            \ifthenelse{\equal{\personaffil}{}}
            { }% leave blank
            {%
              \ifthenelse{\equal{\personaffil}{University of Massachusetts Dartmouth}}%
              { }% leave blank
              {%
                \\ \personaffil% external affiliation
              }%
            }%
          }%
        }%
        \\ \th@degreetitle\ \personrole
      }% end loop over committee members
      %
      % test to see if each of Graduate Director and Dean have been done. 
      % If not, generate line, name & title
      %
      \if@doneGraddirector
      \else
        \vfill \th@signatureline \hfill \th@dateline\\%
        % test whether Graduate Director is also Dean
        \ifthenelse{\equal{\th@graddirector}{\th@collegedean}} {%
          \@doneDeantrue
          \th@graddirector\\%
          Dean, \th@collegeorg\ \th@collegename \\ %
            Acting Graduate Program Director, \phdfullname%
        } {%
          \th@graddirector\\%
          Graduate Program Director, \th@phdfullname\\%
        }%
      \fi
      %
      \if@doneDean
      \else
        \vfill \th@signatureline \hfill \th@dateline\\%
        \th@collegedean\\%
        Dean, \th@collegeorg\ \th@collegename \\
      \fi
      %
      \vfill \th@signatureline \hfill \th@dateline\\%
      \th@gradstudies\\%
      Associate Provost for Graduate Studies%
    } % done non-department programs
    %
    %
    { % start department-based PhD programs
      \newcounter{ct} \forloop{ct}{1}{\value{ct} < 6}%
      % creates a forloop over advisor, co-advisor, readerone and readertwo
      % and checks for all combinations of multiple roles for these people.
      {%
        \ifthenelse{\equal{\value{ct}}{1}} {%
          \renewcommand{\person}{\th@advisor}%
          \ifthenelse{ \equal{\th@coadvisor}{}}
          { \renewcommand{\personrole}{Advisor} }% when no co-advisor
          { \renewcommand{\personrole}{Co-Advisor} }% when co-advisor
          \renewcommand{\persontitle}{\th@advisortitle}%
          \renewcommand{\persondeptname}{\th@advisordept}%
          \renewcommand{\persondeptorg}{\th@deptorg}%
          \renewcommand{\personaffil}{}%
        }{}%
        \ifthenelse{ \equal{\value{ct}}{2}} {%
          \ifthenelse{ \equal{\th@coadvisor}{}}
          {\setcounter{ct}{3} }
          % print nothing and advance counter if coadvisor empty
          {% if co-advisor is set
            \renewcommand{\person}{\th@coadvisor}%
            \renewcommand{\personrole}{Co-Advisor}%
            \renewcommand{\persontitle}{\th@coadvisortitle}%
            \renewcommand{\persondeptname}{\th@coadvisordept}%
            \renewcommand{\persondeptorg}{\th@deptorg}%
            \renewcommand{\personaffil}{}%
          }
        }{}%
        \ifthenelse{\equal{\value{ct}}{3}} {%
          \ifthenelse{ \equal{\th@readerone}{}}
          {\setcounter{ct}{4} }
          % print nothing and advance counter if readerone empty
          {% if readerone is set
          \renewcommand{\person}{\th@readerone}%
          \renewcommand{\personrole}{Committee}%
          \renewcommand{\persontitle}{\th@readeronetitle}%
          \renewcommand{\persondeptname}{\th@readeronedept}%
          \renewcommand{\persondeptorg}{\th@deptorg}%
          \renewcommand{\personaffil}{\th@readeroneaffil}%
          }
        }{}%
        \ifthenelse{\equal{\value{ct}}{4}} {%
          \ifthenelse{ \equal{\th@readertwo}{}}
          {\setcounter{ct}{5} }
          % print nothing and advance counter if readertwo empty
          {% if readertwo is set
          \renewcommand{\person}{\th@readertwo}%
          \renewcommand{\personrole}{Committee}%
          \renewcommand{\persontitle}{\th@readertwotitle}%
          \renewcommand{\persondeptname}{\th@readertwodept}%
          \renewcommand{\persondeptorg}{\th@deptorg}%
          \renewcommand{\personaffil}{\th@readertwoaffil}%
          }
        }{}%
        \ifthenelse{\equal{\value{ct}}{5}} {%
          \ifthenelse{ \equal{\th@readerthree}{}}
          {\setcounter{ct}{6} }
          % print nothing and advance counter if readerthree empty
          {% if readerthree is set
          \renewcommand{\person}{\th@readerthree}%
          \renewcommand{\personrole}{Committee}%
          \renewcommand{\persontitle}{\th@readerthreetitle}%
          \renewcommand{\persondeptname}{\th@readerthreedept}%
          \renewcommand{\persondeptorg}{\th@deptorg}%
          \renewcommand{\personaffil}{\th@readerthreeaffil}%
          }
        }{}%

        % for each committee member entry
        % create correct affiliation entry for external readers
        \ifthenelse{\equal{\persondeptname}{}} {%
          \renewcommand{\persondeptorg}{}%
        }{}
         
        % test for dual roles
        \vfill \th@signatureline \hfill \th@dateline\\%
        % test whether the person is also Graduate Director,
        % Chair or Dean or some permutations thereof
        \ifthenelse{\equal{\person}{\th@graddirector}} {%
          \@doneGraddirectortrue
          \ifthenelse{\equal{\person}{\th@deptchair}}% 
          {
            \@doneChairtrue
            \ifthenelse{\equal{\person}{\th@collegedean}}% 
            {
              \@doneDeantrue
              \person\\%
              Dean, \th@collegeorg\ \th@collegename\\%
              Acting Chairperson and Graduate Program Director, \th@deptorg\ \th@deptname%
            }%
            {
              \ifthenelse{\equal{\persondeptname}{\th@deptname}} {%
                \person\\%
                \persontitle, \persondeptorg\ \persondeptname \\%
                Chairperson and Acting Graduate Program Director, \th@deptorg\ \th@deptname%
              }
              {
                % if Chair is from another department ...
                \person\\%
                \persontitle, \persondeptorg\ \persondeptname\\%
                Chairperson and Acting Graduate Program Director, \th@deptorg\ \th@deptname%
              }%
            }%
          }%
          {
            \ifthenelse{\equal{\person}{\th@collegedean}}% 
            {
              \@doneDeantrue
              \person\\%
              Dean, \th@collegeorg\ \th@collegename\ and %
              Acting Graduate Program Director, \th@deptorg\ \th@deptname%
            }%
            {
              \ifthenelse{\equal{\persondeptname}{\th@deptname}} {%
                \person\\
                \persontitle\\ 
		and Graduate Program Director, \th@deptorg\ \th@deptname%
              }
              {
                % if from another department ...
                \person\\%
                \persontitle, \persondeptorg\ \persondeptname \\%
                Graduate Program Director, \th@deptorg\ \th@deptname%
              }%
            }%
          }%
        }%
        % done Graduate Director, Chair, Dean combinations
        {
          \ifthenelse{\equal{\person}{\th@deptchair}}%
          {
            \@doneChairtrue
            \ifthenelse{\equal{\person}{\th@collegedean}}% 
            {
              \@doneDeantrue
              \person\\%
  	      Dean, \th@collegeorg\ \th@collegename\ and %
              Acting Chairperson, \th@deptorg\ \th@deptname%
            }%
            {
              \ifthenelse{\equal{\persondeptname}{\th@deptname}} {%
                \person\\%
                \persontitle\ and Chairperson, \th@deptorg\ \th@deptname%
              }
              {
                % if person is from another department ...
                \person\\%
                \persontitle, \persondeptorg\ \persondeptname\\%
                Chairperson, \th@deptorg\ \th@deptname%
              }%
            }
          }
          {
            \ifthenelse{\equal{\person}{\th@collegedean}} {%
              \@doneDeantrue
              \person\\%
              Dean, \th@collegeorg\ \th@collegename%
            } {%
              % if person isfrom another department ...
              \person%
              % test for empty department/professorial title entry
              \ifthenelse{\equal{\persondeptname}{}} {
              }{
              \\ \persontitle, \persondeptorg\ \persondeptname%
              }
              % test for non-blank affiliation
              \ifthenelse{\equal{\personaffil}{}}
              { }% leave blank
              {%
                \ifthenelse{\equal{\personaffil}{University of Massachusetts Dartmouth}}%
                { }% leave blank
                {%
                  \\ \personaffil% external affiliation
                }%
              }%
            }%
          }%
        }%
        \\ \th@degreetitle\ \personrole
      }% end loop over committee members
      %
      % test to see if each of Graduate Director, Chair and Dean have been done.
      % If not, generate line, name & title
      %
      \if@doneGraddirector
      \else
        \vfill \th@signatureline \hfill \th@dateline\\%
        % test whether Grad. Director is also Chair or Dean
        \ifthenelse{\equal{\th@graddirector}{\th@deptchair}} {%
          \@doneChairtrue
          \ifthenelse{\equal{\th@graddirector}{\th@collegedean}} {%
            \@doneDeantrue
            \th@graddirector\\%
            Dean, \th@collegeorg\ \th@collegename \\%
            Acting Chairperson and Acting Graduate Program Director, \th@deptorg\ \th@deptname%
          } {%
            \th@graddirector\\%
            Chairperson and Acting Graduate Program Director, \th@deptorg\ \th@deptname%
          }%
        } {%
          \ifthenelse{\equal{\th@graddirector}{\th@collegedean}} {%
            \@doneDeantrue
            \th@graddirector\\%
            Acting Graduate Program Director, \th@deptorg\ \th@deptname%
            \\ Dean, \th@collegeorg\ \th@collegename \\%
          } {%
            \th@graddirector\\%
	    \\*  Graduate Program Director, \th@deptorg\  \th@deptname
          }%
        }%
      \fi
      %
      \if@doneChair
      \else
        \vfill \th@signatureline \hfill \th@dateline\\%
        \ifthenelse{\equal{\th@deptchair}{\th@collegedean}} {%
          \@doneDeantrue
          \th@deptchair\\%
          Acting Chairperson, \th@deptorg\ \th@deptname%
          \\ Dean, \th@collegeorg\ \th@collegename %
        } {%
          \th@deptchair\\%
          Chairperson,\ \th@deptorg\ \th@deptname%
        }%
      \fi
      %
      \if@doneDean
      \else
        \vfill \th@signatureline \hfill \th@dateline\\%
        \th@collegedean\\%
        Dean, \th@collegeorg\ \th@collegename \\
      \fi
      %
      \vfill \th@signatureline \hfill \th@dateline\\%
      \th@gradstudies\\%
      Associate Provost for Graduate Studies%
    }%  done department PhD programs
  }% 
  {}%
  %%  finished the approval page for a Ph.D DISSERTATION
%
}%

%%  completed the approval page !!

%%
%%  create the ABSTRACT PAGE
%%
\newcommand{\th@Abstractpage}{%
  \doublespacing%				
  \clearpage%
  \th@AbstractPageStyle%
  \chapter*{Abstract} %
  \@thInHeadingtrue%
  %\if@chapterCaps%
    %\uppercase\expandafter{\th@title}\\%
  %\else%
  \th@title%
  %\fi %
  \vspace{0.24in}
  \noindent \\ by \th@fwdname %
  \vspace{0.24in}%
  
  \noindent %
  \th@abstractStash%
}
%%  completed the abstract page !!

%%
%%  create the ACKNOWLEDGEMENTS PAGE
%%
%%  the acknowledgements page is used to dedicate the thesis to someone 
%%  and/or to acknowledge people's assistance with the work described.
%%
%%  The acknowledgements should be written in a professional manner. When
%%  writing the acknowledgments, be sure that your use of “person” is
%%  consistent.  If you begin with references to yourself as “the author,”
%%  continue to use third person throughout. If you begin with first person
%%  (“I,” “me,” “my”), use first person consistently.  There are two accepted
%%  spellings of the word “acknowledgments” (the other is “acknowledgements”);
%%  be sure to spell this word consistently.
%%
\newcommand{\th@Acknowledgementspage}{%
  \if@makeAcknowledgements%
    \doublespacing%
    \clearpage%
    \th@AcknowledgementsPageStyle%
    \chapter*{Acknowledgements}%
    \noindent %
    \th@acknowledgementsStash
  \fi%
}
%%  completed the acknowledgements page !!

%%
%%  create the EPIGRAPH PAGE
%%
%%  Some authors include a quotation (epigraph) or illustration (frontispiece)
%%  as the last of their preliminary pages. Neither should be listed in the
%%  table of contents, although a frontispiece may be included in the list of
%%  illustrations. The source of an epigraph is indicated below the quotation
%%  but is not listed in the bibliography or references unless it is also
%%  cited in the text. 
%%
\newcommand{\th@Epigraphpage}{%
  \if@makeEpigraph%
    \clearpage%
    \doublespacing%
    \thispagestyle{empty}%
    \null \vfill%
    \ifthenelse{\equal{\th@EpigraphPageStyle}{epigraph}}%
    {%
      \doublespacing%
      \th@epigraphStash%
    }{%
      {\centering%
      \includegraphics[width=0.9\textwidth,keepaspectratio]{\th@epigraphStash}%
      }
    }%
    \vfill%
  \fi%
}
%%  completed the epigraph page !!


%%
%%  create the PREFACE PAGE
%%
%%  From the UMass Dartmouth Thesis Guide
%%  "Requirements for Theses and Dissertations" (Spring 2015) 
%%  
%%  5.1.8 Preface (optional)
%%  ------------------------
%%  Most theses or dissertations will not have a Preface, which is called for
%%  only for unusual reasons, e.g., when the genesis of the work needs to be
%%  explained or when the author’s contribution to a multiple-authored work must
%%  be noted. If there is a preface, however, it would incorporate any
%%  acknowledgments instead of those appearing as a separate section.
%%  
%%  Preface sections are rarely used.  The first chapter (sometimes called
%%  “Introduction”) in the text section is the appropriate place for
%%  explanations of the context or the motivations that underlie the research,
%%  the research problem, the background of previous scholarship, notable
%%  contributions by other scholars, and so forth. Use a “Preface” section only
%%  for special purposes beyond such purposes as these; examples of such a
%%  special purpose are covered in sections 7.4 and 8.5.
%%  
%%
%%  7.4 Translations by the Author of Material Used
%%  ----------------------------------------------- 
%%  Material that you translate is still the intellectual property of the
%%  author. It must be documented fully (its original-language source cited
%%  properly and included in the bibliography). An appropriate note indicates by
%%  whom it has been translated, by you or someone else. If a thesis or
%%  dissertation will have extensive use of such material, this might be an
%%  occasion for an explanation in a Preface.  Usually, translators of published
%%  works will be indicated in the standard documentation of your notes and/or
%%  bibliography.
%% 
%%  8.5 Collaborative Work That Will Appear in a Thesis or Dissertation
%%  -------------------------------------------------------------------
%%  A thesis or dissertation must represent work done principally if not
%%  entirely by the author. When there are minor instances of research
%%  collaboration, an appropriate citation may be used. If extensive, however,
%%  the committee must approve it in detail and an explanation in a Preface
%%  section is called for (see sections 5.1.8).
%% 
%%  
%%  The preface should be written in a professional manner. When writing the
%%  acknowledgments, be sure that your use of “person” is consistent.  If you
%%  begin with references to yourself as “the author,” continue to use third
%%  person throughout. If you begin with first person (“I,” “me,” “my”), use
%%  first person consistently.  
%%
\newcommand{\th@Prefacepage}{%
  \if@makePreface%
    \addcontentsline{toc}{chapter}%
    {\normalsize\th@HdFnt\th@prefaceTitleStash\normalfont}%
    \clearpage%
    \thispagestyle{plain}%
    \chapter*{\th@prefaceTitleStash}%
    \vspace{2ex plus .6ex minus .12ex}

    {\doublespacing%
      \th@prefaceStash%
    }%
  \fi%
}
%%  completed the preface page !!

%%
%%  create the TOC, LOF & LOT PAGEs
%%
\newcommand{\th@ToCpage}{%
  \if@shortToC%
    \@THshortChaptertrue%
    \typeout{Making Short ToC...}%
  \fi%
  \@thInHeadingfalse%
  \thispagestyle{plain}%
  {\pagestyle{plain}%
    \clearpage
    \tableofcontents
  }
}

\newcommand{\th@LoFpage}{%
  \if@makenoLoF%
    \typeout{Skipping LoF...}%
  \else%
    \if@shortLoF\@THshortChaptertrue\fi%
    \clearpage%
    \addcontentsline{toc}{chapter}%
      {\normalsize\normalfont\LoFnameToC\normalfont}%
    {\pagestyle{plain}
    \doublespacing%
    \listoffigures}%
  \fi%
}

\newcommand{\th@LoTpage}{%
  \if@makenoLoT%
    \typeout{Skipping LoT...}%
  \else%
    \if@shortLoT\@THshortChaptertrue\fi%
    \clearpage%
    \addcontentsline{toc}{chapter}%
      {\normalsize\normalfont\LoTnameToC\normalfont}%
    {\pagestyle{plain}
    \doublespacing%
    \listoftables}%
\fi%
}
%%  completed the ToC, LoF, LoT pages !!

%%
%%  This performs the actual generation of the prologue pages
%%
\newcounter{th@storepage}
\newcommand{\th@MakeThesisPrologue}{%
  \if@makePrologue%
    \pagenumbering{roman}%
    \typeout{Generating Page}%
    \typeout{Making Title Page}%
    \th@Titlepage%
%    \ifthenelse{
%      \equal{\th@fulldegree}{Honors} \OR%
%      \equal{\th@fulldegree}{Undergraduate} }% 
%    {%
%      % no permission page for these ...
%    }%
%    {\typeout{Making Permision-To-Copy Page}%
%      \th@CopyPermissionPage %
%      % permission-to-copy has no page number
%      % reset the page counter
%      \setcounter{page}{1}%
%    }%


%    \typeout{Making Approval Page}%
    \th@Approvalpage%
%    \clearpage%
    \typeout{Making Abstract Page}%
    \th@Abstractpage%
    \typeout{Making Acknowedgements Page}%
    \th@Acknowledgementspage%
    \setcounter{th@storepage}{\value{page}}%
    \typeout{Making ToC Page}%
    \th@ToCpage%
    \typeout{Making LoF Page}%
    \th@LoFpage%
    \typeout{Making LoT Page}%
    \th@LoTpage%
    \typeout{Making Preface Page}%
    \th@Prefacepage%
    \typeout{Making Epigraph Page}%
    \th@Epigraphpage%
  \fi%
}
%%  completed the prologue pages !!

%%
%%  Make the prologue generator-command the very first command of the document.
%%
\let\th@OldBeginDocument\document
\renewcommand*{\document}{%
  \th@OldBeginDocument%
  \th@MakeThesisPrologue%
  \typeout{}%
  \typeout{}%
  \typeout{-------------------Beginning Body----------------------}%
  \typeout{}%
  \typeout{}%
  \clearpage%
  % set the page numbering style for the thesis body
  \pagestyle{myheadings}%
  \pagenumbering{arabic}%
  \markright{}%
  \doublespacing%
  \@THshortChapterfalse%
}

%%
%%  User commands for controlling the Prologue.
%%

\renewcommand*{\title}[1]{%
  \th@StoreIn{\th@title}{#1}%
}%
%
\newcommand*{\conferraldate}[2]{%
  \th@StoreIn{\th@degreemonth}{#1}%
  \th@StoreIn{\th@degreeyear}{#2}%
}%
%
\newcommand{\otherdegrees}[1]{%
  \th@StoreIn{\th@otherdegrees}{#1}%
}% 
%
\renewcommand*{\author}[2]{%
  \th@StoreIn{\th@fwdname}{#1 #2}%
  \th@StoreIn{\th@revname}{#2, #1}%
}
%
\newcommand*{\degree}[2]{%
  \th@StoreIn{\th@fulldegree}{#1}%
  \th@StoreIn{\th@abrvdegree}{#2}%
  \ifthenelse{\equal{\th@abrvdegree}{Ph.D.}}{%
    \th@StoreIn{\th@degreetitle}{Dissertation}%
  }{%
    \th@StoreIn{\th@degreetitle}{Thesis}%
    % this works for both Masters and Undergraduate theses
  }%
}
%
\newcommand*{\phdprogram}[2]{%
  \th@StoreIn{\th@phdoption}{#1}%
  \th@StoreIn{\th@phdname}{#2}%
}%
%
\newcommand*{\advisor}[4]{%
  \th@StoreIn{\th@advisor}{#2}%
  \th@StoreIn{\th@advisortitle}{#1}%
  \th@StoreIn{\th@advisordept}{#3}%
  \th@StoreIn{\th@advisoraffil}{#4}%
}
%
\newcommand*{\coadvisor}[4]{%
  \th@StoreIn{\th@coadvisor}{#2}%
  \th@StoreIn{\th@coadvisortitle}{#1}%
  \th@StoreIn{\th@coadvisordept}{#3}%
  \th@StoreIn{\th@coadvisoraffil}{#4}%
}
%
\newcommand*{\readerone}[4]{%
  \th@StoreIn{\th@readerone}{#2}%
  \th@StoreIn{\th@readeronetitle}{#1}%
  \th@StoreIn{\th@readeronedept}{#3}%
  \th@StoreIn{\th@readeroneaffil}{#4}%
}
%
\newcommand*{\readertwo}[4]{%
  \th@StoreIn{\th@readertwo}{#2}%
  \th@StoreIn{\th@readertwotitle}{#1}%
  \th@StoreIn{\th@readertwodept}{#3}%
  \th@StoreIn{\th@readertwoaffil}{#4}%
}
%
\newcommand*{\readerthree}[4]{%
  \th@StoreIn{\th@readerthree}{#2}%
  \th@StoreIn{\th@readerthreetitle}{#1}%
  \th@StoreIn{\th@readerthreedept}{#3}%
  \th@StoreIn{\th@readerthreeaffil}{#4}%
}
%
\newcommand*{\graddirector}[1]{%
  \th@StoreIn{\th@graddirector}{#1}%
}
%
\newcommand*{\deptchair}[1]{%
  \th@StoreIn{\th@deptchair}{#1}%
}
%
\newcommand*{\collegedean}[1]{%
  \th@StoreIn{\th@collegedean}{#1}%
}
%
\newcommand*{\honorsdirector}[1]{%
  \th@StoreIn{\th@honorsdirector}{#1}%
}
%
\newcommand*{\gradstudies}[1]{%
  \th@StoreIn{\th@gradstudies}{#1}%
}
%
\newcommand*{\dept}[2]{%
  \th@StoreIn{\th@deptorg}{#1}%
  \th@StoreIn{\th@deptname}{#2}%
}
%
\newcommand*{\program}[1]{%
  \th@StoreIn{\th@programname}{#1}%
}
%
\newcommand*{\college}[2]{%
  \th@StoreIn{\th@collegeorg}{#1}%
  \th@StoreIn{\th@collegename}{#2}%
}

%%
%%  define the other prologue pages
%%
\renewcommand{\abstract}[2][short]{%
  \ifthenelse{\equal{#1}{short}}{\relax}{%
    \th@StoreIn{\th@AbstractPageStyle}{\thispagestyle{plain}}%
  }{%
    \th@StoreIn{\th@abstractStash}{#2}%
  }%
}
%
\newcommand{\acknowledgements}[1]{%
  \@makeAcknowledgementstrue%
  \th@StoreIn{\th@AcknowledgementsPageStyle}{\thispagestyle{plain}}%
  \th@StoreIn{\th@acknowledgementsStash}{#1}%
}
%
\newcommand{\preface}[1]{%
  \@makePrefacetrue%
  \th@StoreIn{\th@prefaceTitleStash}{Preface}
  \th@StoreIn{\th@prefaceStash}{#1}%
}
%
\newcommand{\epigraph}[2][epigraph]{%
  \@makeEpigraphtrue%
  \th@StoreIn{\th@EpigraphPageStyle}{#1}
  \ifthenelse{\equal{#1}{epigraph}}{%
    \th@StoreIn{\th@epigraphTitleStash}{Epigraph}
  }{%
    \th@StoreIn{\th@epigraphTitleStash}{Frontispiece}
  }
  \th@StoreIn{\th@epigraphStash}{#2}%
}
%
\newcommand*{\SuspendPrologue}{%
  \@makeProloguefalse%
  \typeout{No prologue pages printed.}%
}
%
\newcommand*{\emptyLoF}{%
  \@makenoLoFtrue%
  \typeout{No LoF printed}%
}
%
\newcommand*{\emptyLoT}{%
  \@makenoLoTtrue%
  \typeout{No LoT printed}%
}
%
\newcommand*{\ToCisShort}{%
  \@shortToCtrue%
  \typeout{Putting page number on short ToC}%
}
%
\newcommand*{\LoFisShort}{%
  \@shortLoFtrue%
  \typeout{Putting page number on short LoF}%
}
%
\newcommand*{\LoTisShort}{%
  \@shortLoTtrue%
  \typeout{Putting page number on short LoT}%
}
%
\makeatletter
\def\@chapter[#1]#2{%
\ifnum \c@secnumdepth >\m@ne
  \refstepcounter{chapter}%
  \if@appendix
    \addcontentsline{toc}{chapter}%
    {\normalfont \protect\appendixnameToC\ \protect\numberline{\normalfont \thechapter} \normalfont #1}%
  \else
    \if@singleappendix
      \addcontentsline{toc}{chapter}%
      {\normalfont \appendixnameToC\ \normalfont #1}%
      % since a single appendix has no number, need to ensure
      % that the ToC entries for section, subsection, equations,
      % figures and tables don't have a leading period.
      \renewcommand*{\thesection}{\arabic{section}}%
      \renewcommand*{\thesubsection}{\thesection.\arabic{subsection}}%
      \renewcommand*{\theequation}{\arabic{equation}}%
      \renewcommand*{\thefigure}{\arabic{figure}}%
      \renewcommand*{\thetable}{\arabic{table}}%
    \else
      \addcontentsline{toc}{chapter}%
      {\normalfont \chapternameToC\ \protect\numberline{\normalfont \thechapter} {\normalfont #1}}%
    \fi
  \fi
\else
\fi
%
\chaptermark{#1}%
\addtocontents{lof}{\protect\addvspace{0\p@}}%
\addtocontents{lot}{\protect\addvspace{0\p@}}%
\if@twocolumn
  \@topnewpage[\@makechapterhead{#2}]%
\else
  \@makechapterhead{#2}%
  \@afterheading
\fi
}

\makeatother
\endinput
%% End of classfile ``umassdthesis.cls''.
