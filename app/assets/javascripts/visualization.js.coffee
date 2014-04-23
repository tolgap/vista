do ($ = jQuery, scope = window) ->
  unless window.Visualization
    scope.Visualization = {}

  scope.Visualization.Server = ->
    w = 540
    h = 360
    r = Math.min(w, h) / 2
    color = d3.scale.category20c()

    container = $('.visualizations .server')
    container.each ->
      data = [{"label" : "Update available", "value" : $(this).data("has-update")},
              {"label" : "Up to date", "value" : $(this).data("up-to-date")}]

      vis = d3.select(this)
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
          if data[i].label == "Update available"
            return "#d62728"
          else
            return "#a5df5b"
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
    width = 550 - margin.left - margin.right
    height = 400 - margin.top - margin.bottom

    container = $('.visualizations .websites')
    container.each ->
      versions = $(this).data("versions")

      x = d3.scale.ordinal()
        .rangeRoundBands([0, width], 0.25)

      y = d3.scale.linear()
        .range([height, 0])

      xAxis = d3.svg.axis()
        .scale(x)
        .orient("bottom")

      yAxis = d3.svg.axis()
        .scale(y)
        .orient("left")
        .ticks(versions.length)

      svg = d3.select(this)
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