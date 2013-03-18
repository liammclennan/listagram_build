topLevel = if typeof window is 'undefined' then global else window
topLevel.statechart = Stativus.createStatechart()
module.exports = topLevel

