<script language="javascript">
	$(document).ready(function() {
					var G_DOCTRL = function(){};
					if((typeof parent.doCtrl)=="function")
					{
						G_DOCTRL = parent.doCtrl;
					}else if((typeof parent.parent.doCtrl)=="function"){
						G_DOCTRL = parent.parent.doCtrl;
					}
      		$.hotkeys.add('Ctrl+0', function(){G_DOCTRL("Ctrl+0");}); 	 
		      $.hotkeys.add('Ctrl+1', function(){G_DOCTRL("Ctrl+1");}); 
		      $.hotkeys.add('Ctrl+2', function(){G_DOCTRL("Ctrl+2");}); 
		      $.hotkeys.add('Ctrl+3', function(){G_DOCTRL("Ctrl+3");}); 
		      $.hotkeys.add('Ctrl+4', function(){G_DOCTRL("Ctrl+4");}); 
		      $.hotkeys.add('Ctrl+5', function(){G_DOCTRL("Ctrl+5");}); 
		      $.hotkeys.add('Ctrl+6', function(){G_DOCTRL("Ctrl+6");}); 
		      $.hotkeys.add('Ctrl+7', function(){G_DOCTRL("Ctrl+7");}); 
      		$.hotkeys.add('Ctrl+8', function(){G_DOCTRL("Ctrl+8");}); 
		      $.hotkeys.add('Ctrl+9', function(){G_DOCTRL("Ctrl+9");}); 
     });
</script>

