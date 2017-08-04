<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
	String goodNo = WtcUtil.repNull(request.getParameter("goodNo"));
	System.out.println("####################################goodNo===="+goodNo);
	String sqlStr="select a.order_id,nvl(a.user_name,' '),b.id_name,a.user_id,a.contact_num,e.product_name,nvl(a.operation_hallname,' '),c.kind_name,d.group_name,a.op_time from sresphoneorder a,sidtype b,sChnClassKind c ,dChnGroupMsg d ,product e where a.id_type=b.id_type and a.channel_type=c.class_kind and a.order_channel=d.group_id and a.product_id=e.product_id and trim(a.phone_no)='"+goodNo+"'";
%>
<wtc:pubselect name="sPubSelect" outnum="10">
	<wtc:sql><%=sqlStr%></wtc:sql> 
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<%
System.out.println("####################################验证该靓号是否被占用===="+result.length);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>该靓号已经被占用</title>
		 <script type="text/javascript">
		 	function haveChoseBack(){
		 				window.returnValue = "11";
						window.close();
		 		}
		 		function haveChoseGo(){
		 				window.returnValue = "00";
						window.close();
		 			}
		 </script>
	</head>
	<body>
	<form method=post name="frm" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
	<div id="title_zi">靓号信息</div>
</div>
 			<table cellspacing=0>
<%
 			if(retCode.equals("000000")){
 				if (result.length < 1)
					{
%>
				<script language="JavaScript">
						window.returnValue="00";
						window.close();
				</script>
<%
				}else{
					for(int i=0;i<result.length;i++){
%>
 				<tr>
	 				<td class='blue'>用户姓名</td>
	 				<td><%=result[i][1]%></td>
	 				<td class='blue'>联系电话</td>
	 				<td><%=result[i][4]%></td>
 				</tr>
 				<tr>
 					<td class='blue'>预占单号</td>
	 				<td><%=result[i][0]%></td>
	 				<td class='blue'>主资费套餐</td>
	 				<td><%=result[i][5]%></td>
 				</tr>
 				<tr>
 					<td class='blue'>证件类型</td>
	 				<td><%=result[i][2]%></td>
 					<td class='blue'>证件号码</td>
 					<td><%=result[i][3]%></td>
 				</tr>
 				<tr>
 					<td class='blue'>预占渠道类型</td>
 					<td><%=result[i][7]%></td>
	 				<td class='blue'>预占渠道名称</td>
	 				<td><%=result[i][8]%></td>
 				</tr>
 				<tr>
 					<td class='blue'>营业厅名称</td>
	 				<td><%=result[i][6]%></td>
	 				<td class='blue'>预占时间</td>
	 				<td><%=result[i][9]%></td>
 				</tr>
<%					
						}
					}
 				}else{
%>
				<script language="JavaScript">
					  window.returnValue = "22";
					  window.close();
				</script>
<%
	}
%>
                <tr><td>该靓号已经被占用,请营业员核对证件号码,以确定是否继续入网。 </td></tr>
 			</table>
 			<!-- <span class="red">该靓号已经被占用,请营业员核对证件号码,以确定是否继续入网。 </span> <br> -->
 	<div id="footer">
		<input class="b_foot" name=back onClick="haveChoseGo()" type=button value=继续>
		<input class="b_foot" name=back onClick="haveChoseBack()" type=button value=取消>
	</div>
 		<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>