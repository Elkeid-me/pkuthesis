%% pkuthesis.cls
%% Copyright 2025 Elkeid Me
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Elkeid Me.
%
% This work consists of the file pkuthesis.cls and
% ctex-fontset-pkuthesis.def.

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{pkuthesis}
  {2025/05/24}{1.0.0}{2025 年本科生毕业论文 LaTeX 模板}

\bool_new:N \__pkuthesis_centersec_bool
\keys_define:nn { pkuthesis }
{
    centersec .code:n = { \bool_gset_true:N \__pkuthesis_centersec_bool },
    centersec .value_forbidden:n = true,
}
\ProcessKeyOptions [ pkuthesis ]
\cs_new:Npn \__pkuthesis_ccwd_space:n #1 { \hspace* { #1 \ccwd } }

\PassOptionsToPackage { no-math } { fontspec }
\LoadClass
  [ a4paper, fontset = pkuthesis, zihao = -4,
    linespread = 1.354167, sub3section ]
  { ctexart }

\ctexset {
    appendix/name = { \appendixname },
    contentsname  = {
        目
        \__pkuthesis_ccwd_space:n { 1 }
        录
    },
    section = {
        format     = \zihao { 3 }\sffamily,
        name       = { , . },
        beforeskip = 5.64bp,
        afterskip  = 5.64bp,
        break      = \clearpage,
    },
    subsection = {
        format = \zihao { 3 } \rmfamily,
        beforeskip = 5.64bp,
        afterskip  = 5.64bp,
    },
    subsubsection = {
        format     = \zihao{ 4 } \rmfamily,
        indent     = 2 \ccwd,
        beforeskip = 5.64pt,
        afterskip  = 5.64pt,
    }
}

\bool_if:NT \__pkuthesis_centersec_bool
{
    \ctexset {
        section = {
            format += \centering,
            name    = { 第, 章 },
            number  = \zhnum { section },
        }
    }
}

\RequirePackage
  [ inner = 2cm, outer = 2cm, bindingoffset = 0.5cm,
    top = 2.5cm, bottom = 2.5cm, head = 3.8mm,
    headsep = 12.02mm, footskip = 7.5mm, twoside ]
  { geometry }

\RequirePackage [ nocheck ] { fancyhdr }
\fancyhead [ C ] { \zihao { -5 } \__pkuthesis_title_cn: }
\fancyhead [ L ] { }
\fancyhead [ R ] { }
\fancyfoot [ C ] { \zihao { 5 } \textsf { 第 \thepage 页 } }

\RequirePackage { enumitem }
\setlist { itemsep = 0pt, listparindent = 2 \ccwd }

\RequirePackage { caption }
\DeclareCaptionFont { 11point }
  { \fontsize { 11bp } { 14.4bp } \selectfont }
\captionsetup [ figure ] {
    labelfont = sf, labelsep = quad,
    font = 11point, name = \textrm { 图 }
}
\counterwithin { figure } { section }
\captionsetup [ table ] {
    labelfont = sf, labelsep = quad,
    font = 11point, name = \textrm { 表 }
}
\counterwithin { table } { section }

\RequirePackage { tocloft }
\RenewDocumentCommand { \cfttoctitlefont } { }
  { \hfil \zihao { -2 } \sffamily \bfseries }
\RenewDocumentCommand { \cftaftertoctitle } { }
  { \hfill }
\RenewDocumentCommand { \cftbeforetoctitleskip } { }
  { 0pt }
\RenewDocumentCommand { \cftaftertoctitleskip } { }
  { 0.755bp }
\tocloftpagestyle { empty }

\cs_new:Npn \__pkuthesis_inter_tnum:
  { \InterTnum \fontsize { 11bp } { 13.248bp } \selectfont }

\RenewDocumentCommand { \cftdot } { }
  { \textmd { . } }
\RenewDocumentCommand { \cftdotsep } { }
  { 0.5 }
