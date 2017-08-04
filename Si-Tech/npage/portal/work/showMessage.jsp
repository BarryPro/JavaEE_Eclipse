<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.boss.util.page.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
	
<%
    String workNo = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode=org_code.substring(0,2);
	  String opName="我收到的消息";
	  String showName = "我的消息";
	  String msg_type = request.getParameter("msg_type");
		String msgCount = request.getParameter("msgCount")==null?"0":request.getParameter("msgCount");//总数
		String  powerCode= (String)session.getAttribute("powerCode");
		System.out.println("showmessage-----msgCount="+msgCount);
	  
	  String ip_Addr = (String)session.getAttribute("ipAddr");
	  
	  int iPageNumber = request.getParameter("pageNumber") == null ? 1: Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 5;
    int iStartPos = (iPageNumber - 1) * iPageSize;
    int iEndPos = iPageNumber * iPageSize;
    
	  String	receSql = "";
	  String	receParam = "";
	  if("0".equals(msg_type)){	  	
	  	 opName="我收到的系统消息";
	  	 showName = "系统消息";
	  	 receSql = " select * from (select a.*, rownum id from(select to_char(seq),sender_no,mess_type,to_char(send_time,'yyyy-MM-dd hh24:mi:ss'),mess_content from DMESSAGEMNG where mess_type=:mess_type and is_read='0' and receive_no = (select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode=:powerCode) and seq not in (select sysmsg_seq from DMESSAGEMNG where sysmsg_no=:sysmsg_no and mess_type = '0' ) and del_flag='0' order by send_time desc ) a)where id <= " + iEndPos + " and id > " + iStartPos;
	  	 receParam = "mess_type="+msg_type+",powerCode="+powerCode+",sysmsg_no="+workNo;
	  }else{
	  	 opName="我收到的个人消息";
	  	 showName = "个人消息";
	  	 receSql = " select * from (select a.*, rownum id from(select to_char(seq),sender_no,mess_type,to_char(send_time,'yyyy-MM-dd hh24:mi:ss'),mess_content from DMESSAGEMNG where mess_type=:mess_type and is_read='0' and receive_no =:receive_no  and del_flag='0' order by send_time desc ) a)where id <= " + iEndPos + " and id > " + iStartPos;
	  	 receParam = "mess_type="+msg_type+",receive_no="+workNo;
	  }
	  System.out.println("showmessage-----"+receSql);
	  System.out.println("showmessage-----"+receParam);
%>
<wtc:service name="TlsPubSelCrm" outnum="6" routerKey="region" routerValue="<%=regionCode %>">
	<wtc:param value="<%=receSql%>" />
	<wtc:param value="<%=receParam%>" />							
</wtc:service>
<wtc:array id ="result" scope = "end"/>
<title><%=opName%></title>
<META  http-equiv=Pragma>
<META  http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
	<link href="/nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
	<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
<head>

<script language="JavaScript">	
function closePage()
{
	window.returnValue="sys";   
  window.close();   
}
</script>
</head>
<body>

	<div>
			<div id="form">
				
				<%
					String msg_seq = "";
					if("000000".equals(retCode)){
							for(int i=0;i<result.length;i++){
							   msg_seq = msg_seq +result[i][0].trim()+"~";
								%>
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<th width="20%" colspan="2"><%=showName+(i+1)%></th>
								</tr>
								<tr>
									<td width="20%">发送人：</td>
									<td ><%=result[i][1]%></td>
								</tr>
								<tr>
									<td width="20%">内容：</td>
									<td ><%=result[i][4]%></td>
								</tr>
								<tr>
									<td width="20%">发送时间：</td>
									<td ><%=result[i][3]%></td>
								</tr>
								</table>
								<BR>
								 							
								<%
							}
							
					}
				%>
			<%-- //置为已读 sDmessageOpr --%>
			<%
				System.out.println("置为已读 msg_seq=="+msg_seq);
			if(!"".equals(msg_seq)){
			%>
			<wtc:service name="sDmessageOpr" outnum="0" routerKey="region" routerValue="<%=regionCode %>">
				<wtc:param value="u" />
				<wtc:param value="" />
				<wtc:param value="" />
				<wtc:param value="" />
				<wtc:param value="" />
				<wtc:param value="<%=msg_seq%>" />
				<wtc:param value="<%=workNo%>" />
				<wtc:param value="<%=workNo%>" />
			  <wtc:param value="d557" />
        <wtc:param value="<%=ip_Addr%>" />
        <wtc:param value="<%=powerCode%>" />
        <wtc:param value="消息管理置为已读" />
			</wtc:service>	
			<%}%>
				<table width="99%" border="0" cellpadding="0" cellspacing="0">
					<tr>
            	<td align="right">
                <%
                		int iQuantity = 0;
                    iQuantity=Integer.parseInt(msgCount.trim());              
                    Page pg = new Page(iPageNumber, iPageSize, iQuantity);
                    PageView view = new PageView(request, out, pg);
                    view.setVisible(true, true, 0, 0);
                %>
            		</td>
        		</tr>
				<tr>
					<td align="center" >
						<input class="b_foot" id="closeThis" type="button" value="关 闭" onclick="closePage()"/>
					</td>
				</tr>
				</table>
		</div>
	</div> 
</body>
</html>		
		
		
		