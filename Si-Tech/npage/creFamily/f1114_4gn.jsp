<%
  /*
   * ����: �û���������(1114)
�� * �汾: 1.0
�� * ����: 2006/10/16
�� * ����: luorui
�� * ��Ȩ: sitech
��*/
%>

<% request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
		String opName = "ͳһ��װ";
    String fieldNum = "";
    int chPos = -1;
    String pageTitle = "��Դ��ϸ��Ϣ���";
    String fieldName = "�������|SIM������|ѡ�ŷ�|";		
 
    String typeStr = "";
    String valueStr = "";  
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
	<HEAD><TITLE>
	�������ƶ�
	<%=pageTitle%></TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<SCRIPT type=text/javascript>
var recordPerPage = 50; //ÿҳ��¼��
var pageNumber = 1; //��ǰҳ��
var nums = 0;//�ܼ�¼��
	var phoneList=window.dialogArguments[0];
	var simList=window.dialogArguments[1];
	var chFeeList=window.dialogArguments[2];
	 var preFeeList=window.dialogArguments[3];
 
var phoneArray = phoneList.split("~");
var simArray = simList.split("~");
var chFeeArray  = chFeeList.split("~");


 onload=function(){
	document.all.nowPage.value = pageNumber;
	document.all.jump.value = pageNumber;
	nums= phoneArray.length-1;//getTokNums(phoneList,"~");
	document.all.recodeNum.value = nums;

	if( parseInt(nums*1%recordPerPage) == 0)
	{
		 document.all.tatolPages.value = nums*1/recordPerPage;
	}
	else
	{
		document.all.tatolPages.value=parseInt(nums/recordPerPage) + 1;
	}
 if(document.all.tatolPages.value>0)
query_main();
 }

 function inExcel()
 {
    try { 
     var excelObj  = new ActiveXObject ( "Excel.Application" ); 
    } 
	catch(e) { 
        rdShowMessageDialog( "Ҫ��ӡ�ñ������밲װExcel���ӱ�������ͬʱ�������ʹ�á�ActiveX �ؼ��������������������ִ�пؼ��� �������������˽���������÷�����"); 
        return false; 
    }
	excelObj.Visible = true;
	excelObj.WorkBooks.Add;
		/*excelObj.Range('A1: D2').NumberFormatLocal = "@" ;
		excelObj.Range('A1: D2').AutoFitColumns;
		excelObj.Range('A1: D2').AutoFitRows;*/
 	var rows=nums;


	   excelObj.Cells(1,1).NumberFormatLocal = "@" ;
 		excelObj.Cells(1,1).Value="�������";
 		excelObj.Cells(1,2).Value="SIM������";				
 		excelObj.Cells(1,3).Value="ѡ�ŷ�";

	if(rows>0)
	{
		try
		{
			for(var i=0;i<rows;i++)
			{
			    
                excelObj.Cells(i+2,1).NumberFormatLocal = "@" ;
 			    excelObj.Cells(i+2,1).Value=phoneArray[i];

			    excelObj.Cells(i+2,2).NumberFormatLocal = "@" ;
 			    excelObj.Cells(i+2,2).Value=simArray[i];
				
			    excelObj.Cells(i+2,3).NumberFormatLocal = "@" ;
 			    excelObj.Cells(i+2,3).Value=chFeeArray[i];
 			   
			}
		}
		catch(e)
		{
			rdShowMessageDialog("����excel�ļ�ʧ�ܣ�");
		}
	}
	else
	{
		rdShowMessageDialog("û�����ݣ�");
	}
	
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 	excelObj.Range('A1:'+str.charAt(cells-1)+rows).Borders.LineStyle=1;
	excelObj.Range('A1:'+str.charAt(cells-1)+rows).AutoFitColumns;
	excelObj.Range('A1:'+str.charAt(cells-1)+rows).AutoFitRows;
 }



function query_button()
{
	 
	pageNumber = 1;
	document.all.tatolPages.value="1";
	document.all.recodeNum.value="0";
	document.all.nowPage.value = pageNumber;
	document.all.jump.value = pageNumber;
 
	query_main();
}

