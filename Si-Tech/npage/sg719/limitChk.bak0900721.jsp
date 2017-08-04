<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
  //Çå³ý»º´æ
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	String workNo = (String)session.getAttribute("workNo");
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
System.out.println("======opCode====="+opCode);	      
	String phoneNo= WtcUtil.repNull(request.getParameter("phoneNo"));
System.out.println("======phoneNo====="+phoneNo);	
	String prodId = WtcUtil.repNull(request.getParameter("prodId"));     
System.out.println("======prodId====="+prodId);
	String retCo="";
	String retMg="";

%>
	<wtc:utype name="sChkProdLimt" id="retVal" scope="end" >
				<wtc:uparam value="<%=workNo%>" type="STRING" />
				<wtc:uparam value="<%=opCode%>" type="STRING" />
				<wtc:uparam value="<%=phoneNo%>" type="LONG" />
				<wtc:uparams name="prod" iMaxOccurs="1">	
							<wtc:uparam value="1" type="STRING" />
							<wtc:uparam value="PRODUCTID" type="STRING" />
							<wtc:uparam value="<%=prodId%>" type="STRING" />
				</wtc:uparams>	
	</wtc:utype>	
<%
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	System.out.println(logBuffer.toString());
		String retCode=retVal.getValue(0);
		String retMsg=retVal.getValue(1);
		if(retCode.equals("0"))
		{
				retCo=retVal.getValue("2.0.0");
				retMg=retVal.getValue("2.0.1");
		}else
		{
				retCo=retCode;
				retMg=retMsg;
		}	
System.out.println("===retCo=="+retCo);		
System.out.println("===retMg=="+retMg);
out.println(retCo+ "@" + retMg);
%>	