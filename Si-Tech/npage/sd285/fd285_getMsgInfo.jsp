
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ���Ѷ�������
�� * �汾: v2.0
�� * ����: 2011/3/28
�� * ����: ningtn
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
			<%@ page contentType= "text/html;charset=gb2312" %>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
			response.setHeader("Pragma","No-Cache"); 
			response.setHeader("Cache-Control","No-Cache");
			response.setDateHeader("Expires", 0); 
			
			String opCode = "d285";
			String opName = "���Ѷ�������-ģ����Ϣ��ѯ";
			
			String regionCode = (String)session.getAttribute("regCode");
			
			String sMsgCode = WtcUtil.repNull(request.getParameter("sMsgCode"));
			String sMsgName = WtcUtil.repNull(request.getParameter("sMsgName"));
			String sKindCode = WtcUtil.repNull(request.getParameter("kindCode"));
			System.out.println("======sKindCode===" + sKindCode+"|"+sMsgCode+"|"+sMsgName);
%>
			<wtc:service name="sd285Qry" routerKey="region" routerValue="<%=regionCode%>" 
				 retcode="retCode1" retmsg="retMsg1" outnum="3">
				<wtc:param value="<%=sMsgCode%>"/>  
				<wtc:param value="<%=sMsgName%>"/> 
				<wtc:param value="<%=sKindCode%>"/> 
			</wtc:service>
			<wtc:array id="resultArr" scope="end" />
<html>
	<head>
	<title>���Ѷ�������-ģ����Ϣ��ѯ</title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			function doConfirm(){
				var functionRadios = document.getElementsByName("functionRadio");	
				var returnStr = "";
				for(var i=0;i<functionRadios.length;i++){
					if(functionRadios[i].checked){
						var radioValue = functionRadios[i].value;
						var valueArr = radioValue.split("|");
						var impFrm = window.dialogArguments;
						/*
						impFrm.MsgCode.value = valueArr[0];
						impFrm.MsgName.value = valueArr[1];
						impFrm.sTemplateContent.value = valueArr[2];
						*/
						window.returnValue= radioValue;
						doClose();
					}
				}				
			}
			
			function doClose(){
				window.close();	
			}
		//-->
	</script>
</head>
<body>
		<%@ include file="/npage/include/header_pop.jsp" %>
     <table cellspacing="0">
			<tr height=25 align="center">
				<th width="15%" nowrap>ѡ��</td>
				<th nowrap>ģ�����</td>
				<th nowrap>ģ������</td> 
			</tr> 
	<%
			if(resultArr.length==0){
				out.println("<tr height='25' align='center'><td colspan='3'>");
				out.println("û���κμ�¼��");
				out.println("</td></tr>");
			}else if(resultArr.length>0){
				String tbclass = "";
				for(int i=0;i<resultArr.length;i++){
					tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>">
								<input type="radio" name="functionRadio" value="<%=resultArr[i][0]%>|<%=resultArr[i][1]%>|<%=resultArr[i][2]%>">	
							</td>
							<td class="<%=tbclass%>"><%=resultArr[i][0]%>&nbsp;</td>
							<td class="<%=tbclass%>"><%=resultArr[i][1]%>&nbsp;</td>
						</tr>
	<%				
				}
			}
	%>
  </table>
	 <table cellspacing="1">
	  <tr> 
	    <td id="footer"> 
	       <input type="button" name="confirmButton" class="b_foot" value="ȷ��" style="cursor:hand;" onClick="doConfirm()" >&nbsp;
	       <input type="button" name="closeButton" class="b_foot" value="�ر�" style="cursor:hand;" onClick="doClose()" >&nbsp;
	    </td>
	  </tr>
	 </table>
 	<%@ include file="/npage/include/footer_pop.jsp" %>
</body>
</html>    		

 
