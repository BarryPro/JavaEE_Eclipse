<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="org.apache.log4j.Logger"%>
<%
	Logger logger = Logger.getLogger("f3518_query.jsp");
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	
	String opName = "集团客户查询";
	
	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));

	String id_iccid = request.getParameter("id_iccid");
	System.out.println("MM"+id_iccid+"ss");

	ArrayList acceptList = new ArrayList();
	
	String paraArr[] = new String[5];
	paraArr[0] = "aaaaxp";
	paraArr[1] = "111111";
	paraArr[2] = "3518";
	paraArr[3] = "duyi";
	paraArr[4] = id_iccid;
	
	//acceptList = impl.callFXService("s3518Qry",paraArr,"9");
%>
    <wtc:service name="s3518QryEXC" retcode="retCode" retmsg="retMsg" outnum="9" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=paraArr[0]%>"/>
    	<wtc:param value="<%=paraArr[1]%>"/> 
        <wtc:param value="<%=paraArr[2]%>"/> 
        <wtc:param value="<%=paraArr[3]%>"/> 
        <wtc:param value="<%=paraArr[4]%>"/> 
    </wtc:service>
    <wtc:array id="retArr" scope="end"/>
<%
	String errCode=retCode;   
	String errMsg=retMsg; 
	System.out.println("错误信息：["+errCode+"]"+errMsg);
			
    if("000000".equals(errCode))
    {
        result = retArr;
    }
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>信息列表</title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<body>
<form>	
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">集团客户查询</div>
</div>
      <table cellspacing="0" id="tab1">
					<tr>
						<th  align="center">选择</th>
						<th  align="center">证件号码</th>
						<th  align="center">集团客户ID</th>
						<th  align="center">集团编号</th>
						<th  align="center">集团名称</th>
						<th  align="center">产品号码</th>
						<th  align="center">产品代码</th>
						<th  align="center">产品名称</th>
						<th  align="center">APN号码</th>
					</tr>
				</table>
				<table cellspacing="0">
					<tr id="footer">
						<td>
					      <input type="button" class="b_foot" name="commit" onClick="doCommit()" value=" 确定 ">
					      <input type="button" class="b_foot" name="back" onClick="removeCurrentTab();" value=" 关闭 ">
						</td>
					</tr>
				</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
<script>
  
	<%
		if("000000".equals(errCode))
		{
			for(int i=0;i < result.length;i++)
			{ 
	%>
			var str='<input type="hidden" name="id_iccid" value="<%=result[i][0]%>">';
			str+='<input type="hidden" name="cust_id" value="<%=result[i][1]%>">';
			str+='<input type="hidden" name="unit_id" value="<%=result[i][2]%>">';
			str+='<input type="hidden" name="unit_name" value="<%=result[i][3]%>">';
			str+='<input type="hidden" name="id_no" value="<%=result[i][4]%>">';
			str+='<input type="hidden" name="product_code" value="<%=result[i][5]%>">';
			str+='<input type="hidden" name="product_name" value="<%=result[i][6]%>">';
			str+='<input type="hidden" name="user_no" value="<%=result[i][7]%>">';

						
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  	newrow.insertCell(1).innerHTML = '<%=result[i][0]%>';
		  	newrow.insertCell(2).innerHTML = '<%=result[i][1]%>';
		  	newrow.insertCell(3).innerHTML = '<%=result[i][2]%>';
		  	newrow.insertCell(4).innerHTML = '<%=result[i][3]%>';
		  	newrow.insertCell(5).innerHTML = '<%=result[i][7]%>';
		  	newrow.insertCell(6).innerHTML = '<%=result[i][5]%>';
		  	newrow.insertCell(7).innerHTML = '<%=result[i][6]%>';
		  	newrow.insertCell(8).innerHTML = '<%=result[i][8]%>';
	<%
			}
		
	%>

		function doCommit()
		{
			if("<%=result.length%>"=="0")
			{
				rdShowMessageDialog("请选择一条信息！");
				return false;
			}
			else if("<%=result.length%>"=="1")
			{//值为一条时不需要用数组
				if(document.all.num.checked)
				{
					window.opener.form1.id_no.value=document.all.id_no.value;
					window.opener.form1.unit_id.value=document.all.unit_id.value;
					window.opener.form1.cust_id.value=document.all.cust_id.value;
					window.opener.form1.unit_name.value=document.all.unit_name.value;
					window.opener.doSubmit();
					window.close();
				}
				else
				{
					rdShowMessageDialog("请选择一条信息！");
					return false;
				}
			}
			else
			{//值为多条时需要用数组
				var a=-1;
				for(i=0;i<document.all.num.length;i++)
				{
					if(document.all.num[i].checked)
					{
						a=i;
						break;
					}
				}
				if(a!=-1)
				{
					window.opener.form1.id_no.value=document.all.id_no[a].value;
					window.opener.form1.unit_id.value=document.all.unit_id[a].value;
					window.opener.form1.cust_id.value=document.all.cust_id[a].value;
					window.opener.form1.unit_name.value=document.all.unit_name[a].value;
					window.opener.doSubmit();
					window.close();
				}
				else
				{
					rdShowMessageDialog("请选择一条信息！");
					return false;
				}
			}
		}
<%
    }
%>
</script>
</body>
</html>
