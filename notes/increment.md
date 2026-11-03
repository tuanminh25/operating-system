pre-increment vs post-increment

	if (++terminal_column == VGA_WIDTH) 

terminal_column increment will eval first then do the check 

	if (terminal_column++ == VGA_WIDTH) 
Check will do first then terminal_column increment later
