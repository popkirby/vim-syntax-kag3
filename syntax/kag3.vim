" Vim syntax file
" Language:     KAG3
" Maintainer:   popkirby <popkirby@gmail.com>
" Last Change:  2012 Mar 3
" Remark:       Include TJS syntax.
" Changes:      First submission.
"
" TODO:
"  - Add TJS syntax at [iscript] ~ [endscript].

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'kag3'
endif


syntax sync fromstart
syntax case match



" KAG3 comments
" starts when ';' appeared
syntax region kag3Comment           start=/^;/ end=/$/

" Strings
syntax region kag3String            start=/"/ skip=/\\"/ end=/"/ contained
syntax region kag3String            start=/'/ skip=/\\'/ end=/'/ contained

" Labels
syntax region kag3LabelName         start=/^\*/ end=/$/ keepend contains=kag3LabelDescription
syntax region kag3LabelDescription  start=/|/ end=/$/ contained

" Tags
syntax region kag3Tag               start=/\[/ end=/\]/ oneline contains=kag3TagName,kag3Attribute,kag3Boolean,kag3AttrValue,kag3String
syntax region kag3TagOneLine        start=/@/  end=/$/  keepend contains=kag3TagName,kag3Attribute,kag3Boolean,kag3AttrValue,kag3String

" Tag name
syntax match kag3TagName            "\[[^ \t\]]\+"hs=s+1 contained
syntax match kag3TagName            "^@\S\+"hs=s+1  contained

" Tag Attribute
syntax match kag3Attribute          "\s+\S+"hs=s+1 contained

" Tag Value
syntax match kag3AttrValue          /=[^'" \t][^ \t\]]*/hs=s+1 contained

" Boolean
syntax keyword kag3Boolean true false contained

" Include TJS2 syntax.
if globpath(&rtp, 'syntax/tjs2.vim') != ''
  syntax include @kag3Tjs2Top syntax/tjs2.vim
  syntax region kag3Tjs2Script         start="\[iscript\]"ms=s+9  end="\[endscript\]"me=s-1 keepend contains=@kag3Tjs2Top,kag3Tjs2ScriptTag
  syntax region kag3Tjs2Script         start="^@iscript"rs=s+8    end="^@endscript"me=s-1   keepend contains=@kag3Tjs2Top,kag3Tjs2ScriptTag
  syntax region kag3Tjs2ScriptTag      start="\[\(iscript\]\)\@=" end="\]" oneline contained        contains=kag3Tjs2ScriptTagName
  syntax region kag3Tjs2ScriptTag      start="@\(iscript\)\@="    end="$"  contained                contains=kag3Tjs2ScriptTagName
  syntax match  kag3Tjs2ScriptTagName  "iscript" contained
endif

" Define highlighting
if version >= 508 || !exists("did_kag3_syn_inits")
  if version < 508
    let did_kag3_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink kag3Comment Comment
  HiLink kag3String String
  HiLink kag3LabelName Label
  HiLink kag3LabelDescription Special
  HiLink kag3Tjs2ScriptTag kag3Tag
  HiLink kag3Tag Function
  HiLink kag3TagOneLine Identifier
  HiLink kag3Tjs2ScriptTagName Identifier
  HiLink kag3TagName Statement
  HiLink kag3Attribute Type
  HiLink kag3AttrValue String
  HiLink kag3Boolean Boolean

  delcommand HiLink
endif

let b:current_syntax = "kag3"
if main_syntax == 'kag3'
  unlet main_syntax
endif
