(function(){
	var root,ozWindow;
	root = this;
})();

document.onkeypress=onkeydown;  
//禁止后退键  作用于IE、Chrome  
document.onkeydown=onkeydown;

function onkeydown()
{
	if ((event.keyCode==8) ) //屏蔽退格删除键  
	{   
	
	  if (window.event.srcElement.tagName.toUpperCase()!="INPUT" && window.event.srcElement.tagName.toUpperCase()!="TEXTAREA" && window.event.srcElement.tagName.toUpperCase()!="TEXT")  
	  {
	    event.keyCode=0;
	    event.returnValue=false;
	  }
	}
}