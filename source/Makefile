#  _____                 
# |     |___ ___ ___ ___ 
# | | | | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
                       
objs = main.o args.o fatal.o t.o common.o data.o trie.o m.o fp86.o
name = morse

all: $(name)

$(name): $(objs)
	ld	-o $(name) $(objs)
%.o: %.asm
	as	-o $@ $<
clean:
	rm	-rf $(objs) $(name)
