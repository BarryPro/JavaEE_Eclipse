<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
String regCode	=(String)session.getAttribute("regCode");
String opCode="e824";
String opName="ʡ��Я���û���Ϣ��ѯ";

String zPhoneNo = (String)request.getParameter("activePhone");
%>


<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>ʡ��Я���û���Ϣ��ѯ</title>
		<script>

		function getTabList()
		{
			if (document.all.phoneNo.value.trim()=="")
			{
				rdShowMessageDialog("���������ֻ�����!",0);
				return false;
			}
			
			/*ָ��Ajax����ҳ*/
			var packet = new AJAXPacket("fE824MainAjax.jsp"
				,"���Ժ�...");
				
			/*��ajaxҳ�洫�ݲ���*/
			packet.data.add("phoneNo",document.all.phoneNo.value.trim() );
			
			/*����ҳ��,��ָ���ص�����*/
			core.ajax.sendPacket(packet,setTabList,true);
			packet=null;
		}
		
		/*�����ѯ�б�*/
		function setTabList(packet)
		{
			/*��ѯ�б����*/
			$("#tabList").empty();
			var	errCode	=packet.data.findValueByName("errCode"); 
			var	errMsg	=packet.data.findValueByName("errMsg"); 

			if (errCode=="000000")
			{
				/*��ò�ѯ�������*/
				var	arrTabList	=packet.data.findValueByName("arrTabList"); 
				
				/*��ѯ�����Ϊ����չʾ*/
				if ( arrTabList.length!=0)
				{
					/*ƴ��ѯ�б��ͷ*/
					$("#tabList").append("<tr>"
						+"<th align='center'>����ʱ��</th>"
						+"<th align='center'>������</th>"
						+"<th align='center'>��Чʱ��</th>"
						+"<th align='center'>Я���</th>"
						+"<th align='center'>Я����</th>"
						+"</tr>"
					);				
					
					/*������ѯ�����ά����ÿһ��*/
					for (var i=0;i<arrTabList.length ;i++ )
					{
						/*jquery����ƴ��̬table*/
						$("#tabList").append("<tr>"
						+"<td><input type='text' id='oprTime"+i+"' name='oprTime"+i+"' "
							+"value='"+arrTabList[i][1]+"' class='InputGrey'></td>"
						+"<td><input type='text' id='oprWorkNo"+i+"' name='oprWorkNo"+i+"' "
							+"value='"+arrTabList[i][2]+"' class='InputGrey'></td>"					
						+"<td><input type='text' id='effTime"+i+"' name='oprEffTime"+i+"' "
							+"value='"+arrTabList[i][3]+"' class='InputGrey'></td>"					
						+"<td><input type='text' id='inGrp"+i+"' name='oprInGrp"+i+"' "
							+"value='"+arrTabList[i][4]+"' class='InputGrey'></td>"
						+"<td><input type='text' id='outGrp"+i+"' name='outGrp"+i+"' "
							+"value='"+arrTabList[i][5]+"' class='InputGrey'></td>"						
						+"</tr>"
						);
					}
				}
				else
				{
					$("#tabList").append("<tr>"
						+"<td colspan='5' align='center'>"
						+"��ʡ��Я����Ϣ!"
						+"</tr>");		
				}
				/*չʾ��ѯ���div*/
				$("#divList").show();
			}
			else
			{
				rdShowMessageDialog(errCode+":"+errMsg);	
				document.getElementById("divList").style.display="none";

				return false;
			}

			
		}
		
		function clearFrm()
		{
			document.all.phoneNo.value="";
			$("#tabList").empty();
		}
		</script>
	</head>
	<body>
	<form name='frm' action='' method='POST'>
		<div	id="Operation_Title">
			<div	class="icon"></div>
				<B><%=opCode%>��<%=opName%></B>
		</div>
		<!--��ѯ����-->
		<DIV	id="Operation_Table">
			<div class="title">
				<div id="title_zi"><%=opName%></div>
			</div>
			
			<table id="libs">
				<tr>
					<th align="center">�ֻ�����</th>
					<td><input	TYPE="TEXT" id='phoneNo' name='phoneNo' value="<%=zPhoneNo%>">
						<font color="orange">*<font>
						</td>
				</tr>	
			</table>
			<!--������ť-->
			<table>
				<tr>
					<td  id="footer">

						<input class="b_foot" type="button" name=qryPage value="��ѯ"
							onClick="getTabList()">
						<input class="b_foot" type="button" name=qryPage value="���"
							onClick="clearFrm()">							
						<input class="b_foot" type="button" name=qryPage value="�ر�"
							onClick="removeCurrentTab();">						
					</td>
				</tr>
			</table>		
			
			<!--��ѯ����б�-->	
			<div id="divList" style="display:none">
				<div	class="title">
					<div	id="title_zi">��ѯ����б�</div>
				</div>
				<!--��Ʒ���б�-->
				<table id="tabList"></table>
			</div>
		</div>
	</form>
	</body>
<html>
