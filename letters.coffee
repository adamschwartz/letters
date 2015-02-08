buffer = document.createElement 'canvas'
bufferContext = buffer.getContext '2d'

randomColor = ->
  num = 150 + Math.floor(Math.random() * 50)
  if Math.random() > .95
    num = 130 + Math.floor(Math.random() * 20)
  "rgb(#{ num }, #{ num }, #{ num })"

randomFont = ->
  fontWeight: 'normal'
  fontSize: Math.floor(Math.random() * 30) + 8
  fontFamily: 'Gill Sans'

randomLetter = ->
  alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
  alphabet[Math.floor(Math.random() * alphabet.length)]

drawLetter = (canvas, context, textFn, colorFn, fontFn, x, y) ->
  context.fillStyle = colorFn()

  text = textFn()

  { fontWeight, fontSize, fontFamily } = fontFn()
  context.font = "#{ fontWeight } #{ fontSize }px '#{ fontFamily }'"

  textWidth = Math.ceil context.measureText(text).width, 10
  textHeight = Math.ceil fontSize * 1.4

  padding = 3

  xMin = Math.max(x - padding, 0)
  yMin = Math.max(y - padding, 0)
  xMax = xMin + textWidth + (2 * padding)
  yMax = yMin + textHeight + (2 * padding)

  collision = false

  if xMax > canvas.width or yMax > canvas.height
    return

  oldData = context.getImageData xMin, yMin, xMax - xMin, yMax - yMin
  oldDataData = oldData.data

  buffer.width = xMax - xMin
  buffer.height = yMax - yMin
  bufferContext.putImageData oldData, 0, 0

  context.fillText text, xMin + padding, yMin + padding

  newData = (context.getImageData xMin, yMin, xMax - xMin, yMax - yMin).data

  i = 0
  pixels = oldData.data.length

  while i < pixels
    if oldDataData[i + 3] > 0 and (newData[i + 3] != oldDataData[i + 3] or newData[i + 2] != oldDataData[i + 2] or newData[i + 1] != oldDataData[i + 1] or newData[i] != oldDataData[i])
      context.putImageData bufferContext.getImageData(0, 0, xMax - xMin, yMax - yMin), xMin, yMin
      break
    i += 4

window.Letters =
  draw: (canvas, numberOfDrawAttempts, options = {}) ->
    letter = options.letter or randomLetter
    color = options.color or randomColor
    font = options.font or randomFont

    width = canvas.width
    height = canvas.height
    context = canvas.getContext '2d'

    context.textBaseline = 'top'
    context.textAlign = 'start'
    context.fontStretch = 1
    context.angle = 0

    for i in [0..numberOfDrawAttempts]
      x = Math.floor Math.random() * width
      y = Math.floor Math.random() * height

      drawLetter canvas, context, letter, color, font, x, y
