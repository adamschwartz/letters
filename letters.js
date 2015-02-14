(function() {
  var buffer, bufferContext, drawLetter, randomColor, randomFont, randomLetter;

  buffer = document.createElement('canvas');

  bufferContext = buffer.getContext('2d');

  randomColor = function() {
    var num;
    num = 150 + Math.floor(Math.random() * 50);
    if (Math.random() > .95) {
      num = 130 + Math.floor(Math.random() * 20);
    }
    return "rgb(" + num + ", " + num + ", " + num + ")";
  };

  randomFont = function() {
    return {
      fontWeight: 'normal',
      fontSize: Math.floor(Math.random() * 30) + 8,
      fontFamily: 'Gill Sans'
    };
  };

  randomLetter = function() {
    var alphabet;
    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    return alphabet[Math.floor(Math.random() * alphabet.length)];
  };

  drawLetter = function(canvas, context, textFn, colorFn, fontFn, x, y) {
    var collision, fontFamily, fontSize, fontWeight, i, newData, oldData, oldDataData, padding, pixels, text, textHeight, textWidth, xMax, xMin, yMax, yMin, _ref;
    context.fillStyle = colorFn();
    text = textFn();
    _ref = fontFn(), fontWeight = _ref.fontWeight, fontSize = _ref.fontSize, fontFamily = _ref.fontFamily;
    context.font = "" + fontWeight + " " + fontSize + "px '" + fontFamily + "'";
    textWidth = Math.ceil(context.measureText(text).width, 10);
    textHeight = Math.ceil(fontSize * 1.4);
    padding = 3;
    xMin = Math.max(x - padding, 0);
    yMin = Math.max(y - padding, 0);
    xMax = xMin + textWidth + (2 * padding);
    yMax = yMin + textHeight + (2 * padding);
    collision = false;
    if (xMax > canvas.width || yMax > canvas.height) {
      return;
    }
    oldData = context.getImageData(xMin, yMin, xMax - xMin, yMax - yMin);
    oldDataData = oldData.data;
    buffer.width = xMax - xMin;
    buffer.height = yMax - yMin;
    bufferContext.putImageData(oldData, 0, 0);
    context.fillText(text, xMin + padding, yMin + padding);
    newData = (context.getImageData(xMin, yMin, xMax - xMin, yMax - yMin)).data;
    i = 0;
    pixels = oldData.data.length;
    while (i < pixels) {
      if (oldDataData[i + 3] > 0 && (newData[i + 3] !== oldDataData[i + 3] || newData[i + 2] !== oldDataData[i + 2] || newData[i + 1] !== oldDataData[i + 1] || newData[i] !== oldDataData[i])) {
        context.putImageData(bufferContext.getImageData(0, 0, xMax - xMin, yMax - yMin), xMin, yMin);
        return false;
      }
      i += 4;
    }
    return true;
  };

  window.Letters = {
    draw: function(canvas, numberOfDrawAttempts, options) {
      var color, context, font, height, i, letter, numberSuccessfullyDrawn, wasDrawn, width, x, y, _i;
      if (options == null) {
        options = {};
      }
      letter = options.letter || randomLetter;
      color = options.color || randomColor;
      font = options.font || randomFont;
      width = canvas.width;
      height = canvas.height;
      context = canvas.getContext('2d');
      context.textBaseline = 'top';
      context.textAlign = 'start';
      context.fontStretch = 1;
      context.angle = 0;
      numberSuccessfullyDrawn = 0;
      for (i = _i = 1; 1 <= numberOfDrawAttempts ? _i <= numberOfDrawAttempts : _i >= numberOfDrawAttempts; i = 1 <= numberOfDrawAttempts ? ++_i : --_i) {
        x = Math.floor(Math.random() * width);
        y = Math.floor(Math.random() * height);
        wasDrawn = drawLetter(canvas, context, letter, color, font, x, y);
        if (wasDrawn) {
          numberSuccessfullyDrawn += 1;
        }
      }
      if (numberOfDrawAttempts === 1) {
        return wasDrawn;
      }
      return numberSuccessfullyDrawn;
    }
  };

}).call(this);
