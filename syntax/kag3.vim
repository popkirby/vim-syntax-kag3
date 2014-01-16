" Vim syntax file
" Language:     KAG3
" Maintainer:   popkirby <popkirby@gmail.com>
" Last Change:  2012 Mar 12
" Remark:       Include TJS syntax.
" Changes:      Added folding at [iscript], [macro].
"
" TODO:

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

" Tags
syntax region kag3Tag               start=/\[/ end=/\]/ contains=kag3TagName,kag3Attribute
syntax region kag3Tag               start=/@/  end=/$/  contains=kag3TagName,kag3Attribute

" Attribute
syntax match  kag3Attribute         +\<[^ \t="'\]]\++ contained nextgroup=kag3AttrEqual,kag3Attribute skipwhite
syntax match  kag3AttrEqual         "="               contained nextgroup=@kag3AttrValue

" Tag name
syntax match  kag3TagName           +\(\[\|@\)\@1<=[^ \t="'\]]\++ contained

" Attribute Value
syntax region  kag3AttrString        start=/"/ skip=/\\"/ end=/"/ contained
syntax region  kag3AttrString        start=/'/ skip=/\\'/ end=/'/ contained
syntax match   kag3AttrNumber        "\d\+" contained
syntax keyword kag3AttrBoolean       true false contained

syntax cluster kag3AttrValue         contains=kag3AttrString,kag3AttrNumber,kag3AttrBoolean

" Labels
syntax region kag3Label             matchgroup=kag3LabelDescBar start=/^\*/ end=/$/ keepend contains=kag3LabelDescBar
syntax match  kag3LabelDescBar      "|"   contained

" Comment
syntax match  kag3Comment           ";.*"

" Include TJS2 syntax.
if globpath(&rtp, 'syntax/tjs2.vim') != ''
  syntax include @kag3TJS2Top syntax/tjs2.vim
  syntax region  kag3TJS2Script            start="^\[iscript\]"      end="^\[endscript\]" transparent keepend      contains=@kag3TJS2Top,kag3TJS2ScriptTag
  syntax region  kag3TJS2Script            start="^@iscript$"        end="^@endscript$"   transparent keepend      contains=@kag3TJS2Top,kag3TJS2ScriptTag
  syntax region  kag3TJS2ScriptTag         start="^\[\(iscript\|endscript\)\@=" end="\]"  contained contains=kag3TJS2ScriptTagName
  syntax region  kag3TJS2ScriptTag         start="^@\(iscript\|endscript\)\@="  end="$"   contained contains=kag3TJS2ScriptTagName
  syntax keyword kag3TJS2ScriptTagName     iscript endscript contained
endif

" Folding
let g:use_kag3_syntax_folding = get(g:, 'use_kag3_syntax_folding', 1)
if g:use_kag3_syntax_folding == 1
  syntax region kag3Tjs2ScriptFold1      start="\[iscript\]" end="\[endscript\]" transparent fold keepend
  syntax region kag3Tjs2ScriptFold2      start="^@iscript"   end="^@endscript"   transparent fold keepend
  syntax region kag3MacroFold1           start="\[macro"     end="\[endmacro\]"  transparent fold keepend
  syntax region kag3MacroFold2           start="^@macro"     end="^@endmacro"    transparent fold keepend
  set foldmethod=syntax
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

  HiLink kag3Tag Special
  
  HiLink kag3Attribute Type
  HiLink kag3AttrEqual Statement

  HiLink kag3TagName Statement

  HiLink kag3AttrString String
  HiLink kag3AttrBoolean Boolean
  HiLink kag3AttrNumber Number
  
  HiLink kag3Label Label
  HiLink kag3LabelDescBar Special

  HiLink kag3TJS2ScriptTag kag3Tag
  HiLink kag3TJS2ScriptTagName kag3TagName

  delcommand HiLink
endif

let b:current_syntax = "kag3"
if main_syntax == 'kag3'
  unlet main_syntax
endif

