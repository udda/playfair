# playfair
Playfair cipher with interesting additions


### Introduction
The Playfair cipher is a manual symmetric encryption technique and was the first literal digram substitution cipher. The scheme was invented in 1854 by Charles Wheatstone, but bears the name of Lord Playfair who promoted the use of the cipher.

The technique encrypts pairs of letters (bigrams or digrams), instead of single letters as in the simple substitution cipher and rather more complex Vigenère cipher systems then in use. The Playfair is thus significantly harder to break since the frequency analysis used for simple substitution ciphers does not work with it. The frequency analysis of bigrams is possible, but considerably more difficult. With 600 possible bigrams rather than the 26 possible monograms (single symbols, usually letters in this context), a considerably larger cipher text is required in order to be useful.

Full article on [Wikipedia](https://en.wikipedia.org/wiki/Playfair_cipher)


### Application
This is a full implementation of Playfair cipher, with some additions to the original specifications. It can:
- show the matrix generated by a particular key
- place letters in the matrix with several patterns (row-by-row, spiral, more to come)
- invert order and/or direction of letters in the matrix
- interactive asking of required arguments if they are missing from command line


### How to build
The application is written in D language version 1. Since it is a simple program that does not use any advanced feature of the language, it should compile flawlessly with every D v1/v2 compiler (dmd, gdc, ldc, ...)

Requirements: a D compiler. I think any D compiler will be just fine, but I have tried only gdc.

How to compile:

- If you choose a compiler different from gdc, run *make CC=newcompiler*
- If you are fine with gdc, simply run *make*

How to install: *make install*

How to uninstall: *make uninstall*
