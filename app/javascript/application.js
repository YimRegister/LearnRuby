// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

window.addEventListener("load", (event) => 
    { 
    console.log("page is fully loaded"); 
    
    
});

$(document).ready(function() {
    $("#mybutton").click(function(){
        alert("button");
    }); 
});



$(".drop").click(function() {
    console.log("click!");
	$(".stem").addClass("rain");
	
	setTimeout(function () { 
		$('.stem').removeClass('rain');
	}, 1200);  
});







var canvas = document.getElementById('canvas');
var c = canvas.getContext('2d');

canvas.width = 500;
canvas.height = 300;

c.fillRect(0,0,canvas.width, canvas.height);

var paintColors = {};
var mouseId = 'mouse';

var mouseDown = false;
var bounding = canvas.getBoundingClientRect();

function addMouseListeners(){
  canvas.addEventListener('mousemove', function(e){
    if(mouseDown){
      
	  var x = e.clientX - bounding.left;
	  var y = e.clientY - bounding.top;
      c.fillStyle = paintColors[mouseId];
      drawCircle(x, y);
    }
  });
  
  canvas.addEventListener('mousedown', function(e){
    mouseDown = true;
    setRandomPaintColor(mouseId);
  });
  
  canvas.addEventListener('mouseup', function(e){
    mouseDown = false;
  });
  
  canvas.addEventListener('dblclick', function(e){
    c.fillStyle = 'black';
    c.fillRect(0,0,canvas.width, canvas.height);
  });
}

function setRandomPaintColor(id){
  function rand255(){ return Math.floor(Math.random()*255);}
  paintColors[id] = 'rgb('+rand255()+','+rand255()+','+rand255()+')';
}

function drawCircle(x, y){
  c.beginPath();
  c.arc(x, y, 7, 0, 2 * Math.PI);
  c.fill();
}

function addMultiTouchListeners(){
  canvas.addEventListener('touchmove',function(e){
    var i, touch;
    setRandomPaintColor();
    for(i = 0; i < e.targetTouches.length; i++){
      touch = e.targetTouches[i];
      c.fillStyle = paintColors[touch.identifier];
      drawCircle(touch.pageX, touch.pageY);
    }
  });
  
  canvas.addEventListener('touchstart',function(e){
    var i, touch;
    for(i = 0; i < e.changedTouches.length; i++){
      touch = e.changedTouches[i];
      setRandomPaintColor(touch.identifier);
    }
  });
  
  canvas.addEventListener('touchend',function(e){
    var i, touch;
    for(i = 0; i < e.changedTouches.length; i++){
      touch = e.changedTouches[i];
      console.log("removing "+touch.identifier);
      delete paintColors[touch.identifier];
    }
  });
}

// prevent scrolling
document.body.addEventListener('touchmove', function(event) {
  event.preventDefault();
}, false); 

addMouseListeners();
addMultiTouchListeners();



