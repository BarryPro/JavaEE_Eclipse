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
System.out.println("####################################��֤�������Ƿ�ռ��===="+result.length);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>�������Ѿ���ռ��</title>
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
	<div id="title_zi">������Ϣ</div>
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
	 				<td class='blue'>�û�����</td>
	 				<td><%=result[i][1]%></td>
	 				<td class='blue'>��ϵ�绰</td>
	 				<td><%=result[i][4]%></td>
 				</tr>
 				<tr>
 					<td class='blue'>Ԥռ����</td>
	 				<td><%=result[i][0]%></td>
	 				<td class='blue'>���ʷ��ײ�</td>
	 				<td><%=result[i][5]%></td>
 				</tr>
 				<tr>
 					<td class='blue'>֤������</td>
	 				<td><%=result[i][2]%></td>
 					<td class='blue'>֤������</td>
 					<td><%=result[i][3]%></td>
 				</tr>
 				<tr>
 					<td class='blue'>Ԥռ��������</td>
 					<td><%=result[i][7]%></td>
	 				<td class='blue'>Ԥռ��������</td>
	 				<td><%=result[i][8]%></td>
 				</tr>
 				<tr>
 					<td class='blue'>Ӫҵ������</td>
	 				<td><%=result[i][6]%></td>
	 				<td class='blue'>Ԥռʱ��</td>
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
                <tr><td>�������Ѿ���ռ��,��ӪҵԱ�˶�֤������,��ȷ���Ƿ���������� </td></tr>
 			</table>
 			<!-- <span class="red">�������Ѿ���ռ��,��ӪҵԱ�˶�֤������,��ȷ���Ƿ���������� </span> <br> -->
 	<div id="footer">
		<input class="b_foot" name=back onClick="haveChoseGo()" type=button value=����>
		<input class="b_foot" name=back onClick="haveChoseBack()" type=button value=ȡ��>
	</div>
 		<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>