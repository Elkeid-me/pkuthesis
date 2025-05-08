\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pkuthesis}
\PassOptionsToPackage{no-math}{fontspec}
\LoadClass[a4paper,fontset=none,zihao=-4,linespread=1.35]{ctexart}

\setCJKmainfont{Source Han Serif SC Regular}[
    BoldFont       = Source Han Serif SC Bold,
    ItalicFont     = STKaiti,
    BoldItalicFont = STKaiti
]
\setCJKmonofont{Source Han Sans SC Light}[
    BoldFont       = Source Han Sans SC Regular,
    ItalicFont     = STKaiti,
    BoldItalicFont = STKaiti
]
\setCJKsansfont{Source Han Sans SC Regular}[
    BoldFont       = Source Han Sans SC Medium,
    ItalicFont     = Source Han Sans SC ExtraLight,
    BoldItalicFont = Source Han Sans SC Light,
]
\setmainfont{Nimbus Roman No9 L}
\setmonofont{JetBrains Mono NL Regular}[
    BoldFont       = JetBrains Mono NL Bold,
    ItalicFont     = JetBrains Mono NL Italic,
    BoldItalicFont = JetBrains Mono NL Bold Italic,
]
\setsansfont{Inter Regular}[
    BoldFont       = Inter Bold,
    ItalicFont     = Inter Italic,
    BoldItalicFont = Inter Bold Italic,
]
\newfontfamily \InterFont {Inter} [ Numbers = Monospaced ]
\newCJKfontfamily \FangSong {SimFang}
\newfontfamily \FangSongEn {SimFang}

\ctexset {
    contentsname = \centerline{\zihao{-2}\sffamily\bfseries 目\hspace{1\ccwd}录}\vspace*{1.5pt},
    section = {
        format     = \zihao{3}\sffamily,
        name       = {,.},
        beforeskip = 5.64bp,
        afterskip  = 5.64bp,
        break      = \clearpage,
    },
    subsection = {
        format = \zihao{3}\rmfamily,
        beforeskip = 5.64bp,
        afterskip  = 5.64bp,
    },
    subsubsection = {
        format = \zihao{4}\rmfamily,
        indent = 2\ccwd,
        beforeskip = 5.64pt,
        afterskip  = 5.64pt,
    }
}

\RequirePackage[left=2cm, right=2cm, bindingoffset=0.5cm,
                top=2.5cm, bottom=2.5cm,
                head=3.8mm, headsep=12.02mm, footskip=7.5mm, twoside]{geometry}

\RequirePackage[nocheck]{fancyhdr}
\fancyhead[C]{{\zihao{-5} \titleCn}}
\fancyhead[L]{}
\fancyhead[R]{}
\fancyfoot[C]{{\zihao{5}\textsf{第 \thepage 页}}}

\RequirePackage{enumitem}
\setlist{topsep=0pt,itemsep=0pt,listparindent=2\ccwd}

\RequirePackage{caption}
\captionsetup[figure]{labelfont=sf,labelsep=quad,font=small,name=\textrm{图}}
\counterwithin{figure}{section}
\captionsetup[table]{labelfont=sf,labelsep=quad,font=small,name=\textrm{表}}
\counterwithin{table}{section}

\RequirePackage{tocloft}
\RenewDocumentCommand{\cfttoctitlefont}{}{\hfil\zihao{-2}\sffamily\bfseries}
\RenewDocumentCommand{\cftaftertoctitle}{}{\hfill}
\RenewDocumentCommand{\cftbeforetoctitleskip}{}{0pt}
\RenewDocumentCommand{\cftaftertoctitleskip}{}{1.5pt}
\tocloftpagestyle{empty}

\RenewDocumentCommand{\cftdot}{}{\textmd{.}}
\RenewDocumentCommand{\cftdotsep}{}{0.5}
\RenewDocumentCommand{\cftparskip}{}{3.5pt}

\RenewDocumentCommand{\cftbeforesecskip}{}{0pt}
\RenewDocumentCommand{\cftsecdotsep}{}{\cftdotsep}
\RenewDocumentCommand{\cftsecfont}{}{\sffamily\InterFont\small}
\RenewDocumentCommand{\cftsecpagefont}{}{\InterFont\small}

\cftsetindents{subsection}{0.39cm}{1.5em}
\RenewDocumentCommand{\cftsubsecfont}{}{\InterFont\small}
\RenewDocumentCommand{\cftsubsecaftersnumb}{}{\rmfamily}
\RenewDocumentCommand{\cftsubsecpagefont}{}{\InterFont\small}

\cftsetindents{subsubsection}{0.78cm}{1.5em}
\RenewDocumentCommand{\cftsubsubsecfont}{}{\InterFont\small}
\RenewDocumentCommand{\cftsubsubsecaftersnumb}{}{\rmfamily}
\RenewDocumentCommand{\cftsubsubsecpagefont}{}{\InterFont\small}

\AddToHook{begindocument/end} {
    \pagestyle{empty}
    \begin{center}
        \vspace*{-2.569mm}
        \includegraphics[width=8.39cm]{PKU-Logo.pdf}

        \vspace*{-5.839mm}

        \zihao{-0} \textsf{本科生毕业论文}

        \vspace*{78.887mm}
    \end{center}

    \noindent\hspace*{1.75cm}\begin{tblr} {
        colspec = {
            Q[halign=c,valign=b,wd=3.19cm,font=\zihao{3}\sffamily]
            Q[halign=c,valign=b,wd=8.3cm,font=\zihao{3}\FangSong\FangSongEn]
        },
        rows = { ht=1.1cm,rowsep=0pt },
        columns = { colsep=0pt},
        hline{2,3,4,5,6} = {2}{2}{dash=solid,wd=0.5bp},
    }
        姓\hspace*{2\ccwd}名：& \studentName \\
        学\hspace*{2\ccwd}号：& \studentID \\
        院\hspace*{2\ccwd}系：& \schoolName \\
        专\hspace*{2\ccwd}业：& \majorIn \\
        导师姓名： & \tutorName
    \end{tblr}

    \begin{center}
        \vspace*{32.158mm}
        \zihao{3} 二〇二五\textsf{年五月}

        \vspace*{-176.595mm}
    \end{center}

    \noindent\hspace*{1.25cm}\begin{tblr} {
        colspec = {
            Q[halign=c,valign=b,wd=2.75cm,font=\zihao{2}]
            Q[halign=c,valign=b,wd=10.16cm,font=\zihao{1}\sffamily\bfseries]
        },
        rows = { ht=1.08cm,rowsep=2mm },
        columns = { colsep=0pt },
        hline{2,3} = {2}{2}{dash=solid,wd=0.75bp},
    }
        题目：& \preTitleCn\titleCn \\
             & \preTitleEn\titleEn
    \end{tblr}
    \newpage
    \vspace*{7.277mm}
    \tableofcontents
    \pagestyle{fancy}
    \setcounter{page}{1}
}

\RequirePackage{graphicx,tabularray}
