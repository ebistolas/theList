Posts = new Meteor.Collection("posts");
Users = new Meteor.Collection("users");
Parse.initialize("3LJfPumFrT2H1gKJ4Zl31m3bh5bF0hvJbxwbIkz8", "KGkBUO1ToZaesgs5bwzOA0324lJXDm0vmhtY6bEz");

Session.set("offset", 0);
Session.set("search", " ");
Session.set("operation", "showList");



if (Meteor.isClient) {
 
 	Meteor.subscribe("posts");
 	Meteor.subscribe("users");
 
  Template.hello.greeting = function () {
    return "Welcome to the list.";
  };
  
  Template.list.showList = function(){
    return Session.get("operation") == 'showList';
  	//return false;
  }
   Template.results.showResults = function(){
    return Session.get("operation") == 'showResults';
  	//return true;
  }
  
  Template.single.showSingle = function(){
  	return Session.get("operation") == 'showSingle';
  }
  Template.user.showUser = function(){
  	return Session.get("operation") == 'showUser';
  }
  Template.new.showNew = function(){
  	return Session.get("operation") == 'showNew';
  }
 Template.list.posts = function () {
	Posts.remove({});
	var Listing = Parse.Object.extend('listing');
	var query = new Parse.Query(Listing);
	var collection = query.collection();
	collection.fetch({
		success: function(collection){
			//console.log(collection);
			collection.each(function(object){
				//console.log(object);
				Posts.insert({
					title: object['attributes']['title'], 
					user: object['attributes']['user'], 
					image: object['attributes']['imgurl'],
					sold: object['attributes']['sold'],
					category: object['attributes']['category'],
					description: object['attributes']['description'],
					price: object['attributes']['price'],
					created: object['createdAt'] 
					});
			});
		},
		error: function(collection, error){
			console.log(error);
		}
	});
 
    	return Posts.find({}, {sort: {created: -1}});
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
	
  	return Users.find({}, {sort: {username: 1}});
  }
  Template.results.posts = function () {
    	var res = Posts.find({title: {$regex: Session.get("search"), $options: 'i' }}, {sort: {created: -1}});
    	return res;
  }
  
  Template.single.posts = function () {
    console.log(Session.get("offset"));
  };

  Template.hello.events({
    'click input.nex' : function () {
      Session.set("operation", "showUser");
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
  		if($('#search').val() === ""){
  			Session.set("search", " ");
  			Session.set("operation", "showList");
  		}
  		else{
  			Session.set("search", $('#search').val());
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
