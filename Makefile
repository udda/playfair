# Copyright (C) 2011-2016 Mario Cianciolo <mr.udda@gmail.com>
# 
# This file is part of playfair.
# 
# playfair is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# playfair is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with playfair.  If not, see <http://www.gnu.org/licenses/>.

CFLAGS=-c -Wall -O3

ifndef CC
	CC=gdc
endif

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
	
