<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa@2010-1-14 :14:39
********************/
%>
              
<%
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              
			
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<head>
	
<title>手机电视 </title>
 
<script language=javascript>
	
 function mysub(){
 	document.frm.action = "f6993_2.jsp";
 	document.frm.submit();
 }
  
</script>
</head>
<body>
	
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">手机电视</div>
</div>

	<table  cellspacing="0" >
		<tr>
			 <td class="blue">
			 受理号码
			 </td>
			 
			 <td>
			 	<input type="text"  name="phoneNo"  id="phoneNo" value="<%=activePhone%>" readOnly class="InputGrey">
			</td>
			
			<td class="blue">
			 操作类型
			 </td>
			 
			 <td>
			 	<select id="opType" name="opType">
			 		<option value="01">订购</option>
			 		<option value="02">取消</option>
			  </select>	
			</td>
		</tr>
		<tr>
			<td class="blue">
			 业务类型
			 </td>
			 
			 <td>
			 	<select id="ywType" name="ywType">
			 		<option value="01">央视</option>
			 		<option value="02">东方</option>
			  </select>	
			</td>
			
			
			<td class="blue">
			 下发类型
			 </td>
			 
			 <td>
			 	<select id="xfType" name="xfType">
			 		<option value="02">SMS</option>
			 		<option value="01">WAP</option>
			  </select>	
			</td>
		</tr>
 <tr>
			<td class="blue">
			 渠道类型
			 </td>
			 
			 <td>
			 	<select id="qdType" name="qdType">
			 		<option value="01">BOSS</option>
			 		<option value="02">网上营业厅</option>
			 		<option value="03">掌上营业厅</option>
			 		<option value="04">短信营业厅</option>
			 		<option value="05">多媒体查询机</option>
			 		<option value="06">10086</option>
			  </select>	
			</td>
			
			
			<td class="blue">
			 &nbsp;
			 </td>
			 
			 <td>
			 	&nbsp;
			</td>
		</tr>
		 
		</table>
 
		<table>
		<tr>
			<td id="footer" >
				<input type="button" value="确定" class="b_foot" onclick="mysub()">
				<input type="button" value="关闭" class="b_foot" onclick="removeCurrentTab()">
			</td>
		</tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>