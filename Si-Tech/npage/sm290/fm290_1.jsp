<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ2015-7-27 16:56:29------------------
ʮһ����Ӫҵǰ̨�����н���ѯ���ܣ���ѯ����ΪԤԼ���£�չʾ���Ϊ�ֻ����룬������֤�����룬��ϵ�ˣ���ϵ�˵绰
 -------------------------��̨��Ա��dujl--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.SimpleDateFormat"%>
<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  
  java.util.Calendar j_calendar = java.util.Calendar.getInstance();
  //j_calendar.add(java.util.Calendar.MONTH, -1);// �·ݼ�1  
	String p_month_date = new java.text.SimpleDateFormat("yyyyMM").format(j_calendar.getTime());
	
	
	String current_timestart=new SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date());
	
	String kaishitimes=current_timestart+"01";
	
	String current_timeend=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
	
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
<SCRIPT language=JavaScript>

  onload=function()
  {
		changeType("aaa");
  	$("#toexcel1").hide();
  }
  
  	function changeType(opCode){

	$("#showTab2").empty();
	$("#upgMainTab tr:gt(0)").remove();
	
	if(opCode == "aaa"){
		
	$("#zjxy1").show();
	$("#upgMainTab").hide();	
	$("#zjxy2").hide();
	$("#toexcel").hide();

	}
	if(opCode == "bbb"){
 
	$("#zjxy1").hide();
	$("#upgMainTab").hide();	
	$("#zjxy2").show();
	$("#toexcel1").hide();

	}	
	
}

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}



//��ѯ��̬չʾIMEI�����б�
function go_sM290Qry(){

	var packet = new AJAXPacket("fm290_2.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("y_year_month",$("#y_year_month").val().trim());//
			packet.data.add("region_code","");//
			core.ajax.sendPacket(packet,do_sM290Qry);
			packet = null; 
}
//��ѯ��̬չʾIMEI�����б��ص�
function do_sM290Qry(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			$("#upgMainTab").show();	
			$("#toexcel1").show();
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
				  //�����һ���ռ�¼��չʾ�����񷵻�����Ϊ���ַ���������Ľ�����߼���ɾ��
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ // 
														 "<td>"+retArray[i][1]+"</td>"+ // 
														 "<td>"+retArray[i][2]+"</td>"+ // 
														 "<td>"+retArray[i][3]+"</td>"+// 
														 "<td>"+retArray[i][4]+"</td>"+// 
														 
														 "<td>"+"1800"+"</td>"+// 
														 "<td>"+"50"+"</td>"+// 
														 "<td>"+"36"+"</td>"+// 
														 "<td>"+retArray[i][8]+"</td>"+// 
														 
														 "<td>"+retArray[i][10]+"</td>"+// 
												 "</tr>";
			}
			if(retArray.length==0) {
							trObjdStr += "<tr>"+
														 "<td colspan='10' align='center'>��ѯ��ϢΪ�գ�</td>"+ // 
												 "</tr>";		
			}
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}

