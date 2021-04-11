PUB211     ?= /usr/local
DESTDIR    ?= $(PUB211)
DESTBIN    ?= $(DESTDIR)/bin

CC         ?= cc
CPPFLAGS    =
CFLAGS      = -O2 -pedantic -Wall
LDFLAGS     =

EXE         = ubgrepv
SRC         = ubgrepv.c
OBJ         = $(SRC:.c=.o)

all: $(EXE)
.PHONY: all

install: $(EXE)
	$(SUDO) install -dm 755 $(DESTBIN)
	$(SUDO) install -m 755 $(EXE) $(DESTBIN)

$(EXE): $(OBJ)
	$(CC) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) -o $@ -c $< $(CPPFLAGS) $(CFLAGS)

clean:
	$(RM) $(EXE) $(OBJ)
.PHONY: clean

