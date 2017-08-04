	<div id="relationArea" style="display:none"></div>
				<div id="wait" style="display:none">
				<img  src="/nresources/default/images/blue-loading.gif" />
			</div>
			<div id="beforePrompt"></div>
		</DIV>             
</DIV>
<script>
	
	function topage(opcode,valideVal,openflag,title,targetUrl)
	{
		 if((typeof parent.L)=="function")
		 {
		 		parent.L(openflag,opcode,title,targetUrl,valideVal);
		 }else{
				parent.parent.L(openflag,opcode,title,targetUrl,valideVal);
		 }
	}
	
	$(function(){
		$('#wait').show();
		getBeforePrompt();
		getOpRela();
	}); 
	
	function getOpRela()
	{
		var packet = new AJAXPacket("/npage/include/getOpRela.jsp","请稍后...");
		packet.data.add("opCode" ,"<%=opCode%>");
	  core.ajax.sendPacketHtml(packet,doGetOpRela,true);//异步
		packet =null;
	}
	
	function doGetOpRela(data)
	{
		if(data.trim()!="")
		{
			$('#relationArea').html(data);
			$('#relationArea').show();
		}
	}
	
	function getBeforePrompt()
	{
		var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","请稍后...");
		packet.data.add("opCode" ,"<%=opCode%>");
	    core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//异步
		packet =null;
	}
	
	function doGetBeforePrompt(data)
	{
		$('#wait').hide();
		$('#beforePrompt').html(data);
	}
	
	function getAfterPrompt()
	{
		var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","请稍后...");
		packet.data.add("opCode" ,"<%=opCode%>");
	  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//同步
		packet =null;
	}
	
	function doGetAfterPrompt(packet)
	{
    var retCode = packet.data.findValueByName("retCode"); 
    var retMsg = packet.data.findValueByName("retMsg"); 
    if(retCode=="000000"){
    	promtFrame(retMsg);
    }
	}
	
	
    function getMidPrompt(classCode,classValue,id111,smCode)
	{
		var packet = new AJAXPacket("/npage/include/getMidPromptNew.jsp","请稍后...");
		packet.data.add("opCode" ,"<%=opCode%>");
		packet.data.add("classCode" ,classCode);
		packet.data.add("classValue" ,classValue);
		packet.data.add("id" ,id111);
		packet.data.add("smCode" ,smCode);
		core.ajax.sendPacket(packet,doGetMidPrompt,true);//异步
		packet =null;
	}
	
	
	function doGetMidPrompt(packet)
	{
	
    var retCode 		= 	packet.data.findValueByName("retCode"); 
    var retMsg 			= 	packet.data.findValueByName("retMsg"); 
    var id111 			= 	packet.data.findValueByName("id"); 


    if(retCode=="000000"){
				document.getElementById(id111).className = "promptBlue";
				$("#"+id111).attr("title",retMsg);
				$("#"+id111).tooltip();
		}else
			{
				document.getElementById(id111).className = "";
				$("#"+id111).attr("title","");
				$("#"+id111).tooltip();
			}
	}
	
	/*zhangyan*/
	function btcGetMidPrompt(classCode , classValue , id111 , smCode)
	{
		var packet = new AJAXPacket("/npage/include/btcGetMidPrompt.jsp","请稍后...");
		packet.data.add("opCode" ,"<%=opCode%>");
		packet.data.add("classCode" ,classCode);
		packet.data.add("classValue" ,classValue);
		packet.data.add("id" ,id111);
		packet.data.add("smCode" ,smCode);
		core.ajax.sendPacket(packet,doBtcGetMidPrompt,true);//异步
		packet =null;
		
	}
/*zhangyan*/
function doBtcGetMidPrompt(packet)
{

	var retCode 		=packet.data.findValueByName("retCode"); 
	var retMsg 			=packet.data.findValueByName("retMsg"); 
	var strId 			=packet.data.findValueByName("strId"); 
	var id1s 			=packet.data.findValueByName("id1s"); 
	var promptContent	=packet.data.findValueByName("promptContent"); 
	var dispIds 			=( strId.substring(0,strId.length-1)).split("|");
	for ( var i=0;	i<dispIds.length; i	++ )
	{
		for ( var j=0; j<id1s.length; j++ )
		{
			if (dispIds[i].indexOf(id1s[j]) > 0)
			{
				document.getElementById(dispIds[i]).className = "promptBlue";
				$("#"+dispIds[i]).attr("title",promptContent[j]);
				$("#"+dispIds[i]).tooltip();	
			}
		}
	}

}
	
</script>