function to_excel_file(obj){
		var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.upgMainTab.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////����µĹ�����   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//�����п� 
  sheet.Columns("B").ColumnWidth =21;//�����п� 
  sheet.Columns("C").ColumnWidth =13;//�����п� 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =8;//�����п� 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =18;//�����п�
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =14;//�����п� 
  sheet.Columns("G").ColumnWidth =14;//�����п� 
  sheet.Columns("G").numberformat="@"; 
  sheet.Columns("H").ColumnWidth =8;//�����п� 
  sheet.Columns("I").ColumnWidth =20;//�����п�
  sheet.Columns("I").numberformat="@"; 
  sheet.Columns("J").ColumnWidth =5;//�����п� 

		for(a=0;a<document.all.upgMainTab.length;a++)
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
  sheet.Columns("B").ColumnWidth =21;//�����п� 
  sheet.Columns("C").ColumnWidth =13;//�����п� 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =8;//�����п� 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =18;//�����п�
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =14;//�����п� 
  sheet.Columns("G").ColumnWidth =14;//�����п� 
  sheet.Columns("G").numberformat="@"; 
  sheet.Columns("H").ColumnWidth =8;//�����п� 
  sheet.Columns("I").ColumnWidth =20;//�����п�
  sheet.Columns("I").numberformat="@"; 
  sheet.Columns("J").ColumnWidth =5;//�����п� 
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

function exportTables(tableIds, flag){
  try{   
      rowIndex = 0;
      oXL = new ActiveXObject("Excel.Application");
      oWB = oXL.Workbooks.Add();
      oSheet = oWB.ActiveSheet;
      
      if (tableIds.length <= 0){
          return;
      }
      
      for (var i = 0; i < tableIds.length; i++){
          ExportToExcel(tableIds[i], flag);
      }
      //����excel�ɼ�����
      oXL.Visible = true;
  }catch(e){
        if((!+'\v1')){ //ie�����  
           alert("�޷�����Excel����ȷ���������Ѿ���װ��Excel!\n\n����Ѿ���װ��Excel��" + 
               "�����IE�İ�ȫ����\n\n���������\n\n"+"���� �� Internetѡ�� �� ��ȫ �� �Զ��弶�� �� ActiveX �ؼ��Ͳ�� �� ��δ���Ϊ�ɰ�ȫִ�нű���ActiveX �ؼ���ʼ����ִ�нű� �� ���� �� ȷ��"); 
        }else{ 
            alert("��ʹ��IE��������С����뵽EXCEL��������");  //�������ð�ȫ�ȼ�������Ϊie�����  
        } 
    }
}

  function ExportToExcel(targetTable, flag) { 
      //ȡ�ñ������
      $('#'+targetTable+' tr').each(function(i, e){
          var cols = $('td, th', this);
          cols.each(function(j, e){
              var value = $.trim($(this).text().replace(/\n/g, ''));
              if (value == ""){
                  value = $(this).find('input').val();
              }
              
              if (flag && (j + 1) == cols.length){
                  return true;
              }
              oSheet.Cells(rowIndex + 1, j + 1).value = value;
          });
          
          rowIndex++;
      });
  }
  
  
  function changeTGflag() {
	
	
		var starttimess = $("#workRulestarttime").val();
		var endtimess = $("#workRuleendtime").val();
		
 if(starttimess.substring(0,4)!=endtimess.substring(0,4)) {
 		rdShowMessageDialog("��ʼ����ʱ�䲻�ܿ��£�");
		return false;

 }		
		
 if(starttimess.substring(4,6)!=endtimess.substring(4,6)) {
 		rdShowMessageDialog("��ʼ����ʱ�䲻�ܿ��£�");
		return false;

 }
 
  if(starttimess.substring(6,8)>endtimess.substring(6,8)) {
 		rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡");
		return false;

 }
 			
			
			 	var myPacket = new AJAXPacket("ajax_queryInfo.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
				myPacket.data.add("starttimess",starttimess);	
				myPacket.data.add("endtimess",endtimess);	
				core.ajax.sendPacketHtml(myPacket,querinfo2,true);
				myPacket = null;
			
			
}

	function querinfo2(data){
		//�ҵ���ӱ���div
		var markDiv=$("#showTab2"); 
		markDiv.empty();
		markDiv.append(data);
		$("#toexcel").show();		
	}	
  
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">��ѯ����</div></div>

   <table id=""  cellspacing="0" >  	
        	  <tr>

			        		<td width=15% class="blue">��������</td>

			        		<td width=84% colspan="3">

			        			<input type="radio" name="opType"	value="aaa"   onclick="changeType(this.value);" checked/>�н���ѯ &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="bbb"  onclick="changeType(this.value);"/>ԤԼ��Ϣ��ѯ &nbsp;&nbsp;
			        			
			    

			        		</td>

        				</tr>
       </table>
       
       
<table cellSpacing="0" id="zjxy1">
	<tr>
	     <td class="blue" width="15%">ԤԼ���£�</td>
		  <td >
			    <input type="text"  name="y_year_month" id="y_year_month" readOnly="readOnly" value="<%=p_month_date%>"  onclick="WdatePicker({dateFmt:'yyyyMM',autoPickDate:true,onpicked:function(){}})" />  
			    	&nbsp;&nbsp;<input type="button" class="b_text" value="��ѯ" onclick="go_sM290Qry()">
		  </td>

	</tr>

</table>


    <table cellspacing="0"  id="zjxy2">
		<tr id="zengjia">
			<td class="blue" width="15%">��ʼʱ��</td>
			<td><input type="text" name="workRulestarttime" id="workRulestarttime"  value="<%=kaishitimes%>"   maxlength="17" onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"  readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRulestarttime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='ʱ���ʽ:YYYYMMDD'><font class='orange' style='display:none'>&nbsp;ʱ���ʽ:YYYYMMDD</font>	
			</td>
						<td class="blue" width="15%">����ʱ��</td>
						<td><input type="text" name="workRuleendtime" id="workRuleendtime"  value="<%=current_timeend%>"   maxlength="17" onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})"  readOnly/>
			 <img id = 'imgLibsStart' onclick="WdatePicker({el:'workRuleendtime',startDate:'%y%M0100',dateFmt:'yyyyMMdd',alwaysUseStartDate:true})" src='/njs/plugins/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle' title='ʱ���ʽ:YYYYMMDD'><font class='orange' style='display:none'>&nbsp;ʱ���ʽ:YYYYMMDD</font>	
			 
			 &nbsp;&nbsp;<input type="button" class="b_text" value="��ѯ" onclick="changeTGflag()">
			 
			</td>
		</tr>
		
	</table>

