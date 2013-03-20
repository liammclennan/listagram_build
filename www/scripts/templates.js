var templates = {};
templates["alert"] = function(obj){
var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};
with(obj||{}){
__p+='<div class="alert alert-block alert-'+
((__t=( level ))==null?'':__t)+
'">\n  '+
((__t=( message ))==null?'':__t)+
'\n</div>';
}
return __p;
}
templates["list"] = function(obj){
var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};
with(obj||{}){
__p+='<h2>'+
((__t=( title ))==null?'':__t)+
'</h2>\n';
 _.each(items, function(item) {  
__p+=' \n  <button class="btn btn-large btn-block listitem '+
((__t=( (item.completed) ? 'disabled' : ''  ))==null?'':__t)+
'" type="button"><input type="checkbox" '+
((__t=( (item.completed) ? 'checked="checked"' : ''  ))==null?'':__t)+
'  class="pull-left button-checkbox"> '+
((__t=( item.description ))==null?'':__t)+
'</button>\n';
 }); 
__p+='';
}
return __p;
}
templates["send"] = function(obj){
var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};
with(obj||{}){
__p+='<h1>Send</h1>\n\n<form>\n    <input name="receiver" class="full-form" type="email" placeholder="receiver..."><br/>\n    <input name="title" class="full-form" type="text" placeholder="title..."><br/>\n    <textarea name="items" class="full-form" rows="6" placeholder="enter one item per line..."></textarea><br/>\n    <button type="submit" class="btn btn-primary btn-block">Send</button>\n</form>\n\n<div class="well">\n  <h1>Sending a list</h1>\n  <p>Use this form to send a list.</p>\n  <p>Enter an email address in first field (receiver...). This can be any valid email address including your own.</p>\n  <p>Give your list a title in the second field.</p>\n  <p>Enter your list in the large field. Put each new list item on its own line.</p>\n  <p>Touch the \'Send\' button to send your list.</p>\n</div>';
}
return __p;
}
templates["errors"] = function(obj){
var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};
with(obj||{}){
__p+='<div class="validation_errors_container alert alert-block alert-error">\n  <ul>\n    ';
 _.each(errors, function (error) { 
__p+='\n      <li>'+
((__t=( error.property ))==null?'':__t)+
' '+
((__t=( error.message ))==null?'':__t)+
'</li>\n    ';
 }) 
__p+='\n  </ul> \n</div>';
}
return __p;
}
templates["register"] = function(obj){
var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};
with(obj||{}){
__p+='<h1>Register</h1>\n\n<form id="register">\n    <input name="email" class="full-form" type="email" placeholder="email..."><br/>\n    <input name="password" class="full-form" type="password" placeholder="password (optional)..."><br/>\n    <button type="submit" class="btn btn-primary btn-block register-submit">Register</button>\n</form>';
}
return __p;
}
templates["login"] = function(obj){
var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};
with(obj||{}){
__p+='<h1>Login</h1>\n\n<form id="login">\n    <input name="email" class="full-form" type="email" placeholder="email..."><br/>\n    <input name="password" class="full-form" type="password" placeholder="password..."><br/>\n    <button type="submit" class="btn btn-primary btn-block">Login</button>\n</form>';
}
return __p;
}
templates["listlist"] = function(obj){
var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};
with(obj||{}){
__p+='';
 if (lists.length === 0) { 
__p+='\n  <div class="alert alert-block alert-info">\n    No lists available\n  </div>\n  <div class="well">\n    <h1>Don\'t have any lists?</h1>\n    <p>Have a friend use listagram to send you a list (using the email address you registered with) or send yourself a list.</p>\n    <p>To send a list, select the \'Send\' option from the menu above.</p>\n  </div>\n';
 } 
__p+='\n';
 _.each(lists, function(list) {  
__p+=' \n  <button class="btn btn-large btn-block listlistitem" type="button" data-id="'+
((__t=( list.id.toString() ))==null?'':__t)+
'">'+
((__t=( list.title ))==null?'':__t)+
'</button>\n';
 }); 
__p+='';
}
return __p;
}
templates["loginregister"] = function(obj){
var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};
with(obj||{}){
__p+='<div class="row-fluid">\n  <div class="span6"><button class="btn btn-large btn-block loginregisteritem" type="button" data-state="login">Login</button></div>\n  <div class="span6"><button class="btn btn-large btn-block loginregisteritem" type="button" data-state="register">Register</button></div>\n</div>\n\n<br/>\n<div class="well">\n  <h1>Welcome to listagram</h1>\n  <p>Use listagram to send lists to your friends.</p>\n  <p>Great for shopping lists, task lists and other short lists.</p>\n</div>\n\n';
}
return __p;
}