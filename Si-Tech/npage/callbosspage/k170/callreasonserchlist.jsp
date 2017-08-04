<%@ page contentType= "text/html;charset=GBK" %>
<%
	String content = request.getParameter("content")==null?"":request.getParameter("content");
%>
<html>
	<head>
		<script src="/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>
		<script src="/njs/csp/xmlHelper.js" type="text/javascript"></script>
    <link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
    <link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
    <link href="/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
    <script>
    	window.onload=function(){
    		var contends = window.parent.parent.opener.xmlSeach.getContendsByNodePropertyM('full','itemSeach ',{'key':'FULLNAME','value':'<%=content%>'});
    		if(contends.length == 0)
    		{
    			document.getElementById("Operation_Table").innerHTML="没有查询到相关信息!";
    		}else{
    			var xmldata="<table>"
					for(var i=0;i<contends.length;i++)
					{
						xmldata+="<tr><td class='Blue' id='td"+contends[i].getAttribute('CALLCAUSE_ID')+"'>"+contends[i].text+contends[i].getAttribute('FULLNAME')+"</td></tr>";
					}
					xmldata+="</table>";
					
					document.getElementById("Operation_Table").innerHTML=xmldata;
					
					var myselect=window.parent.selectcontent.options;
					  for(var i=0;i<myselect.length;i++){
					  	 if(document.getElementById('chk'+myselect[i].value)!=null || document.getElementById('chk'+myselect[i].value) != undefined){
					  		document.getElementById('chk'+myselect[i].value).checked=true;
					  	}
	   			}
				}
    	}
    	</script>
	</head>
	<body>
		<div id='Operation_Table'>
		</div>
	</body>
	<script>
			function checkin(callcause_id)
			{
				var myselect=window.parent.selectcontent.options;
				if(callcause_id.checked)
				{
					myselect.options.add(new Option(callcause_id.fullname,callcause_id.id.replace('chk','')));
				}else{
					for(var i=0;i<myselect.length;i++){
	   				if(myselect[i].value==callcause_id.id.replace('chk','')){
	   					myselect.remove(i);
	   					break;
	   				}
	   			}
				}
				//added by tangsong 20100922 设置"三位一体"按钮可用/不可用
				var relationButton = window.parent.document.getElementById("relationButton");
				if (myselect.length > 0) {
					relationButton.disabled = false;
				} else {
					relationButton.disabled = true;
				}
			}
		</script>
</html>