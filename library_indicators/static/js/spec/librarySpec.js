// tests of the charts.js

describe('poolColors', function(){
    it("should create zero colors",function(){
            var quantity = 0
            var colors = poolColors(quantity)

            expect(colors.length).toEqual(0)
        })
        it("should not create negative colors",function(){
            var quantity = -1
            var colors = poolColors(quantity)

            expect(colors.length).toEqual(0)
        })
        it("should create n colors",function(){
            var quantity = 3
            var colors = poolColors(quantity)

            expect(colors.length).toEqual(3)
        })
});

describe('dynamicColors', function(){
    it('should generate random', function(){
        spyOn(Math,"random")
        dynamicColors()
        expect(Math.random).toHaveBeenCalledTimes(3)
    });
});
