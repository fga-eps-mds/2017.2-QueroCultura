describe("graphics_events", function(){
    describe("per_age_range_graphic", function(){

        it("should create a bar chart",function(){
            var values = '["Livre", "18 anos", "14 anos", "16 anos", "12 anos", "10 anos"]'
            var keys = '[17702, 561, 1087, 706, 801, 410]'
            var chart = null
            var stringChart = '<div><canvas style="display:none" id="bar-chart-events"></canvas></div>'

            $("body").append(stringChart)

            per_age_range_graphic(keys,values)

            chart = document.getElementById("bar-chart-events").outerHTML
            expect(stringChart).not.toEqual(chart)
        })
    })
})
