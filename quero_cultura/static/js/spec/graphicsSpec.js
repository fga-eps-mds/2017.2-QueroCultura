describe("graphics",function(){
    describe("dynamicColors",function(){
        it("should create dynamic colors",function(){
            spyOn(Math,"random")
            dynamicColors()
            expect(Math.random).toHaveBeenCalledTimes(3)
        })
    })

    describe("poolColors",function(){
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
    })

    describe("temporal_graphic", function(){
        it("should create a bar chart",function(){
            var values = '["2014-02", "2014-04", "2014-05", "2014-07", "2014-08", "2014-09", "2014-10", "2014-11", "2014-12", "2015-01", "2015-02", "2015-03", "2015-04", "2015-05", "2015-06", "2015-07", "2015-08", "2015-09", "2015-10", "2015-11", "2015-12", "2016-01", "2016-02", "2016-03", "2016-04", "2016-05", "2016-06", "2016-07", "2016-08", "2016-09", "2016-10", "2016-11", "2016-12", "2017-01", "2017-02", "2017-03", "2017-04", "2017-05", "2017-06", "2017-07", "2017-08", "2017-09", "2017-10"]'
            var keys = '[1, 2, 1356, 136, 409, 190, 346, 286, 148, 255, 431, 633, 432, 587, 1624, 395, 448, 1118, 328, 371, 451, 496, 433, 540, 444, 1401, 415, 430, 571, 535, 407, 332, 187, 234, 680, 411, 810, 933, 251, 361, 434, 377, 639]'
            var chart = null
            var stringChart = '<div><canvas style="display:none" id="bar-chart-month"></canvas></div>'

            $("body").append(stringChart)

            per_month_bar_graphic(keys,values)

            chart = document.getElementById("bar-chart-month").outerHTML
            expect(stringChart).not.toEqual(chart)
        })
    })

    describe("per_area_graphic", function(){
        it("should create a bar chart",function(){
            var values = '["Teatro", "Cultura Tradicional", "Artes Visuais", "Exposição", "Livro e Literatura", "Cultura Digital", "Artes Integradas", "Outros", "Música Popular", "Dança", "Audiovisual", "Música Erudita", "Hip Hop", "Palestra, Debate ou Encontro", "Curso ou Oficina", "Artes Circenses", "Cinema", "Rádio", "Cultura Indígena"]'
            var keys = '[2529, 1097, 925, 703, 2381, 432, 1515, 1936, 5037, 1482, 614, 691, 551, 1965, 1504, 570, 2506, 83, 118]'
            var chart = null
            var stringChart = '<div><canvas style="display:none" id="bar-chart-area"></canvas></div>'

            $("body").append(stringChart)

            per_area_bar_graphic(keys,values)

            chart = document.getElementById("bar-chart-area").outerHTML
            expect(stringChart).not.toEqual(chart)
        })
    })

    describe("grow_graphic", function(){
        it("should create a line chart",function(){
            var values = '["2014-02", "2014-04", "2014-05", "2014-07", "2014-08", "2014-09", "2014-10", "2014-11", "2014-12", "2015-01", "2015-02", "2015-03", "2015-04", "2015-05", "2015-06", "2015-07", "2015-08", "2015-09", "2015-10", "2015-11", "2015-12", "2016-01", "2016-02", "2016-03", "2016-04", "2016-05", "2016-06", "2016-07", "2016-08", "2016-09", "2016-10", "2016-11", "2016-12", "2017-01", "2017-02", "2017-03", "2017-04", "2017-05", "2017-06", "2017-07", "2017-08", "2017-09", "2017-10"]'
            var keys = '[1, 2, 1356, 136, 409, 190, 346, 286, 148, 255, 431, 633, 432, 587, 1624, 395, 448, 1118, 328, 371, 451, 496, 433, 540, 444, 1401, 415, 430, 571, 535, 407, 332, 187, 234, 680, 411, 810, 933, 251, 361, 434, 377, 639]'
            var chart = null
            var stringChart = '<div><canvas style="display:none" id="line-chart-time"></canvas></div>'

            $("body").append(stringChart)

            growth_line_graphic(keys,values)

            chart = document.getElementById("line-chart-time").outerHTML
            expect(stringChart).not.toEqual(chart)
        })
    })
})
