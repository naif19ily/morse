objs = main.o data.o morse.o text.o
flag =
assb = as
name = morse

all: $(name)

$(name): $(objs)
	ld	-o $(name) $(objs)
%.o: %.s
	as	$< -o $@
clean:
	rm	-f $(objs) $(name)
