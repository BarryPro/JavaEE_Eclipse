<%
/********************
 * version v3.0
 * ������: si-tech
 * author: qidp @ 2009-05-10
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>

<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginNo		= (String)session.getAttribute("workNo");
	  String loginPwd		= (String)session.getAttribute("password");
    String parentPhone	    = request.getParameter("parentPhone"); 	
		String phonenostrs    = request.getParameter("phonenostrs");	
	  String menmberidss 		= request.getParameter("menmberidss");
	  String familyCodes 		= request.getParameter("familyCodes");
	  String prodcodess 		= request.getParameter("prodcodess");
	  String  opCode		= WtcUtil.repNull((String)request.getParameter("opCode"));
	  String  opName		= WtcUtil.repNull((String)request.getParameter("opName"));

	  String errPhoneList = "";
    String errMsgList   = "";

 		String printAccept="";
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		printAccept = seq;
%>
		<wtc:service name="sMemberMsgSend"  outnum="2"
			routerKey="region" routerValue="<%=regionCode%>"  
			retcode="addRstCode" retmsg="addRstMsg"  >
			<wtc:param value="<%=printAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=loginPwd%>"/>
			<wtc:param value="<%=parentPhone%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=familyCodes%>"/>
			<wtc:param value="<%=phonenostrs%>"/>
			<wtc:param value="<%=menmberidss%>"/>
		  <wtc:param value="<%=prodcodess%>"/>	
		</wtc:service>
		<wtc:array id="g378Rst" scope="end" />
			
<%
System.out.println("addRstCode=============================="+addRstCode);
System.out.println("addRstMsg=============================="+addRstMsg);
if("000000".equals(addRstCode)){
        	
        	%>
<script>
    rdShowMessageDialog('�����ύ�ɹ���',2);
    location="fe280.jsp?activePhone=<%=parentPhone%>";
</script>
<%
}
        else if("W10011".equals(addRstCode)){
             errPhoneList = addRstMsg;
             
					    StringTokenizer stPhone = new StringTokenizer(errPhoneList,";");
					    String[] errPhoneArr = new String[stPhone.countTokens()];
					    int i = 0;   
					    while(stPhone.hasMoreTokens()){
					        errPhoneArr[i++] = stPhone.nextToken();
					    }
					    System.out.println("------------------errPhoneArr--------------------------"+errPhoneArr.length);
					    

             %>
<html>
<BODY>
<form name="frm" action="" method="post" >
	<div id="t22">
<div id="Main">

   <DIV id="Operation_Table"> 
<div class="title">
	<div id="title_zi">δ�ɹ������б�</div>
</div>

<TABLE cellSpacing="0" id="t1">
    <TR>
        <TH width='50%' align='center'>δ��ӳɹ������б�+ʧ��ԭ��</TH>

    </TR>
    <%
    for (int k=0;k<errPhoneArr.length;k++)
    {
        String tdClass = "";
        if (k%2==0){
            tdClass = "Grey";
        }
    %>
        <TR>
            <TD class='<%=tdClass%>' align='center'><%=errPhoneArr[k]%></TD>
        </TR>
    <%
    }
    %>
</TABLE>

<TABLE cellspacing="0">
    <tr id="footer">
        <td>
            <input class="b_foot_long" name="prtxls" id="prtxls" type=button value="����XLS�ļ�" onclick="printTable(t1)" style="cursor:hand">
									&nbsp; 
			<input name="reset" type="button" class="b_foot" value="����" onclick="goBack()" />
                  </td>
    </tr>
</TABLE>
</div>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</html>

             <%
        }else {
        	
        	%>
<script>
    rdShowMessageDialog('�����ύʧ�ܣ��������<%=addRstCode%>������ԭ��<%=addRstMsg%>',0);
    location="fe280.jsp?activePhone=<%=parentPhone%>";
</script>
<%
        	}

%>
<script ="javascript">

 		function goBack(){
			location="fe280.jsp?activePhone=<%=parentPhone%>";
		}
		 
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
  sheet.Columns("E").ColumnWidth =25;//�����п�
  sheet.Columns("F").ColumnWidth =25;//�����п� 
  sheet.Columns("G").ColumnWidth =10;//�����п� 
  sheet.Columns("G").numberformat="@"; 
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
window.close();
}

</script>