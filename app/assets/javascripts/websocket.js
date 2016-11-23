var serversocket = new WebSocket("wss://localhost:8080/echo", false);

serversocket.onopen = function() {
    serversocket.send("Connection init");
};

// Write message on receive
serversocket.onmessage = function(e) {
   // alert('data');
};

// Write message on receive
serversocket.onerror = function(e) {
    //alert("error");
};