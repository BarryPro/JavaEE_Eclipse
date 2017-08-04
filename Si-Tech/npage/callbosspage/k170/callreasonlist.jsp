<%@ page contentType= "text/html;charset=GBK" %>
<%
	String id = request.getParameter("id")==null?"":request.getParameter("id");
%>
<html>
	<head>
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
    <link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
    <link href="/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
	<script src="/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>
<style>
body
{
	margin:0;
	padding:0;
	font:12px Verdana, Arial, Helvetica, sans-serif,"宋体"，"黑体";
	line-height:1.8em;
	text-align:left;
	color:#003399;
}
html {
	scrollbar-face-color:#d5e1f7;
	scrollbar-highlight-color:#FFFFFF;
	scrollbar-shadow-color:#DEEBF7;
	scrollbar-3dlight-color:#89b3e3;
	scrollbar-arrow-color: #121f54;
	scrollbar-track-color:#F4F0EB;
	scrollbar-darkshadow-color:#89b3e3;
	overflow:hidden;
}
#Operation_Table td.Grey {
	cursor: hand;
	background-color: #BCD2EF;
	
}
#Operation_Table td.Grey1 {
	cursor: hand;
	background-color: #D5E4F5;
	padding-left:20px;
	
}
#Operation_Table td.Grey2 {
	cursor: hand;
	background-color: #D5E4F5;
	padding-left:35px;
	
}
#Operation_Table td.Blue2 {
	cursor: hand;
	padding-left:0px;
}

#Operation_Table td.Blue3 {
	cursor: hand;
	padding-left:18px;
	
}

#Operation_Table td.Blue4 {
	cursor: hand;
	padding-left:33px;
	
}
#Operation_Table td.Blue5 {
	cursor: hand;
	padding-left:48px;
	
}

</style>
	</head>
	<body>
		<div id='Operation_Table' style="padding: 1;margin: 1;">
		</div>
	</body>
			<script>
			window.onload=function(){
				var id = "<%=id%>";
				if(id == "")
				{
					document.getElementById("Operation_Table").innerHTML="没有查询到相关信息!";
				}else
				{
						var contends = window.parent.parent.opener.xmlHelper.getContendsByNodeProperty('full','secondelevel',{'key':'CALLCAUSE_ID','value':id});
					  document.getElementById("Operation_Table").innerHTML=contends[0].text;
					  var myselect=window.parent.selectcontent.options;
					  for(var i=0;i<myselect.length;i++){
					  	if(id == myselect[i].value.substr(0,6))
					  		document.getElementById('chk'+myselect[i].value).checked=true;
	   			}
				}
			}
			
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
			//选中文件 by fangyuan 20090922
			function checkinDesc(callcause_id)
			{

				callcause_id = callcause_id.parentNode.parentNode.firstChild;
				if(callcause_id.checked){
					callcause_id.checked = false;
				}else{
					callcause_id.checked = true;
				}
				
				
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
				//updated by tangsong 20101018 取消在该处保存来电原因
				/*if(callcause_id.checked){
					parent.save();
			  }
			  */
			}
			
			function checkindiv(callcause_id)
			{
				var myselect=window.parent.selectcontent.options;
				if(callcause_id.checked)
				{
					myselect.options.add(new Option(callcause_id.fullname,callcause_id.id.replace('div','')));
				}else{
					for(var i=0;i<myselect.length;i++){
	   				if(myselect[i].value==callcause_id.id.replace('div','')){
	   					myselect.remove(i);
	   					break;
	   				}
	   			}
				}
			}
			
			function levelclick(callcause_id)
			{
				if(callcause_id.showflag == '0')
				{
					$("td[id^="+callcause_id.id+"]").parent().hide();
					$(callcause_id).parent().show();
					$("td[id^="+callcause_id.id+"]").children("img").attr("src","/nresources/default/images/mztree/folder.gif");
					callcause_id.showflag='1';
				}else
				{
					$("td[id^="+callcause_id.id+"]").parent().show();
					$("td[id^="+callcause_id.id+"]").children("img").attr("src","/nresources/default/images/mztree/fopen.gif");
					callcause_id.showflag='0';
				}
			}
			</script>
</html>