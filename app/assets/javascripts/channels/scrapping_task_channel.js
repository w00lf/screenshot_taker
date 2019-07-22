//= require cable
//= require_self
//= require_tree .

this.App = {};
console.log('channel');
App.cable = ActionCable.createConsumer();