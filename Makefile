#  _____ ___ ___ ___ ___ 
# |     | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
#
# Jun 11 2025
#

objs = main.o args.o fatal.o t.o common.o data.o trie.o m.o
name = morse

all: $(name)

$(name): $(objs)
	ld	-o $(name) $(objs)
%.o: %.asm
	as	-o $@ $<
clean:
	rm	-rf $(objs) $(name)
