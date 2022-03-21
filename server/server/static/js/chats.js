const room_name ="testing";
const msgSocket = new WebSocket(
    `ws://${window.location.host}/ws/chats/${room_name}/`
)
var txt = document.getElementById("msg");
const send = document.getElementById("send");
var previousMessages = {
    "messages": [
      ["ourMsg1"],
      ["theirMsg1"],
      ["ourMsg2"],
      ["theirMsg2"],
      ["ourMsg3", "ourMsg3Alt"],
      ["theirMsg3"],
      ["ourMsg4"],
      ["theirMsg4", "theirMsg4Alt"],
      ["ourMsg5", "ourMsg5Alt"],
      ["theirMsg6", "theirMsg6Alt"],
      ["ourMsg7", "ourMsg7Alt"],
    ],
  };

var msgs = previousMessages.messages;
var mainCont = document.getElementById("mainCont");
for(let i=0;i<msgs.length;i++){
    
    for(let j=0;j<msgs[i].length;j++){
        let elem = document.createElement("div");
        if(i%2!=0){
            elem.className = "msg text-left text-[#50d71e]  p-1 text-lg";
        }
        else{
            elem.className = "msg text-right text-[#ff471a]  p-1 text-lg";
        }
        elem.innerHTML = msgs[i][j];
        mainCont.appendChild(elem);
    }
}
send.addEventListener("click",()=>{
    let val = txt.value;
    txt.value = "";
    let data = {"message":val};
    msgSocket.send(
        JSON.stringify(data)
    );
    let elem = document.createElement("div");
    elem.className = "msg text-right text-[#ff471a]  p-1 text-lg";
    elem.innerHTML = val;
    mainCont.appendChild(elem);
})

msgSocket.onmessage = function(e){
    let data = JSON.parse(e.data);
    let message = data.message;
    let elem = document.createElement("div");
    elem.className = "msg text-left text-[#50d71e]  p-1 text-lg";
    elem.innerHTML = message;
    mainCont.appendChild(elem);
}

msgSocket.send(JSON.stringify({
    'message': "Aaaaaaaaaaaaaaaaaa",
    'user':"Bbbbbbbbbbbbbbbbbbbbbbb"
}));