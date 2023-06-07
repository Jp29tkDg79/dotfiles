#! bin/zsh

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt NO_CASE_GLOB
setopt CORRECT
setopt CORRECT_ALL
setopt SHARE_HISTORY # Share history with other shells
setopt HIST_IGNORE_ALL_DUPS # Do not keep same command history is history
setopt HIST_IGNORE_SPACE # If you put a space at the beginning, set it so that it does not remain in the command history
setopt HIST_REDUCE_BLANKS # Remove extra spaces and register in command history
setopt HIST_SAVE_NO_DUPS # Duplicate command remove old commands
setopt INC_APPEND_HISTORY # Add history incrementally
setopt EXTENDED_HISTORY # Show timestamp when executing history command
setopt NO_BEEP
setopt RM_STAR_SILENT # remove confirmation on rm command
setopt nonomatch
setopt prompt_subst  # Executes variable expansion, command substitution, and arithmetic operations
setopt transient_rprompt  # Hide the right prompt after executing the command
setopt hist_no_store
setopt hist_verify
setopt auto_cd  # Make it possible to move by directory name only
setopt auto_list  # List display when there are multiple completion candidates
setopt auto_menu  # Automatically list when there are multiple completion candidates
setopt list_packed # Display completion candidates

setopt list_types # File type identification mark display in completion candidate list
setopt print_eight_bit # Enable display of Japanese file names

setopt rec_exact
setopt autoremoveslash

setopt complete_in_word  # complete at cursor position

setopt glob
setopt glob_complete  # complete from list of candidates without expanding glob
setopt extended_glob  # enable extended glob
setopt mark_dirs   # When generating a path with glob, add "/" at the end if the path is a directory
setopt numeric_glob_sort  # Sort numerically instead of lexicographically
setopt magic_equal_subst  # Completion even after --prefix=/usr or = in the command line argument
setopt always_last_prompt  # avoid wasted scrolling

