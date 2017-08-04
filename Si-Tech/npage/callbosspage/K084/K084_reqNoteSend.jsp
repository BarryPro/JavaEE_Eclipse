<%
  /*
   * 功能: 一般通知发送
　 * 版本: 1.0
　 * 日期: 2008/11/1
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
    String opCode="K084";
    String opName="一般通知发送";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  
	  String user_phone = (String)request.getParameter("user_phone");
	  String msg_content = (String)request.getParameter("msg_content");
	  
	  String action = (String)request.getParameter("myaction");
	  String isFirstIn = (String)request.getParameter("isFirstIn");//是否是第一次进入。N：否，Y：是
	  
	  String scucc_flag = "0";
	  if("sendmsg".equals(action)){
	     System.out.println("\n\n==通知开始发送!==\n");
%>
	     <wtc:service name="sK083Insert" outnum="3">
	       <wtc:param value="<%=user_phone%>" />
	       <wtc:param value="<%=msg_content%>" />
	     </wtc:service>
	     <wtc:array id="retList" scope="end" />
<%     
       
	  if("000000".equals(retCode)&&"N".equals(isFirstIn)){
System.out.println("\n\n==通知发送成功!==\n");
System.out.println("\n\n==开始记录日志!==\n");
       scucc_flag="1";
	  }
	  String serial_no ="";
	  if(retList.length!=0){
	     serial_no = retList[0][2];
System.out.println("serial_no[0][0]==="+retList[0][0]);
System.out.println("serial_no[0][1]==="+retList[0][1]);
System.out.println("serial_no[0][2]==="+retList[0][2]);
%>
	     <wtc:service name="sK083Log" outnum="2">
	       <wtc:param value="<%=user_phone%>" />
	       <wtc:param value="<%=msg_content%>" />
	       <wtc:param value="<%=serial_no%>" />
	       <wtc:param value="<%=scucc_flag%>" />
	     </wtc:service>
<% 
	     System.out.println("==========="+retMsg);
 	  if("000000".equals(retCode)&&"N".equals(isFirstIn)){
%>
<script language="javascript">
    rdShowMessageDialog("通知发送成功！",2);	
</script>
<%
 	}else if("N".equals(isFirstIn)){
%>
 	<script language="javascript">
    rdShowMessageDialog("通知发送失败！错误代码:<%=retCode%>");	
 </script>	
<%
 	}

	} 
}
%>

<html>
<head>
<title>一般通知发送</title>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	

//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
function sendMsg(){
   if( document.sitechform.user_phone.value == ""){
    	  showTip(document.sitechform.user_phone,"发送号码不能为空！请从新选择后输入");
        sitechform.user_phone.focus();
    }
	else if(document.sitechform.msg_content.value == ""){
		showTip(document.sitechform.msg_content,"短信内容不能为空！请从新选择后输入");
		sitechform.msg_content.focus();
    }
   else {
    hiddenTip(document.sitechform.user_phone);
    hiddenTip(document.sitechform.msg_content);
    doSubmit();
    }
}
function doSubmit(){
    window.sitechform.myaction.value="sendmsg";
    window.sitechform.action="K084_commNoteSend.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
}

//function closeWin(){ 
//  window.open("","_self"); 
//  top.opener=null; 
//  top.close(); 
//} 

function accept(){
	
}

function refuse(){}
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body >
<form id=sitechform name=sitechform>
		<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
				<iframe name="false" id="user_index" frameborder="0" marginwidth="8" src="<%=request.getContextPath()%>/npage/callbosspage/K084/K084_reqNoteIn.jsp" width="100%" height="58%">
			<table cellspacing="0" cellpadding="0">
    	 <tr>
    	 	<th>发送工号</th>
    	  <th>消息类别</th>
        <th>发送时间</th>
        <th>消息内容</th>        
     
		</table>
				</iframe>
		<br>
		<div class="clr"></div>
		
		<div class="title">发送内容</div>
    <table cellspacing="0" cellpadding="0">
    	<tr><td>
    	 <textarea name="send_content" id="send_content" rows="6" cols="70"></textArea>
    	</td>
      </tr>
		</table>
		
		<p align="right" id="footer">
			<input name="send" type="button"  id="send" value="同意" onClick="accept()">
			<input name="send" type="button"  id="send" value="拒绝" onClick="refuse()">&nbsp;&nbsp;&nbsp;&nbsp;
			<!--input name="send" type="button"  id="send" value="关闭" onClick="parent.window.close();"-->
			<hr>
		</p>
	</div>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

