Posts = new Meteor.Collection("posts");
Parse.initialize("3LJfPumFrT2H1gKJ4Zl31m3bh5bF0hvJbxwbIkz8", "KGkBUO1ToZaesgs5bwzOA0324lJXDm0vmhtY6bEz");

	var id = "" + Math.random();
	Session.set("ses_id", id);
	console.log(Session.get("ses_id"));
	Results = new Meteor.Collection(Session.get("ses_id"));
	Session.set("offset", 0);
	Session.set("search", " ");
	Session.set("operation", "showList");



if (Meteor.isClient) {
 
 	Meteor.subscribe("messages");
 
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
  
  Template.new.showNew = function(){
  	return Session.get("operation") == 'showNew';
  }
  
  
  
 Template.list.posts = function () {
 		
    	return Posts.find({}, {sort: {created: -1}});
    
  };
  
  Template.results.posts = function () {
  		
  		var Listing = Parse.Object.extend('listing');
		//var ListingCollection = Parse.Collection.extend({model: Listing});
		
		var query = new Parse.Query(Listing);
		query.contains('title', Session.get("search"));
		//query.contains('description', Session.get("search"));
		var collection = query.collection();
		//var collection = new ListingCollection();
		collection.fetch({
			success: function(collection){
				//console.log(collection);
				collection.each(function(object){
					//console.log(object);
					Results.insert({
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
		//Session.set("results", Results.find({}, {sort: {created: -1}}));
		//Session.set("results", JSON.stringify(Results.find({}, {sort: {created: -1}})));
		//Results.remove({});
    	//return JSON.parse(Session.get("results"));
    	var res = Results.find({}, {sort: {created: -1}});
    	//Results.remove({});
    	return res;
  }
  
  Template.single.posts = function () {
    
   // return Posts.find({}, {sort: {title: 1}, skip: Session.get("offset"), limit: 1});
    console.log(Session.get("offset"));
  };

  Template.hello.events({
    'click input' : function () {
      // template data, if any, is available in 'this'
      if (typeof console !== 'undefined')
        console.log("You pressed the button");
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
  

   //  if (Posts.find().count() === 0) {
//       var items = ["MacBook Pro", "Apple iPhone"];
//       var images = ["https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSRtnNqehsMK5-hQqixmXrbp7x408QBm3rvOjx6YdTYllxWz13Lvw","https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcS3oPRziJW6b9nRPjurcdU-zB4ALwQk1OPONjRAMV5NCoW6elU9"];
//       for (var i = 0; i < items.length; i++)
//         Posts.insert({title: items[i], user: 'JS', image: images[i]});
//    
// 	}

	Meteor.publish("posts", function() {
        return Posts.find({});
    });
    
  });
  
  function updateListings(query){
		Posts.remove({});
		var Listing = Parse.Object.extend('listing');
		//var ListingCollection = Parse.Collection.extend({model: Listing});
		
		var query = new Parse.Query(Listing);
		query.contains('title', query);
		//query.contains('description', Session.get("search"));
		var collection = query.collection();
		//var collection = new ListingCollection();
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
  }
  
  
  
  
  
  
}
