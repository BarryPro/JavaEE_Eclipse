<script type="text/javascript" src="/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
<script language="javascript">
	$(document).ready(function() {
		
				//document.oncontextmenu=new Function("event.returnValue=false");
		
					$.hotkeys.add('Ctrl+n', function(){
						rdShowMessageDialog("欢迎您使用黑龙江移动综合客户服务系统！");
						});
						
					$.hotkeys.add('Ctrl+r', function(){
						rdShowMessageDialog("欢迎您使用黑龙江移动综合客户服务系统！");
						});
				  $.hotkeys.add('f5', function(){
							rdShowMessageDialog("欢迎您使用黑龙江移动综合客户服务系统！");
							window.event.keyCode = 0;
							return;
						});

						$.hotkeys.add('f11', function(){
							rdShowMessageDialog("欢迎您使用黑龙江移动综合客户服务系统！");
							window.event.keyCode = 0;
							return;
						});
						
			$.hotkeys.add('Ctrl+s', function(){
						document.forms[0].submit();
					});	
		
      $.hotkeys.add('Ctrl+0', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+0");
					}else{
					  parent.parent.doCtrl("Ctrl+0");
					}
      	}); 	 
      	      
      $.hotkeys.add('Ctrl+1', function(){
			    if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+1");
					}else{
					  parent.parent.doCtrl("Ctrl+1");
					}
      	}); 
      	
      $.hotkeys.add('Ctrl+2', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+2");
					}else{
					  parent.parent.doCtrl("Ctrl+2");
					}
      	}); 	 

      $.hotkeys.add('Ctrl+3', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+3");
					}else{
					  parent.parent.doCtrl("Ctrl+3");
					}
      	}); 	

      $.hotkeys.add('Ctrl+4', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+4");
					}else{
					  parent.parent.doCtrl("Ctrl+4");
					}
      	}); 	
      	
      $.hotkeys.add('Ctrl+5', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+5");
					}else{
					  parent.parent.doCtrl("Ctrl+5");
					}
      	}); 	
      	
      $.hotkeys.add('Ctrl+6', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+6");
					}else{
					  parent.parent.doCtrl("Ctrl+6");
					}
      	}); 	
      	
      $.hotkeys.add('Ctrl+7', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+7");
					}else{
					  parent.parent.doCtrl("Ctrl+7");
					}
      	}); 	
      	
      $.hotkeys.add('Ctrl+8', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+8");
					}else{
					  parent.parent.doCtrl("Ctrl+8");
					}
      	}); 	
      	
      $.hotkeys.add('Ctrl+9', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+9");
					}else{
					  parent.parent.doCtrl("Ctrl+9");
					}
      	}); 	
      	
      	
      	 $.hotkeys.add('Alt+F4', function(){
		      if((typeof parent.closeWindow)=="function")
					{
						parent.closeWindow();
					}else{
					  parent.parent.closeWindow();
					}
      	}); 	
      	
     });
</script>      	
