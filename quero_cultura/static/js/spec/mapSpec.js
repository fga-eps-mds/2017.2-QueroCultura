//Testes feitos para o mapa
describe('InitTime', function () {
	it('should get time with 3 hours and X minutes delay', function () {
		delay = -5	
		var now = InitTime(delay);
		
		var timeTest = new Date();
		timeTest.setHours(timeTest.getHours() - 3, timeTest.getMinutes() - delay);	
		timeTest = timeTest.toJSON()

		expect(now).toEqual(timeTest);

    });
});
