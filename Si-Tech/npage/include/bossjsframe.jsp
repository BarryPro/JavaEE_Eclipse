
	<script type="text/javascript" src="/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
	<script type="text/javascript" src="/njs/redialog/redialog.js"></script>

	<script>
		function _frame_doload()
		{
		try{
				//document.oncontextmenu=new Function("event.returnValue=false");
		
					$.hotkeys.add('Ctrl+n', function(){
						rdShowMessageDialog("��ӭ��ʹ�ü����ƶ��ۺϿͻ�����ϵͳ��");
						});
						
					$.hotkeys.add('Ctrl+r', function(){
						rdShowMessageDialog("��ӭ��ʹ�ü����ƶ��ۺϿͻ�����ϵͳ��");
						});
				  $.hotkeys.add('f5', function(){
							rdShowMessageDialog("��ӭ��ʹ�ü����ƶ��ۺϿͻ�����ϵͳ��");
							window.event.keyCode = 0;
							return;
						});

						$.hotkeys.add('f11', function(){
							rdShowMessageDialog("��ӭ��ʹ�ü����ƶ��ۺϿͻ�����ϵͳ��");
							window.event.keyCode = 0;
							return;
						});
			}catch(e)
			{}
		}
		window.attachEvent('onload',_frame_doload);
	</script>