function delete_table()
{
	 var delnum=document.all.tb.rows.length;

	 while(delnum>1)
  {   
        document.all.tb.deleteRow(1); 
		delnum--;
  }   
}
function query_main()
{
	//var params="pageNumber="+pageNumber;
	//	params+="&recordPerPage="+recordPerPage;	

var nowrecode = recordPerPage*(pageNumber-1);
var nextcode  = nowrecode+recordPerPage;
if(document.all.tatolPages.value == pageNumber && nums*1%recordPerPage != 0)
{
	nextcode = nowrecode+nums*1%recordPerPage;
}
	for(var nowLoc=nowrecode;nowLoc<nextcode;nowLoc++)
	{
	  var tr1=tb.insertRow();
	  tr1.id="tr";
	  tr1.bgColor="#EEEEEE";
	  tr1.insertCell().innerHTML =phoneArray[nowLoc];
	  tr1.insertCell().innerHTML =simArray[nowLoc];
	  if(typeof(chFeeArray[nowLoc])=="undefined")
	  chFeeArray[nowLoc] = "";
	  tr1.insertCell().innerHTML =chFeeArray[nowLoc];
	}
}

function firstPage() //��ҳ
{
	if(pageNumber-1>0)
	{
		delete_table();
		pageNumber = 1;
		query_main();
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
	}
}
function pageUp()
{
	if(pageNumber-1>0)
	{
		delete_table();
		pageNumber =	pageNumber - 1;
		query_main(); 
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
	}
}

function pageDown()
{
	if(pageNumber < document.all.tatolPages.value*1)
	{
		delete_table();
		pageNumber =	pageNumber + 1;
		query_main(); 	
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
	}
}
function lastPage()
{
	if(pageNumber < document.all.tatolPages.value*1)
	{
		delete_table();
		pageNumber =	document.all.tatolPages.value;
		query_main(); 	
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
	}
}
function query_jump()
{
	//alert(document.all.jump.value);
	document.all.jump.value = document.all.jump.value.trim();
	if(document.all.jump.value.trim()=="")
	{
		document.all.jump.value = pageNumber;
		return false;
	}
	if(!forPosInt(document.all.jump))
	{
		document.all.jump.value = pageNumber;
		return false;
	}
	if(document.all.jump.value*1<1 || document.all.jump.value*1>document.all.tatolPages.value)
	{
		document.all.jump.value = pageNumber;
		return false;
	}
	if(document.all.jump.value != pageNumber)
	{
	delete_table();
	pageNumber = document.all.jump.value;	
	document.all.nowPage.value = pageNumber;
	query_main();
	}
}

function hideEvent1()
{
	if(document.all.query_flag.value=="1")
	{
		rdShowMessageDialog("���ڲ�ѯ...�����Ժ�");
		return false;
	}
}


</SCRIPT>

</head>

<BODY>
<div id="operation">
<FORM method=post name="viewRes">  
	<%@ include file="/npage/include/header_pop.jsp" %>                         

	<div id="operation_table">
  <div class="title"><div id="title_zi"><%=pageTitle%></div></div>
  
  <div class="list">
  <table  id="tb" >
 <%  //���ƽ����ͷ  
     chPos = fieldName.indexOf("|");
     out.print("<TR>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<th>&nbsp;&nbsp;" + valueStr + "</th>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
%> 
   </table>
</div>
</div>
  <div style="position:relative;font-size:12px" align="center">
  
	[<a href="#" onclick="firstPage()"> ��ҳ</a>]
 	[<a href="#" onclick="pageUp()" > ��һҳ</a>]
	[<a href="#" onclick="pageDown()"> ��һҳ</a>]
	[<a href="#" onclick="lastPage()" > βҳ</a>]
	&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;<input type="text" size="4" class="likebutton2" name="tatolPages" value="1">ҳ
	&nbsp; ��ǰ��<input type="text" size="4" class="likebutton2" name="nowPage" value="1">ҳ </br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ת����<input type="text"  size="4" name="jump" value="1" onKeyUp="if(event.keyCode==13)query_jump()">ҳ
	&nbsp<input type="button"  class="b_text" name="jump_button" value="��ת" onclick="query_jump();"/>
	&nbsp;&nbsp;&nbsp;&nbsp;��<input type="text" size="4" class="likebutton2" name="recodeNum" value="0">����¼
	&nbsp;&nbsp;&nbsp;&nbsp;
	<input class="b_text" name=back onClick="window.close()" style="cursor:hand" type=button value=" ���� ">&nbsp;
	</div>
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</div>
</BODY></HTML>    
