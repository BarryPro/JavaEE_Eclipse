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
String opCode="e833";
String opName="У԰Ӫ����������";
String iLoginPwd="";
String iPhoneNo="";
String iUserPwd="";
String iOpNote="";
%>


<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title><%=opCode%></title>
		<script>
		function backPage()
		{
			window.location.href=window.location.href; 
			window.location.reload; 
		}
		
		/*ѡ���ѯ����*/
		function getSaleCode()
		{
			
			if(document.all.saleCode.value=="") 
			{
				rdShowMessageDialog("�������봮������!",0)	;
				return false;
			}
            var patrn = /^[0-9]*[1-9][0-9]*$/;
            var sInput = document.all.saleCode.value;
            if (sInput.search(patrn) == -1) 
            {
                rdShowMessageDialog("������������Ϊ������!",0)	;
				return false;
            }
            
            if (  !(parseInt(document.all.saleCode.value , 10)<=1000 ) )
            {
                rdShowMessageDialog("������������С�ڵ���1000!",0)	;
				return false    ;      	
            }
            document.all.saleCode.value
            	=parseInt(document.all.saleCode.value , 10);
			
			//document.all.qryPage.disabled=true;
			/*ָ��Ajax����ҳ*/
			var packet = new AJAXPacket("fE833MainAjax.jsp"
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
			packet.data.add("saleCode",$("#saleCode").val());
			
			/*����ҳ��,��ָ���ص�����*/
			core.ajax.sendPacket(packet,setSCList,true);

			packet=null;			
		}
		
		
		function setSCList(packet)
		{
			/*��ò�ѯ�������*/
			var	arrScList	=packet.data.findValueByName("arrScList"); 
						
			/*��ѯ�б����*/
			$("#tabScList").empty();
			
			/*ƴ��ѯ�б��ͷ*/
			$("#tabScList").append("<tr>"
				+"<th align='center'>���</th>"
				+"<th align='center'>Ӫ������</th>"
				+"</tr>"
			);
		
			/*��ѯ�����Ϊ����չʾ*/
			if ( arrScList.length!=null )
			{
				/*������ѯ�����ά����ÿһ��*/
				for (var i=1;i<arrScList.length+1 ;i++ )
				{
					/*jquery����ƴ��̬table*/
					$("#tabScList").append("<tr>"
					+"<td align='center'>"+i+"</td>"
					+"<td align='center'>"+arrScList[i-1]+"</td>"
					+"</tr>");
				}
			}
			/*չʾ��ѯ���div*/
			$("#tabScList").show();
			document.all.titleSCL.style.display="";
			document.all.pntPage.disabled=false;
			document.all.qryPage.disabled=true;
		}	
			
		var excelObj;	
		function printTable(obj)
		{
		
			document.all.pntPage.disabled=false;
			var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
			total_row = 0;
			
			if(document.all.tabScList.length > 1)	
			{
				excelObj = new ActiveXObject('excel.Application');
				excelObj.Visible = true;
	 			excelObj.WorkBooks.Add;
				for(a=0;a<document.all.tabScList.length;a++)
				{
					rows=obj[a].rows.length;
					
					if(rows>0)
					{
		 				try
						{
							for(i=0;i<rows;i++)					{
								cells=obj[a].rows[i].cells.length;
								for(j=0;j<cells;j++)
		
									excelObj.Cells(i+1+(total_row),j+1).Value=obj[a].rows[i].cells[j].innerText+"";
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
				excelObj.UserControl = true;
				excelObj.WorkBooks.Add;
				excelRows=obj.rows.length;
				excelObj.rows.cells.NumberFormatLocal = "@";
				
				if(excelRows>0)
				{
		 			try
					{
						for(i=0;i<excelRows;i++)
						{
							cells=obj.rows[i].cells.length;
							for(j=0;j<cells;j++)
							{
								excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
							}
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
		</script>
	</head>
	<body>
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
				<div id="title_zi"><%=opName%></div>
			</div>
			
			<table id="tabQryType">
				<tr>
					<th>��������</th>
					<td>
						<input type="text" name="saleCode" id="saleCode" value="">
						<font color='red'>
						��ÿ�ο��������1000����
						</font>
					</td>
				</tr>	
			</table>
			
			<div	class="title" id="titleSCL" style="display:none">
				<div	id="title_zi">��ѯ���</div>
			</div>			
			<table id="tabScList" style="display:none"></table>
			<table>
				<tr>
					<td  id="footer">
						<input class="b_foot" type="button" name=qryPage value="����"
							onClick="getSaleCode()">
						<input class="b_foot" type="button" name=pntPage value="��������"
							onClick="printTable(tabScList);"  disabled>							
						<input class="b_foot" type="button" name=clsPage value="�ر�"
							onClick="removeCurrentTab();">	
						<input class="b_foot" type="button" name='backPage1' value="����"
							onClick="backPage()">		
					</td>
				</tr>
			</table>		
		</div>
	</form>
	</body>
</html>