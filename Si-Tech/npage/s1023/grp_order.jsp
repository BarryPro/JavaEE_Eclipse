<%
  /*
   * 功能: 集团订单信息分视图
　 * 版本: v1.0
　 * 日期: 2011年05月10日
　 * 作者: zhoujf
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%

	String unit_id =  request.getParameter("unit_id")==null?"":request.getParameter("unit_id");
	String implRegion= (String)session.getAttribute("regCode");	
  String workName = (String)session.getAttribute("workName");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String opCode="";
  String opName="订单受理信息";
  String sqlStr="select a.order_goods_id,a.grade,a.curr_status,a.deal_time,a.end_date from dGrpCustOrderGoods a where a.unit_id="+unit_id;
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result" scope="end" />
		
		<%
			System.out.println("result=====1023 begin=============\n"+sqlStr);
		System.out.println("result=================="+result.length);
		for(int ii=0;ii<result.length;ii++){
				for(int jj=0;jj<result[ii].length;jj++){
					System.out.println("result["+ii+"]["+jj+"]="+result[ii][jj]);
				}
		}
		
		System.out.println("result============1023  END======");
		%>
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<FORM name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>

<div class="title"><div id="title_zi">集团订单信息</div></div>
  <table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>订单标识</th>
				<th>订单优先级</th>
				<th>订单状态</th>
				<th>订单受理时间</th>
				<th>订单竣工时间</th>
			</tr>
		<%	
		for(int i = 0; i < result.length; i++)
		{		  
		%>			
			<tr>				
				<td nowrap align='center'><%=result[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][1].trim()%>&nbsp;</td>
				<%
				if("01".equals(result[i][2]) | "1".equals(result[i][2])){
				%>
				<td nowrap align='center'>有效&nbsp;</td>
				<%
			}else{
				%>
				<td nowrap align='center'>无效&nbsp;</td>
				<%
			}
				%>
				<td nowrap align='center'><%=result[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][4].trim()%>&nbsp;</td>
			</tr>
		<%
		}
		%>				
</table>
</BODY>
</HTML>