\RenewDocumentCommand { \cftparskip } { }
  { 3.44bp }

\RenewDocumentCommand { \cftbeforesecskip } { }
  { 0pt }
\RenewDocumentCommand { \cftsecdotsep } { }
  { \cftdotsep }
\RenewDocumentCommand { \cftsecfont } { }
  { \sffamily \__pkuthesis_inter_tnum: }
\RenewDocumentCommand { \cftsecpagefont } { }
  { \__pkuthesis_inter_tnum: }

\cftsetindents { subsection } { 0.39cm } { 1.5em }
\RenewDocumentCommand { \cftsubsecfont } { }
  { \__pkuthesis_inter_tnum: }
\RenewDocumentCommand { \cftsubsecaftersnumb } { }
  { \rmfamily }
\RenewDocumentCommand { \cftsubsecpagefont } { }
  { \__pkuthesis_inter_tnum: }

\cftsetindents { subsubsection } { 0.78cm } { 1.5em }
\RenewDocumentCommand { \cftsubsubsecfont } { }
  { \__pkuthesis_inter_tnum: }
\RenewDocumentCommand { \cftsubsubsecaftersnumb } { }
  { \rmfamily }
\RenewDocumentCommand { \cftsubsubsecpagefont } { }
  { \__pkuthesis_inter_tnum: }

