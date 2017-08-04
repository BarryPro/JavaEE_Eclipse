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
String module_id = WtcUtil.repNull(request.getParameter("module_id"));
String version_no = WtcUtil.repNull(request.getParameter("version_no"));
String version_remark = WtcUtil.repNull(request.getParameter("version_remark"));
String context = WtcUtil.repNull(request.getParameter("context"));
String sqlTemp = "";
String op_type = WtcUtil.repNull(request.getParameter("op_type"));

String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);

if(op_type.equals("add")){
   	/**sqlTemp = "insert into dcallupdatelog (updatelog_id,MODULE_ID,VERSION_NO,VERSION_REMARK,CONTEXT,is_del,op_date,login_no,type,login_name)" 
	+ " values (seq_dcallupdatelog.nextval,'"+module_id+"','"+version_no+"','"+version_remark+"','"+context+"','N',sysdate,'"+kf_longin_no+"','A','"+workName+"')";
   	*/
   	sqlTemp = "insert into dcallupdatelog (updatelog_id,MODULE_ID,VERSION_NO,VERSION_REMARK,CONTEXT,is_del,op_date,login_no,type,login_name)" 
   		+ " values (seq_dcallupdatelog.nextval, :v1, :v2, :v3, :v4,'N',sysdate, :v5,'A', :v6)";
   	%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
   	<wtc:param value="<%=sqlTemp%>"/>
   	<wtc:param value="dbchange"/>
   	<wtc:param value="<%=module_id%>"/>
	<wtc:param value="<%=version_no%>"/>
	<wtc:param value="<%=version_remark%>"/>
	<wtc:param value="<%=context%>"/>
	<wtc:param value="<%=kf_longin_no%>"/>
	<wtc:param value="<%=workName%>"/>
</wtc:service>
   	
   	<%
   	}else{
   	/**sqlTemp = "update dcallupdatelog set MODULE_ID='"+module_id+"',VERSION_NO='"+version_no+"',VERSION_REMARK='"+version_remark+"',CONTEXT='"+context+"',op_date=sysdate,login_no='"+kf_longin_no+"',login_name='"+workName+"' where updatelog_id='"+updatelog_id+"'";
   	*/
   	sqlTemp = "update dcallupdatelog set MODULE_ID= :v1,VERSION_NO= :v2,VERSION_REMARK= :v3,CONTEXT= :v4,op_date=sysdate,login_no= :v5,login_name= :v6 where updatelog_id= :v7";
   	%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
   	<wtc:param value="<%=sqlTemp%>"/>
   	<wtc:param value="dbchange"/>
   	<wtc:param value="<%=module_id%>"/>
	<wtc:param value="<%=version_no%>"/>
	<wtc:param value="<%=version_remark%>"/>
	<wtc:param value="<%=context%>"/>
	<wtc:param value="<%=kf_longin_no%>"/>
	<wtc:param value="<%=workName%>"/>
	<wtc:param value="<%=updatelog_id%>"/>
</wtc:service>
   	<%
}
%>
<wtc:array id="retRows"  scope="end"/>	
<%
   System.out.println(sqlTemp);
   System.out.println(retCode);
   out.clear();
   if("000000".equals(retCode)){
   	out.print(op_type+"|Y");
   }else{
   	out.print(op_type+"|N");
   }
%>