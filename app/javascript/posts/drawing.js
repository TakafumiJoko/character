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
    if(undoDataStack.length === 0){
      redoDataStack = [];
      return;
    }else if(redoDataStack.length === 0){
      return;
    }
    recordUndoDataStack();
    var imageData = redoDataStack.shift();
    context.putImageData(imageData, 0, 0);
  }
  
  function draw(x, y){
    latestPosition.x = x;
    latestPosition.y = y;
    context.moveTo(lastPosition.x, lastPosition.y);
    context.lineTo(latestPosition.x, latestPosition.y);
    context.stroke();
    lastPosition.x = x;
    lastPosition.y = y;
  }

  function dragStart(event){
    redoDataStack = [];
    recordUndoDataStack();
    context.beginPath();
    isDrag = true;
    lastPosition.x = event.layerX;
    lastPosition.y = event.layerY;
  }
  
  function drag(event){
    if(isDrag){
      draw(event.layerX, event.layerY);
    }else{
      return;
    }
  }

  function dragEnd(){
    context.closePath();
    isDrag = false;
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
  
  function initEventHandler(event){
    canvas.addEventListener('mousedown', dragStart);
    canvas.addEventListener('mousemove', drag);
    canvas.addEventListener('mouseup', dragEnd);
    canvas.addEventListener('mouseout', dragEnd);
    
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
  }
  
  initEventHandler(event);
}());

