   
<%
/********************
 version v2.0
 开发商 si-tech
 create wangzc@2010-5-29 :10:48
********************/
%>

              
<%
  String opName = request.getParameter("opName");
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%@ page contentType= "text/html;charset=gb2312" %>
 
<HTML><HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>


<%
String regionCode = (String)session.getAttribute("regCode");

String iChnSource = "01";
String sysAcceptl = WtcUtil.repNull(request.getParameter("sysAcceptl"));
String opCode = WtcUtil.repNull(request.getParameter("opCode"));
String workNo = (String)session.getAttribute("workNo");
String work_name =(String)session.getAttribute("workName");
String loginPwd = (String)session.getAttribute("password");
String phoneNo1 = WtcUtil.repNull(request.getParameter("phone_no1"));
String phoneNo2 = WtcUtil.repNull(request.getParameter("phone_no2"));
String fprodId = WtcUtil.repNull(request.getParameter("fprodId"));
String opNote = request.getParameter("opNote");
String custName=request.getParameter("custName");
String vBackAccept = request.getParameter("vBackAccept");
String iccid = request.getParameter("iccid1");
System.out.println("-------------sysAcceptl--------------"+sysAcceptl);
System.out.println("-------------iChnSource--------------"+iChnSource);
System.out.println("-------------opCode------------------"+opCode);
System.out.println("-------------workNo------------------"+workNo);
System.out.println("-------------loginPwd----------------"+loginPwd);
System.out.println("-------------phoneNo1-----------------"+phoneNo1);
System.out.println("-------------phoneNo2-----------------"+phoneNo2);
System.out.println("-------------fprodId-----------------"+fprodId);
System.out.println("-------------opName------------------"+opName);
System.out.println("-------------vBackAccept------------------"+vBackAccept);
System.out.println("-------------opNote------------------"+opNote);
System.out.println("-------------custName------------------"+custName);
System.out.println("-------------iccid------------------"+iccid);

%>	 	
		<wtc:service name="s8439Cfm" outnum="13" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sysAcceptl%>" />
			<wtc:param value="<%=iChnSource%>" />	
			<wtc:param value="<%=opCode%>" />		
			<wtc:param value="<%=workNo%>" />			
			<wtc:param value="<%=loginPwd%>" />				
			<wtc:param value="<%=phoneNo1%>" />					
			<wtc:param value="" />						
			<wtc:param value="<%=phoneNo2%>" />							
			<wtc:param value="" />	
			<wtc:param value="<%=fprodId%>" />								
			<wtc:param value="<%=opNote%>" />
			<wtc:param value="<%=vBackAccept%>" />
			<wtc:param value="<%=iccid%>" />									
		</wtc:service>
		<wtc:array id="result_t2" scope="end" />
		
				<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+code+
							"&opName="+opName+
							"&workNo="+workNo+
							"&loginAccept="+sysAcceptl+
							"&pageActivePhone="+phoneNo1+
							"&retMsgForCntt="+msg+
							"&opBeginTime="+opBeginTime; 
							
							System.out.println("统一接触："+url);
							%>
<jsp:include page="<%=url%>" flush="true" />
			
<%

System.out.println("----------code---------"+code);
System.out.println("----------msg----------"+msg);
		if(code.equals("000000")){
		if(!opCode.equals("8442"))
		{
%>
<script language="JavaScript">
	 rdShowMessageDialog("业务办理成功",2);
	 removeCurrentTab();
</script>

<%
}else
{
	%>
	<script language="JavaScript">
											   rdShowMessageDialog("业务办理成功! 下面将打印发票！");
											   var infoStr="";
											   infoStr+="<%=workNo%>  <%=work_name%>"+"       三城一网变更"+"|";//工号
											   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
											   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
											   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
											   infoStr+='<%=custName%>'+"|";
											   infoStr+=" "+"|";
											   infoStr+='<%=phoneNo1%>'+"|";
											   infoStr+=" "+"|";//协议号码
											   infoStr+=" "+"|";//手机型号
											   infoStr+="贰元"+"|";//合计金额(大写)
											   infoStr+="<%=WtcUtil.formatNumber(2,2)%>"+"|";//小写
											   infoStr+="变更手续费：  2"+"|";


												 infoStr+="<%=work_name%>"+"|";//开票人
												 infoStr+=" "+"|";//收款人
											  // location="/page/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/page/s1775/f1775_1.jsp";
											  var dirtPage="/npage/s8439/f8439_1.jsp?activePhone=<%=phoneNo1%>%26opCode=<%=opCode%>%26opName=<%=opName%>";
											   location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage;
											</script>
	<%
}

%>




<%}else{
	%>
	<script language="JavaScript">
	 rdShowMessageDialog("<%=code%>:<%=msg%>",0);
	 history.go(-1);
</script>
	<%}%> 
						
  					
