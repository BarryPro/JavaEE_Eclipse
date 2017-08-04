<%
    /*************************************
    * ��  ��: �ſ�������ѯ m078
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2013-4-15
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
%>
<%   
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
 		/* ��ȡϵͳ��ǰʱ�� */
 		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
 		/* ���µ�һ�� */
 		String firstDay = dateStr.substring(0,6) + "01";
 		String regionCode= (String)session.getAttribute("regCode");
 		String groupId= (String)session.getAttribute("groupId");

    String stypesql = "select t.group_id,t.region_name from sregioncode t where t.use_flag = 'Y' order by t.group_id ";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
	<wtc:param value="<%=stypesql%>"/>
</wtc:service>  
<wtc:array id="result1"  scope="end"/>

<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	
	<script language="javascript">
		function doQuery(){
			if($("#stypeCode").val()=="$$$"){
				rdShowMessageDialog("��ѡ��������ƣ�",1);
				return false;
			}
			var getdataPacket = new AJAXPacket("fm078_ajax_query.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("opName","<%=opName%>");
			getdataPacket.data.add("stypeCode",$("#stypeCode").val());
			core.ajax.sendPacketHtml(getdataPacket);
			getdataPacket = null;
		}

		function doProcess(data){
			//�ҵ���ӱ���div
			var markDiv=$("#intablediv"); 
			//���ԭ�б��
			markDiv.empty();
			markDiv.append(data);
			document.form1.toexcel.disabled=false;
		} 
		
		function doReset(){
			window.location.href="fm078_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
		
		$("table[vColorTr='set']").each(function(){
			$(this).find("tr").each(function(i,n){
			  $(this).bind("mouseover",function(){
			  	$(this).addClass("even_hig");
			  });
			  
			  $(this).bind("mouseout",function(){
			  	$(this).removeClass("even_hig");
			  });
			  
			  if(i%2==0){
			  	$(this).addClass("even");
			  }
			});
		});
	</script>
</head>
<body>
<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ѯ����</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue" width="8%" nowrap>��������</td>
			<td>
				<select name="stypeCode" class="button" id="stypeCode" >
					<option value="$$$">--��ѡ��--</option>
					<option value="">ȫʡ</option>
					<%for (int i = 0; i < result1.length; i++) {%>
						<option value="<%=result1[i][0]%>"><%=result1[i][1]%></option>
					<%}%>
				</select>
			</td>
			<td class="blue">��Ʒ����</td>
			<td>
				<input type="text" name="cardNo" id="cardNo" value="�ſ�" class="InputGrey" readonly   />
			</td>		
		</tr>		
		
	</table>
	<table cellspacing="0">
		<tr>
			<td>
				<div align="center">
				<input type="button" name="query" class="b_foot" value="��ѯ" onclick="doQuery()" />
				&nbsp;
				<input type="button" name="toexcel" class="b_foot" value="����" onclick="printTable(t1);" disabled/>
				&nbsp;
				<input type="reset" name="reset" class="b_foot" value="����" onclick="doReset()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
				</div>
			</td>
		</tr>
	</table>
	<div id="intablediv">
	</div>

	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
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
  //2016/03/31 liangyl��
  sheet.Columns("G").ColumnWidth =20;//�����п� 
  sheet.Columns("H").ColumnWidth =10;//�����п� 
  sheet.Columns("I").ColumnWidth =10;//�����п� 

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
  //2016/03/31 liangyl��
  sheet.Columns("G").ColumnWidth =20;//�����п� 
  sheet.Columns("H").ColumnWidth =10;//�����п� 
  sheet.Columns("I").ColumnWidth =10;//�����п� 
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