<%
   /*
   * 功能: 消息展现
　 * 版本: v1.0
　 * 日期: 2011-7-25 16:08:24
　 * 版权: sitech
	 * hejwa
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.boss.util.page.*" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
       //禁止IE缓存页面
	  response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	  response.setHeader("Pragma","no-cache"); //HTTP 1.0
	  response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	  String org_code = (String)session.getAttribute("orgCode");
		String regionCode=org_code.substring(0,2);
		String workNo = (String)session.getAttribute("workNo");
	  String  powerCode= (String)session.getAttribute("powerCode");

		String receSql = " select (select to_char(count(*)) from DMESSAGEMNG where mess_type = '0' and is_read = '0' and receive_no =(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode=:powerCode) and seq not in (select sysmsg_seq from DMESSAGEMNG where sysmsg_no=:sysmsg_no and mess_type = '0') and del_flag='0' ) syscount,"+
        						 " (select to_char(count(*)) from DMESSAGEMNG where mess_type = '1' and is_read = '0' and receive_no = :receive_no and del_flag='0') percount from dual ";
		String receive_no = "powerCode="+powerCode+",sysmsg_no="+workNo+",receive_no="+workNo;
		String syscount = "";
		String percount = "";
%>

<wtc:service name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode %>">
	<wtc:param value="<%=receSql%>" />
	<wtc:param value="<%=receive_no%>" />						
</wtc:service>
<wtc:row id="row" start="0"  length="2">
<% 
	System.out.println("getMessage.jsp--hejwa--op-----"+retCode);
		if("000000".equals(retCode)){
			if(row.length>0){
				 syscount = row[0];
				 percount = row[1];
			}else{
				 syscount = "0";
				 percount = "0";
			}			
		}else{	
				 syscount = "0";
				 percount = "0";
		}
%>
</wtc:row>

<div id="form">
	<table  cellspacing="0" >
			<tr> 					
					<th align="center" width="20%">我收到的消息:</th> 
					<td width="10%">&nbsp;</td>
					<td align="left" width="25%" class="blue" onclick="showMsg('0','<%=syscount%>')" style="cursor:hand">系统消息： <span id="syscount" style="border-bottom:#666666 solid 1px;color: red"><%=syscount%></span>条未读 </td> 
					<td width="10%">&nbsp;</td>
					<td align="left"   class="blue"   onclick="showMsg('1','<%=percount%>')"  style="cursor:hand">个人消息： <span id="percount"  style="border-bottom:#666666 solid 1px;"><%=percount%></span> 条未读 </td> 
			</tr>
	</table>
</div>

<script language="JavaScript">
		function showMsg(msg_type,msgCount){
				window.open("showMessage.jsp?msg_type="+msg_type+"&msgCount="+msgCount,'_blank','height=400,width=500,top=200,left=500,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
				if(msg_type=="0"){
					setTimeout("$('#syscount').text('0')",3000);
				}else{
					setTimeout("$('#percount').text('0')",3000);
				}
			
		}
</script>