\AddToHook { begindocument / end }
{
    \pagestyle { empty }
    \begin { center }
        \vspace* { -2.569mm }
        \includegraphics [ width = 8.39cm ] { PKU-Logo.pdf }
        \par
        \vspace* { -5.839mm }
        \zihao { -0 } \textsf { 本科生毕业论文 }
        \vspace* { 78.887mm }
    \end { center }

    \noindent \hspace* { 1.75cm }
    \begin { tblr } {
        colspec = {
            Q [ halign = c, valign = b, wd = 3.19cm,
                font = \zihao{3} \sffamily ]
            Q [ halign = c, valign = b, wd = 8.3cm,
                font = \zihao{3} \FangSong ]
        },
        rows                   = { ht = 1.1cm, rowsep = 0pt },
        columns                = { colsep = 0pt },
        hline {2, 3, 4, 5, 6 } = { 2 } { 2 } { dash = solid, wd = 0.5bp },
    }
        姓 \__pkuthesis_ccwd_space:n { 2 } 名：&
          \__pkuthesis_author:     \\

        学 \__pkuthesis_ccwd_space:n { 2 } 号：&
          \FangSongEn \__pkuthesis_student_id: \\

        院 \__pkuthesis_ccwd_space:n { 2 } 系：&
          \__pkuthesis_school:     \\

        专 \__pkuthesis_ccwd_space:n { 2 } 业：&
          \__pkuthesis_major:      \\

        导师姓名： & \__pkuthesis_mentor:
    \end { tblr }

    \begin { center }
        \vspace* { 32.158mm }
        \zihao{ 3 } 二〇二五 \textsf { 年五月 }
        \vspace* { -176.595mm }
    \end { center }

    \noindent \hspace* { 1.25cm }
    \begin { tblr } {
        colspec = {
            Q [ halign = c, valign = b, wd = 2.75cm,
                font = \zihao { 2 } ]
            Q [ halign = c, valign = b, wd = 10.16cm,
                font = \zihao { 1 } \sffamily \bfseries ]
        },
        rows            = { ht = 1.08cm, rowsep = 2mm },
        columns         = { colsep = 0pt },
        hline { 2 , 3 } = { 2 } { 2 } { dash = solid, wd = 0.75bp },
    }
        题目：& \__pkuthesis_title_cn_format:
               \__pkuthesis_title_cn: \\

             & \__pkuthesis_title_en_format:
               \__pkuthesis_title_en: \\
    \end { tblr }
    \clearpage
    \newgeometry { left = 2.6cm, right = 2.6cm, top = 3cm,
                   bottom = 2.5cm, bindingoffset = 0cm }
    \centerline { \zihao{ 3 } 北京大学本科毕业论文导师评阅表 }
    \vspace* { 10.535mm }
    \centerline {
        \noindent
        \begin { tblr } {
            hline { 1, 2, 3, 4, 5, 6, 8 } = { solid },
            vlines,
            hspan   = minimal,
            rows    = { rowsep = 0.5mm },
            columns = { colsep = 1.5mm },
            colspec = {
                Q [ halign = c, wd = 1.80cm ]
                Q [ halign = c, wd = 2.13cm ]
                Q [ halign = c, wd = 2.13cm ]
                Q [ halign = c, wd = 3.47cm ]
                Q [ halign = c, wd = 2.20cm ]
                Q [ halign = c, wd = 2.87cm ]
            },
            rowspec = {
                Q [ valign = m, ht = 0.72cm ]
                Q [ valign = m, ht = 0.72cm ]
                Q [ halign = c, valign = m, ht = 1.0cm ]
                Q [ valign = m, ht = 0.72cm ]
                Q [ valign = m, ht = 0.72cm ]
                Q [ ht = 14.5cm ]
            },
            cell { 1 } { 5, 6 } = { r = 2, c = 1 }
                                  { halign = c, valign = m },
            cell { 4 } { 1 }    = { r = 2, c = 1 }
                                  { halign = c, valign = m },
            cell { 4, 5 } { 2 } = { halign = c },
            cell { 4, 5 } { 3 } = { r = 1, c = 4 }
                                  { halign = c },
            cell { 6 } { 1 }    = { r = 1, c = 6 }
                                  { halign = l, valign = h },
            cell { 7 } { 1 }    = { r = 1, c = 6 }
                                  { halign = l, valign = m },
        }
            学生姓名 & \__pkuthesis_author: &
            本科院系 & \__pkuthesis_school: &
            论文成绩（等级制）& \__pkuthesis_grade: \\

            学生学号 & \__pkuthesis_student_id: & 本科专业 & \__pkuthesis_major: & & \\

            导师姓名 & \__pkuthesis_mentor_in_table: &
            { 导师单位 / \\ 所在学院 } & \__pkuthesis_mentor_workplace: &
            导师职称 & \__pkuthesis_mentor_academic_title: \\

            论文题目 & 中文 & \__pkuthesis_title_cn: & & & \\
                    & 英文 & \__pkuthesis_title_en: & & & \\
            {
                \setlength { \parindent } { 2 \ccwd }
                \centerline { 导师评语 }
                \par
                \KaiTi
                \centerline {
                    （包含对论文的性质、难度、分量、综合训练等是否
                    符合培养目标的目的等评价）
                }
                \par
                \__pkuthesis_turtor_comments:
            } & & & & & \\
            {
                \__pkuthesis_ccwd_space:n { 20.5 }
                导师签名：
                \par \  \par
                \__pkuthesis_ccwd_space:n { 24.5 }
                年
                \__pkuthesis_ccwd_space:n { 3 }
                月
                \__pkuthesis_ccwd_space:n { 3 }
                日
            } & & & & & \\
        \end { tblr }
    }
    \clearpage
    \vspace* { 7.622mm }
    \centerline { \zihao{ 3 } \textsf { 版权声明 } }
    \vspace* { 14.522mm }
    \noindent \begin { minipage } [ t ] { \textwidth }
        \linespread { 2.167 } \selectfont
        \setlength { \parindent } { 2 \ccwd }
        任何收存和保管本论文各种版本的单位和个人，未经本论文作者同意，
        不得将本论文转借他人，亦不得随意复制、抄录、拍照或以任何方式传播。
        否则，引起有碍作者著作权之问题，将可能承担法律责任。
    \end { minipage }
    \restoregeometry
    \clearpage
    \setcounter { page } { 1 }
    \centerline { \zihao{ 3 } \textsf{ \textbf{ 摘要 } } }
    \par \  \par
    { \bfseries \__pkuthesis_abstract_cn: }
    \par \  \par
    关键词：\__pkuthesis_keywords_cn:
    \clearpage
    \setcounter { page } { 1 }
    \centerline { \zihao { 3 } \textsf { \textbf { ABSTRACT } } }
    \par \  \par
    \__pkuthesis_abstract_en:
    \par \  \par
    KEY~WORDS:~\__pkuthesis_keywords_en:
    \clearpage
    \setcounter { page } { 1 }
    \vspace* { 18.01bp }
    \tableofcontents
    \clearpage
    \pagestyle { fancy }
    \setcounter { page } { 1 }
}

