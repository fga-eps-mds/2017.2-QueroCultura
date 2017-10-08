//Testes feitos para o mapa
describe('InitTime', function () {
    it('should get time with 3 hours and 5 minutes delay', function () {
	     var now = InitTime();
       var timeTest = new Date();
         timeTest.setHours(timeTest.getHours() - 3, timeTest.getMinutes() - 5);
         timeTest.setMilliseconds(0);
         timeTest = timeTest.toJSON()

	     expect(now).toEqual(timeTest);

    });
});
