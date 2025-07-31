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
% This work consists of the file pkuthesis.cls,
%                                ctex-fontset-pkuthesis.def,
%                            and ctex-fontset-windows.def.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{pkuthesis}
  {2025/07/31}{2.0.0-preview-2}{Thesis class for School of EECS, Peking University, 2025}

\cs_new_protected:Npn \__pku_define_separator:nn #1#2#3
  { \tl_const:cn { c__pku_separator_ #1 _ #2 _tl } {#3} }

\cs_new:Npn \__pku_separator:nn #1#2
  { \tl_use:c { c__pku_separator_ \tl_use:c { g__pku_style_ #1 _separator_tl } _ #2 _tl } }

\__pku_define_separator:nn { comma     } { cn } { ， }
\__pku_define_separator:nn { comma     } { en } { ,~ }
\__pku_define_separator:nn { semicolon } { cn } { ； }
\__pku_define_separator:nn { semicolon } { en } { ;~ }

% `pkuthesis` 只支持 XeTeX 和 LuaTeX。
\msg_new:nnn { pkuthesis } { unsupported-engine }
  {
    The~ pkuthesis~ class~ requires~ XeTeX,~ or~ LuaTeX.~
    `#1'~ is~ not~ supported~ at~ present.
  }
\bool_lazy_any:nF
  {
    { \sys_if_engine_xetex_p:  }
    { \sys_if_engine_luatex_p: }
  }
  {
    \msg_fatal:nne { pkuthesis } { unsupported-engine }
      { \c_sys_engine_str }
  }

\clist_new:N \g__pku_to_ctex_clist
\tl_new:N    \g__pku_style_keywords_separator_tl
\cs_new_protected:Npn \__ccwd_space:n #1 { \hspace* { #1 \ccwd } }
\keys_define:nn { pkuthesis / options }
  {
    draft     .code:n            =
      { \clist_gput_right:Nn \g__pku_to_ctex_clist { draft } },
    draft     .value_forbidden:n = true,
    debug     .bool_gset:N       = \g__pku_debug_bool,
    centersec .bool_gset:N       = \g__pku_centersec_bool,
  }
\ProcessKeyOptions [ pkuthesis / options ]

% 为 `fontspec` 传入 `no-math` 选项。
\PassOptionsToPackage { no-math } { fontspec }

% 使用 XeTeX 时，打开 `xeCJK` 的 `CJKmath` 选项，使数学环境中可以直接输入
% CJK 字符，与使用 LuaTeX 时 `LuaTeX-ja` 的行为一致。
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
        format     = \zihao { 4 } \rmfamily,
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

% 处理 `debug` 开关。
\bool_if:NT \g__pku_debug_bool
  {
    \sys_if_engine_luatex:TF
      { \RequirePackage { lua-visual-debug } }
      { \geometry { showframe } }
  }

% 设置页眉页脚，这基于 `fancyhdr` 包。
\fancyhead [ L ] { }
\fancyhead [ C ] { \zihao { -5 } \g__pku_info_title_cn_tl }
\fancyhead [ R ] { }
\fancyfoot [ L ] { }
\fancyfoot [ C ] { \zihao { 5 } \textsf { 第 \thepage 页 } }
\fancyfoot [ R ] { }

% 设置列表格式，这基于 `enumitem` 包。
\setlist
  {
    itemsep       = 0 pt,
    listparindent = 2 \ccwd,
  }

% 设置图表 `\caption` 格式，这基于 `caption` 包。
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
    name      = \textrm { 表 },
  }
\counterwithin { table } { section }

% 设置目录格式，这基于 `tocloft` 包。
% 这个包的用户接口确实不好……
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
  { \__tnum_sans: \fontsize { 11 bp } { 13.248 bp } \selectfont }

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

% 设置脚注格式细节，这基于 `footmisc` 包。
\DefineFNsymbols* { pkuthesis-circles }
  {
    { \__circled_number: ① } { \__circled_number: ② }
    { \__circled_number: ③ } { \__circled_number: ④ }
    { \__circled_number: ⑤ } { \__circled_number: ⑥ }
    { \__circled_number: ⑦ } { \__circled_number: ⑧ }
    { \__circled_number: ⑨ } { \__circled_number: ⑩ }
    { \__circled_number: ⑪ } { \__circled_number: ⑫ }
    { \__circled_number: ⑬ } { \__circled_number: ⑭ }
    { \__circled_number: ⑮ } { \__circled_number: ⑯ }
    { \__circled_number: ⑰ } { \__circled_number: ⑱ }
    { \__circled_number: ⑲ } { \__circled_number: ⑳ }
    { \__circled_number: ㉑ } { \__circled_number: ㉒ }
    { \__circled_number: ㉓ } { \__circled_number: ㉔ }
    { \__circled_number: ㉕ } { \__circled_number: ㉖ }
    { \__circled_number: ㉗ } { \__circled_number: ㉘ }
    { \__circled_number: ㉙ } { \__circled_number: ㉚ }
    { \__circled_number: ㉛ } { \__circled_number: ㉜ }
    { \__circled_number: ㉝ } { \__circled_number: ㉞ }
    { \__circled_number: ㉟ } { \__circled_number: ㊱ }
    { \__circled_number: ㊲ } { \__circled_number: ㊳ }
    { \__circled_number: ㊴ } { \__circled_number: ㊵ }
    { \__circled_number: ㊶ } { \__circled_number: ㊷ }
    { \__circled_number: ㊸ } { \__circled_number: ㊹ }
    { \__circled_number: ㊺ } { \__circled_number: ㊻ }
    { \__circled_number: ㊼ } { \__circled_number: ㊽ }
    { \__circled_number: ㊾ } { \__circled_number: ㊿ }
  }
\setfnsymbol { pkuthesis-circles }

% 三线表 `hqtblr` 环境。基于 `tabularray` 包。
\NewTblrEnviron { hqtblr }
\SetTblrInner [ hqtblr ]
  {
    hline { 1, Z } = { dash = solid, wd = 2.25 bp },
    hline { 2 }    = { dash = solid, wd = 0.5 bp },
    rows           = { font = \small, rowsep = 1.25 pt },
    row { 1 }      = { font = \small \sffamily \bfseries },
  }

% `\begin{document}` 的钩子，使用 `hyperref` 设置 PDF 元数据。
\hook_gput_next_code:nn { begindocument / before }
  {
    \IfPackageLoadedTF { hyperref }
      {
        \tl_new:N \l__pdfkeywords_tl
        \tl_set:Ne \l__pdfkeywords_tl
          {
            \clist_use:Nn \g__pku_info_keywords_cn_clist
              { \__pku_separator:nn { keywords } { cn } }
          }
        \hypersetup
          {
            pdftitle    = \g__pku_info_title_cn_tl,
            pdfauthor   = \g__pku_info_author_tl,
            pdfkeywords = \l__pdfkeywords_tl,
            pdfcreator  = { LaTeX~ with~ pkuthesis~ class },
          }
      }
      {}
  }

% `\begin{document}` 钩子，处理封面、导师评价表、声明、摘要、关键词与目录。
\hook_gput_next_code:nn { begindocument / end }
  {
    \pagestyle { empty }
    \begin { center }
        \vspace* { -7.297 bp }
        \includegraphics [ width = 83.9 mm ] { PKU-Logo.pdf }
        \par
        \vspace* { -16.713 bp }
        \zihao { -0 } \textsf { 本科生毕业论文 }
    \end { center }
    \par
    \vspace* { 224.363 bp }
    \noindent
    \hspace* { 17.5 mm }
    \begin { tblr }
      {
        colspec =
          {
            Q [ halign = c, valign = b, wd = 31.9 mm,
                font = \zihao { 3 } \sffamily ]
            Q [ halign = c, valign = b, wd = 83 mm,
                font = \zihao { 3 } \FangSong ]
          },
        rows                   = { ht = 11 mm, rowsep = 0 pt },
        columns                = { colsep = 0 pt },
        hline {2, 3, 4, 5, 6 } = { 2 } { 2 } { dash = solid, wd = 0.5 bp },
      }
        姓 \__ccwd_space:n { 2 } 名： &
          \g__pku_info_author_tl      \\

        学 \__ccwd_space:n { 2 } 号： &
          \FangSongEn
          \g__pku_info_student_id_tl  \\

        院 \__ccwd_space:n { 2 } 系： &
          \g__pku_info_school_tl      \\

        专 \__ccwd_space:n { 2 } 业： &
          \g__pku_info_specialty_tl   \\

        导师姓名： & \clist_use:Nn \g__pku_info_mentor_name_clist { 、 }
    \end { tblr }

    \vspace* { 93.396 bp }

    \begin { center }
        \zihao { 3 }
        \zhdigits { \int_use:N \g__pku_info_year_int }
        \textsf { 年 \zhnumber { \int_use:N \g__pku_info_month_int } 月 }
    \end { center }

    \vspace* { -502.413 bp }

    \par
    \noindent
    \hspace* { 12.5 mm }
    \begin { tblr }
      {
        colspec =
          {
            Q [ halign = c, valign = f, wd = 27.5 mm,
                font = \zihao { 2 } ]
            Q [ halign = c, valign = f, wd = 101.6 mm,
                font = \zihao { 1 } \sffamily \bfseries ]
          },
        rows            = { ht = 12.5 mm, rowsep = 2 mm },
        columns         = { colsep = 0 pt },
        hline { 2 , 3 } = { 2 } { 2 } { dash = solid, wd = 0.75 bp },
      }
        题目：& {
                 \g__pku_style_title_format_cn_tl
                 \g__pku_info_title_cn_tl
               } \\
             & {
                 \g__pku_style_title_format_en_tl
                 \g__pku_info_title_en_tl
               } \\
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
        \vspace* { -10.002 bp }
        { \zihao{ 3 } 北京大学本科毕业论文导师评阅表 }
        \par
        \vspace* { 22.491 bp }
        \begin { tblr }
          {
            hline { 1, 2, 3, 4, 5, 6, 8 } = { solid },
            vlines,
            hspan   = minimal,
            rows    = { rowsep = 0.5 mm },
            columns = { colsep = 1.5 mm },
            colspec =
              {
                Q [ halign = c, wd = 18.16 mm ]
                Q [ halign = c, wd = 21.46 mm ]
                Q [ halign = c, wd = 21.46 mm ]
                Q [ halign = c, wd = 34.86 mm ]
                Q [ halign = c, wd = 20.16 mm ]
                Q [ halign = c, wd = 22.86 mm ]
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
            学生姓名 & \g__pku_info_author_tl &
            本科院系 & \g__pku_info_school_tl &
            论文成绩（等级制）& \g__pku_info_grade_tl \\

            学生学号 & \g__pku_info_student_id_tl &
            本科专业 & \g__pku_info_specialty_tl & & \\

            导师姓名 & \clist_use:Nn \g__pku_info_mentor_name_clist { \\ } &
            { 导师单位 / \\ 所在学院 } & \clist_use:Nn \g__pku_info_mentor_workplace_clist { \\ }&
            导师职称 & \clist_use:Nn \g__pku_info_mentor_academic_rank_clist { \\ } \\

            论文题目 & 中文 & \g__pku_info_title_cn_tl & & & \\
                    & 英文 & \g__pku_info_title_en_tl & & & \\
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
                \g__pku_info_mentor_comments_tl
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
    \vspace* { 1.747 bp }
    \begin{center}
        \zihao{ 3 } \textsf { 版权声明 }
    \end{center}
    \vspace* { 28.475 bp }
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
    { \bfseries \g__pku_info_abstract_cn_tl }
    \par \  \par
    关键词：
    \clist_use:Nn \g__pku_info_keywords_cn_clist
      { \__pku_separator:nn { keywords } { cn } }
    \clearpage
    \setcounter { page } { 1 }
    \centerline { \zihao { 3 } \textsf { \textbf { ABSTRACT } } }
    \par \  \par
    \g__pku_info_abstract_en_tl
    \par \  \par
    KEY~ WORDS:~
    \clist_use:Nn \g__pku_info_keywords_en_clist
      { \__pku_separator:nn { keywords } { en } }
    \clearpage
    \setcounter { page } { 1 }
    \vspace* { 18 bp }
    \tableofcontents
    \clearpage
    \pagestyle { fancy }
    \setcounter { page } { 1 }
  }

% `\end{document}` 钩子，处理声明。
\hook_gput_next_code:nn { enddocument }
  {
    \newgeometry
      {
        left          = 25 mm,
        right         = 20 mm,
        top           = 78.587 bp,
        bottom        = 25 mm,
        bindingoffset =  0 mm,
      }
    \section* { \centerline{ 北京大学学位论文原创性声明和使用授权说明 } }
    \addcontentsline { toc } { section }
      { 北京大学学位论文原创性声明和使用授权说明 }
    \pagestyle { empty }
    \vspace* { 1.961 bp }
    \begin{center}
        \zihao { 4 } \textbf { 原创性声明 }
    \end{center}
    \par
    \vspace* { 9.871 bp }
    本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作
    所取得的成果。除文中已经注明引用的内容外，本论文不含任何其他个人或集体
    已经发表或撰写过的作品或成果。对本文的研究做出重要贡献的个人和集体，均
    已在文中以明确方式标明。本声明的法律结果由本人承担。
    \vspace* { 52.347 bp }
    \begin { flushright }
        论文作者签名：
        \__ccwd_space:n { 8.5 }
        \par
        \vspace* { 4.244 bp }
        日期：
        \__ccwd_space:n { 2 }
        年
        \__ccwd_space:n { 1.5 }
        月
        \__ccwd_space:n { 2 }
        日
        \par
    \end { flushright }
    \vspace* { 75.581 bp }
    \begin{center}
        \zihao{ 4 } \textbf{ 学位论文使用授权说明 }
    \end{center}
    \vspace* { 17.652 bp }
    \par
    本人完全了解北京大学关于收集、保存、使用学位论文的规定，即：
    \begin { itemize }
        \item 按照学校要求提交学位论文的印刷本和电子版本；
        \item 学校有权保存学位论文的印刷本和电子版，并提供目录检索与阅览服务，
        在校园网上提供服务；
        \item 学校可以采用影印、缩印、数字化或其它复制手段保存论文；
    \end { itemize }
    \vspace* { 27.258 bp }
    \begin { flushright }
        论文作者签名：
        \__ccwd_space:n { 5 }
        导师签名：
        \__ccwd_space:n { 5 }
        \par
        \vspace* { 8.564 bp }
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

% `biblatex` 包的钩子，处理“参考文献”标题格式。
\hook_gput_next_code:nn { package / biblatex / after }
  {
    \defbibheading { bibliography } [ \refname ]
      {
        \section* {#1}
        \addcontentsline { toc } { section } {#1}
        \vspace* { 16.5 bp }
      }
  }

% `markdown` 包的钩子，提供实验性的 Markdown 支持。
\hook_gput_next_code:nn { package / markdown / after }
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

% 以下为用户接口部分。

% `\appendix` 命令的钩子，处理附录的标题格式。
\hook_gput_next_code:nn { cmd / appendix / after }
  {
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

% 致谢。
\NewDocumentCommand { \acknowledgments } { }
  {
    \section* { 致谢 }
    \addcontentsline { toc } { section } { 致谢 }
  }

\keys_define:nn { pkuthesis / info / mentor }
  {
    name          .clist_gset:N = \g__pku_info_mentor_name_clist,
    workplace     .clist_gset:N = \g__pku_info_mentor_workplace_clist,
    academic-rank .clist_gset:N = \g__pku_info_mentor_academic_rank_clist,
  }

\keys_define:nn { pkuthesis / info }
  {
    title      .tl_gset:N = \g__pku_info_title_cn_tl,
    title*     .tl_gset:N = \g__pku_info_title_en_tl,
    author     .tl_gset:N = \g__pku_info_author_tl,
    student-id .tl_gset:N = \g__pku_info_student_id_tl,
    school     .tl_gset:N = \g__pku_info_school_tl,
    specialty  .tl_gset:N = \g__pku_info_specialty_tl,
    mentor     .meta:nn   = { pkuthesis / info / mentor } {#1},

    year  .int_gset:N = \g__pku_info_year_int,
    month .int_gset:N = \g__pku_info_month_int,
    year  .initial:n  = { \int_use:N \c_sys_year_int },
    month .initial:n  = 5,

    abstract .tl_gset:N    = \g__pku_info_abstract_cn_tl,
    keywords .clist_gset:N = \g__pku_info_keywords_cn_clist,

    abstract* .tl_gset:N    = \g__pku_info_abstract_en_tl,
    keywords* .clist_gset:N = \g__pku_info_keywords_en_clist,

    grade           .tl_gset:N = \g__pku_info_grade_tl,
    mentor-comments .tl_gset:N = \g__pku_info_mentor_comments_tl,
  }

\keys_define:nn { pkuthesis / style }
  {
    title-format  .tl_gset:N = \g__pku_style_title_format_cn_tl,
    title-format* .tl_gset:N = \g__pku_style_title_format_en_tl,

    keywords-separator .choices:nn =
      { comma, semicolon }
      { \tl_gset_eq:NN \g__pku_style_keywords_separator_tl \l_keys_choice_tl },
    keywords-separator .initial:n  = { comma },
  }

\NewDocumentCommand { \ThesisInfo } { +m }
  { \keys_set:nn { pkuthesis / info } {#1} }
\NewDocumentCommand { \ThesisStyle } { +m }
  { \keys_set:nn { pkuthesis / style } {#1} }

