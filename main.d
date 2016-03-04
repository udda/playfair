module playfair.main;

import std.stdio, std.string, std.stream;
import core, locale;

int main(string args[]) {
	return oldmain(args);
/*
	//TODO switch to getopts

	bool	m_encode;
	bool	m_decode;
	bool	m_matrix;
	bool	m_version;
	bool	m_help;

	bool	m_raw;
	bool	m_interactive;
	bool	m_color;

	string	key="";
	string	data="";

	getopt(args,
		"encode|e",			&m_encode,
		"decode|d",			&m_decode,
		"matrix|m", 		&m_matrix,
		"version|v",		&m_version,
		"help|?",			&m_help,

		"raw|w",			&m_raw,
		"interactive|i",	&m_interactive,
		"color|c",			&m_color,

		"key|k",			&key,
		"text|t",			&data
	);
//playfair [mode] [options] [-k key -t text]

	if (m_version)
		WriteFormattedString(version_str);

	if (m_help)
		WriteFormattedString(help_str);

	//...
	return 0;
*/
}


int oldmain(string argv[]) {
	char[] mode;
	char[] str;
	bool result;
	char[] input, key;

	void AskForKey() {
		WriteFormattedString(insertkey_str);
		readln(key);
	}

	void AskForInput() {
		WriteFormattedString(inserttxt_str);
		readln(input);	
	}


	if (argv.length == 1) {
		char[] choice="";
		WriteFormattedString(choice_str);
		choice = readln();
		while((choice[0] - '0') < 1 || (choice[0] - '0') > 6) {
			WriteFormattedString(invalidchoice_str);
			choice = readln();
		}
		switch (choice[0]) {
			case '1': mode = "-e"; break;
			case '2': mode = "-d"; break;
			case '3': mode = "-r"; break;
			case '4': mode = "-m"; break;
			case '5': mode = "-v"; break;
			case '6': mode = "-?"; break;
			default: return 1;
		}
	} else
		mode = argv[1];


	switch(mode) {
		case "-d", "--decode":
			if (argv.length < 4) {
				AskForKey();
				AskForInput();
			} else {
				key = argv[2];
				input = argv[3];
			}
			result = Playfair(key,input,str,Operation.Decode);
			puts(toStringz(str));
			return result ? 0 : 1;
		case "-r", "--rawdecode":
			if (argv.length < 4) {
				AskForKey();
				AskForInput();
			} else {
				key = argv[2];
				input = argv[3];
			}
			result = Playfair(key,input,str,Operation.Decode,true);
	
			for (char c='A';c<='Z' && c!='X';c++)
				str=replace(str,c~"X"~c,c~"[u]X[/]"~c);	
			str=replace(str,"XQX","X[u]Q[/]X");
			if (str[$-1] == 'X') {
				str[$-1] = '[';
				str ~= "u]X[/]";
			}
	
			WriteFormattedString(str);
			return result ? 0 : 1;
		case "-e", "--encode":
			if (argv.length < 4) {
				AskForKey();
				AskForInput();
			} else {
				key = argv[2];
				input = argv[3];
			}
			result = Playfair(key,input,str,Operation.Encode);
			puts(toStringz(str));
			return result ? 0 : 1;
		case "-m", "--matrix":
			if (argv.length < 3) {
				AskForKey();
			} else {
				key = argv[2];
			}
			ShowMatrix(key);
			return 0;
		case "-v", "--version":
			WriteFormattedString(version_str);
			return 0;
		case "-?", "--help":
			WriteFormattedString(help_str);
			return 0;
		default:
			WriteFormattedString(unrecognized_option_str,argv[1]);
			return 1;
	}
}