\AddToHook { enddocument }
{
    \newgeometry { left = 2.5cm, right = 2cm, top = 2.5cm,
                   bottom = 2.5cm, bindingoffset = 0cm }
    \section* { \centerline{ 北京大学学位论文原创性声明和使用授权说明 } }
    \addcontentsline { toc } { section }
      { 北京大学学位论文原创性声明和使用授权说明 }
    \pagestyle { empty }
    \vspace* { 2.359mm }
    \centerline { \zihao { 4 } \textbf { 原创性声明 } }
    \vspace* { 7.572mm }
    本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作
    所取得的成果。除文中已经注明引用的内容外，本论文不含任何其他个人或集体
    已经发表或撰写过的作品或成果。对本文的研究做出重要贡献的个人和集体，均
    已在文中以明确方式标明。本声明的法律结果由本人承担。
    \vspace* { 17.497mm }
    \begin { flushright }
        论文作者签名：
        \__pkuthesis_ccwd_space:n { 8.5 }
        \par
        \vspace* { 1.538mm }
        日期：
        \__pkuthesis_ccwd_space:n { 2 }
        年
        \__pkuthesis_ccwd_space:n { 1.5 }
        月
        \__pkuthesis_ccwd_space:n { 2 }
        日
        \par
    \end { flushright }
    \vspace* { 51.83mm }
    \centerline { \zihao{ 4 } \textbf{ 学位论文使用授权说明 } }
    \vspace* { 10.817mm }
    \par
    本人完全了解北京大学关于收集、保存、使用学位论文的规定，即：
    \begin { itemize }
        \item 按照学校要求提交学位论文的印刷本和电子版本；
        \item 学校有权保存学位论文的印刷本和电子版，并提供目录检索与阅览服务，
        在校园网上提供服务；
        \item 学校可以采用影印、缩印、数字化或其它复制手段保存论文；
    \end { itemize }
    \vspace* { 14.694mm }
    \begin { flushright }
        论文作者签名：
        \__pkuthesis_ccwd_space:n { 5 }
        导师签名：
        \__pkuthesis_ccwd_space:n { 5 }
        \par
        \vspace* { 3.042mm }
        日期：
        \__pkuthesis_ccwd_space:n { 1.5 }
        年
        \__pkuthesis_ccwd_space:n { 1.5 }
        月
        \__pkuthesis_ccwd_space:n { 1.5 }
        日
        \__pkuthesis_ccwd_space:n { 6.5 }
        \par
    \end { flushright }
}

