"Vim plugin to formally complete shell variable.
"Additionally, complete double quatation for a word.
"
"Author : nishidyatutokyo@gmail.com

augroup myvimrc
	autocmd!
augroup END

autocmd myvimrc FileType sh noremap <silent> { :call Bash_comp('{')<CR>
autocmd myvimrc FileType sh noremap <silent> } :call Bash_comp('}')<CR>
autocmd myvimrc FileType * noremap <silent> " :call Bash_comp('"')<CR>

function! Bash_comp(c)

	if getline('.')[col('.')-1]==''
		exe "normal! ".a:c
		return
	endif

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

	if a:c=='"'
		exe "normal! i".a:c
	else
		exe "normal! i${"
	endif

	call cursor(line('.'),col('.')+1)

	let c=col('.')

	normal! f 

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

	else
		if a:c=='"'
			normal! i"
		else
			normal! i}
		endif

	endif

endfunction

