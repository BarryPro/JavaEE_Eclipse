<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("ISO-8859-1"); 
%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
    String opName = "APN���������ϸ��ѯ";
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    //�õ��������
    ArrayList retArray = new ArrayList();
    ArrayList retArray1 = new ArrayList();
    String return_code,return_message;
    String[][] result = new String[][]{};
    String[][] allNumStr =  new String[][]{};
%> 	

<%
/*
SQL���        sql_content
ѡ������       sel_type   
����           title      
�ֶ�1����      field_name1
*/
    String fieldNum 	= "";
    String fieldName 	= new String(request.getParameter("fieldName").getBytes("ISO-8859-1"),"GB2312"); 
    String pageTitle 	= new String(request.getParameter("pageTitle").getBytes("ISO-8859-1"),"GB2312");   
    
    //String prod_code = new String(request.getParameter("prod_code").getBytes("ISO-8859-1"),"GB2312");
    //String prod_desc = new String(request.getParameter("prod_desc").getBytes("ISO-8859-1"),"GB2312");
    String apnNo = new String(request.getParameter("apnNo").getBytes("ISO-8859-1"),"GB2312");
    String grpIdNo = new String(request.getParameter("grpIdNo").getBytes("ISO-8859-1"),"GB2312");
    
    String sqlFilter 	= "";
    
    /**************** ��ҳ���� ********************/
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	  int iPageSize = 11;
	  int iStartPos = (iPageNumber-1)*iPageSize;
	  int iEndPos = iPageNumber*iPageSize;
	  String vStartPos = ""+iStartPos;
	  String vEndPos = ""+iEndPos;
	/**********************************************/
    
   
		
    //String sqlStr = "select nvl(count(*),0) num from dGrpApnTermMsghis a,dCustMsg b,dCustDoc c where a.apn_addr='"+apnNo+"' and a.id_no='"+grpIdNo+"' and a.terminal_no=b.phone_no and a.update_type!='d' and b.cust_id=c.cust_id and a.update_accept in (select max(update_accept) from dGrpApnTermMsghis where apn_addr='"+apnNo+"' group by terminal_no) order by a.terminal_no";
	//String sqlStr1 = "select * from (select a.terminal_no,c.cust_name,a.ip_address,a.update_login,to_char(a.update_time,'yyyymmdd hh24:mi:ss'),a.update_accept , rownum id  from dGrpApnTermMsghis a,dCustMsg b,dCustDoc c where a.apn_addr='"+apnNo+"' and a.id_no='"+grpIdNo+"' and a.terminal_no=b.phone_no and a.update_type!='d' and b.cust_id=c.cust_id and a.update_accept in (select max(update_accept) from dGrpApnTermMsghis where apn_addr='"+apnNo+"' group by terminal_no) order by a.terminal_no) where id <="+iEndPos+" and id>"+iStartPos;

    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");

    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    if(selType.compareTo("N") == 0)
    {   selType = "";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";   
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-<%=pageTitle%></TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<SCRIPT type=text/javascript>
function saveTo()
{
      var rIndex;        //ѡ�������
      var retValue = ""; //����ֵ
      var chPos;         //�ַ�λ��
      var obj;
      var fieldNo;        //���������к�
      var retFieldNum = document.fPubSimpSel.retFieldNum.value;
      var retQuence = document.fPubSimpSel.retQuence.value;  //�����ֶ��������
      var retNum = retQuence.substring(0,retQuence.indexOf("|"));
      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
      var tempQuence;
      if(retFieldNum == "")	
      {     return false;   }
       //���ص�����¼
          for(i=0;i<document.fPubSimpSel.elements.length;i++)
          { 
    		      if (document.fPubSimpSel.elements[i].name=="List")
    		      {    //�ж��Ƿ��ǵ�ѡ��ѡ��
    				   if (document.fPubSimpSel.elements[i].checked==true)
    				   {     //�ж��Ƿ�ѡ��
        				     //alert(document.fPubSimpSel.elements[i].value);
        			         rIndex = document.fPubSimpSel.elements[i].RIndex;
        			         tempQuence = retQuence;
        			         for(n=0;n<retNum;n++)
        			         {   
        			            chPos = tempQuence.indexOf("|");
        			            fieldNo = tempQuence.substring(0,chPos);
        			            //alert(fieldNo);
        			            obj = "Rinput" + rIndex + fieldNo;
        			            //alert(obj);
        			            retValue = retValue + document.all(obj).value + "|";
        			            tempQuence = tempQuence.substring(chPos + 1);
        			         }
                             //alert(retValue);                                  
        					 window.returnValue= retValue;
                       }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("��ѡ����Ϣ�",0);
		    return false;
		}
		opener.getvaluecust(retValue);
		window.close(); 
}

function allChoose()
{   //��ѡ��ȫ��ѡ��
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    {
        if(document.fPubSimpSel.elements[i].type=="checkbox")
        {    //�ж��Ƿ��ǵ�ѡ��ѡ��
            document.fPubSimpSel.elements[i].checked = true;
        }
    }
}

function cancelChoose()
{   //ȡ����ѡ��ȫ��ѡ��
    for(i=0;i<document.fPubSimpSel.elements.length;i++)
    { 
        if(document.fPubSimpSel.elements[i].type =="checkbox")
        {    //�ж��Ƿ��ǵ�ѡ��ѡ��
            document.fPubSimpSel.elements[i].checked = false;
        }
    }
}

 function inExcel()
 {
  var excelObj = new ActiveXObject('Excel.Application');
	excelObj.Visible = true;
	excelObj.WorkBooks.Add;
		/*excelObj.Range('A1: D2').NumberFormatLocal = "@" ;
		excelObj.Range('A1: D2').AutoFitColumns;
		excelObj.Range('A1: D2').AutoFitRows;*/
 	var rows=document.all.tb1.rows.length;
	var cells=0;
	if(rows>0)
	{
		try
		{
			for(var i=0;i<rows;i++)
			{
			  cells=document.all.tb1.rows[i].cells.length;
 			  for(var j=0;j<cells;j++)				
			  {
          excelObj.Cells(i+1,j+1).NumberFormatLocal = "@" ;
 			    excelObj.Cells(i+1,j+1).Value=document.all.tb1.rows[i].cells[j].innerText;
 			  }
			}
		}
		catch(e)
		{
			rdShowMessageDialog("����excel�ļ�ʧ�ܣ�");
			window.close();
		}
	}
	else
	{
		rdShowMessageDialog("û�����ݣ�");
		window.close();
	}
	
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 	excelObj.Range('A1:'+str.charAt(cells-1)+rows).Borders.LineStyle=1;
	excelObj.Range('A1:'+str.charAt(cells-1)+rows).AutoFitColumns;
	excelObj.Range('A1:'+str.charAt(cells-1)+rows).AutoFitRows;
 }
 
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">APN���������ϸ��ѯ</div>
</div>
  <table id="tb1" cellspacing="0">
    

<%  //���ƽ����ͷ  
     chPos = fieldName.indexOf("|");
     out.print("<TR>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<TH nowrap>" + valueStr + "</TH>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1+1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
     
     
     
     
     
%>

<%
    //���ݴ��˵�Sql��ѯ���ݿ⣬�õ����ؽ��
    int recordNum = 0;
	try
 	{      	
            %>
                <wtc:service name="s3439EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="<%=fieldNum%>" >
                	<wtc:param value="<%=grpIdNo%>"/>
                	<wtc:param value="<%=apnNo%>"/> 
                  <wtc:param value="<%=vStartPos%>" />
    	            <wtc:param value="<%=vEndPos%>" />
                </wtc:service>
                <wtc:array id="retArr" scope="end"/>
            <%
    
      		  result = retArr;      		
            recordNum = Integer.parseInt(result[0][7].trim());
            System.out.println("# recordNum = "+recordNum);
      		for(int i=0;i<recordNum;i++)
      		{
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<7-1;j++)
      		    {
                    if(j==0)
                    {
                        typeStr = "<TD>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						}	          		            
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }
                    else
                    {        		        
          		        inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }          		            
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
     	}catch(Exception e){
     		 e.printStackTrace();
			 System.out.println("��ѯ����!!");       		
     	}          
%>  
   	</tr>
  </table>
  <!-------------------chendx 20091124 update---------------------------------->
	<%
		Page pg = new Page(iPageNumber,iPageSize,recordNum);
		PageView view = new PageView(request,out,pg);					
	%>
	<div style="position:relative;font-size:12px" align="center">
		<%
		    view.setVisible(true,true,0,0);      
		%>
	</div>
<!------------------------------------------------------>
    <TABLE  cellSpacing=0>
    <TBODY>
        <TR> 
            <TD id='footer'>
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>");
        out.print("<input class='b_foot' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>");       
    } 
%> 
           
                
                <input class="b_foot" name=commit onClick="inExcel()" style="cursor:hand" type=button value=����>
          
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=����>       
            </TD>
        </TR>
    </TBODY>
    </TABLE>
    
  <!-------------------chendx 20091124 update---------------------------------->
  <!--  <table cellspacing="0" id=contentList>
	<tr>
	 <td>
<%	
    //int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
   // System.out.println("<"+iPageNumber+">,<"+iPageSize+">,<"+recordNum+">");
    //Page pg = new Page(iPageNumber,iPageSize,recordNum);
	//  PageView view = new PageView(request,out,pg); 
   	//view.setVisible(true,true,0,0);       
%>
     </TD>
    </TR>
 </TABLE>-->

  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------> 
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>    
