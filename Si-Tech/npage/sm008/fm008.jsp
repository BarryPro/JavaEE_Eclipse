<%
/********************
 version v2.0
������: si-tech
*
*update:wanghyd@2013-12-2 
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode  = request.getParameter("opCode");
	String opName  = request.getParameter("opName");			
%>

<script>

function doCheck2()
{	

	if(checkElement(document.frm.srv_no)==false) {
		return false;
	}
			
 
 var srv_no=document.frm.srv_no.value.trim();
 var optypes=$("#banlitype").val()
 
	var myPacket = new AJAXPacket("fm008_qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	myPacket.data.add("srv_no",srv_no);
	myPacket.data.add("optypes",optypes);
	core.ajax.sendPacketHtml(myPacket,checkSMZValue,true);
	getdataPacket = null;
}
  function checkSMZValue(data) {
				//�ҵ���ӱ���div
				var markDiv=$("#gongdans"); 
				//���ԭ�б��
				markDiv.empty();
				markDiv.append(data);
				//document.frm.toexcel.disabled=false;
}

function returnpages() {
	window.location.href="fm008.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
}

function changetype() {
				 var optypes=$("#banlitype").val();
				var markDiv=$("#gongdans"); 
				//���ԭ�б��
				markDiv.empty();
				 if(optypes=="1") {
				$("#zifeizengli1").show();
				$("#zhongduanlei1").hide();
				$("#xinyingxiaohuodongzhixing1").hide();
				}else if(optypes=="0") {
				$("#zifeizengli1").hide();
				$("#zhongduanlei1").show();
				$("#xinyingxiaohuodongzhixing1").hide();
				}else if(optypes=="2") {
				$("#xinyingxiaohuodongzhixing1").show();
				$("#zifeizengli1").hide();
				$("#zhongduanlei1").hide();
				}

}


</script>

<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body onload="changetype()">
<FORM method=post name="frm">
	
  
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">��ѯ����</div>
		</div>
    <table cellspacing="0">
      <TBODY>
        <TR>
          <TD class="blue" width="16%">�ֻ�����</td>
          		<td width="84%">
                <input type="text" size="17" value="" maxLength="13" name="srv_no" id="srv_no" v_must="1"  maxlength="11" v_type="mobphone">
      			</td>
      	</TR>		       
        <TR>
          <TD class="blue">��ѯ����</td>
          <td> 
          			<select id="banlitype" name="banlitype" onChange="changetype()">
								<option value="1">�ʷ�������</option>
								<option value="0">�ն���</option>
								<option value="2">��Ӫ���ִ��</option>
							  </select>
          	&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" name="Button1" value="��ѯ" onclick="doCheck2()">		
          </TD>
        </tr>
        
 		<tr height='25' align='left'   id="zifeizengli1">
		<td colspan='4' >
		<font color="red" style="display:">
		
		  ҵ��Χ��ͳһԤ������(2289)������Ԥ���Ӫ����(8379)����ϲ����Ӫ�������루e462����

			
			</font> 
		</td>
		</tr>
		
		 	<tr height='25' align='left' id="zhongduanlei1">
		<td colspan='4' style="display:">
		<font color="red">
		

			ҵ��Χ����������(1145)����Լ�ƻ�Ԥ�湺��(d069)��Ԥ�湺��-��Լ(g975)����������(i101)�����ֻ���(1143)����Լ�ƻ�����(e505)�����ֻ����ͻ���(8027)��Ԥ�滰���Żݹ���(1141)�����������ѣ����·�����(7955)��
			
			</font> 
		</td>
		</tr>
		<tr height='25' align='left' id="xinyingxiaohuodongzhixing1">
		<td colspan='4' style="display:">
		<font color="red">

			1��չʾ�û����������Ӫ������Ϣ��״̬������������������ȡ�����˻���
			2�����û�����Ӫ�����а����ʷѣ������ʷѸ�������չʾ��
			3���б���չʾ��ʱ���Ϊ����ʱ��¼�Ŀ�ʼ������ʱ�䣬��״̬Ϊ������ȡ�����˻���������ʵ���ʷ�ʱ��Ϊ׼;
			4��Ӫ����ʽ��ʼ������ʱ�������ݵ�Ϊ��ʷ����û�м�¼���ʷѴ��롢���ơ���/���ӡ���ʼ������ʱ�������ݵ�Ϊ���ʷѵ�Ӫ�����

			</font> 
		</td>
		</tr>
    
      </TBODY>
	  </TABLE>
   
      
      	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					
					&nbsp; <input class="b_foot" name=back onClick="returnpages()" type=button value=���>
						&nbsp;<input class="b_foot" type=button name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
		
			</div>
			</td>
		</tr>
	</table>
			<div id="gongdans">
		</div>	
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
<script ="javascript">
var excelObj;

function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.t1.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////����µĹ�����   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//�����п� 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =9;//�����п� 
  sheet.Columns("C").ColumnWidth =21;//�����п� 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =14;//�����п� 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =16;//�����п�
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =35;//�����п� 
  sheet.Columns("G").ColumnWidth =10;//�����п� 

		for(a=0;a<document.all.t1.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						var g=0;
						for(j=0;j<cells;j++)
						{
							if(obj[a].rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj[a].rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value='';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj[a].rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj[a].rows[i].cells[j].innerText;
							g++;
							}
						}
					}
				}
				catch(e)
				{
					alert('����excelʧ��!');
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
 //excelObj.WorkBooks.Add; 
   var workB = excelObj.Workbooks.Add(); ////����µĹ�����   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//�����п� 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =9;//�����п� 
  sheet.Columns("C").ColumnWidth =21;//�����п� 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =14;//�����п� 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =16;//�����п�
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =35;//�����п� 
  sheet.Columns("G").ColumnWidth =10;//�����п� 
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					var g=0;
					for(j=0;j<cells;j++)
					{
							if(obj.rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj.rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value = '';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj.rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj.rows[i].cells[j].innerText;
							g++;
							}
					}
				}
			}
			catch(e)
			{
				alert('����excelʧ��!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
	excelObj.Range('A1:'+str.charAt(cells+colspan-2)
+total_row).Borders.LineStyle=1;
}

</script>

