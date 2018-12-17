//Notification Object
const Notification={
    messages:[],
    nextId: 0,
    unseen:0,
    add(opts){
      var data=Object.assign({
          html: 'no html',
          index: ++this.nextId,
          created: new Date(),
          elapsed: null
      },
      opts);
      this.messages.unshift(data);
      this.messages.length = Math.min(this.messages.length, 30);
      ++this.unseen;

    },
    install(Vue){
        Object.defineProperty(Vue.prototype, '$notification', {
          get () { return Notification }
      })  }
};
Vue.use(Notification);
