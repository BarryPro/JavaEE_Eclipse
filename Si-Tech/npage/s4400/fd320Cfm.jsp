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
String pass = (String)session.getAttribute("password");
String opName = (String)session.getAttribute("opName");

String phone_no=request.getParameter("phoneNo");
String cust_pass =request.getParameter("passwd");
String old_accept=request.getParameter("old_loginAccept");
String op_code=request.getParameter("opCode");

String paraAray[] = new String[8];

paraAray[0]="";
paraAray[1]="10";
paraAray[2]=op_code;
paraAray[3]=work_no;
paraAray[4]=pass;	
paraAray[5]=phone_no;
paraAray[6]=cust_pass;
paraAray[7]=old_accept;
%>
<wtc:service name="sD320Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/>
    <wtc:param value="<%=paraAray[2]%>"/>
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
    <wtc:param value="<%=paraAray[7]%>"/> 	
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
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraAray[2] +"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+paraAray[5]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
			System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 	


	    if(errCode.equals("0")||errCode.equals("000000")){
         System.out.println("sD320Cfm in fd320Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
				<script language="JavaScript">
				   rdShowMessageDialog("提交成功!",2);
					 window.location.href = "fd320.jsp?phoneNo=<%=paraAray[5]%>&passwd=<%=paraAray[6]%>&disPlay=yes";
				</script>											  
<%	 	       	 	  	
 	     	}else{
			 			System.out.println("sD320Cfm in fd320Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
			 			System.out.println(errCode+"   errCode    "+errMsg+"    errMsg");
						%>   
						<script language="JavaScript">
							rdShowMessageDialog("操作失败!<%=errMsg%>",0);
							window.location.href = "fd320.jsp?phoneNo=<%=paraAray[5]%>&passwd=<%=paraAray[6]%>&disPlay=yes";
						</script>
<%
 			}
%>

