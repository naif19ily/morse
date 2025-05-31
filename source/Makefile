#  ____    __  _____  _____   ______  ______ 
# |    \  /  |/     \|     | |   ___||   ___|
# |     \/   ||     ||     \  `-.`-. |   ___|
# |__/\__/|__|\_____/|__|\__\|______||______|

objs = main.o data.o morse.o text.o
flag =
assb = as
name = morse

all: $(name)

$(name): $(objs)
	ld	-o $(name) $(objs)
%.o: %.asm
	as	$< -o $@
clean:
	rm	-f $(objs) $(name)
