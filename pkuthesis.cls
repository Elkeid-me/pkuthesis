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
  {2025/06/09}{2.0.0-dev}{Thesis class for School of EECS, Peking University, 2025}

% `pkuthesis` 暂时只支持 XeTeX、LuaTeX 或 upLaTeX。
\msg_new:nnn { pkuthesis } { unsupported-engine }
  {
    The~ pkuthesis~ class~ requires~ XeTeX,~ LuaTeX~ or~ upLaTeX.~
    `#1'~ is~ not~ supported~ at~ present.
  }
\bool_if:nF
  { \sys_if_engine_xetex_p: || \sys_if_engine_luatex_p: || \sys_if_engine_uptex_p: }
  {
    \msg_fatal:nnx { pkuthesis } { unsupported-engine }
      { \c_sys_engine_str }
  }

% 与此同时，对 upLaTeX 的支持尚在测试中。
\msg_new:nnn { pkuthesis } { uplatex-support }
  {
    Support~ for~ upLaTeX~ is~ currently~ in~ testing.~ Functionality~ may~
    be~ incomplete~ and~ contain~ errors.~ Please~ prioritize~ XeTeX~ or~
    LuaTeX~ instead.
  }
\bool_if:nT
  { \sys_if_engine_uptex_p: }
  { \msg_warning:nn { pkuthesis } { uplatex-support } }

\bool_new:N \g__pku_centersec_bool
\bool_new:N \g__pku_draft_bool
\clist_new:N \g__pku_to_ctex_clist
\cs_new_protected:Npn \__ccwd_space:n #1 { \skip_horizontal:n { #1 \ccwd } }
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

% 为 `fontspec` 传入 `no-math` 选项。
\PassOptionsToPackage { no-math } { fontspec }

% 使用 XeTeX 时，打开 `xeCJK` 的 `CJKmath` 选项，使数学环境中可以直接输入
% CJK 字符，与使用 LuaTeX 时 `luatex-ja` 的行为一致。
\sys_if_engine_xetex:T
  { \PassOptionsToPackage { CJKmath } { xecjk } }

% 现在，加载 `ctexart` 文档类，字体配置为 `pkuthesis`，
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
            beforeskip = 5.64 bp,
            afterskip  = 5.64 bp,
            number     = \zhnum { section },
            break      = \clearpage,
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
            beforeskip = 5.64 bp,
            afterskip  = 5.64 bp,
            break      = \clearpage,
          }
      }
  }

% 设置其他级别标题的格式。为什么不设置 `\paragraph` 等级别的格式？
% 因为教务模板里没有。
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
        format     = \zihao { 3 } \rmfamily,
        beforeskip = 5.64 bp,
        afterskip  = 5.64 bp,
      },
    subsubsection =
      {
        format     = \zihao{ 4 } \rmfamily,
        indent     = 2 \ccwd,
        beforeskip = 5.64 bp,
        afterskip  = 5.64 bp,
      }
  }

% 加载 `fancyhdr` 宏包，设置页眉页脚格式。
\RequirePackage [ nocheck ] { fancyhdr }

% 加载 `footmisc` 宏包，设置脚注格式。
\RequirePackage [ perpage, symbol* ] { footmisc }

% 加载 `geometry` 宏包，设置页边距。
\RequirePackage
  [
    paperheight   = 297 mm,
    paperwidth    = 210 mm,
    inner         = 20 mm,
    outer         = 20 mm,
    bindingoffset = 5 mm,
    top           = 25 mm,
    bottom        = 25 mm,
    head          = 3.8 mm,
    headsep       = 12.02 mm,
    footskip      = 7.5 mm,
    twoside,
  ]
  { geometry }

% 其他的包。
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

\setlist
  {
    itemsep       = 0 pt,
    listparindent = 2 \ccwd,
  }

\DeclareCaptionFont { 11point }
  { \fontsize { 11 bp } { 14.4 bp } \selectfont }
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
  { 0 pt }
\RenewDocumentCommand { \cftaftertoctitleskip } { }
  { 0.755 bp }
\tocloftpagestyle { empty }

\cs_new_protected:Npn \__pku_inter_tnum:
  { \InterTNUM \fontsize { 11 bp } { 13.248 bp } \selectfont }

\RenewDocumentCommand { \cftdot } { }
  { \textmd { . } }
\RenewDocumentCommand { \cftdotsep } { }
  { 0.5 }
\RenewDocumentCommand { \cftparskip } { }
  { 3.44 bp }

\RenewDocumentCommand { \cftbeforesecskip } { }
  { 0 pt }
\RenewDocumentCommand { \cftsecdotsep } { }
  { \cftdotsep }
\RenewDocumentCommand { \cftsecfont } { }
  { \sffamily \__pku_inter_tnum: }
\RenewDocumentCommand { \cftsecpagefont } { }
  { \__pku_inter_tnum: }

\cftsetindents { subsection } { 3.9 mm } { 1.5 \ccwd }
\RenewDocumentCommand { \cftsubsecfont } { }
  { \__pku_inter_tnum: }
\RenewDocumentCommand { \cftsubsecaftersnumb } { }
  { \rmfamily }
\RenewDocumentCommand { \cftsubsecpagefont } { }
  { \__pku_inter_tnum: }

\cftsetindents { subsubsection } { 7.8 mm } { 1.5 \ccwd }
\RenewDocumentCommand { \cftsubsubsecfont } { }
  { \__pku_inter_tnum: }
\RenewDocumentCommand { \cftsubsubsecaftersnumb } { }
  { \rmfamily }
\RenewDocumentCommand { \cftsubsubsecpagefont } { }
  { \__pku_inter_tnum: }

\DefineFNsymbols* { pkuthesis-circles }
  {
    { \SourceHanSerif ① }
    { \SourceHanSerif ② }
    { \SourceHanSerif ③ }
    { \SourceHanSerif ④ }
    { \SourceHanSerif ⑤ }
    { \SourceHanSerif ⑥ }
    { \SourceHanSerif ⑦ }
    { \SourceHanSerif ⑧ }
    { \SourceHanSerif ⑨ }
  }
\setfnsymbol { pkuthesis-circles }

\NewTblrEnviron { hqtblr }
\SetTblrInner [ hqtblr ]
  {
    hline { 1, Z } = { dash = solid, wd = 2.25 bp },
    hline { 2 }    = { dash = solid, wd = 0.5 bp },
    rows           = { font = \small, rowsep=1.25 pt },
    row { 1 }      = { font = \small \sffamily \bfseries },
  }

\AddToHook { begindocument / end }
  {
    \pagestyle { empty }
    \begin { center }
        % \__pku_vspace:n { 0pt }
        \includegraphics [ width = 83.9 mm ] { PKU-Logo.pdf }
        \par
        % \skip_vertical:n { -58.39 mm }
        \zihao { -0 } \textsf { 本科生毕业论文 }
    \end { center }

    \skip_vertical:n { 78.887 mm }

    \noindent
    \skip_horizontal:n { 175.cm }
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

    \skip_vertical:n { 32.158 mm }

    \begin { center }
        \zihao{ 3 } 二〇二五 \textsf { 年五月 }
    \end { center }

    \skip_vertical:n { -176.595 mm }

    \noindent
    \skip_horizontal:n { 12.5 cm }
    \begin { tblr }
      {
        colspec =
          {
            Q [ halign = c, valign = b, wd = 27.5 mm,
                font = \zihao { 2 } ]
            Q [ halign = c, valign = b, wd = 101.6 mm,
                font = \zihao { 1 } \sffamily \bfseries ]
          },
        rows            = { ht = 10.8 mm, rowsep = 2 mm },
        columns         = { colsep = 0pt },
        hline { 2 , 3 } = { 2 } { 2 } { dash = solid, wd = 0.75bp },
      }
        题目：& \__pku_title_cn_format:
               \__pku_title_cn: \\

             & \__pku_title_en_format:
               \__pku_title_en: \\
    \end { tblr }
    \clearpage
    \newgeometry
      {
        left          = 26 mm,
        right         = 26 mm,
        top           = 30 mm,
        bottom        = 25 mm,
        bindingoffset =  0 mm,
      }
    \begin { center }
        { \zihao{ 3 } 北京大学本科毕业论文导师评阅表 }
        \skip_vertical:n { 10.535 mm }

        \begin { tblr }
          {
            hline { 1, 2, 3, 4, 5, 6, 8 } = { solid },
            vlines,
            hspan   = minimal,
            rows    = { rowsep = 0.5 mm },
            columns = { colsep = 1.5 mm },
            colspec =
              {
                Q [ halign = c, wd = 18.0 mm ]
                Q [ halign = c, wd = 21.3 mm ]
                Q [ halign = c, wd = 21.3 mm ]
                Q [ halign = c, wd = 34.7 mm ]
                Q [ halign = c, wd = 20.0 mm ]
                Q [ halign = c, wd = 22.7 mm ]
              },
            rowspec =
              {
                Q [ valign = m,             ht = 7.2 mm ]
                Q [ valign = m,             ht = 7.2 mm ]
                Q [ halign = c, valign = m, ht =  10 mm ]
                Q [ valign = m,             ht = 7.2 mm ]
                Q [ valign = m,             ht = 7.2 mm ]
                Q [                         ht = 145 mm ]
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
    \skip_vertical:n { 7.622 mm }
    \begin{center}
        \zihao{ 3 } \textsf { 版权声明 }
    \end{center}
    \skip_vertical:n { 14.522 mm }
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
        left          = 25 mm,
        right         = 20 mm,
        top           = 25 mm,
        bottom        = 25 mm,
        bindingoffset =  0 mm,
      }
    \section* { \centerline{ 北京大学学位论文原创性声明和使用授权说明 } }
    \addcontentsline { toc } { section }
      { 北京大学学位论文原创性声明和使用授权说明 }
    \pagestyle { empty }
    \skip_vertical:n { 2.359 mm }
    \begin{center}
        \zihao { 4 } \textbf { 原创性声明 }
    \end{center}
    \skip_vertical:n { 7.572 mm }
    本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作
    所取得的成果。除文中已经注明引用的内容外，本论文不含任何其他个人或集体
    已经发表或撰写过的作品或成果。对本文的研究做出重要贡献的个人和集体，均
    已在文中以明确方式标明。本声明的法律结果由本人承担。
    \skip_vertical:n { 17.497mm }
    \begin { flushright }
        论文作者签名：
        \__ccwd_space:n { 8.5 }
        \par
        \skip_vertical:n { 1.538 mm }
        日期：
        \__ccwd_space:n { 2 }
        年
        \__ccwd_space:n { 1.5 }
        月
        \__ccwd_space:n { 2 }
        日
        \par
    \end { flushright }
    \skip_vertical:n { 51.83 mm }
    \begin{center}
        \zihao{ 4 } \textbf{ 学位论文使用授权说明 }
    \end{center}
    \skip_vertical:n { 10.817 mm }
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
\RenewDocumentCommand { \title } { s m }
  {
    \IfBooleanTF {#1}
      { \cs_new:Npn \__pku_title_en: {#2} }
      { \cs_new:Npn \__pku_title_cn: {#2} }
  }
\RenewDocumentCommand { \abstract } { s +m }
  {
    \IfBooleanTF {#1}
      { \cs_new:Npn \__pku_abstract_en: {#2} }
      { \cs_new:Npn \__pku_abstract_cn: {#2} }
  }
\NewDocumentCommand { \keywords } { s m }
  {
    \IfBooleanTF {#1}
      { \cs_new:Npn \__pku_keywords_cn: {#2} }
      { \cs_new:Npn \__pku_keywords_en: {#2} }
  }
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
\NewDocumentCommand { \titleFormat } { s m }
  {
    \IfBooleanTF {#1}
      { \cs_set:Npn \__pku_title_en_format: {#2} }
      { \cs_set:Npn \__pku_title_cn_format: {#2} }
  }
