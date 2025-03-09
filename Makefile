#                __
#               / _)
#      _.----._/ /	dc0x13
#     /         /	part of `morse` project.
#  __/ (  | (  |	Mar 09 2025
# /__.-'|_|--|_|
objs = main.o helps.o
flags =
cc = gcc
exe = mrs

all: $(exe)

$(exe): $(objs)
	ld	-o $(exe) $(objs)
%.o: %.s
	as	-o $@ $< $(flags)
clean:
	rm	-rf $(objs) $(exe)
