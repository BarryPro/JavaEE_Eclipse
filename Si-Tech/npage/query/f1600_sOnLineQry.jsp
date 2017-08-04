<%
/********************
 version v2.0
开发商: si-tech
*
*create by lipf 20120509
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1600";
  String opName = "宽带信息查询之在线信息查询";
  String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String iLoginAccept = "0";     //流水
  String iChnSource = "01";			//渠道标识
  String iOpCode=request.getParameter("iOpCode");//操作代码
  String iLoginNo = (String)session.getAttribute("workNo");//工号
	String iLoginPwd = (String)session.getAttribute("password");//工号密码
	String iPhoneNo  = request.getParameter("iPhoneNo");//手机号码
  String iUserPwd = "";					//手机密码
	String iOpNote="在线信息查询";//备注
	String iAccount  =request.getParameter("iAccount");//用户账号
%>
	<wtc:service name="sOnLineQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="5" >
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		<wtc:param value="<%=iOpNote%>"/>
		<wtc:param value="<%=iAccount%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	if (!"000000".equals(retCode1)){
%>
		<script language="JavaScript">
			rdShowMessageDialog("错误提示:  <%=retMsg1%>");
			history.go(-1);
		</script>
<%	
	}
%>
<HTML><HEAD><TITLE>在线信息查询</TITLE>
</HEAD>
<body>

<FORM method=post name="f1600_sOnLineQry">
<%@ include file="/npage/include/header.jsp" %>     	
		<div id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">在线信息</div>
		</div>
    <table cellspacing="0">
      <tbody>
        <tr align="center">
          <th>上线时间</th>
          <th>用户IP</th>
          <th>接入设备IP</th>
          <th>接入设备端口</th>
          <th>会话ID</th>
        </tr>
<%	      
			String tbClass="";
			for(int y=0;y<result.length;y++)
			{
				if(y%2==0)
				{
					tbClass="Grey";
				}else
				{
					tbClass="";
				}
%>
	        <tr align="center">
<%    		
				for(int j=0;j<result[0].length;j++)
				{
%>
		  			<td class="<%=tbClass%>"><%= result[y][j]%>&nbsp;</td>
<%			
				}
			}
%>
	        </tr>
         </TBODY>
	    </TABLE>
          
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=iOpCode%>')" type=button value=关闭>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