\AddToHook { package / biblatex / after }
{
    \defbibheading { bibliography } [ \refname ]
    {
        \section* {#1}
        \addcontentsline { toc } { section } {#1}
        \vspace* { 16.5bp }
    }
}

\AddToHook { package / markdown / after }
{
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

\AddToHook { package / hyperref / after }
{
    \hypersetup {
        pdftitle    = { \__pkuthesis_title_cn: },
        pdfauthor   = { \__pkuthesis_author: },
        pdfkeywords = { \__pkuthesis_keywords_cn: },
    }
}

\RequirePackage [ perpage, symbol* ] { footmisc }
\DefineFNsymbols* { pkuthesis-circles } {
    { \SourceHanSerif ① } { \SourceHanSerif ② }
    { \SourceHanSerif ③ } { \SourceHanSerif ④ }
    { \SourceHanSerif ⑤ } { \SourceHanSerif ⑥ }
    { \SourceHanSerif ⑦ } { \SourceHanSerif ⑧ }
    { \SourceHanSerif ⑨ }
}
\setfnsymbol { pkuthesis-circles }

\RequirePackage { graphicx }
\RequirePackage { tabularray }

\NewTblrEnviron { hqtblr }
\SetTblrInner [ hqtblr ] {
    hline { 1, Z } = { dash = solid, wd = 2.25bp },
    hline { 2 }    = { dash = solid, wd = 0.5bp },
    rows           = { font = \small, rowsep=1.25pt },
    row { 1 }      = { font = \small \sffamily \bfseries },
}

\cs_new_eq:NN \__pkuthesis_appendix: \appendix

\RenewDocumentCommand { \appendix } { }
{
    \__pkuthesis_appendix:
    \ctexset {
        subsection = {
            name   = 附录,
            format = \zihao { -4 } \rmfamily,
            indent = 2 \ccwd,
        }
    }
}

\NewDocumentCommand { \acknowledgments } { }
{
    \section* { 致谢 }
    \addcontentsline { toc } { section } { 致谢 }
}

\NewDocumentCommand { \mentor } { o m m m }
{
    \cs_new:Npn \__pkuthesis_mentor: {#2}
    \cs_new:Npn \__pkuthesis_mentor_workplace: {#3}
    \cs_new:Npn \__pkuthesis_mentor_academic_title: {#4}
    \IfNoValueTF {#1}
      { \cs_new:Npn \__pkuthesis_mentor_in_table: {#2} }
      { \cs_new:Npn \__pkuthesis_mentor_in_table: {#1} }
}

\cs_new:Npn \__pkuthesis_title_cn_format: { }
\cs_new:Npn \__pkuthesis_title_en_format: { }

\RenewDocumentCommand { \author } { m }
  { \cs_new:Npn \__pkuthesis_author: {#1} }
\NewDocumentCommand { \titleCn } { m }
  { \cs_new:Npn \__pkuthesis_title_cn: {#1} }
\NewDocumentCommand { \titleEn } { m }
  { \cs_new:Npn \__pkuthesis_title_en: {#1} }
\NewDocumentCommand { \abstractCn } { +m }
  { \cs_new:Npn \__pkuthesis_abstract_cn: {#1} }
\NewDocumentCommand { \abstractEn } { +m }
  { \cs_new:Npn \__pkuthesis_abstract_en: {#1} }
\NewDocumentCommand { \keywordsCn } { m }
  { \cs_new:Npn \__pkuthesis_keywords_cn: {#1} }
\NewDocumentCommand { \keywordsEn } { m }
  { \cs_new:Npn \__pkuthesis_keywords_en: {#1} }
\NewDocumentCommand { \studentID } { m }
  { \cs_new:Npn \__pkuthesis_student_id: {#1} }
\NewDocumentCommand { \school } { m }
  { \cs_new:Npn \__pkuthesis_school: {#1} }
\NewDocumentCommand { \major } { m }
  { \cs_new:Npn \__pkuthesis_major: {#1} }
\NewDocumentCommand { \grade } { m }
  { \cs_new:Npn \__pkuthesis_grade: {#1} }
\NewDocumentCommand { \turtorComments } { +m }
  { \cs_new:Npn \__pkuthesis_turtor_comments: {#1} }
\NewDocumentCommand { \titleCnFormat } { m }
  { \cs_set:Npn \__pkuthesis_title_cn_format: {#1} }
\NewDocumentCommand { \titleEnFormat } { m }
  { \cs_set:Npn \__pkuthesis_title_en_format: {#1} }
