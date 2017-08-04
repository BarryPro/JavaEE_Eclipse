<%
   /*
   * 功能: 查询用户推荐营销活动
　 * 版本: v1.0
　 * 日期: 2008年8月28日
　 * 作者: zhouzy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>

<%@ include file="/npage/common/portalInclude.jsp" %>

<%
     String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
     String phone_no = (String)request.getParameter("activePhone");
     String sql="select a.action_id ,b.action_name,to_char(b.PLAN_START_DATE,'yyyymmdd')||'--'||to_char(b.PLAN_END_DATE,'yyyymmdd'),b.action_desc,c.Priority_name from dbsalesadm.dFndCustomerInfo a,dbsalesadm.dFndSaleAction b,dbsalesadm.sFndPriOrityCode c,dbsalesadm.dFndAcChannelRel d where  a.action_id=b.action_id and a.cust_group_id=b.cust_group_id and a.cust_group_id=d.cust_group_id and a.action_id=d.action_id and b.priority_code=c.Priority_code and a.phone_no like '%"+phone_no+"%' and b.action_status='0004' and d.contact_channel_type='906' order by b.priority_code asc";
		 String sqlBuf="";
		 String sqlBuf2="";
		 System.out.println("sql:="+sql);
		 String sqlBuf3=" select cust_group_id from dbsalesadm.dFndCustomerInfo where phone_no like '%"+phone_no+"%'";
		 int trFlag=0;
%>
<wtc:pubselect name="sPubSelect" outnum="1">
   <wtc:sql><%=sqlBuf3%></wtc:sql>
</wtc:pubselect>
<wtc:array id="groupResult" scope="end"/>
<wtc:pubselect name="sPubSelect" outnum="5">
    <wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<div  id="form">
	<table width="100%" cellpadding="0" cellspacing="0">
	    
	    
<%
	System.out.println("result.length:="+result.length);
	if(result.length>0){
	for(int i=0;i<result.length;i++){
	System.out.println("result[i][0]:="+result[i][0]);
	sqlBuf="select b.channel_type_name from dbsalesadm.dFndCustExecCircs a,dbsalesadm.sFndChannelType b where a.CONTACT_CHANNEL_type=b.channel_type_code and a.phone_no like '%"+phone_no+"%' and a.action_id='"+result[i][0]+"' and a.is_local_transact='0'";
	sqlBuf2="select 1 from dFndSaleAshCust where phone_no like '%"+phone_no+"%' and action_id='"+result[i][0]+"'";
	System.out.println("sqlBuf:="+sqlBuf);
	System.out.println("sqlBuf2:="+sqlBuf2);
%>
<wtc:pubselect name="sPubSelect" outnum="1">
    <wtc:sql><%=sqlBuf%></wtc:sql>
  </wtc:pubselect>
<wtc:array id="result2" scope="end"/>
<wtc:pubselect name="sPubSelect" outnum="1">
    <wtc:sql><%=sqlBuf2%></wtc:sql>
  </wtc:pubselect>
<wtc:array id="result3" scope="end"/>  	
<%
System.out.println("result3.length:========="+result3.length);
System.out.println("result2.length:========="+result2.length);
System.out.println("trFlag1111111111:========="+trFlag);
if(result3.length==0&&result2.length==0){
System.out.println("trFlag2222222222:========="+trFlag);
if(trFlag==0){
%>
<tr> 
	<th>营销活动名称</th>
	<th>活动时间</th> 
	<th>任务描述</th> 
	<th>优先级</th>
	<th>执行渠道</th>
</tr>
<%trFlag++;}%>
		<tr>
		<td><a href=javascript:parent.parent.openPage("2","4822","营销活动执行反馈","s4823/f4822.jsp?phoneNo=<%=phone_no.trim()%>&saleCode=<%=result[i][0]%>&reFlag=0","") ><span class='orange'><%=result[i][1]%></span></a></td>
		<td><%=result[i][2]%>&nbsp</td>
		<td><%=result[i][3]%>&nbsp</td>
		<td><%=result[i][4]%>&nbsp</td>
		<td>
<%
if(groupResult.length>0){
String groupSql="select b.channel_type_name from dbsalesadm.dFndAcChannelRel a,dbsalesadm.sFndChannelType b where a.contact_channel_type=b.channel_type_code and a.action_id='"+result[i][0]+"' and a.cust_group_id='"+groupResult[0][0]+"' order by a.priority_code asc";
System.out.println(groupSql);%>
<wtc:pubselect name="sPubSelect" outnum="1">
    <wtc:sql><%=groupSql%></wtc:sql>
  </wtc:pubselect>
<wtc:array id="groupSqlResult" scope="end"/>
<%
if(groupSqlResult.length>0){
for(int j=0;j<groupSqlResult.length;j++){
%>
<%=groupSqlResult[j][0]%>&nbsp
<%
}
}else{
%>
&nbsp
<%	
}
}else{
%>
&nbsp
<%}%>
		</td>
		</tr>
<%	
	}
 }
}
if(trFlag==0){%>
<tr> 
	<td align="center">
		<!--a href=javascript:parent.parent.openPage("2","4823","非目标客户询问信息与反馈","s4823/f4823.jsp","") >非目标客户询问信息与反馈</a-->
		<a href="#" onclick="javascript:window.open('../../../npage/s4823/f4823.jsp');">非目标客户询问信息与反馈</a>
	</td>
</tr>
<%}%>
	</table>
</div>
 <script>
 $("#wait6").hide();		   
 </script>
