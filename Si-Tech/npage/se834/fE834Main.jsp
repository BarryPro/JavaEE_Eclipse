<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
String regCode	=(String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" 
	routerKey="region" routerValue="<%=regCode%>"  id="seq"/>
<%
String loginAccept=seq;
String iChnSource="01";
String opCode=request.getParameter("opCode");

String opCode1=request.getParameter("opCode");
String opName=request.getParameter("opName");
String iLoginPwd=(String)session.getAttribute("password");
String iPhoneNo="";
String iUserPwd="";
String iOpNote="";

/*�ʼ���Ϣ*/
String postBT="";
String postET="";

String clgBT="";
String clgET="";
%>


<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title><%=opCode%></title>
		<script language="javascript" type="text/javascript" 
			src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
		<script>
		/*����excel*/
		var excelObj;
		function printTab(obj)
		{
			document.all.pntPage.disabled=false;

			var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
			total_row = 0;
			if(document.all.tabList.length > 1)	
			{
				excelObj = new ActiveXObject('excel.Application');
				excelObj.Visible = true;
	 			excelObj.WorkBooks.Add;
				for(a=0;a<document.all.tabList.length;a++)
				{
					rows=obj[a].rows.length;
					if(rows>0)
					{
		 				try
						{
							for(i=0;i<rows;i++)					{
								cells=obj[a].rows[i].cells.length;
								for(j=0;j<cells;j++)
									excelObj.Cells(i+1+(total_row),j+1).Value=obj[a].rows[i].cells[j].innerText;
							}
						}
						catch(e)
						{
							//alert('����excelʧ��!');
						}
					}
					else
					{
						alert('no data');
		 			}
		 			total_row = eval(total_row+rows);
				}
			}
			else
			{
				excelObj = new ActiveXObject('excel.Application');
				excelObj.Visible = true;
				excelObj.WorkBooks.Add;
				rows=obj.rows.length;
				if(rows>0)
				{
		 			try
					{
						for(i=0;i<rows;i++)
						{
							cells=obj.rows[i].cells.length;
							for(j=0;j<cells;j++)
								excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
						}
					}
					catch(e)
					{
						//alert('����excelʧ��!');
					}
					total_row = eval(total_row+rows);
				}
				else
				{
					alert('no data');
				}
			}
		}			
			
		function init()
		{
			if ("<%=opCode1%>"=="e835")
			{
				document.all.rdoQryType[2].checked=true;
				
				document.all.qryCdn.style.display="block";
				/*չʾѧУ��Ϣ��ѯ��������*/
				document.all.qryCdn2.style.display="none";
				/*�����ʼ���Ϣ��ѯ��������*/
				document.all.qryCdn3.style.display="block";
				/*���ز�ѯ����б�*/	
				document.all.qryList.style.display="none";						
				
			}	
		}
			
		/*ѡ���ѯ����*/
		function getQryInfo(qryType)
		{
			if("1"==qryType)/*δ���������ѯ*/
			{
				/*�޲�ѯ��������,ֱ��Ajax��ʽ���ú�̨����*/
				document.all.qryCdn.style.display="none";
				/*չʾѧУ��Ϣ��ѯ��������*/
				document.all.qryCdn2.style.display="none";
				/*�����ʼ���Ϣ��ѯ��������*/
				document.all.qryCdn3.style.display="none";
				/*���ز�ѯ����б�*/	
				document.all.qryList.style.display="block";	
				/*���ص�����ť*/
				document.all.pntPage.style.display="none";	
				
				
				/*��ajax������*/
				var packet = new AJAXPacket("fE834MainAjax.jsp"
					,"���Ժ�...");
					
				/*��ajaxҳ�洫�ݲ���*/
				packet.data.add("loginAccept",$("#loginAccept").val());
				packet.data.add("iChnSource",$("#iChnSource").val());
				packet.data.add("opCode",$("#opCode").val());
				packet.data.add("opName",$("#opName").val());
				packet.data.add("iLoginPwd",$("#iLoginPwd").val());
				packet.data.add("iPhoneNo",$("#iPhoneNo").val());
				packet.data.add("iUserPwd",$("#iUserPwd").val());
				packet.data.add("iOpNote",$("#iOpNote").val());		
				packet.data.add("ajaxType","INIT");			
				
				/*����ҳ��,��ָ���ص�����*/
				core.ajax.sendPacket(packet,setInitInfo,true);
	
				packet=null;					
			}
			else if ("2"==qryType)/*�ʼ���Ϣ��ѯ*/
			{
				document.all.qryCdn.style.display="block";
				/*չʾ�ʼ���Ϣ��ѯ��������*/
				document.all.qryCdn2.style.display="block";
				/*����ѧУ��Ϣ��ѯ��������*/
				document.all.qryCdn3.style.display="none";
				/*���ز�ѯ����б�*/
				document.all.qryList.style.display="none";
				/*��ʾ��ť*/
				document.all.pntPage.style.display="";	
			}
			else if ("3"==qryType)/*ǰ��Ӫ��ѧУ��Ϣ��ѯ*/
			{
				document.all.qryCdn.style.display="block";
				/*չʾѧУ��Ϣ��ѯ��������*/
				document.all.qryCdn2.style.display="none";
				/*�����ʼ���Ϣ��ѯ��������*/
				document.all.qryCdn3.style.display="block";
				/*���ز�ѯ����б�*/	
				document.all.qryList.style.display="none";		
				/*��ʾ��ť*/
				document.all.pntPage.style.display="";		
			}
		}
		
		/*��ѯ�ʼ���Ϣ*/
		function getPostInfo()
		{
			if (document.all.postBT.value.trim()=="")
			{
				rdShowMessageDialog("���뿪ʼʱ����д!",0);
				return false;
			}
			
			if (document.all.postET.value.trim()=="")
			{
				rdShowMessageDialog("�������ʱ����д!",0);
				return false;
			}
			
			if ( !(document.all.postBT.value<=document.all.postET.value) )
			{
				rdShowMessageDialog("��ʼʱ�����С�ڵ��ڽ���ʱ��!",0);
				return false;			
			}
			/*��ajax������*/
			var packet = new AJAXPacket("fE834MainAjax.jsp"
				,"���Ժ�...");
				
			/*��ajaxҳ�洫�ݲ���*/
			packet.data.add("saleCode",$("#saleCode").val() );
			
			packet.data.add("loginAccept",$("#loginAccept").val());
			packet.data.add("iChnSource",$("#iChnSource").val());
			packet.data.add("opCode",$("#opCode").val());
			packet.data.add("opName",$("#opName").val());
			packet.data.add("iLoginPwd",$("#iLoginPwd").val());
			packet.data.add("iPhoneNo",$("#iPhoneNo").val());
			packet.data.add("iUserPwd",$("#iUserPwd").val());
			packet.data.add("iOpNote",$("#iOpNote").val());
			packet.data.add("postBT",$("#postBT").val());			
			packet.data.add("postET",$("#postET").val());			
			packet.data.add("ajaxType","POST");			
			
			/*����ҳ��,��ָ���ص�����*/
			core.ajax.sendPacket(packet,setPostInfo,true);

			packet=null;				
		}
		
		function setPostInfo(packet)
		{
			/*��ò�ѯ�������*/
			var	arrP	=packet.data.findValueByName("arrP"); 
			var retCodeP=packet.data.findValueByName("retCodeP");	
			var retMsgP=packet.data.findValueByName("retMsgP");	
			if ( retCodeP!="000000" )
			{
				rdShowMessageDialog(retCodeP+":"+retMsgP);
				window.location="fE834Main.jsp?opCode=<%=opCode%>"
				+"&opName=<%=opName%>";	
			}
			/*��ѯ�б����*/
			$("#tabList").empty();
			
			if ( arrP.length!=0 )
			{
				/*ƴ��ѯ�б��ͷ*/
				$("#tabList").append("<tr>"
					+"<th align='center'>�ֻ�����</th>"
					+"<th align='center'>�ʼĵ�ַ</th>"
					+"<th align='center'>��������</th>"
					+"<th align='center'>�ռ�������</th>"
					+"<th align='center'>�ռ��˵绰</th>"
					+"</tr>"
				);		
				
				for ( var i=0;i<arrP.length; i++ )
				{
					$("#tabList").append("<tr>"
						+"<td align='center'>"+arrP[i][0]+"</td>"
						+"<td align='center'>"+arrP[i][1]+"</td>"
						+"<td align='center'>"+arrP[i][2]+"</td>"
						+"<td align='center'>"+arrP[i][3]+"</td>"
						+"<td align='center'>"+arrP[i][4]+"</td>"
					+"</tr>");
				}		
			}
			else
			{
				$("#tabList").append("<tr>"
					+"<td align='center' colspan='6'>"+"���ʼ���Ϣ!"+"</td>"
				+"</tr>"	);			
			}
			document.all.qryList.style.display="";	
		}
		
		function getClgInfo()
		{
			if (document.all.clgBT.value.trim()=="")
			{
				rdShowMessageDialog("���뿪ʼʱ����д!",0);
				return false;
			}
			
			if (document.all.clgET.value.trim()=="")
			{
				rdShowMessageDialog("�������ʱ����д!",0);
				return false;
			}
			
			if ( !(document.all.clgBT.value<=document.all.clgET.value) )
			{
				rdShowMessageDialog("��ʼʱ�����С�ڵ��ڽ���ʱ��!",0);
				return false;			
			}			
			
			/*��ajax������*/
			var packet = new AJAXPacket("fE834MainAjax.jsp"
				,"���Ժ�...");
				
			/*��ajaxҳ�洫�ݲ���*/
			packet.data.add("saleCode",$("#saleCode").val() );
			
			packet.data.add("loginAccept",$("#loginAccept").val());
			packet.data.add("iChnSource",$("#iChnSource").val());
			packet.data.add("opCode",$("#opCode").val());
			packet.data.add("opName",$("#opName").val());
			packet.data.add("iLoginPwd",$("#iLoginPwd").val());
			packet.data.add("iPhoneNo",$("#iPhoneNo").val());
			packet.data.add("iUserPwd",$("#iUserPwd").val());
			packet.data.add("iOpNote",$("#iOpNote").val());
			packet.data.add("clgBT",$("#clgBT").val());			
			packet.data.add("clgET",$("#clgET").val());			
			packet.data.add("ajaxType","CLG");			
			
			/*����ҳ��,��ָ���ص�����*/
			core.ajax.sendPacket(packet,setClgInfo,true);

			packet=null;
		}
		
		function setClgInfo(packet)
		{
			/*��ò�ѯ�������*/
			var	arrC	=packet.data.findValueByName("arrC"); 
			var retCodeC=packet.data.findValueByName("retCodeC");	
			var retMsgC=packet.data.findValueByName("retMsgC");	
			if ( retCodeC!="000000" )
			{
				rdShowMessageDialog(retCodeC+":"+retMsgC);
				window.location="fE834Main.jsp?opCode=<%=opCode%>"
				+"&opName=<%=opName%>";	
			}						
			/*��ѯ�б����*/
			$("#tabList").empty();
			if ( arrC.length!=0 )
			{
				/*ƴ��ѯ�б��ͷ*/
				$("#tabList").append("<tr>"
					+"<th align='center'>�ֻ�����</th>"
					+"<th align='center'>ѧУ����</th>"
					+"<th align='center'>ѧԺ����</th>"
					+"<th align='center'>רҵ����</th>"
					+"<th align='center'>������������</th>"
					+"</tr>"
				);		
				
				for ( var i=0;i<arrC.length; i++ )
				{
					$("#tabList").append("<tr>"
						+"<td align='center'>"+arrC[i][0]+"</td>"
						+"<td align='center'>"+arrC[i][1]+"</td>"
						+"<td align='center'>"+arrC[i][2]+"</td>"
						+"<td align='center'>"+arrC[i][3]+"</td>"
						+"<td align='center'>"+arrC[i][4]+"</td>"
					+"</tr>");
				}		
			}
			else
			{
				$("#tabList").append("<tr>"
					+"<td align='center' colspan='6'>"+"��ѧУ��Ϣ!"+"</td>"
				+"</tr>"	);			
			}
			document.all.qryList.style.display="";	
		}
		
		function setInitInfo(packet)
		{
			/*��ò�ѯ�������*/
			var	arrI =packet.data.findValueByName("arrI"); 
			var retCodeI=packet.data.findValueByName("retCodeI");	
			var retMsgI=packet.data.findValueByName("retMsgI");	
			if ( retCodeI!="000000" )
			{
				rdShowMessageDialog(retCodeI+":"+retMsgI);
			window.location="fE834Main.jsp?opCode=<%=opCode%>"
				+"&opName=<%=opName%>";	
			}							
			/*��ѯ�б����*/
			$("#tabList").empty();
			if ( arrI.length!=0 )
			{
				/*ƴ��ѯ�б��ͷ*/
				$("#tabList").append("<tr>"
					+"<th align='center'>�ֻ�����</th>"
					+"<th align='center'>���֤��</th>"
					+"<th align='center'>ԤռID</th>"
					+"</tr>"
				);		
				
				for ( var i=0;i<arrI.length; i++ )
				{
					$("#tabList").append("<tr>"
						+"<td align='center'>"+arrI[i][0]+"</td>"
						+"<td align='center'>"+arrI[i][1]+"</td>"
						+"<td align='center'>"+arrI[i][2]+"</td>"
					+"</tr>");
				}		
			}
			else
			{
				$("#tabList").append("<tr>"
					+"<td align='center' colspan='3'>"+"��ǰ��Ӫ����Ϣ!"+"</td>"
				+"</tr>"	);			
			}
			document.all.qryList.style.display="";				
		}

		function resetPage()
		{
			window.location="fE834Main.jsp?opCode=<%=opCode%>"
				+"&opName=<%=opName%>";	
		}
		</script>
	</head>
	<body onload="init()">
	<form name='frmE834' action='' method='POST'>
		<input type="hidden" name="loginAccept" id="loginAccept" value="<%=loginAccept%>">
		<input type="hidden" name="iChnSource" id="iChnSource"  value="<%=iChnSource%>">
		<input type="hidden" name="opCode" id="opCode"  value="<%=opCode%>">
		<input type="hidden" name="opName" id="opName"  value="<%=opName%>">
		<input type="hidden" name="iLoginPwd" id="iLoginPwd"  value="<%=iLoginPwd%>">
		<input type="hidden" name="iPhoneNo" id="iPhoneNo"  value="<%=iPhoneNo%>">
		<input type="hidden" name="iUserPwd" id="iUserPwd"  value="<%=iUserPwd%>">
		<input type="hidden" name="iOpNote" id="iOpNote"  value="<%=iOpNote%>">		
		
		<div id="Operation_Title">
			<div class="icon"></div>
			<B><%=opCode%>.<%=opName%></B>
		</div>
		<!--��ѯ����-->
		<DIV	id="Operation_Table">
			<div class="title">
				<div id="title_zi"><%=opCode%>.<%=opName%></div>
			</div>
			
			<table id="tabQryType">
				<tr>
					<th align="center">��ѯ����</th>
					<th align="center">
						<input type="radio" name="rdoQryType" value="1"
							onclick="getQryInfo(1)">
							δ���������ѯ &nbsp&nbsp
						<input type="radio" name="rdoQryType" value="2"
							onclick="getQryInfo(2)">
							�ʼ���Ϣ��ѯ &nbsp&nbsp
						<input type="radio" name="rdoQryType" value="3"
							onclick="getQryInfo(3)">
							ǰ��Ӫ��ѧУ��Ϣ��ѯ &nbsp&nbsp
					</th>
				</tr>	
			</table>

			<!--��ѯ����б�-->	
			<div id="qryCdn" style="display:none">
				<div	class="title">
					<div	id="title_zi">��ѯ����</div>
				</div>
			</div>	
				<!--�ʼ���Ϣ-->
				<table id="qryCdn2" name="qryCdn2" style="display:none">
					<tr>
						<tH align='center'>��ʼʱ��</tH>
						<td>
							<input type="type" name='postBT' id='postBT' 
								readOnly value=''>
							<font color="orange">*<font>
							<img id = "imgPostBT" 
								onclick="WdatePicker({el:'postBT',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" 
		 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
						</td>
						<tH align='center'>����ʱ��</tH>
						<td>
							<input type="type" name='postET' id='postET' 
								readOnly value=''>
							<font color="orange">*<font>
							<img id = "imgPostET" 
								onclick="WdatePicker({el:'postET',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" 
		 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
						</td>
					</tr>
					<tr>
						<td  id="footer" colspan="4">
							<input class="b_foot" type="button" name=qryPage value="��ѯ"
								onClick="getPostInfo()">
							<input class="b_foot" type="button" name=clsPage value="�ر�"
								onClick="removeCurrentTab();">					
						</td>
					</tr>
				</table>
				
				<!--ѧУ��Ϣ-->
				<table id="qryCdn3" name="qryCdn3" style="display:none">
					<tr>
						<tH align='center'>��ʼʱ��</tH>
						<td>
							<input type="type" name='clgBT' id='clgBT' 	
								readOnly value=''>
							<font color="orange">*<font>
							<img id = "imgClgBT" 
							onclick="WdatePicker({el:'clgBT',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" 
	 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
						</td>
						<tH align='center'>����ʱ��</tH>
						<td>
							<input type="type" name='clgET' id='clgET' 	
								readOnly value=''>
							<font color="orange">*<font>
							<img id = "imgClgET" 
							onclick="WdatePicker({el:'clgET',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" 
	 						src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle"/>
						</td>
					</tr>	
					<tr>
						<td  id="footer" colspan="4">
							<input class="b_foot" type="button" name=qryPage value="��ѯ"
								onClick="getClgInfo()">
							<input class="b_foot" type="button" name=clsPage value="�ر�"
								onClick="removeCurrentTab();">					
						</td>
					</tr>
				</table>
				
			<!--��ѯ����б�-->	
			<div id="qryList" name="qryList" style="display:none">
				<div	class="title">
					<div	id="title_zi">��ѯ���</div>
				</div>
				<!--��ѯ����б�-->
				<table id="tabList"></table>
				<table>
					<tr>
						<td  id="footer" colspan="4">
							<input class="b_foot" type="button" name=pntPage value="����"
								onClick="printTab(tabList)">
							<input class="b_foot" type="button" name=clsPage value="�ر�"
								onClick="removeCurrentTab();">		
							<input class="b_foot" type="button" name=rstPage value="����"
								onClick="resetPage()">	
						</td>
					</tr>	
				</table>
			</div>
		</div>
	</form>
	</body>
</html>