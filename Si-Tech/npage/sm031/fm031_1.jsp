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
	
	if(document.all.endDate.value==""||document.all.beginDate.value==""){
		rdShowMessageDialog("�����뿪ʼʱ�䡢����ʱ��");
		return;
	}
	if(document.all.endDate.value<document.all.beginDate.value){
		rdShowMessageDialog("����ʱ�䲻��С�ڿ�ʼʱ�䣬����������");
		document.all.beginDate.focus();
		document.all.endDate.value="";
		return;
	}
	var beginDateStr = document.all.beginDate.value;
	var endDateStr = document.all.endDate.value;
	var beginDateSub = beginDateStr.substring(0,6);
	var endDateSub = endDateStr.substring(0,6);
	if(beginDateSub != endDateSub){
		rdShowMessageDialog("��ʼʱ�������ʱ�������һ����Ȼ���ڣ�");
		return false;
	}
	
	var packet = new AJAXPacket("fm031_AjaxGetList.jsp","���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");
			packet.data.add("phoneIn",$("#phoneIn").val());
			packet.data.add("beginDate",$("#beginDate").val());
			packet.data.add("endDate",$("#endDate").val());
			packet.data.add("iRowStart",pageObj.iRowStart);
			packet.data.add("iRowEnd",pageObj.iRowEnd);
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
			initPage(retArray[0][18]);//���÷�ҳ����
			$("#showReTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
				var trData = "";
				for(var j=0;j<retArray[i].length;j++){
					trData += retArray[i][j]+"��";
				}
				trObjdStr += "<tr>"+
										 "<td nowrap >"+retArray[i][0]+"</td>"+
										 "<td nowrap >"+retArray[i][1]+"</td>"+
										 "<td nowrap >"+retArray[i][2]+"</td>"+
										 "<td nowrap >"+retArray[i][3]+"</td>"+
										 "<td nowrap >"+retArray[i][4]+"</td>"+
										 "<td nowrap >"+retArray[i][5]+"</td>"+
										 "<td nowrap >"+retArray[i][6]+"</td>"+
										 "<td nowrap >"+retArray[i][7]+"</td>"+
										 "<td nowrap >"+retArray[i][8]+"</td>"+
										 "<td nowrap >"+retArray[i][9]+"</td>"+
										 "<td nowrap >"+retArray[i][10]+"</td>"+
										 "<td nowrap >"+retArray[i][11]+"</td>"+
										 "<td nowrap >"+retArray[i][12]+"</td>"+
										 "<td nowrap >"+retArray[i][13]+"</td>"+
										 "<td nowrap >"+retArray[i][14]+"</td>"+
										 "<td nowrap >"+retArray[i][15]+"</td>"+
										 "<td nowrap >"+retArray[i][16]+"</td>"+
										 "<td nowrap >"+retArray[i][17]+"</td>"+
										 "</tr>";
			}
			
			if(""!=trObjdStr){
				$("#saveToExcelBtn").show();
				$("#showReTab tr:eq(0)").after(trObjdStr);
				$("#showReDiv").show();
			}else{
				$("#saveToExcelBtn").hide();
				$("#showReDiv").hide();
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

/*��ѯ��������*/
function qryAllAndExcel(){
		var packet = new AJAXPacket("fm031_AjaxGetList.jsp","���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");
			packet.data.add("phoneIn",$("#phoneIn").val());
			packet.data.add("beginDate",$("#beginDate").val());
			packet.data.add("endDate",$("#endDate").val());
			packet.data.add("iRowStart","1");
			packet.data.add("iRowEnd",pageObj.iRowSum);
			core.ajax.sendPacket(packet,doGetAjaxInfo2);
			packet =null;
}

function doGetAjaxInfo2(packet){
	var code = packet.data.findValueByName("code");
	var msg = packet.data.findValueByName("msg");
	if("000000"==code){
		var retArray = packet.data.findValueByName("retArray");
		var trObjdStr = "";
		
		if(retArray.length>0){
			initPage(retArray[0][18]);//���÷�ҳ����
			$("#hideReTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
				var trData = "";
				for(var j=0;j<retArray[i].length;j++){
					trData += retArray[i][j]+"��";
				}
				trObjdStr += "<tr>"+
										 "<td nowrap >"+retArray[i][0]+"</td>"+
										 "<td nowrap >"+retArray[i][1]+"</td>"+
										 "<td nowrap >"+retArray[i][2]+"</td>"+
										 "<td nowrap >"+retArray[i][3]+"</td>"+
										 "<td nowrap >"+retArray[i][4]+"</td>"+
										 "<td nowrap >"+retArray[i][5]+"</td>"+
										 "<td nowrap >"+retArray[i][6]+"</td>"+
										 "<td nowrap >"+retArray[i][7]+"</td>"+
										 "<td nowrap >"+retArray[i][8]+"</td>"+
										 "<td nowrap >"+retArray[i][9]+"</td>"+
										 "<td nowrap >"+retArray[i][10]+"</td>"+
										 "<td nowrap >"+retArray[i][11]+"</td>"+
										 "<td nowrap >"+retArray[i][12]+"</td>"+
										 "<td nowrap >"+retArray[i][13]+"</td>"+
										 "<td nowrap >"+retArray[i][14]+"</td>"+
										 "<td nowrap >"+retArray[i][15]+"</td>"+
										 "<td nowrap >"+retArray[i][16]+"</td>"+
										 "<td nowrap >"+retArray[i][17]+"</td>"+
										 "</tr>";
			}
			
			if(""!=trObjdStr){
				
				$("#hideReTab tr:eq(0)").after(trObjdStr);
				saveToExcel(hideReTab);
			}else{
				
			}
		}else{
			rdShowMessageDialog("��ѯ�����б�Ϊ��");
		}
	}else{
		rdShowMessageDialog("��ѯ����"+code+"��"+msg);
	}
}

var excelObj;
function saveToExcel(obj){
	
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.hideReTab.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 excelObj.WorkBooks.Add; 
		for(a=0;a<document.all.hideReTab.length;a++)
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
					for(j=0;j<cells;j++){
						var valueTe = obj.rows[i].cells[j].innerText;
						//���ȫ�����ּӵ�Ʋ�ű���ı�
						if(/^\d+$/.test(valueTe)){
							valueTe = "'"+valueTe;
						}
						excelObj.Cells(i+1,j+1).Value=valueTe;
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
		
		<td class="blue" width="11%">��ʼʱ��</td>
		<td width="22%"><input type="text" name="beginDate" id="beginDate" value="<%=currentDate%>"  onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />  </td>
		<td class="blue" width="11%">����ʱ��</td>
		<td width="22%"> <input type="text" name="endDate" id="endDate" value="<%=hyDate%>" onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />   </td>
		<td class="blue" width="11%">���ٱ�����</td>
		<td width="22%"><input type="text" name="phoneIn" id="phoneIn" value="" /> </td>
	</tr>
</table>

<TABLE cellSpacing=0>
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="��ѯ" onclick="doQuery()"           />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
			<input type="button" class="b_foot" value="EXCEL����" onclick="qryAllAndExcel();" id="saveToExcelBtn"  style="display:none"  /> 
	 	</td>
	</tr>
</table>

<div id="showReDiv" style="display:none" >
	<div style="overflow-x:auto;overflow-y:hidden;">
		<table id="showReTab" cellSpacing="0">
			<tr>
				<th>ҵ������</th>
				<th>��������</th>
				<th>����ʱ��</th>
				<th>������ˮ��</th>
				<th>�ٱ�����</th>
				<th>�û�������</th>
				<th>���ٱ�����</th>
				<th>�ܶ˿ں�</th>
				<th>�˿�״̬</th>
				<th>���Ŵ���</th>
				<th>��������</th>
				<th>���Ź�ģ</th>
				<th>���Ź�������</th>
				<th>��������</th>
				<th>�ٱ���������</th>
				<th>�������</th>
				<th>�������ʱ��</th>
				<th>�����᰸ʱ��</th>
			</tr>
		</table>
		<br>
	</div>
	<%@ include file="page.jsp" %>
</div>
<div style="overflow-x:auto;overflow-y:hidden;display:none">
		<table id="hideReTab" cellSpacing="0">
			<tr>
				<th>ҵ������</th>
				<th>��������</th>
				<th>����ʱ��</th>
				<th>������ˮ��</th>
				<th>�ٱ�����</th>
				<th>�û�������</th>
				<th>���ٱ�����</th>
				<th>�ܶ˿ں�</th>
				<th>�˿�״̬</th>
				<th>���Ŵ���</th>
				<th>��������</th>
				<th>���Ź�ģ</th>
				<th>���Ź�������</th>
				<th>��������</th>
				<th>�ٱ���������</th>
				<th>�������</th>
				<th>�������ʱ��</th>
				<th>�����᰸ʱ��</th>
			</tr>
		</table>
		<br>
	</div>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>