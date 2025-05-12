\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pkuthesis}
\PassOptionsToPackage{no-math}{fontspec}
\LoadClass[a4paper,fontset=none,zihao=-4,linespread=1.354167]{ctexart}

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
\newfontfamily \SourceHanSerif {Source Han Serif SC Regular}

\ctexset {
    appendix/name = {\appendixname},
    contentsname  = \centerline{\zihao{-2}\sffamily\bfseries 目\hspace{1\ccwd}录}\vspace*{1.5pt},
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
\setlist{itemsep=0pt,listparindent=2\ccwd}

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
        columns = { colsep=0pt },
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
    \clearpage
    \centerline{\zihao{3}北京大学本科毕业论文导师评阅表}
    \vspace*{15.535mm}
    \noindent\begin{tblr} {
        hline{1,2,3,4,5,6,9} = {solid},
        vlines,
        hspan=minimal,
        rows = { rowsep=0pt },
        columns = { colsep=1.5mm },
        colspec = {
            Q[halign=c,wd=1.80cm]
            Q[halign=c,wd=2.13cm]
            Q[halign=c,wd=2.38cm]
            Q[halign=c,wd=3.22cm]
            Q[halign=c,wd=2.20cm]
            Q[halign=c,wd=2.87cm]
        },
        rowspec = {
            Q[valign=m,ht=0.82cm]
            Q[valign=m,ht=0.82cm]
            Q[halign=c,valign=m,ht=1.1cm]
            Q[valign=m,ht=0.82cm]
            Q[valign=m,ht=0.82cm]
            Q[ht=13.6cm]
            Q[ht=0.82cm]
            Q[ht=0.82cm]
        },
        cell{1}{5,6} = {r=2,c=1}{halign=c,valign=m},
        cell{4}{1}   = {r=2,c=1}{halign=c,valign=m},
        cell{4,5}{2} = {halign=c},
        cell{4,5}{3} = {r=1,c=4}{halign=l},
        cell{6}{1}   = {r=1,c=6}{halign=l,valign=h},
        cell{7,8}{1} = {r=1,c=6}{halign=l,valign=m},
    }
        学生姓名 & \studentName & 本科院系 & \schoolName & 论文成绩（等级制）& \\
        学生学号 & \studentID & 本科专业 & \majorIn & & \\
        导师姓名 & \tutorName & {导师单位/\\所在学院} & & 导师职称 \\
        论文题目 & 中文 & \titleCn & & & \\
                & 英文 & \titleEn & & & \\
        {
          \setlength{\parindent}{2\ccwd}\centerline{导师评语}

          \centerline{\textit{（包含对论文的性质、难度、分量、综合训练等是否符合培养目标的目的等评价）}}
        } & & & & & \\
        \hspace{18.5\ccwd}导师签名： & & & & & \\
        \hspace{22.5\ccwd}年\hspace{3\ccwd}月\hspace{3\ccwd}日 & & & & & \\
    \end{tblr}
    \clearpage
    \vspace*{12.622mm}
    \centerline{\zihao{3}\textsf{版权声明}}

    \vspace*{14.522mm}

    \noindent\begin{minipage}[t]{\textwidth}
        \linespread{2}\selectfont
        \setlength{\parindent}{2\ccwd}
        任何收存和保管本论文各种版本的单位和个人，未经本论文作者同意，
        不得将本论文转借他人，亦不得随意复制、抄录、拍照或以任何方式传播。
        否则，引起有碍作者著作权之问题，将可能承担法律责任。
    \end{minipage}
    \clearpage
    \centerline{\zihao{3}\textsf{\textbf{摘要}}}

    ~

    \abstractCn

    ~

    关键词：\keywordsCn

    \clearpage
    \centerline{\zihao{3}\textsf{\textbf{ABSTRACT}}}

    ~

    \abstractEn

    ~

    KEY WORDS: \keywordsEn
    \clearpage
    \vspace*{7.277mm}
    \tableofcontents
    \clearpage
    \pagestyle{fancy}
    \setcounter{page}{1}
}

