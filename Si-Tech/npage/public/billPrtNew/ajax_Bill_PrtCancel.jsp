<%
/********************
 *开发商: si-tech
 *create by hejwa @ 2016/11/21 11:14:09
 *发票项目
 ********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	request.setCharacterEncoding("GBK");
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);


	String retCode = "000000";
	String retMsg1="";
	String billhao="";
	String billdai="";
	String yzaccept="";


String loginNo = (String)session.getAttribute("workNo");
String loginNoPass = (String)session.getAttribute("password");
String ipAddrss = (String)session.getAttribute("ipAddr");
String groupId = (String)session.getAttribute("groupId");

String liushui = request.getParameter("liushui");
String opcode = request.getParameter("opcode");
String workno = request.getParameter("workno");
String timess = request.getParameter("time");
String phonenos = request.getParameter("phonenos");
String id_no = request.getParameter("id_no");
String contract_no = request.getParameter("contract_no");
String zhipiaohao = request.getParameter("zhipiaohao");
String fapiaohao = request.getParameter("fapiaohao");
String fapiaodai = request.getParameter("fapiaodai");
String sm_name = request.getParameter("sm_name");
String jinexiao = request.getParameter("jinexiao");
String jineda = request.getParameter("jineda");
String beizhu =workno+"进行发票预占取消";
String biaozhi = request.getParameter("biaozhi");
String zengzhisinfo = request.getParameter("zengzhisinfo");
String shuilv = request.getParameter("shuilv");
String shuie = request.getParameter("shuie");
String zhangqi = request.getParameter("zhangqi");
String yuzhanbiaozhi = request.getParameter("yuzhanbiaozhi");
String username = request.getParameter("username");
String huowuguige = request.getParameter("huowuguige");
String xinghao = request.getParameter("xinghao");
String fapiaoleixing =request.getParameter("fapiaoleixing");

String danwei = request.getParameter("danwei");
String shuliang = request.getParameter("shuliang");
String danjia = request.getParameter("danjia");
String regionCodesss = request.getParameter("regionCode");
String groupIdsss = request.getParameter("groupId");
String hongziflag = request.getParameter("hongziflag");


%>
        
<wtc:service name="scancelInDB" outnum="100"  retcode="errCode" retmsg="errMsg" routerKey="region" routerValue="<%=regionCode%>">
<wtc:param value="<%=liushui%>" />	
<wtc:param value="<%=opcode%>" />	
<wtc:param value="<%=workno%>" />	
<wtc:param value="<%=timess%>" />
<wtc:param value="<%=phonenos%>" />
<wtc:param value="<%=id_no%>" />	
<wtc:param value="<%=contract_no%>" />
<wtc:param value="<%=zhipiaohao%>" />	
<wtc:param value="<%=fapiaohao%>" />	
<wtc:param value="<%=fapiaodai%>" />	
<wtc:param value="<%=sm_name%>" />
<wtc:param value="<%=jinexiao%>" />	
<wtc:param value="<%=jineda%>" />
<wtc:param value="<%=beizhu%>" />	
<wtc:param value="5" />	
<wtc:param value="<%=zengzhisinfo%>" />	
<wtc:param value="<%=shuilv%>" />
<wtc:param value="<%=shuie%>" />	
<wtc:param value="<%=zhangqi%>" />
<wtc:param value="<%=username%>" />	
<wtc:param value="<%=fapiaoleixing%>" />		
<wtc:param value="<%=huowuguige%>" />	
<wtc:param value="<%=xinghao%>" />	
<wtc:param value="<%=danwei%>" />
<wtc:param value="<%=shuliang%>" />	
<wtc:param value="<%=danjia%>" />
<wtc:param value="<%=regionCodesss%>" />	
<wtc:param value="<%=groupIdsss%>" />	
<wtc:param value="<%=hongziflag%>" />		
</wtc:service>
<wtc:array id="baseArr" scope="end"/>

<%
System.out.println(" ------billnew-------------取消打印发票 调 scancelInDB 服务 1次发票释放------------------- ");
System.out.println("-------billnew-------------scancelInDB------errCode------>"+errCode);  
System.out.println("-------billnew-------------scancelInDB------errMsg------->"+errMsg);  
errMsg = errMsg.replaceAll("\"","”");

%>	

var response = new AJAXPacket();
response.data.add("retCode", "<%=errCode%>");
response.data.add("retMsg", "<%=errMsg%>");

core.ajax.receivePacket(response);
