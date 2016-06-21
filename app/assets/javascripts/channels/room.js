App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {},

  disconnected: function() {},

  received: function(data) {
    console.log('trade', data['trade'])
    console.log('trade', data)
    if (data['message'] != null){
      return $('#messages').append(data['message']);
    } else if (data['trade'] != null) {
      return $('#trades').append(data['trade']);
    }
  },

  speak: function(message, portfolio_id) {
    return this.perform('speak', {
      message: message,
      portfolio_id: portfolio_id
    });
  }
});

$(document).on("keypress", "[data-behavior~=room_speaker]", function(event) {
  if (event.keyCode === 13) {
    var message = event.target.value;
    var portfolio_id = $('#portfolio-title')[0].getAttribute('data');

    App.room.speak(message, portfolio_id);
    event.target.value = '';
    return event.preventDefault();
  }
});
