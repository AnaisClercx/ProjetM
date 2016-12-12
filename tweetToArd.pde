import twitter4j.*;
import twitter4j.api.*;
import twitter4j.auth.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.management.*;
import twitter4j.util.*;
import twitter4j.util.function.*;


import java.util.*;

//objects declarations
TwitterFactory twitterFactory;
Twitter twitter;
RequestToken requestToken;
//Request object declaration
Query requete;
//Result request object declaration
QueryResult resultat;

ArrayList tweets; 
boolean lance= true; // timing request 1/min max, and initialize the loop for
String msg,user,pseudo,date; // variable data collected: tweet, user, pseudo, date
String prevMsg; // variable previous msg, to see if it's the same
int increm=0; //timing request
int i=0; 
boolean premMsg=true;  // first tweet


void setup() {
  //size of screen
  size(800, 800);
  smooth();//Improve rendering

  //Authentification
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("qRvmeK2ZPljqmcWQLkK2FCTdV");
  cb.setOAuthConsumerSecret("5RD17owRk0iixzRxSexpIE10Nzjby95dmnaCouR5vruOotI5y3");
  cb.setOAuthAccessToken("805463566790881280-AntdznSKGA5pcLThG0I86wi83bXAJzQ");
  cb.setOAuthAccessTokenSecret("QVcZu4c7akysDourexn7PKE3vQbhuhYNgfqbXKfuYHXod");
  
  twitterFactory = new TwitterFactory(cb.build());
  twitter = twitterFactory.getInstance(); 
}
void draw() {
  
  if (lance==true ){ // if we are in limit of api
    //renewal background for not overprint
  background(0); // initialize screen


  try {
    // search request
    requete = new Query("#Marine2017");
    //result request
    resultat = twitter.search(requete);
    //stock result in array list
    tweets = (ArrayList) resultat.getTweets();


    for (int i = 0; i < 1; i++) {//for the firt element of array list
      
      Status t=(Status) tweets.get(i);//get status
      
      User u=(User) t.getUser(); //get user of tweet
      
      user=u.getName(); // get user name
     
      msg = t.getText();// get tweet text
      
      pseudo = t.getUser().getScreenName();// get pseudo user
      
      Date d = t.getCreatedAt();
      String date = d.toString();// get date 
      

      //text color
      fill(255);// text color
      
      textSize(12); // text size
      
     
      if (msg.equals(prevMsg)==false || premMsg==true){// if it's first tweet or if it's a different tweet
      text(msg, 160, 40,450,450);// display tweet
      text(pseudo, 25, 40,150,150);//display user pseudo
      text(date, 25, 140,150,150);// display date
      prevMsg=msg; // tweet become previous tweet
      }
      

       if (msg.equals(prevMsg)==true){// if it's same tweet
      text("", 160, 40,750,550); // display nothing
      text("", 25, 40,150,150);
      }
      
      
      
      lance=false; // don't run for the time being
      premMsg= false; // next tweet wasn't first tweet
         
    }


    //increm ++; //timming request up
   // println(increm); 
  }
  
  catch (TwitterException e) {// if try doesn't run, say couldn t connect
    println("Couldn't connect: " + e);
  }

}
if (increm>3200){ // if time is almost over
  background(0);// initialize screen
  
}

  if (increm>4000){ // if time for request is over
    lance=true; // autorize new search
    increm=0; // initialize time for request
    i=0;// initialize i
    
  }
    increm ++; //time for request up
    println(increm); // tell me what time for request is it
    println("msg", msg); // tell me tweet is it
}