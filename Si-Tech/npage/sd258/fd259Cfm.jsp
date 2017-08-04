<%
  /*
   * 功能: 无线监控营销活动冲正 d259
   * 版本: 1.8.2
   * 日期: 2011/3/10
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%		
String work_no =(String)session.getAttribute("workNo");
String orgCode =(String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String ip_Addr =(String)session.getAttribute("ip_Addr");
String pass = (String)session.getAttribute("password");
String login_accept=request.getParameter("login_accept");
String phone_no=request.getParameter("phone_no");
String opName=request.getParameter("op_name");
String opNote=request.getParameter("opNote");
String old_accept=request.getParameter("old_accept");
String opcode=request.getParameter("opcode");
String paraAray[] = new String[10];

paraAray[0] = login_accept;
paraAray[1] = "01";
paraAray[2] = opcode;
paraAray[3] = work_no;
paraAray[4] = pass;
paraAray[5] = phone_no;
paraAray[6] = " ";
paraAray[7] = opNote;
paraAray[8] = old_accept;
paraAray[9] = ip_Addr;
%>
<wtc:service name="sd259Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/>
    <wtc:param value="<%=paraAray[2]%>"/>
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
    <wtc:param value="<%=paraAray[7]%>"/>
    <wtc:param value="<%=paraAray[8]%>"/>
    <wtc:param value="<%=paraAray[9]%>"/>    	
</wtc:service>
<wtc:array id="result1" scope="end" />

<%
    System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
		String retCodeForCntt = errCode ;
		String loginAccept = paraAray[0]; 
		
		if(errCode.equals("0")||errCode.equals("000000")){
				if(result1.length>0){
				  //loginAccept=result1[0][0];
				}
		}
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraAray[2] +"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+paraAray[1]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
			System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 	


	    if(errCode.equals("0")||errCode.equals("000000")){
         System.out.println("调用服务s6906Cfm in f6906Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
				<script language="JavaScript">
				   rdShowMessageDialog("提交成功!",2);
				   removeCurrentTab();
				</script>											  
<%	 	       	 	  	
 	     	}else{
			 			System.out.println("调用服务s6906Cfm in f6906Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
						%>   
						<script language="JavaScript">
							rdShowMessageDialog("操作失败!<%=errMsg%>",0);
							window.location="fd258_login.jsp?activePhone=<%=paraAray[5]%>&opCode=<%=opcode%>";
						</script>
<%
 			}
%>

