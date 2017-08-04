<%
  /*
   * 功能: 获得座席密码
　 * 版本: 1.0.0
　 * 日期: 2009/04/13
　 * 作者: fangyuan
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

//tancf 20100201
 String subccno= request.getParameter("ccno");


	String workNo = (String)session.getAttribute("workNo");	// boss工号代码

	String sql="select a.password from dlogincfg a where a.login_no = :workNo and substr(a.subccno,1,1) = :subccno";
	myParams = "workNo="+workNo+",subccno="+subccno ; ;
	System.out.println("workNo*******:["+workNo+"]");
	System.out.println("subccno*******:["+subccno+"]");
	System.out.println("sql*******:"+sql);
	
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="3">
	<wtc:param value="<%=sql%>"/>
	<wtc:param value="<%=myParams%>"/>	
</wtc:service>
<wtc:array id="rows" scope="end" />
	var response = new AJAXPacket();
<%
	String passwd ="";
	if(rows.length>0){
	passwd = rows[0][0];
 
%>
response.data.add("retCode","<%=retCode%>");
response.data.add("passwd","<%=passwd%>");

<%
	}
%>

core.ajax.receivePacket(response);