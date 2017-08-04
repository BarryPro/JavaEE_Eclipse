<%
   /*
   * 功能: 查询申告名称
　 * 版本: v1.0
　 * 日期: 2011年02月16日
   * 作者: huangrong
   * 修改历史
　 * 版权: sitech
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*;" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
	  String org_code = (String)session.getAttribute("orgCode");
		String regionCode=org_code.substring(0,2);
		String workNo = (String)session.getAttribute("workNo");
		String sqlStmt = 
		" SELECT A.LOGIN_ACCEPT, A.TITLE, C.GROUP_NAME, B.LOGIN_NAME," + 
		"  D.LEVEL_NAME, A.LOGIN_TIME, A.IS_APPROVAL " +
	    " FROM dbinfoadm.DFAULTREPORTMSG A, DLOGINMSG B, DCHNGROUPMSG C, "+
	    " dbinfoadm.SMSGESIGENCECODE D, dbinfoadm.SCHNWORKFLOWSTATUS E, " +
	    " dbinfoadm.SCHNWORKFLOWSWITCH F "+
	    " WHERE A.LOGIN_NO = B.LOGIN_NO "+
	    " AND B.GROUP_ID = C.GROUP_ID "+
	    " AND A.LEVEL_ID = D.LEVEL_CODE "+
	    " AND A.WF_STATUS = E.WF_STATUS "+
	    " AND A.WF_TYPE = E.WF_TYPE "+
	    " AND F.FUNC_TYPE = '0' "+
	    " AND F.WF_TYPE = A.WF_TYPE "+
	    " AND A.WF_STATUS = F.DEST_STATUS "+
	    " AND A.ACCEPT_LOGIN IN "+
	    " (SELECT LOGIN_NO "+
	    " FROM dbinfoadm.SFAULTREPORTACCEPTDPTMT AAA "+
	    " WHERE AAA.DPTMT_ID IN (SELECT DPTMT_ID "+
	    " FROM dbinfoadm.SFAULTREPORTACCEPTDPTMT AA "+
	    " WHERE 1 = 1)) "+
	    " AND A.ACCEPT_LOGIN IN "+
	    " (SELECT LOGIN_NO "+
	    " FROM dbinfoadm.SFAULTREPORTACCEPTDPTMT AAA "+
	    " WHERE AAA.DPTMT_ID IN "+
	    " (SELECT DPTMT_ID "+
	    " FROM dbinfoadm.SFAULTREPORTACCEPTDPTMT AA "+
	    " WHERE 1 = 1  AND AA.LOGIN_NO = '"+workNo+"')) AND  F.FUNC_CODE = '9666' ORDER BY A.WF_STATUS ASC, LOGIN_TIME DESC ";
%>

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="7">
			<wtc:sql><%=sqlStmt%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
	<div class="itemContent">
		<div id="form">

				<table width="100%" border=0 cellpadding="0" cellspacing=1 cellpadding="0" class="list">
					<tr>
						<th>名称</th>
					</tr>
					<%
					if(retCode.equals("000000")){
						if(result.length>5)
						{
							for(int i=0; i<5; i++)
							{
								String classes="";
								if(i%2==1){classes="grey";}
					%>
							<tr>
								<td class="<%=classes%>" align="center"><%=result[i][1]%></td>
							</tr>
					<%
							}
						}else
						{
							for(int i=0; i<result.length; i++)
							{
								String classes="";
								if(i%2==1){classes="grey";}
					%>
							<tr>
								<td class="<%=classes%>" align="center"><%=result[i][1]%></td>
							</tr>
					<%
							}
						}	
					}
					else
					{
						out.println("<tr><td>获取数据错误</td></tr>");
					}
					%>
				</table>
		  </div>
		</div>
		
<script>
   $("#wait11").hide();		   
</script>		

		