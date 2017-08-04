<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.10
 模块：合作伙伴业务申请
********************/
%>


<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>

<%
	String regCode = (String)session.getAttribute("regCode");
	String bizCodeAdd = request.getParameter("bizCodeAdd");
	//String sq2 = "select max(substr(bizCodeAdd,9,2)) from sBillSpCode where bizCodeAdd like '"+bizCodeAdd+"%'";
	//String sq2="select max(substr(bizcode,9,2)) from dbaseecsibusi where bizcode like '"+bizCodeAdd+"%'";
	/* diling update for 行业网关接口升级项目@2014/1/23  */
	/*String sq2 = "select max(substr(BIZCODEADD,9,2)) from sbillspcode where BIZCODEADD like '"+bizCodeAdd+"%'";*/
	String sq2 = "select max(a) from(select max(substr(BIZCODEADD,9,2)) a from sbillspcode where BIZCODEADD like '"+bizCodeAdd+"%' union select max(substr(BIZCODEADD,9,2)) a from dbvipadm.sbillspcodeexit  where  BIZCODEADD like '"+bizCodeAdd+"%')";
	//ArrayList noArr = co.spubqry32("1",sq2);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=sq2%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%
	String[][] nott = result1;
	System.out.println("nott============"+nott.length);
	if(nott[0][0].trim().equals("")){
		nott = new String[1][1];
		nott[0][0]="00";
	}
	
	
%>
var response = new AJAXPacket();
response.data.add("nott","<%=nott[0][0]%>");
response.data.add("flag","10");
core.ajax.receivePacket(response);

