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
  {2025/05/27}{2.0.0-dev}{Thesis class for School of EECS, Peking University, 2025}

`pkuthesis` 暂时只支持 XeTeX 和 LuaTeX。
\msg_new:nnn { pkuthesis } { unsupported-engine }
{
    The~ pkuthesis~ class~ requires~ XeTeX~ or~ LuaTeX.~
    "#1"~ is~ not~ supported~ at~ present.
}

\bool_if:nF { \sys_if_engine_xetex_p: || \sys_if_engine_luatex_p: }
{
    \msg_fatal:nnx { pkuthesis } { unsupported-engine }
      { \c_sys_engine_str }
}

\bool_new:N \g__pku_centersec_bool
\bool_new:N \g__pku_draft_bool
\dim_new:N  \l__pku_tmpa_dim
\skip_new:N \l__pku_tmpa_skip
\clist_new:N \g__pku_to_ctex_clist
\cs_new_protected:Npn \__ccwd_space:n #1 { \skip_horizontal:n { #1 \ccwd } }
\cs_new_protected:Npn \__pku_vspace:N #1
{
    \dim_set_eq:NN \l__pku_tmpa_dim \tex_prevdepth:D
    \tex_hrule:D height 0pt
    \nobreak
    \skip_vertical:n { -12bp }
    % \skip_vertical:N #1
    % \skip_vertical:N \c_zero_skip
    \dim_set_eq:NN \tex_prevdepth:D \l__pku_tmpa_dim
}
\cs_new_protected:Npn \__pku_vspace:n #1
{
    \skip_set:Nn \l__pku_tmpa_skip {#1}
    \__pku_vspace:N \l__pku_tmpa_skip
}
\keys_define:nn { pkuthesis / options }
{
    draft     .code:n =
    {
        \bool_gset_true:N \g__pku_draft_bool
        \clist_gput_right:Nn \g__pku_to_ctex_clist { draft }
    },
    draft     .value_forbidden:n = true,
    centersec .code:n = { \bool_gset_true:N \g__pku_centersec_bool },
    centersec .value_forbidden:n = true,
}
\ProcessKeyOptions [ pkuthesis / options ]

% `no-math``fontspec`。
\PassOptionsToPackage { no-math } { fontspec }

% 使用 XeTeX 时，打开 `xeCJK` 的 `CJKmath` 选项，使数学环境中可以直接输入
% CJK 字符，与使用 LuaTeX 时 `luatex-ja` 的行为一致。
\sys_if_engine_xetex:T
  { \PassOptionsToPackage { CJKmath } { xecjk } }

% 现在，加载 `ctexart` 文档类，纸张大小为 A4，字体配置为 `pkuthesis`，
% 正文字号为小四号，行距因子为 1.354167。
%
% 在教务 Word 模板中，行距被设置为 1.25 倍；且设置文档网格为 15.6 磅
% (磅 = point，在 Word 中为 1/72 英寸，即 TeX 中的 big point，bp)。
% 因此，教务 Word 模板的行距为 1.25 × 15.6 = 19.5bp。
%
% 而我们将正文字号设置为小四（12bp），`ctex` 会自动设置 `\baselineskip` 为
% 12 × 1.2 = 14.4bp。而真正的行距为 `\baselineskip` 乘 `linespread`。
%
% 可见 `linespread` 应为 19.5 / 14.4 = 1.354167。
%
% 此外，打开 `sub3section` 开关，在 `\paragraph` 后换行。
%
% 可能更好的选择是 `ctexbook` 文档类。
\LoadClass
[
    a4paper,
    fontset    = pkuthesis,
    zihao      = -4,
    linespread = 1.354167,
    sub3section,
    \g__pku_to_ctex_clist
]
  { ctexart }


% 处理 `centersec` 开关。
\bool_if:NTF \g__pku_centersec_bool
{
    \ctexset
    {
        section =
        {
            format     = \zihao { 3 } \sffamily \centering,
            name       = { 第, 章 },
            beforeskip = 5.64bp,
            afterskip  = 5.64bp,
            number     = \zhnum { section },
        }
    }
}
{
    \ctexset
    {
        section =
        {
            format     = \zihao { 3 } \sffamily,
            name       = { , . },
            beforeskip = 5.64bp,
            afterskip  = 5.64bp,
            break      = \clearpage,
        }
    }
}

% 设置其他级别标题的格式。
\ctexset
{
    appendix / name = { \appendixname },
    contentsname  =
    {
        目
        \__ccwd_space:n { 1 }
        录
    },
    subsection =
    {
        format = \zihao { 3 } \rmfamily,
        beforeskip = 5.64bp,
        afterskip  = 5.64bp,
    },
    subsubsection =
    {
        format     = \zihao{ 4 } \rmfamily,
        indent     = 2 \ccwd,
        beforeskip = 5.64bp,
        afterskip  = 5.64bp,
    }
}

% 加载 `fancyhdr` 宏包，设置页眉页脚格式。
\RequirePackage [ nocheck ] { fancyhdr }

% 加载 `footmisc` 宏包，设置脚注格式。
\RequirePackage [ perpage, symbol* ] { footmisc }

% 加载 `geometry` 宏包，设置页边距。
\RequirePackage
[
    inner         = 2cm,
    outer         = 2cm,
    bindingoffset = 0.5cm,
    top           = 2.5cm,
    bottom        = 2.5cm,
    head          = 3.8mm,
    headsep       = 12.02mm,
    footskip      = 7.5mm,
    twoside,
]
  { geometry }

\RequirePackage
{
    caption,
    enumitem,
    graphicx,
    tabularray,
    tocloft,
}

% 处理 `draft` 开关。
\bool_if:NT \g__pku_draft_bool { \geometry { showframe } }

\fancyhead [ L ] { }
\fancyhead [ C ] { \zihao { -5 } \__pku_title_cn: }
\fancyhead [ R ] { }
\fancyfoot [ L ] { }
\fancyfoot [ C ] { \zihao { 5 } \textsf { 第 \thepage 页 } }
\fancyfoot [ R ] { }

\setlist { itemsep = 0pt, listparindent = 2 \ccwd }

\DeclareCaptionFont { 11point }
  { \fontsize { 11bp } { 14.4bp } \selectfont }
\captionsetup [ figure ]
{
    labelfont = sf,
    labelsep  = quad,
    font      = 11point,
    name      = \textrm { 图 },
}
\counterwithin { figure } { section }
\captionsetup [ table ]
{
    labelfont = sf,
    labelsep  = quad,
    font      = 11point,
    name = \textrm { 表 },
}
\counterwithin { table } { section }

\RenewDocumentCommand { \cfttoctitlefont } { }
  { \hfil \zihao { -2 } \sffamily \bfseries }
\RenewDocumentCommand { \cftaftertoctitle } { }
  { \hfill }
\RenewDocumentCommand { \cftbeforetoctitleskip } { }
  { 0pt }
\RenewDocumentCommand { \cftaftertoctitleskip } { }
  { 0.755bp }
\tocloftpagestyle { empty }

\cs_new_protected:Npn \__pku_inter_tnum:
  { \InterTNUM \fontsize { 11bp } { 13.248bp } \selectfont }

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
  { \sffamily \__pku_inter_tnum: }
\RenewDocumentCommand { \cftsecpagefont } { }
  { \__pku_inter_tnum: }

\cftsetindents { subsection } { 0.39cm } { 1.5em }
\RenewDocumentCommand { \cftsubsecfont } { }
  { \__pku_inter_tnum: }
\RenewDocumentCommand { \cftsubsecaftersnumb } { }
  { \rmfamily }
\RenewDocumentCommand { \cftsubsecpagefont } { }
  { \__pku_inter_tnum: }

\cftsetindents { subsubsection } { 0.78cm } { 1.5em }
\RenewDocumentCommand { \cftsubsubsecfont } { }
  { \__pku_inter_tnum: }
\RenewDocumentCommand { \cftsubsubsecaftersnumb } { }
  { \rmfamily }
\RenewDocumentCommand { \cftsubsubsecpagefont } { }
  { \__pku_inter_tnum: }

\DefineFNsymbols* { pkuthesis-circles } {
    { \SourceHanSerif ① } { \SourceHanSerif ② }
    { \SourceHanSerif ③ } { \SourceHanSerif ④ }
    { \SourceHanSerif ⑤ } { \SourceHanSerif ⑥ }
    { \SourceHanSerif ⑦ } { \SourceHanSerif ⑧ }
    { \SourceHanSerif ⑨ }
}
\setfnsymbol { pkuthesis-circles }

\NewTblrEnviron { hqtblr }
\SetTblrInner [ hqtblr ] {
    hline { 1, Z } = { dash = solid, wd = 2.25bp },
    hline { 2 }    = { dash = solid, wd = 0.5bp },
    rows           = { font = \small, rowsep=1.25pt },
    row { 1 }      = { font = \small \sffamily \bfseries },
}

\AddToHook { begindocument / end }
{
    \pagestyle { empty }
    \begin { center }
        % \__pku_vspace:n { 0pt }
        \includegraphics [ width = 8.39cm ] { PKU-Logo.pdf }
        \par
        \skip_vertical:n { -5.839mm }
        \zihao { -0 } \textsf { 本科生毕业论文 }
    \end { center }

    \skip_vertical:n { 78.887mm }

    \noindent
    \skip_horizontal:n { 1.75cm }
    \begin { tblr }
    {
        colspec =
        {
            Q [ halign = c, valign = b, wd = 3.19cm,
                font = \zihao { 3 } \sffamily ]
            Q [ halign = c, valign = b, wd = 8.3cm,
                font = \zihao { 3 } \FangSong ]
        },
        rows                   = { ht = 1.1cm, rowsep = 0pt },
        columns                = { colsep = 0pt },
        hline {2, 3, 4, 5, 6 } = { 2 } { 2 } { dash = solid, wd = 0.5bp },
    }
        姓 \__ccwd_space:n { 2 } 名： &
          \__pku_author:      \\

        学 \__ccwd_space:n { 2 } 号： &
          \FangSongEn
          \__pku_student_id:  \\

        院 \__ccwd_space:n { 2 } 系： &
          \__pku_school:      \\

        专 \__ccwd_space:n { 2 } 业： &
          \__pku_major:       \\

        导师姓名： & \__pku_mentor:
    \end { tblr }

    \skip_vertical:n { 32.158mm }

    \begin { center }
        \zihao{ 3 } 二〇二五 \textsf { 年五月 }
    \end { center }

    \skip_vertical:n { -176.595mm }

    \noindent
    \skip_horizontal:n { 1.25cm }
    \begin { tblr }
    {
        colspec =
        {
            Q [ halign = c, valign = b, wd = 2.75cm,
                font = \zihao { 2 } ]
            Q [ halign = c, valign = b, wd = 10.16cm,
                font = \zihao { 1 } \sffamily \bfseries ]
        },
        rows            = { ht = 1.08cm, rowsep = 2mm },
        columns         = { colsep = 0pt },
        hline { 2 , 3 } = { 2 } { 2 } { dash = solid, wd = 0.75bp },
    }
        题目：& \__pku_title_cn_format:
               \__pku_title_cn: \\

             & \__pku_title_en_format:
               \__pku_title_en: \\
    \end { tblr }
    \clearpage
    \newgeometry { left = 2.6cm, right = 2.6cm, top = 3cm,
                   bottom = 2.5cm, bindingoffset = 0cm }
    \begin { center }
        { \zihao{ 3 } 北京大学本科毕业论文导师评阅表 }
        \skip_vertical:n { 10.535mm }

        \begin { tblr }
        {
            % width = \textwidth
            hline { 1, 2, 3, 4, 5, 6, 8 } = { solid },
            vlines,
            hspan   = minimal,
            rows    = { rowsep = 0.5mm },
            columns = { colsep = 1.5mm },
            colspec =
            {
                Q [ halign = c, wd = 1.80cm ]
                Q [ halign = c, wd = 2.13cm ]
                Q [ halign = c, wd = 2.03cm ]
                Q [ halign = c, wd = 3.47cm ]
                Q [ halign = c, wd = 2.00cm ]
                Q [ halign = c, wd = 2.27cm ]
            },
            rowspec =
            {
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
            学生姓名 & \__pku_author: &
            本科院系 & \__pku_school: &
            论文成绩（等级制）& \__pku_grade: \\

            学生学号 & \__pku_student_id: & 本科专业 & \__pku_major: & & \\

            导师姓名 & \__pku_mentor_in_table: &
            { 导师单位 / \\ 所在学院 } & \__pku_mentor_workplace: &
            导师职称 & \__pku_mentor_academic_title: \\

            论文题目 & 中文 & \__pku_title_cn: & & & \\
                    & 英文 & \__pku_title_en: & & & \\
            {
                \setlength { \parindent } { 2 \ccwd }
                \centerline { 导师评语 }
                \par
                \KaiTi
                \centerline
                {
                    （包含对论文的性质、难度、分量、综合训练等是否
                    符合培养目标的目的等评价）
                }
                \par
                \__pku_mentor_comments:
            } & & & & & \\
            {
                \__ccwd_space:n { 20.5 }
                导师签名：
                \par \  \par
                \__ccwd_space:n { 24.5 }
                年
                \__ccwd_space:n { 3 }
                月
                \__ccwd_space:n { 3 }
                日
            } & & & & & \\
        \end { tblr }
    \end { center }
    \clearpage
    \skip_vertical:n { 7.622mm }
    \begin{center}
        \zihao{ 3 } \textsf { 版权声明 }
    \end{center}
    \skip_vertical:n { 14.522mm }
    \noindent
    \begin { minipage } [ t ] { \textwidth }
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
    { \bfseries \__pku_abstract_cn: }
    \par \  \par
    关键词：\__pku_keywords_cn:
    \clearpage
    \setcounter { page } { 1 }
    \centerline { \zihao { 3 } \textsf { \textbf { ABSTRACT } } }
    \par \  \par
    \__pku_abstract_en:
    \par \  \par
    KEY~WORDS:~\__pku_keywords_en:
    \clearpage
    \setcounter { page } { 1 }
    \skip_vertical:n { 18.01bp }
    \tableofcontents
    \clearpage
    \pagestyle { fancy }
    \setcounter { page } { 1 }
}

\AddToHook { enddocument }
{
    \newgeometry
    {
        left          = 2.5cm,
        right         = 2.0cm,
        top           = 2.5cm,
        bottom        = 2.5cm,
        bindingoffset = 0.0cm,
    }
    \section* { \centerline{ 北京大学学位论文原创性声明和使用授权说明 } }
    \addcontentsline { toc } { section }
      { 北京大学学位论文原创性声明和使用授权说明 }
    \pagestyle { empty }
    \skip_vertical:n { 2.359mm }
    \centerline { \zihao { 4 } \textbf { 原创性声明 } }
    \skip_vertical:n { 7.572mm }
    本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作
    所取得的成果。除文中已经注明引用的内容外，本论文不含任何其他个人或集体
    已经发表或撰写过的作品或成果。对本文的研究做出重要贡献的个人和集体，均
    已在文中以明确方式标明。本声明的法律结果由本人承担。
    \skip_vertical:n { 17.497mm }
    \begin { flushright }
        论文作者签名：
        \__ccwd_space:n { 8.5 }
        \par
        \skip_vertical:n { 1.538mm }
        日期：
        \__ccwd_space:n { 2 }
        年
        \__ccwd_space:n { 1.5 }
        月
        \__ccwd_space:n { 2 }
        日
        \par
    \end { flushright }
    \skip_vertical:n { 51.83mm }
    \centerline { \zihao{ 4 } \textbf{ 学位论文使用授权说明 } }
    \skip_vertical:n { 10.817mm }
    \par
    本人完全了解北京大学关于收集、保存、使用学位论文的规定，即：
    \begin { itemize }
        \item 按照学校要求提交学位论文的印刷本和电子版本；
        \item 学校有权保存学位论文的印刷本和电子版，并提供目录检索与阅览服务，
        在校园网上提供服务；
        \item 学校可以采用影印、缩印、数字化或其它复制手段保存论文；
    \end { itemize }
    \skip_vertical:n { 14.694mm }
    \begin { flushright }
        论文作者签名：
        \__ccwd_space:n { 5 }
        导师签名：
        \__ccwd_space:n { 5 }
        \par
        \skip_vertical:n { 3.042mm }
        日期：
        \__ccwd_space:n { 1.5 }
        年
        \__ccwd_space:n { 1.5 }
        月
        \__ccwd_space:n { 1.5 }
        日
        \__ccwd_space:n { 6.5 }
        \par
    \end { flushright }
}

\AddToHook { package / biblatex / after }
{
    \defbibheading { bibliography } [ \refname ]
    {
        \section* {#1}
        \addcontentsline { toc } { section } {#1}
        \skip_vertical:n { 16.5bp }
    }
}

\AddToHook { package / markdown / after }
{
    \markdownSetup
    {
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
    \hypersetup
    {
        pdftitle    = { \__pku_title_cn: },
        pdfauthor   = { \__pku_author: },
        pdfkeywords = { \__pku_keywords_cn: },
        pdfcreator  = { LaTeX~with~pkuthesis~class },
    }
}

\cs_new_eq:NN \__pku_appendix: \appendix

\RenewDocumentCommand { \appendix } { }
{
    \__pku_appendix:
    \ctexset
    {
        subsection =
        {
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
    \cs_new:Npn \__pku_mentor: {#2}
    \cs_new:Npn \__pku_mentor_workplace: {#3}
    \cs_new:Npn \__pku_mentor_academic_title: {#4}
    \IfNoValueTF {#1}
      { \cs_new:Npn \__pku_mentor_in_table: {#2} }
      { \cs_new:Npn \__pku_mentor_in_table: {#1} }
}

\cs_new:Npn \__pku_title_cn_format: { }
\cs_new:Npn \__pku_title_en_format: { }

\RenewDocumentCommand { \author } { m }
  { \cs_new:Npn \__pku_author: {#1} }
\NewDocumentCommand { \titleCn } { m }
  { \cs_new:Npn \__pku_title_cn: {#1} }
\NewDocumentCommand { \titleEn } { m }
  { \cs_new:Npn \__pku_title_en: {#1} }
\NewDocumentCommand { \abstractCn } { +m }
  { \cs_new:Npn \__pku_abstract_cn: {#1} }
\NewDocumentCommand { \abstractEn } { +m }
  { \cs_new:Npn \__pku_abstract_en: {#1} }
\NewDocumentCommand { \keywordsCn } { m }
  { \cs_new:Npn \__pku_keywords_cn: {#1} }
\NewDocumentCommand { \keywordsEn } { m }
  { \cs_new:Npn \__pku_keywords_en: {#1} }
\NewDocumentCommand { \studentID } { m }
  { \cs_new:Npn \__pku_student_id: {#1} }
\NewDocumentCommand { \school } { m }
  { \cs_new:Npn \__pku_school: {#1} }
\NewDocumentCommand { \major } { m }
  { \cs_new:Npn \__pku_major: {#1} }
\NewDocumentCommand { \grade } { m }
  { \cs_new:Npn \__pku_grade: {#1} }
\NewDocumentCommand { \mentorComments } { +m }
  { \cs_new:Npn \__pku_mentor_comments: {#1} }
\NewDocumentCommand { \titleCnFormat } { m }
  { \cs_set:Npn \__pku_title_cn_format: {#1} }
\NewDocumentCommand { \titleEnFormat } { m }
  { \cs_set:Npn \__pku_title_en_format: {#1} }
