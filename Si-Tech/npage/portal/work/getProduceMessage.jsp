<%
   /*
   * 功能: 查询生产信息
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
<%@ include file="/npage/login/dispatch.jsp" %>
<%
		String urlStr = getLink("3","chninfo/f9633.do?operate=view_init","9633",session,request,"我收到的信息");
	  String org_code = (String)session.getAttribute("orgCode");
		String regionCode=org_code.substring(0,2);
		String workNo = (String)session.getAttribute("workNo");
		String sqlStmt = 
		" SELECT title,login_accept " + 
	    " FROM dbinfoadm.DMESSAGEPUB A, dbinfoadm.SMSGTYPEDETCODE B, dbinfoadm.DMESSAGEPUBPEOPLE C,"+
	    " dbinfoadm.SCHNWORKFLOWSWITCH D " +
	    " WHERE A.MESSAGE_ID = B.MESSAGE_ID "+
	    " AND A.LOGIN_ACCEPT IN C.MESSAGE_ID "+
	    " AND A.SEND_STATUS = D.SRC_STATUS "+
	    " AND D.FUNC_TYPE = '0' "+
	    " AND C.LOGIN_NO = '"+workNo+"' "+
	    " AND D.FUNC_CODE = '9633' "+
	    " AND IS_READ = 'N' "+
	    "  ORDER BY A.LEVEL_ID, A.BEGIN_TIME DESC ";
%>

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
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
								<td class="<%=classes%>" align="center">
									<!--<a href="javascript:L('0','','','','')" target="_blank"><%=result[i][0]%></a>-->
									<a style="cursor:hand" onclick='javascript:window.open("<%=urlStr%>&login_accept=<%=result[i][1]%>","99041","width="+screen.availWidth+",height="+screen.availHeight+",top=0,left=0,scrollbars=yes,resizable=yes,status=yes")' ><%=result[i][0]%></a>
								</td>
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
								<td class="<%=classes%>" align="center">
								<a style="cursor:hand" onclick='javascript:window.open("<%=urlStr%>&login_accept=<%=result[i][1]%>","99041","width="+screen.availWidth+",height="+screen.availHeight+",top=0,left=0,scrollbars=yes,resizable=yes,status=yes")' ><%=result[i][0]%></a>
								</td>
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
   $("#wait10").hide();		   
</script>		

		