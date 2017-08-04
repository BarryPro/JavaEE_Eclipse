<%
/********************
 version v2.0
开发商 si-tech
update hejw@2009-1-7
********************/
%>


<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 

 
	String phoneNo = request.getParameter("phoneNo");
	String UsedPoint = request.getParameter("Mark_Subtract");
	String FavourCount = "1";
	String FavourCode = "JFHL";
	String Op_note = request.getParameter("do_note");
	String Op_code = "126j";
	String Login_accept = request.getParameter("loginAccept");
	String GiftCode = request.getParameter("Gift_Code");
	String LoginAccept = request.getParameter("oPayAccept");

	String regionCode=(String)session.getAttribute("regCode");

%>


<%
    //ArrayList arr = (ArrayList)session.getAttribute("allArr");

    //String[][] baseInfo = (String[][])arr.get(0);
    //String[][] pass = (String[][])arr.get(4);
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    
	
	
   String [] inParas = new String[10];
   inParas[0]  = phoneNo;
   inParas[1]  = workno;
   inParas[2]  = UsedPoint;
   inParas[3]  = FavourCount;
   inParas[4]  = FavourCode;
   inParas[5]  = Op_code;
   inParas[6]  = Op_note;
   inParas[7]  = Login_accept;
   inParas[8]  = GiftCode;
   inParas[9]  = LoginAccept;
   
   System.out.println("phoneNo="+phoneNo);
   System.out.println("workno="+workno);
   System.out.println("UsedPoint="+UsedPoint);
   System.out.println("FavourCount="+FavourCount);
   System.out.println("FavourCode="+FavourCode);
   System.out.println("Op_code="+Op_code);
   System.out.println("Op_note="+Op_note);
   System.out.println("Login_accept="+Login_accept);
   System.out.println("GiftCode="+GiftCode);
   System.out.println("LoginAccept="+LoginAccept);

   //ScallSvrViewBean viewBean = new ScallSvrViewBean();//实例化viewBean
   //CallRemoteResultValue  value = null;
   //value  = viewBean.callService("2",phoneNo,"s126jCfm","2", inParas); 
   //String result[][] =  null;
	
   

  

	%>
   <wtc:service name="s126jCfm" outnum="2" retmsg="msg" retcode="return_code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=inParas[0]%>" />
	<wtc:param value="<%=inParas[1]%>" />
	<wtc:param value="<%=inParas[2]%>" />
	<wtc:param value="<%=inParas[3]%>" />
	<wtc:param value="<%=inParas[4]%>" />
	<wtc:param value="<%=inParas[5]%>" />
	<wtc:param value="<%=inParas[6]%>" />
	<wtc:param value="<%=inParas[7]%>" />
	<wtc:param value="<%=inParas[8]%>" />
	<wtc:param value="<%=inParas[9]%>" />
		</wtc:service>
		<wtc:array id="result" scope="end"/>
	<%
 	if (return_code1.equals("000000"))
	{
     String return_code = result[0][0];
     String return_msg = result[0][1];
 String error_msg = return_code;
%>
  <SCRIPT LANGUAGE="JavaScript">
		<!--
			rdShowMessageDialog("操作成功!");
			window.location.href="f126j_1.jsp?activePhone=<%=phoneNo%>";

		//-->
		</SCRIPT>

<%

}else{%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			rdShowMessageDialog("错误!<br>错误代码：'<%=return_code1%>'，错误信息：'<%=msg%>'。",0);
			window.location.href="f126j_1.jsp?activePhone=<%=phoneNo%>";

		//-->
		</SCRIPT>
<%}%>



<%
String url ="/npage/contact/upCnttInfo.jsp?opCode="+"126j"+"&retCodeForCntt="+return_code1+"&opName="+"积分换礼"+"&workNo="+workno+"&loginAccept="+Login_accept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+msg+"&opBeginTime="+opBeginTime; 
%>

<jsp:include page="<%=url%>" flush="true" />