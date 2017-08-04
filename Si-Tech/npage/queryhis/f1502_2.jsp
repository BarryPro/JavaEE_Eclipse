<%
	/********************
	 version v2.0
	开发商: si-tech
	*
	*update:zhanghonga@2008-08-12 页面改造,修改样式
	*
	********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%--保留了com.sitech.boss.pub.util.Encrypt,因为本地的加密方式暂时无法替换--%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
	String opCode = "1502";
	String opName = "综合信息历史查询";
	
	String workNo = (String)session.getAttribute("workNo");
  String workName=(String)session.getAttribute("workName");
	String Department = (String)session.getAttribute("orgCode");
	String ip_Addr = "172.16.23.13";
	String regionCode = Department.substring(0,2);
	String password = (String)session.getAttribute("password"); //diling add for 安全加固


//输入参数 查询类型，查询条件，机构代码，工号，权限代码。
	String queryType = request.getParameter("QueryType");//查询类型
	String condText  = request.getParameter("condText"); //查询条件
	String custPass  = request.getParameter("custPass"); //用户密码


	/**
		*不能使用WtcUtil.encrypt()来加密.黑龙江的加密方式跟吉林和山西的都不一样.
		*这里使用了Encrypt的加密,在Encrypt中调用了本地的java加密方式
	***/
	String passwd = Encrypt.encrypt(custPass);
	System.out.println("-------passwd="+passwd);
	
	session.setAttribute("verifyFlag","false");
	session.setAttribute("userPhoneNo",condText);
	
	String authFlag = "0";
	String tempStr = "";
	String[][] favInfo = (String[][])session.getAttribute("favInfo");
	String[] favStr = new String[favInfo.length];
	for(int i = 0 ;i < favStr.length; i++){ 
		tempStr = favInfo[i][0].trim();
		if(tempStr.compareTo("a272") == 0) {     
			authFlag = "1";         
		}
	}
 
     
	/**
	try
	{	 
		s1500View viewBean = new s1500View();//实例化viewBean		 
		arlist = viewBean.view_s1500_1(queryType,condText,workNo,passwd,regionCode,opCode); 
 	}
	catch(Exception e)
	{
		//System.out.println("调用EJB发生失败！");
	}
	**/
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

		<wtc:service name="s1500PhoneQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9" >
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=passwd%>"/>
		<wtc:param value="<%=queryType%>"/>
		<wtc:param value="<%=condText%>"/>
		<wtc:param value="<%=regionCode%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%	

	String return_code = result[0][0];
	String return_message = result[0][1];
	System.out.println("lllllllllllllreturn_code="+return_code);
	System.out.println(result.length);
	
	if ((result.length==1  && return_code.equals("000000"))) {
		response.sendRedirect("f1502_Main.jsp?parStr="+result[0][2]+"|"+result[0][3]+"&passFlag=0");
		return;
	} else if (return_code.equals("150099")) {
		response.sendRedirect("f1502_Main.jsp?parStr="+result[0][2]+"|"+result[0][3]+"&passFlag=1");
		return;
	}
%>


<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
	<TITLE>综合信息查询+<%=authFlag%></TITLE>
</HEAD>
<BODY>

<FORM method=post name="frm1500">
<input type="hidden" name="opCode"  value="1500">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">用户信息</div>
	</div> 
<!------------------------>
    <table>
      <tr align="center">
        <th>服务号码</th>
        <th>用户ID号</th>
        <th>服务类型</th>
        <th>当前状态</th>  
        <th>状态变更时间</th>  
        <th>入网时间</th>
      </tr>
	<%
		for(int y=0;y<result.length;y++){
	%>
			<tr>
				<%    
					for(int j=2;j<result[y].length-1;j++){
				%>
						<td height="25">
							<div align="center">
								<a href="f1502_Main.jsp?parStr=<%=result[y][2]+"|"+result[y][3]%>" ><%= result[y][j]%> </a>
							</div>
						</td>
				<%
					}
				%>
			</tr>
	<%
	  }
	%>
	</tr>
	</td>
</table>

<table>
  <tr> 
    <td id="footer">
      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=返回>
      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
    </td>
  </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
