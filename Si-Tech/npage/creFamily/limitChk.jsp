<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%

System.out.println("------------------------------limitChk.jsp---------------------------------------");  
  //Çå³ý»º´æ
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	String workNo = (String)session.getAttribute("workNo");
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String iOprType= WtcUtil.repNull(request.getParameter("iOprType"));
	String prodId = WtcUtil.repNull(request.getParameter("prodId"));     
	String vQtype = WtcUtil.repNull(request.getParameter("vQtype"));  
	String idNo =   WtcUtil.repNull(request.getParameter("idNo"));  
	String retCo="";
	String retMg="";
	
	System.out.println("##############################");
	System.out.println("###workNo==="+workNo);
	System.out.println("###opCode==="+opCode);
	System.out.println("###prodId==="+prodId);
	System.out.println("###iOprType==="+iOprType);
	System.out.println("###vQtype==="+vQtype);
	System.out.println("###idNo==="+idNo);
	System.out.println("##############################");
%>

	<wtc:utype name="sPMQOfferlimit" id="retVal" scope="end" >
		<wtc:uparams>
				<wtc:uparam value="<%=workNo%>" type="STRING" />
				<wtc:uparam value="<%=opCode%>" type="STRING" />
				<wtc:uparam value="<%=prodId%>" type="LONG" />
				<wtc:uparam value="<%=iOprType%>" type="INT" />
				<wtc:uparam value="<%=vQtype%>" type="STRING" />
				<wtc:uparam value="<%=idNo%>" type="STRING" />
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
				retCo=retVal.getValue("2.0");
				retMg=retVal.getValue("2.1");
		}else
		{
				retCo=retCode;
				retMg=retMsg;
		}	
System.out.println("===retCo1=="+retCo);		
System.out.println("===retMg1=="+retMg);
out.println(retCo+ "@" + retMg);
%>	