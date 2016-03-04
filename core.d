module playfair.core;

import std.string, std.array, std.stdio;
import matrix;

enum Operation {
	Encode=1,
	Decode=-1
};

// string to uppercase, removes invalid characters and changes 'J's to 'I's
char[] Normalize(char[] s) {
	s=toupper(s);
	foreach(ref char c; s) {
		if (c < 'A' || c > 'Z')
			c = '-';
		if (c == 'J')
			c = 'I';
	}
	return replace(s,"-","");
}

char[] RemoveDuplicates(char[] s) {
	char tmp;
	for(int i=0;i<s.length;i++) {
		tmp = s[i];
		s = replace(s,""~s[i],"-");
		s[i] = tmp;
	}
	return replace(s,"-","");
}

char[] BuildMatrix(char key[]) {
	if (!key.length)
		return replace(uppercase,"J","");

	bool spiral = false;
	uint offset = 0;
	bool reverse = false;
	bool invert = false;

	bool ctrlchar=true;
	for (int i=0; ctrlchar && i<key.length; i++) {
		switch (key[i]) {
			case '@':
				spiral = true;
				break;
			case ':':
				reverse = true;
				break;
			case '-':
				invert=true;
				break;
			case '>':
				++offset;
				offset%=25;
				break;
			case '<':
				offset+=24;
				offset%=25;
				break;
			default:
				ctrlchar = false;
				break;
		}
	}

	char m[] = RemoveDuplicates( Normalize( key ~ uppercase ) );

	if (offset)
		m = m[(25-offset)..$] ~ m[0..(25-offset)];
	if (reverse)
		m = m.reverse;

	if (spiral) {
		if (invert)
			m = TransformMatrix(m, spiral_ccw);
		else
			m = TransformMatrix(m, spiral_cw);
	} else {
		if (invert)
			m = TransformMatrix(m, linear_inv);
	}
	return m;
}

void ShowMatrix(char key[]) {
	char m[]=BuildMatrix(key);

	if (m == "")
		return;

	for (int i=0; i<25; i++) {
		putchar(m[i]);
		if ((i+1)%5)
			putchar(' ');
		else
			putchar('\n');
	}
}

bool Playfair(char key[], char input[], ref char output[], Operation mode=Operation.Encode, bool raw=false) {
	if (input == "")
		return false;

	char matrix[]=BuildMatrix(key);
	
	if (matrix == "")
		return false;
	
	output=Normalize(input);
	int p1,p2;

	int F(char c) {
		for (int i=0; i<25; i++)
			if (matrix[i] == c)
				return i;
		return -1;
	}

	if (mode == Operation.Encode) {
		for (char c='A';c<='Z' && c!='X';c++)
			output=replace(output,""~c~c,c~"X"~c);	
		output=replace(output,"XX","XQX");

		if (output.length % 2)
			output ~= "X";
	}

	for (int i=0; i<output.length; i+=2) {
		p1=F(output[i]);
		p2=F(output[i+1]);
		if (p1%5 == p2%5) { //same column
			output[i]	= matrix[( p1 + (mode == Operation.Encode ? 5 : 20) ) % 25];
			output[i+1]	= matrix[( p2 + (mode == Operation.Encode ? 5 : 20) ) % 25];
		} else if (p1-(p1%5) == p2-(p2%5)) { //same row
			output[i]	= matrix[p1 - (p1 % 5) + (p1 + (mode == Operation.Encode ? 1 : 4)) % 5];
			output[i+1]	= matrix[p2 - (p2 % 5) + (p2 + (mode == Operation.Encode ? 1 : 4)) % 5];
		} else { //rectangle
			output[i]	= matrix[ (p1 - (p1%5) + (p2%5)) % 25 ];
			output[i+1]	= matrix[ (p2 - (p2%5) + (p1%5)) % 25 ];
		}
	}

	//deletes 'X's separating doubles, 'Q's separating two 'X's and the possible ending 'X'
	if (!raw && mode == Operation.Decode) {
		for (char c='A';c<='Z' && c!='X';c++)
			output=replace(output,c~"X"~c,c~""~c);	
		output=replace(output,"XQX","XX");
		if (output[$-1] == 'X')
			output[$-1] = 0;
	}
	
	return true;
}

