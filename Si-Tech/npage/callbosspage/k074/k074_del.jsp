<%
  /*
   * 功能: 逻辑删除系统版本维护记录
　 * 版本: 1.0.0
　 * 日期: 2009/10/12
　 * 作者: jiangbing
　 * 版权: sitech
   *update:
　*/
%>
<%
	//String opCode = "K074";
	//String opName = "系统版本维护记录";
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	 String kf_longin_no = (String) session.getAttribute("workNo");
	 String workName = (String)session.getAttribute("workName");
   String updatelog_id = WtcUtil.repNull(request.getParameter("updatelog_id"));
/** old sql : String sqlTemp = "update dcallupdatelog set is_del='Y',op_date=sysdate,login_no='"+kf_longin_no+"',login_name='"+workName+"' where updatelog_id='"+updatelog_id+"'";
*/
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String sqlTemp = "update dcallupdatelog set is_del='Y',op_date=sysdate,login_no= :v1 ,login_name= :v2 where updatelog_id= :v3 ";

%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlTemp%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=kf_longin_no%>"/>
	<wtc:param value="<%=workName%>"/>
	<wtc:param value="<%=updatelog_id%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
<%
   out.clear();
   if("000000".equals(retCode)){
   	out.print("Y");
   }else{
   	out.print("N");
   }
%>