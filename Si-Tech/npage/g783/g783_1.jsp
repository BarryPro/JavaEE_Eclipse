<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
		String[] inParas1 = new String[2];
		String[] inParas2 = new String[2];
		
		String opCode = "g783";
		String opName = "用户信誉度黑名单";
		String regionCode = (String)session.getAttribute("regCode");
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String ip_Addr =  (String)session.getAttribute("ipAddr"); 
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		
		String opFlag = request.getParameter("InOpFlag") ;
		String phone_no = request.getParameter("InPhoneNo") ;
		String is_Level = request.getParameter("is_level") ;
		String is_LimitOwe = request.getParameter("is_limit_owe") ;
		String is_ShortMsg = request.getParameter("is_msg") ;

%>

<HTML>
<HEAD>
 

 
<title>用户信誉度黑名单</title>
</head>
<BODY onload=""> 
<form action="g783_1.jsp" method="post" name="frm" ENCTYPE="multipart/form-data" >
		 
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">执行结果：</div>
		</div>
		
	<%
		if( opFlag.equals("Q") )
		{
		
			inParas1[0] = "SELECT to_char(id_no), phone_no, login_no , to_char(op_time,'yyyymmdd hh24:mi:ss') , op_note,"+
			" decode(is_level,1,'参与评级','禁用评级'), decode(is_limit_owe,1,'参与信誉度','禁用信誉度'), decode(is_short_msg,1,'发送短信','禁用短信') "+
			"  FROM dLimitOwe_BlackList where id_no in ( "+
			" select id_no from dCustMsg where phone_no = :phone )" ;
			
		  inParas1[1]="phone="+phone_no ;
	%>
	
      	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="8">
		    <wtc:param value="<%=inParas1[0]%>"/>
		    <wtc:param value="<%=inParas1[1]%>"/>
		    </wtc:service>
		    <wtc:array id="result" scope="end" />	 
			
	<%

			if( result.length > 0 )
			{
	%>
	
  <table>
     <tr>
        <td class="blue" width="3%">用户ID</td>
        <td class="blue" width="3%">手机号码</td>
        <td class="blue" width="3%">操作工号</td>
        <td class="blue" width="5%">操作时间</td>
        <td class="blue" width="3%">备注</td>		
        <td class="blue" width="3%">是否评级</td>	
        <td class="blue" width="3%">信誉度</td>	
        <td class="blue" width="3%">短信</td>	
     </tr>
      
     <tr>
        <td  width="3%"><%=result[0][0]%></td>	
        <td  width="3%"><%=result[0][1]%></td>	
        <td  width="3%"><%=result[0][2]%></td>	
        <td  width="5%"><%=result[0][3]%></td>	
        <td  width="3%"><%=result[0][4]%></td>	
        <td  width="3%"><%=result[0][5]%></td>
        <td  width="3%"><%=result[0][6]%></td>
        <td  width="3%"><%=result[0][7]%></td>
        		
     </tr>
	</table>

	<%
			}
			else
			{
	%>
	
				<SCRIPT type=text/javascript>
					rdShowMessageDialog("查询出错。</br>手机号不对或用户不存在！",0);
					history.go(-1);
				</SCRIPT>

	<%
			}
		}
		else
		{ 
	%>
			<wtc:service name="sBlackListAdd" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:param value="<%=phone_no%>"/>
				<wtc:param value="<%=workno%>"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=opFlag%>"/>
				<wtc:param value="<%=is_Level%>"/>
				<wtc:param value="<%=is_LimitOwe%>"/>
				<wtc:param value="<%=is_ShortMsg%>"/>
			</wtc:service>
			<wtc:array id="result2" start="0" length="1" scope="end"/>
		
			<%
				if( retCode1.equals("000000") )
				{
			%>
				<SCRIPT type=text/javascript>
					rdShowMessageDialog("操作黑名单成功！！",0);
					history.go(-1);
				</SCRIPT>

	<%
				}
				else
	%>
				<SCRIPT type=text/javascript>
					rdShowMessageDialog("操作黑名单失败。<br>错误代码：'<%=retCode1%>'。<br>错误信息：'<%=retMsg1%>'。",0);
					history.go(-1);
				</SCRIPT>
	<%
		}
	%>
		
	
  <table cellspacing="0">
    <tbody> 

 		


    </tbody>
  </table>
  

           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="return2" class="b_foot" value="返回" onClick="history.go(-1)" >
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>