describe('eraseCookie', function(){

	it('should erase cookie', function(){

		spyOn(window, 'writeCookie')

		eraseCookie('nome')

		expect(window.writeCookie).toHaveBeenCalledWith('nome', '', -1)
	});
});

describe('readCookie', function(){
	it('should read cookie', function(){
		var test = readCookie('dontExist01020304')

		expect(test).toEqual(null)
	});
});