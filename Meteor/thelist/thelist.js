
Posts = new Meteor.Collection("posts");
Users = new Meteor.Collection("users");
Parse.initialize("3LJfPumFrT2H1gKJ4Zl31m3bh5bF0hvJbxwbIkz8", "KGkBUO1ToZaesgs5bwzOA0324lJXDm0vmhtY6bEz");

Session.set("offset", 1);
Session.set("search", " ");
Session.set("searchBy", "title");
Session.set("operation", "showList");
Session.set("light_id", 0);

function scrape(){
		  Posts.remove({});
		  var Listing = Parse.Object.extend('listing');
		  var query = new Parse.Query(Listing);
		  var collection = query.collection();
		  collection.fetch({
			success: function(collection){
				//console.log(collection);
				collection.each(function(object){
					//console.log(object['attributes']['images']);
					Posts.insert({
						title: object['attributes']['title'], 
						user: object['attributes']['user'], 
						images: object['attributes']['images'],
						sold: object['attributes']['sold'],
						category: object['attributes']['category'],
						description: object['attributes']['description'],
						price: object['attributes']['price'],
						tags: object['attributes']['tags'],
						created: object['createdAt'],
						id: object['id']
						});
				});
			},
			error: function(collection, error){
				console.log(error);
			}
		});
}


