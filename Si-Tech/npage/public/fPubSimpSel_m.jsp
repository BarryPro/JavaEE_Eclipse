<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.24
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%> 
<% request.setCharacterEncoding("gbk");%>

<%!
    //�õ��������
    int recordNum = 0;
    int iQuantity = 0;
    String return_code,return_message;

%> 	

<%
/*
SQL���        sql_content
ѡ������       sel_type   
����           title      
�ֶ�1����      field_name1
*/
	String opName = request.getParameter("pageTitle");
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String sqlStr = request.getParameter("sqlStr");
    String sqlStr1 = request.getParameter("sqlStr1")==null?"":request.getParameter("sqlStr1");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

	System.out.println("sqlStr====="+sqlStr);
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
<HEAD><TITLE><%=pageTitle%></TITLE>
</HEAD>
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
	      var fPubSimpSels = document.getElementsByName("List");
          //for(i=0;i<document.fPubSimpSel.elements.length;i++)
		  for(i=0;i<fPubSimpSels.length;i++)
          { 
    		      //if (document.fPubSimpSel.elements[i].name=="List")
    		      //{    //�ж��Ƿ��ǵ�ѡ��ѡ��
    				   if (fPubSimpSels[i].checked==true)
    				   {     //�ж��Ƿ�ѡ��
        				     //alert(document.fPubSimpSel.elements[i].value);
        			         rIndex = fPubSimpSels[i].RIndex;
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
        					 window.returnValue= retValue     
                       }
    		   // }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("��ѡ����Ϣ�",0);
		    return false;
		}

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
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">   
<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">��ѯ���</div>
	</div>	
  <table cellspacing="0">
    <tr>
<%  //���ƽ����ͷ  
     chPos = fieldName.indexOf("|");
     out.print("<TR>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<TH>&nbsp;&nbsp;" + valueStr + "</TH>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
%> 

<%
    //���ݴ����Sql��ѯ���ݿ⣬�õ����ؽ��
	try
 	{      	
        //retArray = callView.sPubSelect(fieldNum,sqlStr);
%>
		<wtc:pubselect name="sPubSelect" outnum="<%=fieldNum%>">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end"/>
<%
		
        recordNum = result.length;
        if (result.length == 0)
            recordNum = 0;

  		for(int i=0;i<recordNum;i++)
  		{
  			String tdClass = (i%2==0)?"":"Grey";
  		    typeStr = "";
  		    inputStr = "";
  		    out.print("<TR>");
  		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
  		    {
  		    	
                if(j==0)
                {
                    typeStr = "<TD class="+tdClass+">&nbsp;";
                    if(selType.compareTo("") != 0)
                    {
                        typeStr = typeStr + "<input type='" + selType +  
          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
					}	          		            
                    typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
      		            " id='Rinput" + i + j + "' class='InputGrey' value='" + 
      		            (result[i][j]).trim() + "'readonly></TD>";          		            
                }
                else
                {        		        
      		        inputStr = inputStr + "<TD class="+tdClass+">&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
      		            " id='Rinput" + i + j + "' class='InputGrey' value='" + 
      		            (result[i][j]).trim() + "'readonly></TD>";          		            
                }          		            
  		    }
  		    out.print(typeStr + inputStr);
  		    out.print("</TR>");
  		}
 	}catch(Exception e){
   		System.out.println("��ѯ����!!");
 	}          
%>
<%


%>   
   </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer">
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
        out.print("<input name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");       
    } 
%> 

<%
				if(selType.compareTo("") != 0)
				{
%>              
                <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ��>&nbsp;
<%
				}
%>             
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=����>&nbsp;        
            </TD>
        </TR>
    </TBODY>
    </TABLE>
  
  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>  
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    
