"Vim plugin to formally complete shell variable.
"Additionally, complete double quatation for a word.
"
"Author : nishidyatutokyo@gmail.com

augroup myvimrc
	autocmd!
augroup END

autocmd myvimrc FileType sh noremap <silent> { :call Bash_comp('{')<CR>
autocmd myvimrc FileType sh noremap <silent> } :call Bash_comp('}')<CR>
autocmd myvimrc FileType sh noremap <silent> " :call Bash_comp('"')<CR>

function! Bash_comp(c)

	" Run default command at empty line
	if getline('.')[col('.')-1]==''
		exe "normal! ".a:c
		return
	endif

	" Put cursor at the first char of current word
	if col('.')>1
		if getline('.')[col('.')-2]!=' '
			let c=col('.')
			normal! F 
			if c==col('.')
				normal! b
			else
				call cursor(line('.'),col('.')+1)
			endif
		endif
	endif

	" Put leftside mark
	if a:c=='"'
		exe "normal! i".a:c
	else
		" Do not put another '$' if already there
		if getline('.')[col('.')-1] == '$'
			exe "normal! i{"
		else
			exe "normal! i${"
		endif
	endif

	call cursor(line('.'),col('.')+1)

	let c=col('.')

	" Go after current word
	normal! f 

	" When there is no space after current word
	if c==col('.')

		if a:c=='"'
			normal! $a"
		else
			normal! f.
			if c==col('.')
				normal! $a}
			else
				normal! i}
			endif
		endif

	" When there is a space after current word
	else
		if getline('.')[col('.')-1] ~= \W
			call cursor(line('.'),col('.')-1)
		endif
		if a:c=='"'
			normal! i"
		else
			normal! i}
		endif

	endif

endfunction

