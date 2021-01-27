// 
const store = new Vuex.Store({
  state: {
	     count: 92,
        
         edit:{ 
        	 currentId: "?",
             query: "todo edit/query"
         },      
         "features":{
            "serviceworker": false
          },
         "images": {
        	 thumbtask :`<thumbnail>
  <size width="200" height="200"/>
  <filters>             
      <colorize color="green" alpha=".5"/>      
      <caption position="CENTER">Some Text here</caption>
      <rotate angle="15"/>
      <canvas height="300" width="300" position="TOP_LEFT" color="yellow"/> 
  </filters>
  <output format="gif"/>         
  </thumbnail>
  `
       },
       "settings": {
	      "ace": {
		     theme: "github",
		     themeDark: "chaos",
		     keybinding: "ace",
		     fontsize: 16,
		     enableSnippets:true,
		     enableBasicAutocompletion:true,
		     enableLiveAutocompletion:true
		     },
		  "dark": false
		  },
	 "markdown":{
	   "toc": true
	 }
  },
  
  mutations: {
    increment (state) {
      state.count++
    },
    initialiseStore(state) {
		// Check if the ID exists
    	var s=localStorage.getItem('store')
		if(s) {
			// Replace the state object with the stored item
			this.replaceState(
				Object.assign(state, JSON.parse(s))
			);
		}
    	//console.log("initialiseStore: ",s)
	}
  }
})
store.subscribe((mutation, state) => {
	// Store the state object as a JSON string
	localStorage.setItem('store', JSON.stringify(state));
	//console.log("store subscribe")
});