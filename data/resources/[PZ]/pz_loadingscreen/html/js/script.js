var vid = document.getElementById("bg-video");
vid.volume = 0.1;

function volumeUp() {
  vid.volume = vid.volume + 0.1;
}

function volumeDown() {
  vid.volume = vid.volume - 0.1;
}

window.onload = function() 
{

  let cur = document.getElementById("cursor");

  document.addEventListener("mousemove", function (n) {
    cur.style.left = n.clientX + 3 + "px";
    cur.style.top = n.clientY + 3 + "px";
  })
}