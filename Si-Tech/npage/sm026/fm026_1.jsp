<%
/********************
 version v2.0
 ������ si-tech
 create hejwa 2014-1-15 10:40:38
********************/
%>
              
<%
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String currentDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	
	java.util.Calendar calendar = java.util.Calendar.getInstance();
	calendar.add(java.util.Calendar.DAY_OF_YEAR, 1);
	String hyDate = new java.text.SimpleDateFormat("yyyyMMdd").format(calendar.getTime()); 
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>
	
	

	
	
function reSetThis(){
	location = location;	
}

function doQuery(){
	if($("#sSiName").val().trim()==""&&$("#sSiAccNumber").val().trim()==""&&$("#sPhoneNo").val()==""){
		rdShowMessageDialog("����������һ����ѯ����");
		return;
	}
	var packet = new AJAXPacket("fm026_AjaxGetList.jsp","���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");
			packet.data.add("sSiName",$("#sSiName").val());
			packet.data.add("sSiAccNumber",$("#sSiAccNumber").val());
			packet.data.add("sPhoneNo",$("#sPhoneNo").val());
			core.ajax.sendPacket(packet,doGetAjaxInfo);
			packet =null;
}

function doGetAjaxInfo(packet){
	var code = packet.data.findValueByName("code");
	var msg = packet.data.findValueByName("msg");
	if("000000"==code){
		var retArray = packet.data.findValueByName("retArray");
		var trObjdStr = "";
		
		if(retArray.length>0){
			$("#showReTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
			 
				trObjdStr += "<tr>"+
										 "<td>"+retArray[i][0]+"</td>"+
										 "<td>"+retArray[i][1]+"</td>"+
										 "<td>"+retArray[i][2]+"</td>"+
										 "<td>"+retArray[i][3]+"</td>"+
										 "<td>"+retArray[i][4]+"</td>"+
										 "<td>"+retArray[i][5]+"</td>"+
										 "</tr>";
			}
			
			if(""!=trObjdStr){
				$("#showReTab tr:eq(0)").after(trObjdStr);
				$("#showReDiv").show();
				$("#saveToExcelBtn").show();
				
			}else{
				$("#showReDiv").hide();
				$("#saveToExcelBtn").hide();
			}
		}else{
			$("#showReDiv").hide();
			$("#saveToExcelBtn").hide();
			rdShowMessageDialog("��ѯ�б�Ϊ��");
		}
	}else{
		$("#showReDiv").hide();
		$("#saveToExcelBtn").hide();
		rdShowMessageDialog("��ѯ����"+code+"��"+msg);
	}
}

var excelObj;
function saveToExcel(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.showReTab.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 excelObj.WorkBooks.Add; 
		for(a=0;a<document.all.showReTab.length;a++)
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
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">��ѯ����</div></div>
<input type="hidden" name="opCode" value="<%=opCode%>" />
<input type="hidden" name="opName" value="<%=opName%>" />
<input type="hidden" name="iRowStart" value="1" />
<input type="hidden" name="iRowEnd" value="10" />
<table cellSpacing="0">
	<tr>
		<td class="blue" width="11%">��ҵ����</td>
		<td  width="22%"><input type="text" name="sSiName" id="sSiName" value="" /> </td>
		
		<td class="blue" width="11%">EC���������</td>
		<td  width="22%"><input type="text" name="sSiAccNumber" id="sSiAccNumber" value="" /> </td>
		
		<td class="blue" width="11%">�ֻ�����</td>
		<td  width="22%"><input type="text" name="sPhoneNo" id="sPhoneNo" value="" /> </td>
		
	</tr>
</table>

<TABLE cellSpacing=0>
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="��ѯ" onclick="doQuery()"           />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
			<input type="button" class="b_foot" value="EXCEL����" onclick="saveToExcel(showReTab)" id="saveToExcelBtn"  style="display:none"  /> 
	 	</td>
	</tr>
</table>
 
<div id="showReDiv" style="display:none">
	<table id="showReTab" cellSpacing="0">
		<tr>
			<th>�û��ֻ�����</th>
			<th>��ҵ����</th>
			<th>EC���������</th>
			<th>ҵ�����</th>
			<th>ҵ������</th>
			<th>������������ʱ��</th>
		</tr>
	</table>
</div>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>