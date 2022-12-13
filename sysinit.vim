"vim ~/.vimrc"

"Ubuntu的设置"
"set guifont=Ubuntu\ Mono\ Regular\ 25
"color evening

"Windows方案"
"color evening
set guifont=Consolas:h18:cANSI
"color molokai

"自动对齐"
set ai
"字体高亮"
syntax on
"显示行号"
set number
"自动缩进"
set autoindent
"c语言格式缩进"
autocmd FileType c,cpp,java :set cindent
autocmd FileType c,cpp,java :set smartindent
"回车和删除有效"
set backspace=2
"设置tab为4个空格"
set tabstop=4
set shiftwidth=4
set softtabstop=4
"关闭提示音"
set vb t_vb=
au GuiEnter * set t_vb=

"插入模式的映射"
:inoremap df <ESC>
:inoremap aa <ESC>la
:inoremap ( ()<ESC>i
:inoremap [ []<ESC>i
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
:inoremap {<CR> {<CR>}<ESC>O

"可视模式的映射"
:xnoremap H 0
:xnoremap L $
:xnoremap <Space> 10
:xnoremap ( xi()<Esc>P
:xnoremap { xi{}<Esc>P
:xnoremap [ xi[]<Esc>P
:xnoremap / I//<Esc>

"正常模式的映射"
:nnoremap H 0
:nnoremap L $
:nnoremap <Space> 10
:nnoremap <C-a> ggVG"+y


" Windows f11 一键编译运行 
"map <F11> :call CompileRunGcc()<CR>
"func! CompileRunGcc()
"    exec "w"
"	if &filetype == 'c'
"        exec "!gcc -fexec-charset=GBK % -o %<.exe -g"
"        exec "!%<.exe"
"	elseif &filetype == 'cpp'
"        exec "!g++ -fexec-charset=GBK % -o %<.exe -g"
"        exec "!%<.exe"
"	elseif &filetype == 'java'
"        exec "!javac % -encoding utf-8"
"        exec "!java %< -encoding utf-8"	
"	elseif &filetype == 'python'
"        exec "!python %"
"	endif
"endfunc

"Linux 编译运行
"map <F> :call Run()<CR>
"func! Run()
"    exec "w"
"    exec "!g++ -Wall % -o %<"
"    exec "!./%<"
"endfunc

"在特定的文件中使用"
"autocmd FileType c
"autocmd FileType cpp
"autocmd FileType python

" 将BackSpace键映射为RemovePairs函数
:inoremap <BS> <c-r>=RemovePairs()<CR>
" 按BackSpace键时判断当前字符和前一字符是否为括号对或一对引号，如果是则两者均删除，并保留BackSpace正常功能
func! RemovePairs()
	let l:line = getline(".") " 取得当前行
	let l:current_char = l:line[col(".")-1] " 取得当前光标字符
	let l:previous_char = l:line[col(".")-2] " 取得光标前一个字符 

	if (l:previous_char == '"' || l:previous_char == "'") && l:previous_char == l:current_char
		return "\<delete>\<bs>"
	elseif index(["(", "[", "{"], l:previous_char) != -1
		" 将光标定位到前括号上并取得它的索引值
		execute "normal! h" 
		let l:front_col = col(".")
		" 将光标定位到后括号上并取得它的行和索引值
		execute "normal! %" 
		let l:line1 = getline(".")
		let l:back_col = col(".")
		" 将光标重新定位到前括号上
		execute "normal! %"
		" 当行相同且后括号的索引比前括号大1则匹配成功
		if l:line1 == l:line && l:back_col == l:front_col + 1
			return "\<right>\<delete>\<bs>"
		else
			return "\<right>\<bs>"
		end
	else
	  	return "\<bs>" 
	end
endfunc