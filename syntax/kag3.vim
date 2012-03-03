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
syntax match kag3TagName            "@\S\+"hs=s+1  contained

" Tag Attribute
syntax match kag3Attribute          "\s+\S+"hs=s+1 contained

" Tag Value
syntax match kag3AttrValue          /=[^'" \t][^ \t\]]*/hs=s+1 contained

" Boolean
syntax keyword kag3Boolean true false contained

" Define highlighting
if version >= 508 || !exists("did_kag3_syn_inits")
  if version < 508
    let did_kag3_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " Use HTML highlighting definition.
  HiLink kag3Comment Comment
  HiLink kag3String String
  HiLink kag3LabelName Label
  HiLink kag3LabelDescription Special
  HiLink kag3Tag Function
  HiLink kag3TagOneLine Identifier
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



