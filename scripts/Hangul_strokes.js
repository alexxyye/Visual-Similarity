let choSeong = new Array(
	new Array(
		0x3131, 0x3132, 0x3134, 0x3137, 0x3138, 0x3139, 0x3141, 0x3142, 0x3143, 0x3145,
		0x3146, 0x3147, 0x3148, 0x3149, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e
	),

	new Array(
		"ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ",
		"ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
	),

	new Array(
		2, 4, 2, 3, 6, 5, 4, 4, 8, 2,
		4, 1, 3, 6, 4, 4, 4, 4, 3
	)
);

let jungSeong = new Array(
	new Array(
		0x314f, 0x3150, 0x3151, 0x3152, 0x3153, 0x3154, 0x3155, 0x3156, 0x3157, 0x3158,
		0x3159, 0x315a, 0x315b, 0x315c, 0x315d, 0x315e, 0x315f, 0x3160, 0x3161, 0x3162,
		0x3163
	),

	new Array(
		"ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ",
		"ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ",
		"ㅣ"
	),

	new Array(
		2, 3, 3, 4, 2, 3, 3, 4, 2, 4,
		5, 3, 3, 2, 4, 5, 3, 3, 1, 2,
		1
	)
);

let jongSeong = new Array(
	new Array(
		0x0000, 0x3131, 0x3132, 0x3133, 0x3134, 0x3135, 0x3136, 0x3137, 0x3139, 0x313a,
		0x313b, 0x313c, 0x313d, 0x313e, 0x313f, 0x3140, 0x3141, 0x3142, 0x3144, 0x3145,
		0x3146, 0x3147, 0x3148, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e
	),

	new Array(
		"", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ",
		"ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ",
		"ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
	),

	new Array(
		0, 2, 4, 4, 2, 5, 5, 3, 5, 7,
		9, 9, 7, 9, 9, 8, 4, 4, 6, 2,
		4, 1, 3, 4, 3, 3, 4, 3
	)
);

let smallAlphabet = new Array (
	new Array(
		"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
		"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
	),

	new Array(
		2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 3, 1, 3,
		2, 1, 2, 2, 2, 1, 2, 2, 2, 4, 2, 2, 3
	)
);

let bigAlphabet = new Array(
	new Array(
		"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
		"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
	),

	new Array(
		3, 3, 1, 2, 4, 3, 2, 3, 1, 1, 3, 1, 4,
		3, 1, 2, 2, 3, 1, 2, 1, 2, 4, 2, 3, 3
	)
);

let characterScan = function (text) {
	let characters = new Array();
	let characterArr = new Array();

	for( let i = 0; i < text.length; i++ ) {
		characters[i] = text.charCodeAt(i);

		if( characters[i] >= 0xAC00 && characters[i] <= 0xD7A3 ) { // hangul to jaso
			let unicode = characters[i] - 0xAC00;
			let cho = unicode / (21 * 28);
			let jung = (unicode % (21 * 28)) / 28;
			let jong = (unicode % (21 * 28)) % 28;

			characterArr.push( String.fromCharCode(choSeong[0][parseInt(cho)]) );
			characterArr.push( String.fromCharCode(jungSeong[0][parseInt(jung)]) );
			if( jong != 0x0000 )
				characterArr.push( String.fromCharCode(jongSeong[0][parseInt(jong)]) );
		}

		else
			characterArr.push( String.fromCharCode(characters[i]) ); // except hangul(alphabet...)
	}

	return characterArr;
}

let characterStrokecount = function (source) {
	let strokeCount = 0;

	let smallAlphaCheck = /[a-z]/;
	let bigAlphaCheck = /[A-Z]/;
	let hangul = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;

	if( smallAlphaCheck.test(source) )
		strokeCount += funcOfstrokeCount( smallAlphabet[0], smallAlphabet[1], source );

	else if( bigAlphaCheck.test(source) )
		strokeCount += funcOfstrokeCount( bigAlphabet[0], bigAlphabet[1], source );
	
	else if( hangul.test(source) ) { // hangul
		strokeCount += funcOfstrokeCount( choSeong[1], choSeong[2], source[0] );
		strokeCount += funcOfstrokeCount( jungSeong[1], jungSeong[2], source[1] );
		strokeCount += funcOfstrokeCount( jongSeong[1], jongSeong[2], source[2] );
	}

	else {
		alert("한글, 영어만 입력해 주세요!");
		document.getElementById("character").value = "";
	}

	return strokeCount;
}

let funcOfstrokeCount = function ( alphabetArr, alphabetStrokeCountArr, alphabet ) {
	if( alphabet == undefined ) return 0; // prevent blank from being undefined

	for( let i = 0; i < alphabetArr.length; i++ ) {
		if( alphabet == alphabetArr[i] )
			return alphabetStrokeCountArr[i];
	}
}

let process = function () {
	let characterID = document.getElementById("character").value;
	let strokeCountID = document.getElementById("strokecount");
	let characterArr = new Array();
	let strokeCount = 0;

	for( let i = 0; i < characterID.length; i++ )
		characterArr[i] = characterScan( characterID.substr(i, 1) );

	for( let i = 0; i < characterID.length; i++ )
		strokeCount += characterStrokecount(characterArr[i]);
	
	strokeCountID.innerHTML = strokeCount;
}
