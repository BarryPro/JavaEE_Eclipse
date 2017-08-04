<%
  /*
   * 功能: 无线监控设备营销活动申请 d258
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
String work_name =(String)session.getAttribute("workName");
String orgCode =(String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String ip_Addr =(String)session.getAttribute("ip_Addr");
String login_accept =request.getParameter("login_accept");
String pass = (String)session.getAttribute("password");
String cust_name=request.getParameter("cust_name");
String paper_code=request.getParameter("paper_code");
String prepay_fee=request.getParameter("paper_money");
String award_code=request.getParameter("award_code");
String award_detailcode=request.getParameter("award_detailcode");
String gift_code=request.getParameter("gift_code");
String consume_term=request.getParameter("consume_term");
String gift_name=request.getParameter("gift_name");
String phone_no = request.getParameter("phone_no");
String opNote = request.getParameter("opNote");
String opcode = request.getParameter("opcode");
String opName=request.getParameter("op_name");
String paraAray[] = new String[16];

paraAray[0] =login_accept;
paraAray[1] ="01";
paraAray[2] = opcode;
paraAray[3] = work_no;
paraAray[4] = pass;
paraAray[5] = phone_no;
paraAray[6] = "";
paraAray[7] = paper_code;
paraAray[8] = award_code;
paraAray[9] = award_detailcode;
paraAray[10] = gift_code;
paraAray[11] = prepay_fee;
paraAray[12] = consume_term;
paraAray[13] = opNote;
paraAray[14] = ip_Addr;
paraAray[15] = gift_name;
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[0]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[1]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[2]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[3]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[4]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[5]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[6]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[7]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[8]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[9]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[10]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[11]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[12]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[13]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[14]);
System.out.println("%%%%%%%paraAray[0]%%%%%%%%"+paraAray[15]);
%>

			
<wtc:service name="sd258Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
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
<wtc:param value="<%=paraAray[10]%>"/>
<wtc:param value="<%=paraAray[11]%>"/>
<wtc:param value="<%=paraAray[12]%>"/>
<wtc:param value="<%=paraAray[13]%>"/>	
<wtc:param value="<%=paraAray[14]%>"/>
<wtc:param value="<%=paraAray[15]%>"/>		
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
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraAray[2] +"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+paraAray[1]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
	System.out.println("url="+url);
%>
<jsp:include page="<%=url%>" flush="true" />
<%
System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 	
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

