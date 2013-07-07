if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syn region puppetDefine	start="^\s*\(class\|define\|site\|node\)" end="{" contains=puppetDefType,puppetDefName,pupppetDefArguments
syn keyword puppetDefType class define site node inherits contained
syn keyword puppetInherits inherits contained
syn region puppetDefArguments start="(" end=")" contains=puppetArgument
syn match puppetArgument "\w\+" contained
syn match puppetDefName "\w\+" contained

syn match puppetInstance "\w\+\s*{" contains=puppetTypeBrace,puppetTypeName,puppetTypeDefault
syn match puppetTypeBrace "{" contained
syn match puppetTypeName "[a-z]\w*" contained
syn match puppetTypeDefault "[A-Z]\w*" contained

syn match puppetParam "\w\+\s*=>" contains=puppetTypeRArrow,puppetTypeParamName
syn match puppetTypeRArrow "=>" contained
syn match puppetTypeParamName "\w\+" contained
syn match puppetVariable "$\w\+"
syn match puppetVariable "${\w\+}"
syn match puppetParen "("
syn match puppetParen ")"
syn match puppetParen "{"
syn match puppetParen "}"

syn region PuppetString start=+"+ skip=+"\\\\\|\\"+ end=+"+ contains=puppetVariable

syn keyword puppetBoolean true false
syn keyword puppetKeyword import inherits include
syn keyword puppetControl case default

syn match puppetComment "\s*#.*$" contains=puppetTodo
syn keyword puppetTodo TODO NOTE FIXME XXX BUGBUG contained

command -nargs=+ HiLink hi def link <args>

HiLink puppetVariable Identifier
HiLink puppetBoolean Boolean
HiLink puppetType Identifier
HiLink puppetDefault Identifier
HiLink puppetKeyword	Define
HiLink puppetTypeDefs	Define
HiLink puppetComment	Comment
HiLink puppetString	String
HiLink puppetTodo	Todo
" HiLink puppetBrace	Delimiter
" HiLink puppetTypeBrace	Delimiter
" HiLink puppetParen	Delimiter
HiLink puppetDelimiter	Delimiter
HiLink puppetControl	Statement
HiLink puppetDefType	Define
HiLink puppetDefName	Type
HiLink puppetTypeName	Statement
HiLink puppetTypeDefault	Type
HiLink puppetParamName	Identifier
HiLink puppetArgument	Identifier

delcommand HiLink

let b:current_syntax = "puppet"

