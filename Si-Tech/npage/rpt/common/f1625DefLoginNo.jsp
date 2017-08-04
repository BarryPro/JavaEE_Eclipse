<%
/********************
 * version v2.0
 * gaopeng 2013/11/26 15:30:53 双跨融合V网成员套餐受理
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("======gaopengSeeLog====== f1625DefLoginNo.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		String groupId = WtcUtil.repNull(request.getParameter("groupId"));
		
		String[] inParamsss1 = new String[2];
    inParamsss1[0] = "select * from (select rtrim(login_no),rtrim(login_name)   from dloginmsg where vilid_flag='1' and group_id =:groupId order by login_no asc) where rownum = 1 ";
    inParamsss1[1] = "groupId="+groupId;
    
    System.out.println("======gaopengSeeLog====== f1625DefLoginNo.jsp ==========");
    
    String[] inParamsss2 = new String[2];
    inParamsss2[0] = "select * from (select rtrim(login_no),rtrim(login_name)   from dloginmsg where vilid_flag='1' and group_id =:groupId order by login_no desc) where rownum = 1 ";
    inParamsss2[1] = "groupId="+groupId;
		
		System.out.println("======gaopengSeeLog====== f1625DefLoginNo.jsp ==========");
		
		String begin_login = "";
		String begin_name ="";
		String end_login = "";
		String end_name ="";
		
		String retCode = "";
		String retMsg = "";
		
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="2">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>
	<wtc:array id="result1" scope="end" />
		
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2ss" retmsg="retMsg2ss" outnum="2">			
		<wtc:param value="<%=inParamsss2[0]%>"/>
		<wtc:param value="<%=inParamsss2[1]%>"/>	
	</wtc:service>
	<wtc:array id="result2" scope="end" />	
<%

System.out.println("======gaopengSeeLog====== f1625DefLoginNo.jsp ==========result1.length="+result1.length);
System.out.println("======gaopengSeeLog====== f1625DefLoginNo.jsp ==========result2.length="+result2.length);

		if(result1.length > 0 && "000000".equals(retCode1ss)){
			begin_login = result1[0][0];
			begin_name = result1[0][1];
			
		}
		if(result2.length > 0 && "000000".equals(retCode2ss)){
			end_login = result2[0][0];
			end_name = result2[0][1];
		}
		
		if(!"000000".equals(retCode1ss) || !"000000".equals(retCode2ss)){
			retCode = "444444";
			retMsg = "调用查询服务异常";
		}
		else{
			retCode = "000000";
			retMsg = "查询成功";
		}
		
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode %>");
response.data.add("retMsg","<%=retMsg %>");
response.data.add("begin_login","<%=begin_login%>");
response.data.add("begin_name","<%=begin_name%>");
response.data.add("end_login","<%=end_login%>");
response.data.add("end_name","<%=end_name%>");
core.ajax.receivePacket(response);