<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-23 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
	String opCode = (String)request.getParameter("opCode");
   	String opName = (String)request.getParameter("opName");	
	String regionCode= (String)session.getAttribute("regCode");  	
	String regionName = "";
	int StampNum = 100;	
	String sql = "select region_name from sregioncode where region_code = '"+regionCode+"'";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
<%	
	//ArrayList resultArr = impl.sPubSelect("1",sql);
	String retCode = retCode1;
	String retMsg = retMsg1;
	if(retCode.equals("000000"))
	{
		String[][] regionNameStr = result;
		if(regionNameStr!=null&&regionNameStr.length>0){
			regionName = regionNameStr[0][0];
		}
	}
	else
	{
%>
	<script language="javascript">
		rdShowMessageDialog("获得地市信息失败！",0);
		window.close();
	</script>
<%
	}
	
	sql = "select param_value from sPubConfig where param_code = 'stamp_number' and region_code = '"+regionCode+"'";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultArr" scope="end" />
<%	
	
	//resultArr = impl.sPubSelect("1",sql);
	retCode = retCode2;
	retMsg = retMsg2;
	if(retCode.equals("000000"))
	{
		if(resultArr != null && resultArr.length>0)
		{
			String[][] StampNumStr = resultArr;
			StampNum = Integer.parseInt(StampNumStr[0][0]);
		}
		else
		{
%>
			<script language="javascript">
				rdShowMessageDialog("获得预占次数失败！");
				window.close();
			</script>
<%
		}
	}

%>
<html>
<head>
<title><%=opName%></title>
</head> 
<script language=javascript>	
	function fsubmit1()
	{
		getAfterPrompt();
		var count = document.form1.stampCount.value;
		var my_regex = /^\d+$/;
		if(!my_regex.test(count))
		{
			rdShowMessageDialog("输入预占次数不合法!");
			return false;
		}
		document.form1.action="f7512Cfm.jsp";
		document.form1.submit();
		document.form1.bSubmit1.disabled=true;
	}
	
	//重置预占次数
	function resetAdd() 
	{
		document.form1.stampCount.value=100;
	}
</script>
<body>
<form name="form1" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
			<div id="title_zi"><%=opName%></div>
	</div> 
	<TABLE  cellspacing="0">
		<TBODY>
			<tr>
				<TD width="15%" class="blue">&nbsp;地市名称 </td>
				<td width="35%">
					<input type="text" name="groupName"  maxlength="60" value="<%=regionName%>" readonly class="InputGrey">
					<font class="orange">*</font>
				</TD>
				<TD width="15%" class="blue">&nbsp;预占次数</td>
				<TD width="35%">
					<input type="text" name="stampCount" value="<%=StampNum%>">
					<font class="orange">*</font>
				</TD>
			</tr>
		</TBODY>
	</TABLE>

	<TABLE  cellspacing="0">
		<TR>
			<TD id="footer">
				<input class="b_foot_long" type="button" name="bSubmit1" onclick="fsubmit1()" value="修改配置" >&nbsp;
				<input name="resetModBtn" type="button" class="b_foot" value="重置" onclick="resetAdd()">&nbsp;	
				<input class="b_foot" type="button" name="Return" onclick="removeCurrentTab()" value="关闭">
			</TD>
		</TR>
	</TABLE>
	<%@ include file="/npage/include/footer.jsp" %>   
</FORM>
</body>
</html>
