(function(){
  
  const canvas = document.getElementById("draw-area");
  const context = canvas.getContext("2d");
  context.lineWidth = 5;
  const latestPosition = { x: null, y: null };
  const lastPosition = { x: null, y: null };
  let isDrag = false;
  let undoDataStack = [];
  let redoDataStack = [];
  
  function recordUndoDataStack(){
    undoDataStack.unshift(context.getImageData(0, 0, canvas.width, canvas.height));
  }
  
  function recordRedoDataStack(){
    redoDataStack.unshift(context.getImageData(0, 0, canvas.width, canvas.height));
  }
  
  function undo(){
    if(undoDataStack.length === 0){
      return;
    }
    recordRedoDataStack();
    var imageData = undoDataStack.shift();
    context.putImageData(imageData, 0, 0);
  }
  
  function redo(){
    if(redoDataStack.length === 0){
      return;
    }
    recordUndoDataStack();
    var imageData = redoDataStack.shift();
    context.putImageData(imageData, 0, 0);
  }
  

  function drawStart(event){
    redoDataStack = [];
    recordUndoDataStack();
    context.beginPath();
    isDrag = true;
    lastPosition.x = event.layerX;
    lastPosition.y = event.layerY;
    //スマホ対応
    document.addEventListener('touchmove', handleTouchMove, {passive: false});
  }
  
  function draw(x, y){
    if(isDrag){
      latestPosition.x = x;
      latestPosition.y = y;
      context.moveTo(lastPosition.x, lastPosition.y);
      context.lineTo(latestPosition.x, latestPosition.y);
      context.stroke();
      lastPosition.x = x;
      lastPosition.y = y;
    }else{
      return;
    }
  }

  function drawEnd(){
    context.closePath();
    isDrag = false;
    //スマホ対応
    document.removeEventListener('touchmove', handleTouchMove, {passive: false});
  }

  function clearCanvas(){
    recordUndoDataStack();
    context.clearRect(0, 0, canvas.width, canvas.height);
  }
  
  function setWhiteLine(){
    context.strokeStyle = 'white';
    context.lineWidth = 10;
  }
  
  function setBlackLine(){
    context.strokeStyle = 'black';
    context.lineWidth = 5;
  }

  function sendImage(){
    var base64 = canvas.toDataURL();
    var imageURLField = document.getElementById('image-url-field');
    imageURLField.value = base64;
  }
  
  function handleTouchMove(event) {
      event.preventDefault();
  }
    
  function initEventHandler(event){
    canvas.addEventListener('mousedown', drawStart);
    canvas.addEventListener('mousemove', (event) => {
      const x = event.layerX;
      const y = event.layerY;
      draw(x, y);
    });
    canvas.addEventListener('mouseup', drawEnd);
    canvas.addEventListener('mouseout', drawEnd);
    
    const clearButton = document.getElementById("clear-button");
    clearButton.addEventListener('click', clearCanvas);
    clearButton.addEventListener('click', setBlackLine);
    const eraseButton = document.getElementById("erase-button");
    eraseButton.addEventListener('click', setWhiteLine);
    const drawButton = document.getElementById("draw-button");
    drawButton.addEventListener('click', setBlackLine);
    const undoButton = document.getElementById("undo-button");
    undoButton.addEventListener('click', undo);
    const redoButton = document.getElementById("redo-button");
    redoButton.addEventListener('click', redo);
    const submitButton = document.getElementById("submit-button");
    submitButton.addEventListener('click', sendImage);    
    
    // 以降スマホ対応
    canvas.addEventListener('touchstart', drawStart);
    canvas.addEventListener('touchmove', (event) => {
      const x = event.layerX;
      const y = event.layerY;
      draw(x, y);
    });
    canvas.addEventListener('touchend', drawEnd);

    clearButton.addEventListener('touchstart', clearCanvas);
    clearButton.addEventListener('touchstart', setBlackLine);
    eraseButton.addEventListener('touchstart', setWhiteLine);
    drawButton.addEventListener('touchstart', setBlackLine);
    undoButton.addEventListener('touchstart', undo);
    redoButton.addEventListener('touchstart', redo);
    submitButton.addEventListener('touchstart', sendImage);
  }
  
  initEventHandler(event);
})();