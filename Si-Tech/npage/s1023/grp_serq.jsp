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
  String opName="服务请求信息";
  String sqlStr="SELECT t.sheet_id,t.oper_name, sum(decode(t.param_name,'客户地址',t.param_value,0)) 客户地址, sum(decode(t.param_name,'联系人名称',t.param_value,0)) 联系人名称,sum(decode(t.param_name,'联系人号码',t.param_value,0)) 联系人号码,to_char(t.OPER_DATE,'yyyymmdd'), t.ACT_NAME, t.STATUS_NAME from (SELECT a.sheet_id, a.oper_name, a.param_name,  A.PARAM_VALUE,A.OPER_DATE, B.ACT_NAME, C.STATUS_NAME FROM dbsalesadm.DMKTNETINFO A, dbsalesadm.SMKTNETOPER B, dbsalesadm.SMKTNETSTATUS C WHERE A.ACT_CODE = B.ACT_CODE AND A.STATUS_CODE = C.STATUS_CODE AND A.SHEET_ID IN (SELECT SHEET_ID FROM DBSALESADM.DMKTNETINFO A, DBSALESADM.SMKTNETOPER B WHERE A.ACT_CODE = B.ACT_CODE AND PARAM_VALUE ='"+unit_id+"')) t group by t.oper_name,t.OPER_DATE, t.ACT_NAME, t.STATUS_NAME ,t.sheet_id";
  String sql ="SELECT UNIT_ID,to_char(RETURN_DATE, 'yyyy-mm-dd'),RETURN_TYPE,SERVICE_NO, RETURN_ADDRESS,trim(SUMMARY) from dbvipadm.dGrpReturninfo  where UNIT_ID ='"+unit_id+"'";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="10">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result" scope="end" />
		
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="10">
			<wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="results" scope="end" />
		
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

<div class="title"><div id="title_zi">集团预约信息</div></div>
  <table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>工单标识</th>
				<th>受理人</th>
				<th>客户地址</th>
				<th>预约人姓名</th>
				<th>联系电话</th>
				<th>预约时间</th>
				<th>业务类别</th>
				<th>处理结果</th>
				
			</tr>
		<%	
		for(int i = 0; i < result.length; i++)
		{		   
		%>			
			<tr>				
				<td nowrap align='center'><%=result[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][6].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][7].trim()%>&nbsp;</td>
			</tr>
		<%
		}
		%>				
</table>

<br>

<div class="title"><div id="title_zi">主动服务信息</div></div>
  <table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>客户标识</th>
			
				<th>业务服务时间</th>
				<th>服务方式</th>
				<th>受理员</th>
				<th>回访地点</th>
				<th>业务内容</th>
				
			</tr>
		<%	
		for(int i = 0; i < results.length; i++)
		{		  
		%>			
			<tr>				
				<td nowrap align='center'><%=results[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=results[i][1].trim()%>&nbsp;</td>
				<% if ("1".equals(results[i][2])){ %>
					<td nowrap align='center'>现场拜访&nbsp;</td>
					<% } else if("2".equals(results[i][2])) {%>
						<td nowrap align='center'>电话访谈&nbsp;</td>
						<% } %>
				<td nowrap align='center'><%=results[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=results[i][4].trim()%>&nbsp;</td>
				<td><%=results[i][5].trim()%>&nbsp;</td>
				
		</tr>
		<%
		}
		%>				
</table>
</BODY>
</HTML>


