<%
	/********************
	 version v2.0
	开发商: si-tech
	*
	*create by lipf 20120322
	*
	********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%--保留了com.sitech.boss.pub.util.Encrypt,因为本地的加密方式暂时无法替换--%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
	String opCode = "e729";
	String opName = "宽带信息查询";
	
	String workNo = (String)session.getAttribute("workNo");
  String workName=(String)session.getAttribute("workName");
	String Department = (String)session.getAttribute("orgCode");
	String ip_Addr = "172.16.23.13";
	String regionCode = Department.substring(0,2);


//输入参数 查询类型，查询条件，机构代码，工号，权限代码。
	String queryType = request.getParameter("QueryType");//查询类型
	String condText  = request.getParameter("condText"); //查询条件
	//String custPass  = request.getParameter("custPass"); //用户密码
	String iCfmLogin="";
	String iIdIccid="";
	String iCustName="";
	String iContactName="";
	String iContactPhone="";
	if("0".equals(queryType)){
		iCfmLogin=condText;
	}else if("1".equals(queryType)){
		iIdIccid=condText;
	}else if("2".equals(queryType)){
		iCustName=condText;
	}else if("3".equals(queryType)){
		iContactName=condText;
	}else if("4".equals(queryType)){
		iContactPhone=condText;
	}
	System.out.println("1600     lipf   oldparam  =====queryType=condText========   " +queryType+"  ======  "+condText+"  ======  ");
	


	/**
		*不能使用WtcUtil.encrypt()来加密.黑龙江的加密方式跟吉林和山西的都不一样.
		*这里使用了Encrypt的加密,在Encrypt中调用了本地的java加密方式
	***/
	//String passwd = Encrypt.encrypt(custPass);
	System.out.println("1600     lipf   newparam  =====queryType=condText========   " +queryType+"  ======  "+condText+"  ======  ");
	session.setAttribute("verifyFlag","false");
	session.setAttribute("userPhoneNo",condText);
	
	String authFlag = "0";
	boolean pwrf = false; 
	String pubOpCode = opCode;  
	String pubWorkNo = workNo;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
	if(pwrf){
	    authFlag="1";
	}
%>

		<wtc:service name="sBroadQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="8" >
		<wtc:param value="0"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opName%>"/>
		<wtc:param value="<%=iCfmLogin%>"/>
		<wtc:param value="<%=iIdIccid%>"/>
		<wtc:param value="<%=iCustName%>"/>
		<wtc:param value="<%=iContactName%>"/>
		<wtc:param value="<%=iContactPhone%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>

<%	
	if(result!=null && result.length>0){
		String return_code = result[0][0];
		String return_message = result[0][1];
		System.out.println("lipf   1600  s1500PhoneQry     ===========return_code=result.length====        "+return_code+" =========  "+result.length);
	}
	/**  单条记录也展示列表
	if ((result.length==1  && return_code.equals("000000"))) {
		response.sendRedirect("f1600_Main.jsp?parStr="+result[0][2]+"|"+result[0][3]+"&passFlag=0");
		return;
	} else if (return_code.equals("150099")) {
		response.sendRedirect("f1600_Main.jsp?parStr="+result[0][2]+"|"+result[0][3]+"&passFlag=1");
		return;
	}
	*/
%>


<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
	<TITLE>宽带信息查询+<%=authFlag%></TITLE>
</HEAD>
<BODY>

<FORM method=post name="frm1600">
<input type="hidden" name="opCode"  value="e729">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">用户信息</div>
	</div> 
<!------------------------>
    <table>
      <tr align="center">
        <th>宽带账号</th>
        <th>身份证号</th>
        <th>客户姓名</th>
        <th>宽带安装联系人</th>
        <th>安装联系电话</th>
        <th>安装地址</th>
      </tr>
	<%
		for(int y=0;y<result.length;y++){
	%>
			<tr>
				<%    
					for(int j=0;j<result[y].length-2;j++){
				%>
						<td height="25">
							<div align="center">
								<a href="f1600_Main.jsp?parStr=<%=result[y][6]+"|"+result[y][7]%>" ><%= result[y][j]%> </a>
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
