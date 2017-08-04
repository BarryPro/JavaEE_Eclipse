<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="import java.text.SimpleDateFormat;"%>

<%
		//----------------申请订购新的基本销售品-----------------------

		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));
		String optypes = WtcUtil.repNull(request.getParameter("optypes"));
		String workNo = (String)session.getAttribute("workNo");
		/* liujian add workNo and password 2012-4-5 15:59:15 begin */
		String password = (String) session.getAttribute("password");
		/* liujian add workNo and password 2012-4-5 15:59:15 end */
		String opCode = request.getParameter("opCode");
		String groupId = (String)session.getAttribute("groupId");
		  String regionCode = (String)session.getAttribute("regCode");
		String current_timeNAME= new SimpleDateFormat("yyyyMMddhhmmssSSS", Locale.getDefault()).format(new java.util.Date());
		
				String offeridstr2 = WtcUtil.repNull(request.getParameter("offeridstr2"));
		String statustr2 = WtcUtil.repNull(request.getParameter("statustr2"));
		String typestr2 = WtcUtil.repNull(request.getParameter("typestr2"));
	
		  	String strArray="var retAry;";  


		String flagTD="false";
		System.out.println("--------------offerId----------------"+offerId);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept" />
			<wtc:service name="sQuitOfferInst" routerKey="region" routerValue="<%=regionCode%>" outnum="11" retmsg="msg2" retcode="code2">
    		  <wtc:param value="<%=loginAccept%>"/>
    		  <wtc:param value="01"/>
    		  <wtc:param value="g538"/>
    		  <wtc:param value="<%=workNo%>"/>
    		  <wtc:param value="<%=password%>"/>
    		  <wtc:param value="<%=phoneNo%>"/>
					<wtc:param value=""/>
					<wtc:param value="<%=offerId%>"/>
					<wtc:param value="0"/>
    	</wtc:service>
    	<wtc:array id="result_t" scope="end"/>


<% 

	String retCode1="";
	String retMsg1="";

		retCode1 = code2;
		retMsg1  = msg2.replaceAll("\\n"," ");
		strArray = WtcUtil.createArray("retAry",result_t.length);
	%>
		 
	  <%=strArray%>	
	<%
	if(retCode1.equals("000000")){
		int retValNum = result_t.length;
	System.out.println("@@@@---sSearShortMsgHis---------------retValNum------"+retValNum);	

		for(int i=0;i<retValNum;i++){
	System.out.println("=result_t[i][0]"+result_t[i][0]);	
	System.out.println("=result_t[i][1]"+result_t[i][1]);	
	System.out.println("=result_t[i][2]"+result_t[i][2]);	
	System.out.println("=result_t[i][3]"+result_t[i][3]);	
	System.out.println("=result_t[i][4]"+result_t[i][4]);	
	System.out.println("=result_t[i][5]"+result_t[i][5]);	
	System.out.println("=result_t[i][6]"+result_t[i][6]);
%>
		retAry[<%=i%>][0] = "<%=result_t[i][0]%>";
		retAry[<%=i%>][1] = "<%=result_t[i][1]%>";
		retAry[<%=i%>][2] = "<%=result_t[i][2]%>";
		retAry[<%=i%>][3] = "<%=result_t[i][3]%>";
		retAry[<%=i%>][4] = "<%=result_t[i][4]%>";
		retAry[<%=i%>][5] = "<%=result_t[i][5]%>";
		retAry[<%=i%>][6] = "<%=result_t[i][6]%>";
		retAry[<%=i%>][7] = "<%=current_timeNAME%>";
<%			
			}
		}


	System.out.println("----------------end=--------------");
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode1%>");
response.data.add("errorMsg","<%=retMsg1%>");
response.data.add("squeryofferId","<%=offerId%>");
response.data.add("retAry",retAry);
core.ajax.receivePacket(response);
