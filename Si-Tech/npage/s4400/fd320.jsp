<%
  /*
   * 功能: 全球通VIP候车服务冲正 d320
   * 版本: 2.0
   * 日期: 2011/3/24
   * 作者: huangrong
   * 版权: si-tech
   * update:
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
  String opCode =  "d320";
	String opName =  "全球通VIP候车服务冲正";
	String workNo =  (String)session.getAttribute("workNo");
	String workName =  (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	String workpw = (String)session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");

	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo")) ;
	String passwd = WtcUtil.repNull(request.getParameter("passwd")) ;
	String ret_code = "";
	String ret_meg = "";
	String result[][] = null;
	int recNum1=0;
	int recNum = 0 ;
	String disPlay = request.getParameter("disPlay") ;

	if("yes".equals(disPlay)){////控制第一次不显示
		System.out.println("--------------111111111111111111111-------------------------");
	%>

		<wtc:service name="sD320Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
			<wtc:param value=" " />
			<wtc:param value=" " />
			<wtc:param value="<%=opCode%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=workpw%>" />
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="<%=passwd%>" />
		</wtc:service>
  	<wtc:array id="r0" start="0" length="2" scope="end" />
		<wtc:array id="r1" start="2" length="6" scope="end" />

<%
		ret_code = retCode;
		ret_meg = retMsg;
		result = r1;
	}
	if(!ret_code.equals("000000")&&!ret_code.equals(""))
	{%>
	 <script language='jscript'>
		rdShowMessageDialog('错误信息：<%=ret_meg%>' + '错误代码：' + '<%=ret_code%>' + '！',0);
		window.location.href = "fd320.jsp?phoneNo=<%=phoneNo%>&passwd=<%=passwd%>&disPlay=no";
	</script>
	<%}	else{
	if(result!=null)
	{
		recNum1=result.length;
		if(recNum1<1)
		{
%>
	<script language='jscript'>
		window.location.href = "fd320.jsp?phoneNo=<%=phoneNo%>&passwd=<%=passwd%>&disPlay=no";
	</script>

<%
}}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
<!--
	function qry(){
	    if(!check(document.form)){
        	return false;
        }

	    if((document.form.phoneNo.value).trim()==""){
    	    	  	rdShowMessageDialog("请输入手机号码!");
					      document.form.phoneNo.focus();
						  	return false;
    	}

	    if((document.form.passwd.value).trim()==""){
    	    	  	rdShowMessageDialog("请输入密码!");
					      document.form.passwd.focus();
						  	return false;
    	}
    document.form.queryBut.disabled=true;
		document.form.submit();
	}

	function comjsp()
	{
		getAfterPrompt();

		var tab=document.getElementById("ShowId");
		var trs=tab.rows;
		if(trs.length<3)
		{
			 rdShowMessageDialog("此号码没有操作记录,不能办理冲正操作!");
			 return false;
		}

    if((document.form.phoneNo.value).trim()==""){
  	    	  	rdShowMessageDialog("请输入手机号码!");
				      document.form.phoneNo.focus();
					  	return false;
  	}

    if((document.form.passwd.value).trim()==""){
  	    	  	rdShowMessageDialog("请输入密码!");
				      document.form.passwd.focus();
					  	return false;
  	}

		var flag="N";
		var radios=document.getElementsByName("oprRadio");
		var changdu = radios.length;
    for(var i=0;i<changdu;i++)
		{
			var radio=radios[i];
			if(radio.checked==true)
			{
				var td=document.getElementById("loginAccept"+(i+1));
				var old_loginAccept=td.innerHTML;
				document.form.old_loginAccept.value=old_loginAccept;
				flag="Y";
			}
		}
		if(flag=="N")
		{
			 rdShowMessageDialog("请选择一条需要删除的记录!");
			 return false;
		}
		form.action="fd320Cfm.jsp";
		form.submit();
	  return true;
	}

	function combegin()
	{
		document.form.phoneNo.value="";
		document.form.passwd.value="";
	}
-->
</script>
</head>
<body>
<FORM action="fd320.jsp" method=post name=form>
<%@ include file="/npage/include/header.jsp"%>
<div class="title">
	<div id="title_zi">当日办理全球通VIP候车服务业务查询</div>
</div>
  <input type="hidden" name="disPlay"  value="yes">
<table cellSpacing="0">
		<tr>
			<td class="blue">用户号码</td>
			<td>
				<input type="text" name="phoneNo" value="<%=phoneNo%>"  v_must=1 v_type="phone" size=20 onblur="checkElement(this)"/>
			</td>
			<td class="blue">密码</td>
			<td>
				<input type="password" name="passwd"  value="<%=passwd%>" v_must=1  onblur="checkElement(this)"/>
			</td>
		</tr>

		 <tr id="footer">
	      <td colspan="4" align="center"><input class="b_foot" name="queryBut" type="button" value="查询" style="cursor:hand;" onclick="qry()"></td>
	    </tr>
	  </table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
      <table cellSpacing="0" id="ShowId">
	          <tr id="ShowTotalId">
	          	<th><div align="center">选择</div></th>
	            <th><div align="center">操作水流</div></th>
	            <th><div align="center">用户号码</div></th>
	            <th><div align="center">用户姓名</div></th>
	            <th><div align="center">消费积分</div></th>
	            <th><div align="center">免费次数</div></th>
	            <th><div align="center">随行人员个人</div></th>
              </tr>
              <%
              	if(result!= null){
			    			recNum = result.length ;
							}
			 				%>
			  <%if(recNum<1){%>
		  	<tr><td colspan="12" align = "center"><b><font class="orange">此号码没有操作记录</font></td></tr>
		      <%}else{%>
	          <%
          		for(int i=0;i<recNum;i++){
          		String tdClass = "";
         if (i%2==0){
             tdClass = "Grey";
         }
		  	  %>
				<tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';;this.style.cursor='hand'">
			      <td class="<%=tdClass%>"><div align="center"><input type="radio" name="oprRadio"></div></td>
			      <td class="<%=tdClass%>"><div align="center"  id="loginAccept<%=i+1%>"><%=result[i][0]%></div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][1]%></div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][2]%></div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][5]%></div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][4]%></div></td>
		  	  	<td class="<%=tdClass%>"><div align="center"><%=result[i][3]%></div></td>
	  	  </tr>
			  <%}}%>

			  <tr id="footer">
        	<td colspan="11" align="right">
        				 <div align="center">
			              <input class="b_foot" type="button" id="confirm" name="confirm" value="确认" index="2" onClick="comjsp()">
			              <input class="b_foot" type="button" name=back value="清除" onClick="combegin();">
					          <input class="b_foot" type="button" name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>');">
			            </div>
        	</td>
        </tr>
		</table>
		<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>"/>
		<input type="hidden" name="opName" id="opName" value="<%=opName%>"/>
		<input type="hidden" name="old_loginAccept" id="old_loginAccept"/>

   <%@ include file="/npage/include/footer.jsp"%>
</FORM>
</BODY>
</HTML>
<%}%>

