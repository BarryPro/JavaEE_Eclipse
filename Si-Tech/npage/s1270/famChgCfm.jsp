<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
 		String curnentTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date()); //当前时间
		String nextMonth="";
		String workNo = (String)session.getAttribute("workNo");
		String opCode = WtcUtil.repNull(request.getParameter("opCode"));
		String offerId= WtcUtil.repNull(request.getParameter("offerId"));	
	  String effTime= WtcUtil.repNull(request.getParameter("effTime"))+" 00:00:00";	
    String expTime= WtcUtil.repNull(request.getParameter("expTime"))+" 00:00:00";	
    String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));	
    String servId      = WtcUtil.repNull(request.getParameter("servId"));	
    
		String[] AllProdInfoAry = new String[]{};	//取所有成员信息
		if(!WtcUtil.repNull(request.getParameter("offerInfoAry")).equals("")){
			AllProdInfoAry = request.getParameterValues("offerInfoAry");
		}
		Calendar c = Calendar.getInstance();
		c.add(Calendar.MONTH, 1);
		c.set(Calendar.DAY_OF_MONTH, 1);
		Date cc = c.getTime();
		nextMonth = new java.text.SimpleDateFormat("yyyyMMdd 00:00:00").format(cc); 
		
	System.out.println("workNo ="+workNo );
	System.out.println("loginAccept ="+loginAccept );
	System.out.println("servId ="+servId );
	System.out.println("opCode ="+opCode );
  System.out.println("offerId ="+offerId );
	System.out.println("effTime ="+effTime );
	System.out.println("expTime ="+expTime );
%>

<wtc:utype name="sSetGrpMem" id="retVal" scope="end" >
			<wtc:uparam value="<%=workNo%>" type="string"/>
			<wtc:uparam value="<%=loginAccept%>" type="long"/>
			<wtc:uparam value="<%=servId%>" type="long"/>
			<wtc:uparam value="<%=opCode%>" type="string"/>
			<wtc:uparam value="<%=offerId%>" type="int"/>	
			<wtc:uparam value="<%=effTime%>" type="string"/>		
			<wtc:uparam value="<%=expTime%>" type="string"/>	
<wtc:uparams name="offerInfoList" iMaxOccurs="1">	
<%
for(int i=0;i<AllProdInfoAry.length;i++){		
		String[] prodInfoAry = new String[]{};
		prodInfoAry = AllProdInfoAry[i].split("\\|");
		System.out.println("phone_no["+i+"]="+prodInfoAry[3]);
%>
		<wtc:uparam value="<%=prodInfoAry[3]%>" type="string"/>
<%
		}
%>		
	</wtc:uparams>
</wtc:utype>

<%

	String retrunCode=String.valueOf(retVal.getValue(0));
	String returnMsg  =retVal.getValue(1).replaceAll("\\n","");
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	System.out.println(logBuffer.toString());
	
	System.out.println(retrunCode+"===ret=="+returnMsg);	
%>
var response = new AJAXPacket();
response.data.add("errorCode","<%=retrunCode%>");
response.data.add("errorMsg","<%=returnMsg%>");
core.ajax.receivePacket(response);      