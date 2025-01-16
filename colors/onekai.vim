set background=dark
highlight clear

if exists('syntax_on')
	syntax reset
endif

set t_Co=256
let g:colors_name = 'blep'

let s:AnsiColor = ['00', '5f', '87', 'af', 'd7', 'ff']
let s:AnsiGrey = ['00',
	\ '08', '12', '1c', '26', '30', '3a', '44', '4e',
	\ '58', '62', '6c', '76', '80', '8a', '94', '9e',
	\ 'a8', 'b2', 'bc', 'c6', 'd0', 'da', 'e4', 'ee']

function s:AnsiRGB(prefix, ccode)
	if a:ccode == v:null
		let [acode, hcode] = ['NONE', 'NONE']
	elseif type(a:ccode) == v:t_string
		let [acode, hcode] = [a:ccode, a:ccode]
	elseif type(a:ccode) == v:t_dict
		return s:AnsiRGB(a:prefix, a:ccode[a:prefix])
	elseif a:ccode > 0
		let [B, ccode] = [a:ccode % 10, a:ccode / 10]
		let [G, R] = [ccode % 10, ccode / 10]
		let acode = R * 36 + G * 6 + B + 16
		let hcode = '#'  . s:AnsiColor[R] . s:AnsiColor[G] . s:AnsiColor[B]
	elseif a:ccode == -25
		let acode = 231
		let hcode = '#ffffff'
	else
		let acode = 231 - a:ccode
		let hcode = s:AnsiGrey[-a:ccode]
		let hcode = '#' . hcode . hcode . hcode
	endif
	return [ 'cterm' . a:prefix . '=' . acode, 'gui' . a:prefix . '=' . hcode ]
endfunction

function s:Highlight(group, ...)
	" group, fg, bg, gui, guisp
	let cargs = a:000 + [v:null, v:null, v:null]
	let cmd = ['highlight!', a:group] + s:AnsiRGB('fg', cargs[0]) +
		\ s:AnsiRGB('bg', cargs[1]) + s:AnsiRGB('', cargs[2])
	execute join(cmd, ' ')
endfunction

let s:BlepWhite   = -21
let s:BlepGrey    = -16
let s:BlepBlue    = 335
let s:BlepGreen   = 353
let s:BlepCyan    = 255
let s:BlepRed     = 522
let s:BlepYellow  = 542
let s:BlepPink    = 535
let s:BlepGreyD   = -6
let s:BlepGreyDD  = -3
let s:BlepGreenD  = 012
let s:BlepRedD    = 210

call s:Highlight('Normal', s:BlepWhite, v:null, v:null)

call s:Highlight('Pmenu', v:null, s:BlepGreyD, v:null)
highlight! link ColorColumn  Pmenu
highlight! link CursorLine   Pmenu
" highlight! link CursorColumn Pmenu

call s:Highlight('CursorColumn ', v:null, s:BlepGreyDD, v:null)

call s:Highlight('PmenuSel', s:BlepYellow, s:BlepGreyD, 'bold')
highlight! link Highlight       PmenuSel
highlight! link CocSelectedText PmenuSel
highlight! link CocMenuSel      PmenuSel

call s:Highlight('Keyword', s:BlepRed, v:null, v:null)
highlight! link Conditional Keyword
highlight! link Define      Keyword
" highlight! link PreCondit   Keyword
" highlight! link Macro       Keyword
highlight! link Operator    Keyword
highlight! link Include     Keyword
highlight! link PreProc     Keyword
highlight! link Statement   Keyword
highlight! link Tag         Keyword
" highlight! link Repeat      Keyword
" highlight! link Debug       Keyword

call s:Highlight('Type', s:BlepCyan, v:null, v:null)
highlight! link Constant     Type
highlight! link Boolean      Type
highlight! link Number       Type
highlight! link Character    Type
highlight! link Float        Type
highlight! link SpecialChar  Type
highlight! link Directory    Type
highlight! link StorageClass Type
highlight! link Structure    Type
highlight! link Typedef      Type
" highlight! link Exception    Type

call s:Highlight('StatusLine',   s:BlepWhite, s:BlepGreyD, 'bold')
call s:Highlight('StatusLineNC', s:BlepWhite, s:BlepGreyD, v:null)

call s:Highlight('DiffText',   s:BlepWhite, s:BlepGreenD, 'bold')
call s:Highlight('DiffAdd',    s:BlepWhite, s:BlepRedD,   'bold')
highlight! link diffAdded DiffAdd
call s:Highlight('DiffDelete', 200,         v:null, v:null)
highlight! link diffRemoved DiffDelete

call s:Highlight('DiffChange',     v:null,      v:null,      v:null)
call s:Highlight('Underlined',     v:null,      v:null,      'underline')
call s:Highlight('Visual',         v:null,      s:BlepGreyD, v:null)
call s:Highlight('Cursor',         v:null,      s:BlepWhite, v:null)

call s:Highlight('Search',         s:BlepWhite, 012,         v:null)
call s:Highlight('IncSearch',      s:BlepGreen, v:null,      'inverse')

call s:Highlight('Error', s:BlepRed, v:null, 'undercurl')
highlight! link CocErrorSign        Error

call s:Highlight('ErrorMsg', s:BlepRed, v:null, v:null)
highlight! link CocErrorFloat       ErrorMsg
highlight! link CocDiagnosticsError ErrorMsg

call s:Highlight('Warning', s:BlepYellow, v:null, 'undercurl')
highlight! link CocWarningSign        Warning

call s:Highlight('WarningMsg', s:BlepYellow, v:null, v:null)
highlight! link CocWarningFloat       WarningMsg
highlight! link CocDiagnosticsWarning WarningMsg

call s:Highlight('Special',        s:BlepWhite, v:null,      v:null)
" highlight! link Delimiter Special

call s:Highlight('Title',          s:BlepWhite, v:null,      'bold')
call s:Highlight('LineNr',         s:BlepGrey,  v:null,      v:null)
call s:Highlight('CursorLineNr',   s:BlepWhite, s:BlepGreyD, v:null)
call s:Highlight('SignColumn',     v:null,      s:BlepGreyD, v:null)

call s:Highlight('Comment',        s:BlepGrey,  v:null,      v:null)
" highlight! link Ignore         Comment
highlight! link Conceal        Comment
highlight! link NonText        Comment
highlight! link SpecialComment Comment
highlight! link SpecialKey     Comment
highlight! link CocCodeLens    Comment

call s:Highlight('VertSplit',    s:BlepGrey,   s:BlepGreyD, v:null)
call s:Highlight('Folded',       s:BlepGrey,   s:BlepGreyD, v:null)

call s:Highlight('IndentBlanklineChar', s:BlepGreyD, v:null, v:null)

call s:Highlight('Identifier',   145,          v:null,      v:null)

call s:Highlight('Function',     s:BlepYellow, v:null,      v:null)
call s:Highlight('Label',        s:BlepYellow, v:null,      v:null)
call s:Highlight('String',       s:BlepYellow, v:null,      v:null)

call s:Highlight('Todo',         s:BlepRed,    v:null,      'inverse')
call s:Highlight('MatchParen',   s:BlepRed,    v:null,      'inverse')

