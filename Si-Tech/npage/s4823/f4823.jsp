<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%
	String phone_no = (String)request.getParameter("activePhone");
	String sql="select distinct a.action_id,"+
                "action_name,to_char(PLAN_START_DATE, 'yyyymmdd') || '--' ||to_char(PLAN_END_DATE, 'yyyymmdd'),"+
                "action_desc,priority_name "+
                "from dbsalesadm.dFndSaleAction a,dbsalesadm.sFndPriOrityCode b,"+
                "dbsalesadm.dFndAcChannelRel c,dbsalesadm.dFndCustomerGroup d "+
                "where a.priority_code = b.priority_code and a.action_id = c.action_id "+
                "and a.cust_group_id=c.cust_group_id and a.action_id = d.action_id "+
   							"and a.cust_group_id = d.cust_group_id and c.contact_channel_type = '906' "+
                "and action_status = '0004' and sysdate between d.start_date and d.end_date";
	System.out.println("sql = " + sql);
	String sqlBuf="";
	String sqlBuf2="";
%>
<wtc:pubselect name="sPubSelect" outnum="5">
    <wtc:sql><%=sql%></wtc:sql>
  </wtc:pubselect>
  <wtc:array id="result" scope="end"/>
<%  	
	String opCode="4823";
	String opName="非目标客户群活动信息列表";
%>	
<html>
<head>
<title>非目标客户群活动信息列表</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<form name="frm" method="post" action="" >
<%@ include file="/npage/include/header.jsp" %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr align="center"> 
          	 <th nowrap>营销活动名称</th>
             <th nowrap>活动时间</th>
             <th nowrap>任务描述</th>
             <th nowrap>优先级</th>
          </tr>   
         <%
						if(result.length>0){
						for(int i=0;i<result.length;i++){
						sqlBuf="select b.channel_type_name from dbsalesadm.dFndCustExecCircs a,dbsalesadm.sFndChannelType b where a.contact_channel_type=b.channel_type_code and a.phone_no='"+phone_no+"' and a.action_id='"+result[i][0]+"' and a.is_local_transact='0'";
						sqlBuf2="select 1 from dbsalesadm.dFndSaleAshCust where phone_no='"+phone_no+"' and action_id='"+result[i][0]+"'";
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
					if(result3.length==0&&result2.length==0){
					%>
							<tr>
							<td><a href=javascript:parent.parent.openPage("2","4822","营销活动执行反馈","s4823/f4822.jsp?phoneNo=<%=phone_no.trim()%>&saleCode=<%=result[i][0]%>&reFlag=1","") ><span class='orange'><%=result[i][1]%></span></a>&nbsp;</td>
							<td><%=result[i][2]%>&nbsp;</td>
							<td><%=result[i][3]%>&nbsp;</td>
							<td><%=result[i][4]%>&nbsp;</td>
							</tr>
					<%
						}
					 }
					}
					%>
								<TD align="center" colspan=5>
									<input class="b_foot" name=commit onClick="parent.removeTab('<%=opCode%>');" type=button value=关闭>
									&nbsp;
								</TD>
							</tr>
        </table>
<%@ include file="/npage/include/footer.jsp" %>	
</form>
</body>
</html>