if (Meteor.isClient) {
	scrape(); // cache the remote database

	// Router for Pages
	var Router = Backbone.Router.extend({
		routes: {
			"":      "main",
			"users": "users",
			"users/:search": "users",
			"search/:by/:search":	 "search",
		},
		main: function () {
			Session.set("operation", "showList");
		},
		users: function (user) {
			Session.set("search", user);
			Session.set("operation", "showUser");
		},
		// search can be done by
		// /search/desc/?
		// /search/title/?
		// /search/cat/?
		// /search/tag/?
		search: function (by, term) {
			Session.set("searchBy", by);
			Session.set("search", term);
			Session.set("operation", "showResults");
		}
	});
	
	var BlogRouter = new Router;
	Backbone.history.start({pushState: true});

 	Meteor.subscribe("posts");
 	Meteor.subscribe("users");
 
  Template.hello.greeting = function () {
    return "Welcome to the list.";
  };
  
  Template.list.showList = function(){
    return Session.get("operation") == 'showList' || Session.get("operation") == 'showResults';
  	//return false;
  }
   
  
  Template.single.showSingle = function(){
  	return Session.get("operation") == 'showSingle';
  }
  Template.user.showUser = function(){
  	return Session.get("operation") == 'showUser';
  }
  Template.new.showNew = function(){
  	return Session.get("operation") == 'showNew';
  	//return true;
  }
 Template.list.posts = function () {
    if(Session.get("operation") == 'showList'){
		var allposts = Posts.find({}, {sort: {created: 1}}).fetch(); // get all the content
    }
    else{
    	if(Session.get("searchBy") === 'title'){
  			var allposts = Posts.find({
  			title: {$regex: Session.get("search"), $options: 'i' }}, 
  			{sort: {created: -1}}).fetch();
    	}
    	else if(Session.get("searchBy") === 'desc'){
    		var allposts = Posts.find({
			    description: {$regex: Session.get("search"), $options: 'i' }}, 
			  {sort: {created: -1}}).fetch();
    	}
		  else if(Session.get("searchBy") === 'cat'){
    		var allposts = Posts.find({
			  category: {$regex: Session.get("search"), $options: 'i' }}, 
			  {sort: {created: -1}}).fetch();
    	}
    	else if(Session.get("searchBy") === 'tag'){
    		var allposts = Posts.find({
			  tags: {$regex: Session.get("search"), $options: 'i' }}, 
			  {sort: {created: -1}}).fetch();
    	}
    }
    
    ///////////////////////////////////////////////////////////////////////
//		THIS CODE RETURNS ELEMENTS AS A MULTIDIMENSIONAL ARRAY.
//		ELEMENTS ARE BROKEN INTO COLLECTIONS OF THREE
//		THE "list" TEMPLATE NEEDS TO BE SET UP TO HANDLE THIS.
//		I.E. 
//			{{#each posts}} <-- "posts" is the block inside the "list" template
//			<div class="row">
//				{{#each this}} <-- NOTICE: "this" MUST be used as we are iterating inside a multi-depth
//					<div class="post">
//					{{> post}} <-- the "post" template
//					</div>
//				{{/each}}
//			</div>
//			{{/each}}
///////////////////////////////////////////////////////////////////////
//		UNCOMMENT THE BELOW CODE TO ENABLE. REMEMBER TO COMMENT OUT 
//		THE LATER RETURN STATEMENT.
////////////////////////////////////////
		var rows = new Array(); // create an array to hold the rows
		while(allposts.length){ // while the content array still has elements in it
			var cols = new Array(); // create an array to represent columns
			for(var i = 0; i < 3; i++){ // insert three elements into the array
				if(allposts.length){ // make sure there are still elements. IMPORTANT.
					cols.push(allposts.pop()); // pop an element off the content arr into the column arr.
				}
			}
			rows.push(cols); // push the columns into the rows array
		}
		return rows;
		console.log(threeby);
////////////////////////////////////////
// 		return  Posts.find({}, {sort: {created: 1}});
    
  };
  
  Template.user.users = function(){
  	Users.remove({});
  	var query = new Parse.Query(Parse.User);
	var collection = query.collection();
	collection.fetch({
		success: function(collection){
			//console.log(collection);
			collection.each(function(object){
				console.log(object);
				Users.insert({
					username: object['attributes']['username'],
					image: object['attributes']['imgurl'],
					location: object['attributes']['location'],
					description: object['attributes']['bio'],
					name: object['attributes']['name'],
					gender: object['attributes']['gender'],
					email: object['attributes']['email'],
					created: object['createdAt']
				});
			});
		},
		error: function(collection, error){
			console.log(error);
		}
	});
	
  	return Users.find({name: {$regex: Session.get("search"), $options: 'i' }}, {sort: {username: 1}});
  }
  
  Template.single.posts = function () {
    console.log(Session.get("offset"));
  };

  Template.hello.events({
    'click' : function (evt) {
      //Session.set("search", "");
      //Session.set("operation", "showList");
    }
  });
  
  Template.new.events({
  	'click input.inc' : function(){
  		var title = $("#title").val();
  		var author = $("#author").val();
  		var price = $("#price").val();
  		var image = $("#image").val();
  		
  		Posts.insert({'title':title, 'author':author, 'price':price, 'image':image});
  		
  		$("#title").val("");
  		$("#author").val("");
  		$("#image").val("");
  		
  	}
  });
  
  Template.search.events({
  	'click input.inc' : function(){
  		if($('#bigSearch').val() === ""){
  			Session.set("searchBy", "title");
  			Session.set("search", " ");
  			Session.set("operation", "showList");
  		}
  		else{
  			Session.set("searchBy", "title");
  			Session.set("search", $('#bigSearch').val());
  			Session.set("operation", "showResults");
  		}
  		
  		
  		//Parse.Push.send({data:"Hello"});
  	}
  });

  Template.single.events({
  		'click' : function(evt){
  			var e = $(evt.target).attr("class");
  			if(e === 'nex'){
  				Session.set("offset", Session.get("offset")+1);
  			}
  			else if (e === 'pre'){
  				Session.set("offset", Session.get("offset")-1);
  			}
  		}
  	
  });
  
  Template.list.events({
    'click' : function (evt) {
      if($(evt.target).attr("id")){
      	var e = $(evt.target).attr("id");
  	  	//alert(e);
  	  	Session.set("light_id", e);
  	  	// This is where we pop up the lightbox
  	  }
    }
  });
   
  Template.light.posts = function(){
     return Posts.find({id: Session.get("light_id")});
  }
   
  Template.light.showLight = function () {
  	return Session.get("light_id");
  }
  Template.light.events({
    'click' : function (evt) {
      var id;
      if(id = $(evt.target).attr("id")){
      	var src;
      	if(src = $(evt.target).attr("src")){
      		$(evt.target).parent().parent().css("background-image", "url("+src+")");
      	}
  	  	else if(id === 'l'){
  	  		var ids = $(evt.target).parent().find('img').map(function(){
                       return this.src;
                   }).get();
  	  		//alert(ids[Session.get("offset")]);
  	  		
  	  		if(Session.get("offset") === -1){
  	  			Session.set("offset", ids.length - 1)
  	  		}
  	  		
  	  		$(evt.target).parent().css("background-image", "url("+ids[Session.get("offset")]+")");
  	  		Session.set("offset", Session.get("offset") - 1);
  	  	}
  	  	else if(id === 'r'){
  	  		var ids = $(evt.target).parent().find('img').map(function(){
                       return this.src;
                   }).get();
            
            if(Session.get("offset") === ids.length){
  	  			Session.set("offset", 0)
  	  		}
        	
  	  		$(evt.target).parent().css("background-image", "url("+ids[Session.get("offset")]+")");
  	  		Session.set("offset", Session.get("offset") + 1);
  	  		
  	  	}
  	  	else{
  	  		Session.set("light_id", 0);
  	  		Session.set("offset", 1);
  	  	}
  	  	// This is where we pop up the lightbox
  	  }
    }
  });
  
  
	$(document).keyup(function(e) {
		if (e.keyCode == 27) { 
			Session.set("light_id", 0);
  	  		Session.set("offset", 1);
		 }   // esc
		if(e.keyCode == 39 && Session.get("light_id")){
			//Session.set("offset", Session.get("offset") + 1);
		}
		if(e.keyCode == 37 && Session.get("light_id")){
			//Session.set("offset", Session.get("offset") - 1);
		}
	});
  
}

if (Meteor.isServer) {
	
  Meteor.startup(function () {
	Meteor.publish("posts", function() {
        return Posts.find({});
    });
    Meteor.publish("users", function() {
        return Users.find({});
    });
    
});  


}
