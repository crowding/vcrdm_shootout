#The object of this makefile is to extract random dots regression test 
#data from the OSXDots routines.
#
#Peter Meilstrup

+Psychtoolbox/Screen.m: Psychtoolbox.DONE

#I need to link up the local package +Psychtoolbox with whatever
#Psychtoolbox you've already installed.
Psychtoolbox.DONE: link_psychtoolbox.m
	mkdir -p +Psychtoolbox
	./runmatlab link_psychtoolbox
	touch Psychtoolbox.DONE

regression_data.mat: Psychtoolbox.DONE
	touch regression_data.mat

clean:
	rm -rf +Psychtoolbox
	rm -f Psychtoolbox.DONE

all: regression_data.mat