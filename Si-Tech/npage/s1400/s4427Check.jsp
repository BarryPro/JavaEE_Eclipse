<%
/********************
version v2.0
开发商: si-tech
update:zhangnc@2009-07-21 补充生成电子托收单
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%
	String regionCode= (String)session.getAttribute("regCode");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");	

	//托收年月
	String TPrintDate = request.getParameter("TPrintDate");
	//工号
	String WorkNo =  request.getParameter("WorkNo");
	
	//取合同号    
	String DataCon0 = request.getParameter("TContract1");  
	String DataCon1 = request.getParameter("TContract2");  
	String DataCon2 = request.getParameter("TContract3");  
	String DataCon3 = request.getParameter("TContract4");  
	String DataCon4 = request.getParameter("TContract5");  
	String DataCon5 = request.getParameter("TContract6");  
	String DataCon6 = request.getParameter("TContract7");  
	String DataCon7 = request.getParameter("TContract8");  
	String DataCon8 = request.getParameter("TContract9");    
	String DataCon9 = request.getParameter("TContract10");   
	//取金额    
	String DataMon0 = request.getParameter("Money1");     
	String DataMon1 = request.getParameter("Money2");     
	String DataMon2 = request.getParameter("Money3");     
	String DataMon3 = request.getParameter("Money4");     
	String DataMon4 = request.getParameter("Money5");     
	String DataMon5 = request.getParameter("Money6");     
	String DataMon6 = request.getParameter("Money7");     
	String DataMon7 = request.getParameter("Money8");     
	String DataMon8 = request.getParameter("Money9");     
	String DataMon9 = request.getParameter("Money10");        
	//初始化     	
	String[] str = new String[10];   
//	String CountNo="";
	
	//拼串
	if((DataCon0!=null && !DataCon0.equals("")) && (DataMon0!=null && !DataMon0.equals(""))){
		str[0] = TPrintDate+"|"+DataCon0+"|"+WorkNo+"|"+DataMon0;}
	if((DataCon1!=null && !DataCon1.equals("")) && (DataMon1!=null && !DataMon1.equals(""))){
		str[1] = TPrintDate+"|"+DataCon1+"|"+WorkNo+"|"+DataMon1;}
	if((DataCon2!=null && !DataCon2.equals("")) && (DataMon2!=null && !DataMon2.equals(""))){
		str[2] = TPrintDate+"|"+DataCon2+"|"+WorkNo+"|"+DataMon2;}
	if((DataCon3!=null && !DataCon3.equals("")) && (DataMon3!=null && !DataMon3.equals(""))){
		str[3] = TPrintDate+"|"+DataCon3+"|"+WorkNo+"|"+DataMon3;}
	if((DataCon4!=null && !DataCon4.equals("")) && (DataMon4!=null && !DataMon4.equals(""))){
		str[4] = TPrintDate+"|"+DataCon4+"|"+WorkNo+"|"+DataMon4;}
	if((DataCon5!=null && !DataCon5.equals("")) && (DataMon5!=null && !DataMon5.equals(""))){
		str[5] = TPrintDate+"|"+DataCon5+"|"+WorkNo+"|"+DataMon5;}
	if((DataCon6!=null && !DataCon6.equals("")) && (DataMon6!=null && !DataMon6.equals(""))){
		str[6] = TPrintDate+"|"+DataCon6+"|"+WorkNo+"|"+DataMon6;}
	if((DataCon7!=null && !DataCon7.equals("")) && (DataMon7!=null && !DataMon7.equals(""))){
		str[7] = TPrintDate+"|"+DataCon7+"|"+WorkNo+"|"+DataMon7;}
	if((DataCon8!=null && !DataCon8.equals("")) && (DataMon8!=null && !DataMon8.equals(""))){
		str[8] = TPrintDate+"|"+DataCon8+"|"+WorkNo+"|"+DataMon8;}
	if((DataCon9!=null && !DataCon9.equals("")) && (DataMon9!=null && !DataMon9.equals(""))){
		str[9] = TPrintDate+"|"+DataCon9+"|"+WorkNo+"|"+DataMon9;}

	//String[][] result = new String[][]{};
    
	String[] inParas = new String[10];

	inParas[0]=str[0];
  inParas[1]=str[1];
  inParas[2]=str[2];
  inParas[3]=str[3];
  inParas[4]=str[4];
  inParas[5]=str[5];
  inParas[6]=str[6];
  inParas[7]=str[7];
  inParas[8]=str[8];
  inParas[9]=str[9];

	
	//callRemoteResultValue = viewBean.callService("0",null, "s4427Check", "2", inParas);
%>
	<wtc:service name="s4427Check" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>
		<wtc:param value="<%=inParas[6]%>"/>
		<wtc:param value="<%=inParas[7]%>"/>
		<wtc:param value="<%=inParas[8]%>"/>
		<wtc:param value="<%=inParas[9]%>"/>						
	</wtc:service>
	<wtc:array id="result" scope="end"/>
	
<%  
	String errorCode = "";
	String errorMsg = "";
	int resultSize = result.length;
	if (resultSize != 0) {
		errorCode = result[0][0];
		errorMsg = result[0][1];
	}
	System.out.println("errorCode============"+errorCode);
	System.out.println("errorMsg============"+errorMsg);
	
	retMsg1 = retMsg1.replaceAll("\r\n","</br>");  
	retMsg1 = retMsg1.replaceAll("\r","</br>"); 
	retMsg1 = retMsg1.replaceAll("\n","</br>"); 
	retMsg1 = retMsg1.replaceAll("\"","&quot;"); 
	retMsg1 = retMsg1.replaceAll("\'","&quot;"); 
	retMsg1 = retMsg1.replaceAll("\'","&quot;"); 
	
%>

var response = new AJAXPacket();
response.data.add("flag","1");
response.data.add("errorCode","<%=retCode1%>");
response.data.add("errorMsg","<%=retMsg1%>");
core.ajax.receivePacket(response);