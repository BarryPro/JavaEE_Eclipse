<%
   /*
   * 功能: 查询地区代码
　 * 版本: v1.0
　 * 日期: 2007/01/12
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
		Logger logger = Logger.getLogger("f5238_1.jsp");
		ArrayList retArray = new ArrayList();
		String[][] result = new String[][]{};
		 
		String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
		String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	
		ArrayList retList1 = new ArrayList();  
		String sqlStr1="";
		
		sqlStr1 = " select  region_code, region_name from ( " + 
	            " select a.region_code region_code , a.region_name region_name from sRegionCode a, sProdLoginCtrl b " +
	            " where       decode(b.region_code,'99',b.region_code,a.region_code) = b.region_code " + 
	            " and    b.login_no ='" + loginNo + "' " + 
	            " union " +
	            " select a.region_code region_code , a.region_name region_name from sRegionCode a where region_code ='"+ regionCode+ "' ) " + 
	            " order by region_code";
		
		//retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
%>
    <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:sql><%=sqlStr1%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr" scope="end"/>
<%
		String[][] retListString1 = retArr;
		int errCode=Integer.parseInt(retCode);
		String errMsg=retMsg;

	  String workNo = loginNo;	
	  String workName = loginName;
	  String op_name = "地区列表";
	  String opName = op_name;

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
<form name="frm" method="POST" >
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">地区列表</div>
</div>
<table cellspacing="0" id="tab1">
	<tr>
		<th align="center">
			选择
		</th>
		<th  align="center">
			地区代码
		</th>
		<th align="center">
			地区名称
		</th>
	</tr>
</table>
<table cellspacing="0">
	<tr id="footer">
		<td>
	      <input class="b_foot" type="button" name="commit" onClick="doCommit();" value=" 确定 ">
	      <input class="b_foot" type="button" name="back" onClick="doClose();" value=" 关闭 ">
		</td>
	</tr>
</table>
</div>
</form>
</body>
</html>

<script>
	  
		<%for(int i=0;i < retListString1.length;i++){ %>
			var str='<input type="hidden" name="region_code" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="region_name" value="<%=retListString1[i][1]%>">';
		
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		<%}%>

		function doCommit()
		{
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("您没有选择地区代码！",0);
				return false;
			}
			else if("<%=retListString1.length%>"=="1"){//值为一条时不需要用数组
				if(document.all.num.checked){
					window.opener.fPubSimpSel.regionCode.value=document.all.region_code.value;
					//window.opener.form1.region_name.value=document.all.region_name.value;
					//window.close();
				}
				else{
					rdShowMessageDialog("您没有选择地区代码！",0);
					return false;
				}
			}
			else{//值为多条时需要用数组
				var a=-1;
				for(i=0;i<document.all.num.length;i++){
					if(document.all.num[i].checked){
						a=i;
						break;
					}
				}
				if(a!=-1){
					window.opener.fPubSimpSel.regionCode.value=document.all.region_code[a].value;
					//window.opener.form1.region_name.value=document.all.region_name[a].value;
					//window.close();
				}
				else{
					rdShowMessageDialog("您没有选择地区代码！",0);
					return false;
				}
			}
			window.close();
		}
	
	function doClose()
	{
		
		window.close();
	}
</script>