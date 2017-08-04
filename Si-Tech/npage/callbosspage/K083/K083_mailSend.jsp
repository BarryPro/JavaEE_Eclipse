<%
  /*
   * 功能: 电子邮件发送
　 * 版本: 1.0
　 * 日期: 2008/11/23
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
    String opCode="K083";
    String opName="电子邮件发送";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  
	  String user_phone = (String)request.getParameter("user_phone");
	  String msg_content = (String)request.getParameter("msg_content");
	  
	  String action = (String)request.getParameter("myaction");
	  String isFirstIn = (String)request.getParameter("isFirstIn");//是否是第一次进入。N：否，Y：是
	  
	  String scucc_flag = (String)request.getParameter("flag");
	  System.out.println("\n\n=1=scucc_flag==\n"+scucc_flag);
	  if(scucc_flag==null){
	    scucc_flag="";
	  }
	  System.out.println("\n\n=2=scucc_flag==\n"+scucc_flag);
	  if("sendmsg".equals(action)){
	     System.out.println("\n\n==电子邮件发送!==\n");
%>
	     <wtc:service name="sK083Insert" outnum="3">
	       <wtc:param value="<%=user_phone%>" />
	       <wtc:param value="<%=msg_content%>" />
	     </wtc:service>
	     <wtc:array id="retList" scope="end" />
<%     
       
	  if("000000".equals(retCode)&&"N".equals(isFirstIn)){
//System.out.println("\n\n==电子邮件发送!==\n");
//System.out.println("\n\n==开始记录日志!==\n");
       scucc_flag="1";
	  }else{
	  	 scucc_flag="0";
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
    rdShowMessageDialog("电子邮件发送",2);	
</script>
<%
 	}else if("N".equals(isFirstIn)){
%>
 	<script language="javascript">
    rdShowMessageDialog("电子邮件发送:<%=retCode%>");	
 </script>	
<%
 	}

	} 
}
%>

<html>
<head>
<title>电子邮件发送</title>
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
    	  showTip(document.sitechform.user_phone,"发送地址不能为空！请从新选择后输入");
        sitechform.user_phone.focus();
    }
	else if(document.sitechform.msg_content.value == ""){
		showTip(document.sitechform.msg_content,"内容不能为空！请从新选择后输入");
		sitechform.msg_content.focus();
    }
   else {
    hiddenTip(document.sitechform.user_phone);
    hiddenTip(document.sitechform.msg_content);
    //doSubmit();
    sendSubmit();
    }
}
//普通方式发送
function doSubmit(){
    window.sitechform.myaction.value="sendmsg";
    window.sitechform.action="K083_mailSend.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
}
//rpc调用发送
function sendSubmit(){
	/**
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/K083/K083_mailSend_rpc.jsp","正在发送邮件，请稍候......");
	mypacket.data.add("user_phone",document.sitechform.user_phone.value);
	mypacket.data.add("msg_content",document.sitechform.msg_content.value);
  core.ajax.sendPacket(mypacket,doProcess,true);
	mypacket=null;*/
	rdShowMessageDialog("发送电子邮件");
}

function doProcess(packet){
	var retCode = packet.data.findValueByName("scucc_flag");
	if(retCode="1"){
    window.sitechform.flag.value="1";
	}else if(retCode="0"){
    window.sitechform.flag.value="0";
	}
	  window.sitechform.action="K083_msgSend.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
}
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body >
<form id=sitechform name=sitechform>
	<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">邮件地址 &nbsp;<input name="user_phone" type="text"></div>
		<table cellspacing="0">
		</table>   
		
		<br>
		<div class="title">邮件内容</div>
    <br> 
    <table cellspacing="0" cellpadding="0">
    	<tr><td>
    	 <textarea name="msg_content" id="msg_content" rows="10" cols="75"></textArea>
    	</td>
      </tr>
		</table>
		
		<br><br>

		<p id="footer"><input name="send" type="button"  id="send" value="执行" onClick="sendMsg()">
		 		<hr>	
		</p>
		<div class="title">业务处理结果</div>
		<table>
			<tr>
			<td >
			<%
			if(scucc_flag.equals("1")){
			   out.print("邮件发送成功");
			}else if(scucc_flag.equals("0")){
			   out.print("邮件发送失败");
			}else {
			 	 out.print("&nbsp;");
			}
			%>
			</td>
		 </tr>
		</table>
<input type="hidden" name="myaction" value="">
<input type="hidden" name="isFirstIn" value="N">
<input type="hidden" name="flag" value="">
	</div>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

