<%
/*
 * zhangyan 2012-10-10 14:35:38
 ��������sg176Init
���ܣ�  ���Ų�Ʒǿ�ƿ��ػ���ʼ����ѯ����
ʱ�䣺  wuxy 20120904

 *@ ���������
 *@        sInLoginAccept             ������ˮ
 *@        sInChnSource               ������Դ
 *@        sInOpCode                  ��������
 *@        sInLoginNo                 ��������
 *@        sInLoginPwd                ��������
 *@        sInPhone                   �ֻ�����
 *@        sInUserPwd                 �ֻ��û�����
 *@        sInContractNo              ���Ų�Ʒ�ʻ����� 
 *@
 *@ ���ز�����
 *@         vUnitId                   ���ű���
 *@         vUnitName                 ��������
 *@       	vOfferName                ��Ʒ����
            vRunCode                  ״̬
            vRunName                  ״̬����
            vBeginTime                ��ʼʱ��
            vEndTime                  ����ʱ��

*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
%>


<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title><%=opCode%></title>
	</head>
	<body >
		<form  name="frm" action="" method="POST" >
			<input type="hidden" id="opCode" name	="opCode"	value= "<%=opCode%>">
			<input type="hidden" id="opName" name	="opName"	value= "<%=opName%>">
			<%@ include file="/npage/include/header.jsp" %>

			<DIV id="Operation_Table">

				<div class="title">
					<div id="title_zi"><%=opName%></div>
				</div>
				<table>
					<tr>
						<td align="center">���Ų�Ʒ�ʻ�����:</td>
						<td>
							<input type="text" id="contract_no" name="contract_no">
						</td>			
					</tr>			
					<tr> 
						<td  id="footer" colspan='2'>
							<input class="b_foot" type="button" name=nextBtn value="��һ��"
								onClick="nextStep();">
							<input class="b_foot" type="button" name=clsBtn value="�ر�"
								onClick="removeCurrentTab();">								
						</td>
					</tr>
				</table>	
			</div>
		</form>
	</body>
	<script type="text/javascript">		
		
	/*����������*/
	function nextStep()
	{
		var opCode=document.all.opCode.value;
		var opName=document.all.opName.value;
		
		if ( !forInt(document.all.contract_no) )
		{
			return false;
		}	
		
		document.frm.action="fG176Main.jsp?opCode="+opCode+"&opName="+opName;
		document.frm.submit();
	}

	</script>
</html>