<div class="title"><div id="title_zi">����б�</div></div>
<TABLE cellSpacing="0" id="upgMainTab"  name="upgMainTab">
    <tr>
        <th>�ֻ�����</th>
        <th>����</th>
        <th>֤������</th>
        <th>��ϵ��</th>
        <th>��ϵ�˵绰</th>	
        <th>Ԥ��</th>	
        <th>�����Ѷ��(����)</th>	
        <th>��������(��ʱ��)</th>	
        <th>����Ӫҵ��</th>	
        <th>��������</th>	
        
    </tr>
</table>
<div id="showTab2" ></div>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" id="toexcel" name="toexcel" class="b_foot" value="����" onclick="printTable(t1);" />
	 		<input type="button" id="toexcel1" name="toexcel1" class="b_foot" value="����" onclick="to_excel_file(upgMainTab)" />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<script ="javascript">
var excelObj;

function printTable(obj){
 
	
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////����µĹ�����   
   var sheet = workB.ActiveSheet;  
   var ExcelSheet =  workB.WorkSheets(1);
	if(document.all.t1.length > 1)	{
		
  sheet.Columns("A").ColumnWidth =12;//�����п� 
  sheet.Columns("B").ColumnWidth =21;//�����п� 
  sheet.Columns("C").ColumnWidth =13;//�����п� 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =8;//�����п� 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =18;//�����п�
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =14;//�����п� 
  sheet.Columns("G").ColumnWidth =14;//�����п� 
  sheet.Columns("G").numberformat="@"; 
  sheet.Columns("H").ColumnWidth =8;//�����п� 
  sheet.Columns("I").ColumnWidth =20;//�����п�
  sheet.Columns("I").numberformat="@"; 
  sheet.Columns("J").ColumnWidth =5;//�����п� 

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
	
  sheet.Columns("A").ColumnWidth =12;//�����п� 
  sheet.Columns("B").ColumnWidth =21;//�����п� 
  sheet.Columns("C").ColumnWidth =13;//�����п� 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =8;//�����п� 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =18;//�����п�
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =14;//�����п� 
  sheet.Columns("G").ColumnWidth =14;//�����п� 
  sheet.Columns("G").numberformat="@"; 
  sheet.Columns("H").ColumnWidth =8;//�����п� 
  sheet.Columns("I").ColumnWidth =20;//�����п�
  sheet.Columns("I").numberformat="@"; 
  sheet.Columns("J").ColumnWidth =5;//�����п� 
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
	excelObj.Range('A1:'+"K"+total_row).Borders.LineStyle=1;
	/*�ϲ���Ԫ�� ��һ��*/
	excelObj.Range("A1:K1").MergeCells = true;
	/*�ϲ���Ԫ�� ��total_row��*/
	excelObj.Range("B"+total_row+":E"+total_row).MergeCells = true;
	excelObj.Range("G"+total_row+":K"+total_row).MergeCells = true;
	
	/*�������û������*/
	excelObj.Range("A"+(total_row-1)+":O"+(total_row-1)).Borders.LineStyle=0;
	excelObj.Range("A"+(total_row-2)+":O"+(total_row-2)).Borders.LineStyle=0;
	excelObj.Range("A"+(total_row)+":O"+(total_row)).Borders.LineStyle=0;

	/*��һ�к���Ӵ� ��ֱˮƽ����*/
	excelObj.Range("A1:K1").Font.Name="����";
	excelObj.Range("A1:K1").Font.Bold=true;
	excelObj.Range("A1:K1").VerticalAlignment = 2;
	excelObj.Range("A1:K1").HorizontalAlignment = 3;
	/*
	ExcelSheet.ActiveSheet.Cells(0,0).Font.Name="����";
	ExcelSheet.ActiveSheet.Cells(0,0).Font.Bold=true;
	ExcelSheet.ActiveSheet.Cells(0,0).VerticalAlignment = 2;
	ExcelSheet.ActiveSheet.Cells(0,0).HorizontalAlignment = 3;
	*/
	//excelObj.Columns("A1:K1").Font.Bold=true;
	
	
   
}

</script>