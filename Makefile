CC=gdc
CFLAGS=-c -Wall -O3

all: playfair
playfair: core.o locale.o main.o matrix.o
	$(CC) -o $@ $^

%.o: %.d
	$(CC) $(CFLAGS) $<


clean:
	-rm -f *.o

distclean: clean
	-rm -f playfair

install: playfair
	cp -f playfair $(DESTDIR)/usr/bin/

uninstall:
	rm -f $(DESTDIR)/usr/bin/playfair
	