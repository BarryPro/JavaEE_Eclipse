<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
 
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
 	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
 	System.out.println("gaopengSeeLog====loginAccept="+loginAccept);
 	String retCodeMy="";
 	String retMsgMy="";
 
 	String[] inParamsss1 = new String[2];
	
	inParamsss1[0] = 
	"select count(1) as mailzero from prodoffertmpsect a,product_offer_attr b where a.loginaccept  = :VloginAccept"
	+" and a.offertype = '10'"
	+" and a.optype = '1'"
	+" and a.offerid = b.offer_id"
	+" and b.offer_attr_seq = '80005'"
	+" and b.offer_attr_value = '0'";
	
	inParamsss1[1] = "VloginAccept="+loginAccept;
	
	
	String[] inParamsss2 = new String[2];
	inParamsss2[0] = "select count(1) as mailfive from prodoffertmpsect a,product_offer_attr b where a.loginaccept  = :VloginAccept"
	+" and a.offertype = '10'"
	+" and a.optype = '1'"
	+" and a.offerid = b.offer_id"
	+" and b.offer_attr_seq = '80005'"
	+" and b.offer_attr_value = '5'";
	inParamsss2[1] = "VloginAccept="+loginAccept;
	
	String[] inParamsss3 = new String[2];
	inParamsss3[0] = "select count(1) as miguzero from prodoffertmpsect a,product_offer_attr b where a.loginaccept  = :VloginAccept"
	+" and a.offertype = '10'"
	+" and a.optype = '1'"
	+" and a.offerid = b.offer_id"
	+" and b.offer_attr_seq = '80006'"
	+" and b.offer_attr_value = '0'";
	inParamsss3[1] = "VloginAccept="+loginAccept;
	
	String[] inParamsss4 = new String[2];
	inParamsss4[0] = "select count(1) as migufive from prodoffertmpsect a,product_offer_attr b where a.loginaccept  = :VloginAccept"
	+" and a.offertype = '10'"
	+" and a.optype = '1'"
	+" and a.offerid = b.offer_id"
	+" and b.offer_attr_seq = '80006'"
	+" and b.offer_attr_value = '5'";
	inParamsss4[1] = "VloginAccept="+loginAccept;
	
	
	String mailzero = "";
	String mailfive = "";
	String miguzero = "";
	String migufive = "";
	
	String retCode = "";
	String retMsg = "";
	
	

 
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>	
		</wtc:service>

<wtc:array id="amailzero" scope="end" />
	
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">			
		<wtc:param value="<%=inParamsss2[0]%>"/>
		<wtc:param value="<%=inParamsss2[1]%>"/>	
		</wtc:service>

<wtc:array id="amailfive" scope="end" />
	
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="1">			
		<wtc:param value="<%=inParamsss3[0]%>"/>
		<wtc:param value="<%=inParamsss3[1]%>"/>	
		</wtc:service>

<wtc:array id="amiguzero" scope="end" />
	
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4" outnum="1">			
		<wtc:param value="<%=inParamsss4[0]%>"/>
		<wtc:param value="<%=inParamsss4[1]%>"/>	
		</wtc:service>

<wtc:array id="amigufive" scope="end" />

<%


System.out.println("gaopengSeeLog===="+retCode1);
System.out.println("gaopengSeeLog===="+retCode2);
System.out.println("gaopengSeeLog===="+retCode3);
System.out.println("gaopengSeeLog===="+retCode4);
	if("000000".equals(retCode1) && "000000".equals(retCode2) && "000000".equals(retCode3) && "000000".equals(retCode4)){
		
		retCode = "000000";
		retMsg = "查询主资费信息成功！";
		
		System.out.println("gaopengSeeLog===="+Integer.parseInt(amailzero[0][0]));
		if(Integer.parseInt(amailzero[0][0]) > 0){
			mailzero = "Y";
		}else{
			mailzero = "N";
		}
		System.out.println("gaopengSeeLog===="+Integer.parseInt(amailfive[0][0]));
		if(Integer.parseInt(amailfive[0][0]) > 0){
			mailfive = "Y";
		}else{
			mailfive = "N";
		}
		System.out.println("gaopengSeeLog===="+Integer.parseInt(amiguzero[0][0]));
		if(Integer.parseInt(amiguzero[0][0]) > 0){
			miguzero = "Y";
		}else{
			miguzero = "N";
		}
		System.out.println("gaopengSeeLog===="+Integer.parseInt(amigufive[0][0]));
		if(Integer.parseInt(amigufive[0][0]) > 0){
			migufive = "Y";
		}else{
			migufive = "N";
		}
		
	}else{
		retCode = "000001";
		retMsg = "查询主资费信息失败！请联系管理员！";
	}

%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode %>");
response.data.add("retMsg","<%=retMsg %>");
response.data.add("mailzero","<%=mailzero %>");
response.data.add("mailfive","<%=mailfive %>");
response.data.add("miguzero","<%=miguzero %>");
response.data.add("migufive","<%=migufive %>");
core.ajax.receivePacket(response);