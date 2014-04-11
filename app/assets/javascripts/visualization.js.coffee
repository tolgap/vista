do ($ = jQuery, scope = window) ->
  unless window.Visualization
    scope.Visualization = {}

  scope.Visualization.Server = ->
    w = 640
    h = 360
    r = Math.min(w, h) / 2
    color = d3.scale.category20c()

    container = $('.visualizations .server')
    data = [{"label" : "Update available", "value" : container.data("has-update")},
            {"label" : "Up to date", "value" : container.data("up-to-date")}]

    vis = d3.select(".visualizations .server")
      .append("svg:svg")
      .data([data])
        .attr("width", w)
        .attr("height", h)
      .append("svg:g")
        .attr("transform", "translate(" + r + "," + r + ")")

    arc = d3.svg.arc().outerRadius(r)
    pie = d3.layout.pie().value (d) ->
      return d.value

    arcs = vis.selectAll("g.slice")
      .data(pie)
      .enter()
        .append("svg:g")
          .attr("class", "slice")

    arcs.append("svg:path")
      .attr("fill", (d, i) ->
        return color(i)
      ).attr("d", arc)

    arcs.append("svg:text")
      .attr("transform", (d) ->
        d.innerRadius = 0
        d.outerRadius = r
        return "translate(" + arc.centroid(d) + ")"
      ).attr("text-anchor", "middle")
      .text (d, i) ->
        return data[i].label + " (" + data[i].value + ")"

  scope.Visualization.Website = ->
    margin = {top: 20, right: 20, bottom: 30, left: 40}
    width = 1140 - margin.left - margin.right
    height = 600 - margin.top - margin.bottom

    container = $('.visualizations .websites')
    versions = container.data("versions")

    console.log versions

    x = d3.scale.ordinal()
      .rangeRoundBands([0, width], 0.1)

    y = d3.scale.linear()
      .range([height, 0])

    xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom")

    yAxis = d3.svg.axis()
      .scale(y)
      .orient("left")
      .ticks(10)

    svg = d3.select(".visualizations .websites")
      .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    x.domain(versions.map((d) ->
        return d[0]
    ))
    y.domain([0, d3.max(versions, (d) ->
      return d.length
    )])

    svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis)

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", -30)
        .attr("dy", "0em")
        .style("text-anchor", "end")
        .text("Websites")

    svg.selectAll(".bar")
        .data(versions)
      .enter().append("rect")
        .attr("class", "bar")
        .attr("x", (d) ->
          return x(d[0])
        ).attr("width", x.rangeBand())
        .attr("y", (d) ->
          return y(d.length)
        )
        .attr("height", (d) ->
          return height - y(d.length)
        )

type = (d) ->
  d.length = +d.length
  return d