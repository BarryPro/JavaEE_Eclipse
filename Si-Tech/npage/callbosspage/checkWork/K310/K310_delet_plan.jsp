<%
  /*
   * 功能: 总计划删除ajax数据操作
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者:
　 * 版权: sitech
   *
 　*/
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%

//通知发送记录删除
//获取参数
String workNo = (String)session.getAttribute("workNo");
String msg_id=request.getParameter("msg_id");
String contect_id=request.getParameter("contect_id");
String object_id=request.getParameter("object_id");
String strDeldqcplan="delete from dqcplan where PLAN_ID= :v1 and content_id=:v2 and object_id=:v3&&"+msg_id+"^"+contect_id+"^"+object_id ;
String strDelDQCLOGINPLAN="delete from DQCLOGINPLAN where PLAN_ID= :v1 and content_id=:v2 and object_id=:v3&&"+msg_id+"^"+contect_id+"^"+object_id ;
String strDelDQCCHECKLOGINPLAN="delete from DQCCHECKLOGINPLAN where PLAN_ID= :v1 &&"+msg_id; 
List sqlList=new ArrayList();
String[] sqlArr = new String[]{};
sqlList.add(strDeldqcplan);
sqlList.add(strDelDQCLOGINPLAN);
sqlList.add(strDelDQCCHECKLOGINPLAN);
sqlArr = (String[])sqlList.toArray(new String[3]);
//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);