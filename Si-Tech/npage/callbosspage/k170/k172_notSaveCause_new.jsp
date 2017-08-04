<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<title>无标题文档</title>
<script type="text/javascript" src="/njs/extend/prototype/prototype.js"></script>	
<!--modify wangyong 20090817 修改引入js，替换成吉林本地使用-->
<script src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>  
<script src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js" type="text/javascript"></script>
<!--script type="text/javascript" src="/njs/si/core_sitech_pack_new.js"></script-->	
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
</head>
<body>
<div id="Operation_Table">
	<table  width="100%" height="250px" border="0" cellpadding="0" cellspacing="0">
		<tr>
	  	<td valign="top">
	 			<table cellspacing="0">
	 				<tr>
  					<th  align="center" colspan="2"><input type="radio" name="isNowCause" value="" checked="true" onclick="showCurrent()">
        		当前来话</th>
   					<th align="center" colspan="2"><input type="radio" name="isNowCause" value="" onclick="showHistory()">
        		历史未保存来话</th>
  				</tr>
  			</table>
 	 				<tr>
    				<td>
	  			     <iframe  name="myFrame"  frameborder="0" width="100%" height="250px" marginwidth="0" marginheight="0" scrolling="auto" src=""></iframe>		  			
	  		   </td>
  				</tr>
  		</td>
	   </tr>
	</table>	
</div>
</body>
<script language=javascript>
 showCurrent();
 function showCurrent(){
  var contactId= parent.document.getElementById("contactId").value;
  var contactMonth = parent.document.getElementById("contactMonth").value; 
  Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/K172_notSaveCauseList_new.jsp?contactId="+contactId+"&contactMonth="+contactMonth,"myFrame");
 }
 
 function showHistory(){
  var contactId=parent.document.getElementById("contactId").value;
  var contactMonth = parent.document.getElementById("contactMonth").value;
  var kfWorkNum=parent.document.getElementById("kfWorkNum").value;
  Window.open(<%=request.getContextPath()%>"/npage/callbosspage/k170/K172_notSaveCauseList_new.jsp?flag=1"+"&contactId="+contactId+"&contactMonth="+contactMonth+"&kfWorkNum="+kfWorkNum,"myFrame"); 
 }
 
</script>
</html>
