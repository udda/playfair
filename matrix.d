module playfair.matrix;

char[] TransformMatrix(char[] m, char[25] pattern) {
	char[] newmatrix;
	for (int i=0; i<25; i++)
		newmatrix ~= m[pattern[i]];
	return newmatrix;
}

const char spiral_cw[25] =	[0,	 1,	 2,	 3,	 4,
							15,	16,	17,	18,	 5,
							14,	23,	24,	19,	 6,
							13,	22,	21,	20,	 7,
							12,	11,	10,	 9,	 8];

const char spiral_ccw[25] =	[0,	15,	14,	13,	12,
							 1,	16,	23,	22,	11,
							 2,	17,	24,	21,	10,
							 3,	18,	19,	20,	 9,
							 4,	 5,	 6,	 7,	 8];

const char linear_inv[25] =	[4,	 3,	 2,	 1,	 0,
							 9,	 8,	 7,	 6,	 5,
							14,	13,	12,	11,	10,
							19,	18,	17,	16,	15,
							24,	23,	22,	21,	20];
