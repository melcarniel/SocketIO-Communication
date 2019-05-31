var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

io.on('connection', function (socket) {
    console.log('an user connected');

    socket.on('ledOn', function(data) {
        console.log('ledOn: ' + data);
        socket.broadcast.emit('ledOn', data);
    });

    socket.on('ledOff', function(data) {
        console.log('ledOff: ' + data);
        socket.broadcast.emit('ledOff', data);
    });
});

http.listen(3000, function () {
    console.log('listening on *:3000');
});