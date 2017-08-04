<%
  /*
   * 功能: 计划明细修改ajax数据操作
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: tancf
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
String workNo = (String)session.getAttribute("workNo");
String contentMore="";
String primarykey=request.getParameter("primarykey");
String[] sqlArr = new String[]{};
List sqlList=new ArrayList();
String MIN_TIME=request.getParameter("MIN_TIME")==null?"":request.getParameter("MIN_TIME");
String MAX_TIME=request.getParameter("MAX_TIME")==null?"":request.getParameter("MAX_TIME");
String PLAN_TIME=request.getParameter("PLAN_TIME")==null?"":request.getParameter("PLAN_TIME");
String ALERT_DAYS=request.getParameter("ALERT_DAYS")==null?"":request.getParameter("ALERT_DAYS");
String ALERT_VALUE=request.getParameter("ALERT_VALUE")==null?"":request.getParameter("ALERT_VALUE");

if(!MIN_TIME.equals(""))
{
contentMore=contentMore+"MIN_TIME='"+MIN_TIME+"',";
}
if(!MAX_TIME.equals(""))
{
contentMore=contentMore+"MAX_TIME='"+MAX_TIME+"',";
}
if(!PLAN_TIME.equals(""))
{
contentMore=contentMore+"PLAN_TIME='"+PLAN_TIME+"',";
}
if(!ALERT_DAYS.equals(""))
{
contentMore=contentMore+"ALERT_DAYS='"+ALERT_DAYS+"',";
}

if(!ALERT_VALUE.equals(""))
{
contentMore=contentMore+"ALERT_VALUE='"+ALERT_VALUE+"',";
}

contentMore=contentMore+"UPDATE_LOGIN_NO='"+workNo+"',";
contentMore=contentMore+"UPDATE_DATE=sysdate ";
String strDelDQCLOGINPLANTemp="update DQCLOGINPLAN set "+contentMore;
String where=" where trim(plan_id) || '_' || trim(object_id) || '_' || trim(content_id) || '_' || trim(login_no) = :v1&&"+primarykey;

sqlList.add(strDelDQCLOGINPLANTemp+where);



int totalNum=1;

sqlArr = (String[])sqlList.toArray(new String[totalNum]);
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