\AddToHook{enddocument} {
    \section*{\centerline{北京大学学位论文原创性声明和使用授权说明}}
    \addcontentsline{toc}{section}{北京大学学位论文原创性声明和使用授权说明}
    \pagestyle{empty}

    \vspace*{2.359mm}

    \centerline{\zihao{4}\textbf{原创性声明}}

    \vspace*{7.572mm}

    本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作
    所取得的成果。除文中已经注明引用的内容外，本论文不含任何其他个人或集体
    已经发表或撰写过的作品或成果。对本文的研究做出重要贡献的个人和集体，均
    已在文中以明确方式标明。本声明的法律结果由本人承担。

    \vspace*{17.497mm}

    \begin{flushright}
        论文作者签名：\hspace*{8.5\ccwd}

        \vspace*{1.538mm}

        日期：\hspace*{2\ccwd}年\hspace*{1.5\ccwd}月\hspace*{2\ccwd}日
    \end{flushright}

    \vspace*{51.83mm}

    \centerline{\zihao{4}\textbf{学位论文使用授权说明}}

    \vspace*{10.817mm}

    本人完全了解北京大学关于收集、保存、使用学位论文的规定，即：

    \begin{itemize}
        \item 按照学校要求提交学位论文的印刷本和电子版本；

        \item 学校有权保存学位论文的印刷本和电子版，并提供目录检索与阅览服务，在校园网上提供服务；

        \item 学校可以采用影印、缩印、数字化或其它复制手段保存论文；
    \end{itemize}

    \vspace*{14.694mm}

    \begin{flushright}
        论文作者签名：\hspace*{5\ccwd}导师签名：\hspace*{5\ccwd}

        \vspace*{3.042mm}

        日期：\hspace*{1.5\ccwd}年\hspace*{1.5\ccwd}月\hspace*{1.5\ccwd}日\hspace*{6.5\ccwd}
    \end{flushright}
}

\AddToHook{package/biblatex/after} {
    \defbibheading{bibliography}[\refname]{
        \section*{#1}
        \addcontentsline{toc}{section}{#1}
        \vspace*{16.5pt}
    }
}

\AddToHook{package/markdown/after} {
    \markdownSetup {
        shiftHeadings          = -1,
        citations              = true,
        relativeReferences     = true,
        headerAttributes       = true,
        rawAttribute           = true,
        hashEnumerators        = true,
        texMathDollars         = true,
        texMathSingleBackslash = true,
    }
}

\RequirePackage[perpage,symbol*]{footmisc}
\DefineFNsymbols*{Circles} {
    {\SourceHanSerif ①} {\SourceHanSerif ②}
    {\SourceHanSerif ③} {\SourceHanSerif ④}
    {\SourceHanSerif ⑤} {\SourceHanSerif ⑥}
    {\SourceHanSerif ⑦} {\SourceHanSerif ⑧}
    {\SourceHanSerif ⑨}
}
\setfnsymbol{Circles}

\RequirePackage{graphicx,tabularray}

\NewTblrEnviron{hqtblr}
\SetTblrInner[hqtblr] {
    hline{1,Z} = { dash=solid,wd=2.25bp },
    hline{2}   = { dash=solid,wd=0.5bp },
    rows       = { font=\small, rowsep=1.25pt },
    row{1}     = { font=\small\sffamily\bfseries },
}

\NewDocumentCommand { \Appendix } { } {
    \appendix
    \ctexset {
        subsection = {
            name   = {附录},
            format = \zihao{-4}\rmfamily,
            indent = 2\ccwd,
        },
    }
}

\NewDocumentCommand { \Acknowledgments } { } {
    \section*{致谢}
    \addcontentsline{toc}{section}{致谢}
}
