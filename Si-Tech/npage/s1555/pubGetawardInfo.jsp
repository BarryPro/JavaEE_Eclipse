<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2008.12.31
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="java.io.*" %>

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
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    
    String regCode = (String)session.getAttribute("regCode");
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
/*    
    String selType = "";
    String pageTitle = "";
    
    String fieldNum = "2";
    String sqlStr = request.getParameter("sqlStr");
    String fieldName = "��ʶ|����|�Ա�|����|";     
*/    
%>

<HEAD><TITLE>������BOSS-<%=pageTitle%></TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

<SCRIPT type=text/javascript>
function saveTo()
{
/*
		 var d1= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString())+" "+new Date().getHours()+":"+new Date().getMinutes()+":"+new Date().getSeconds();
*/

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
			         rIndex = document.fPubSimpSel.elements[i].RIndex;
			         tempQuence = retQuence;
			         for(n=0;n<retNum;n++)
			         {   
			            chPos = tempQuence.indexOf("|");
			            fieldNo = tempQuence.substring(0,chPos);
			            obj = "Rinput" + rIndex + fieldNo;
			            retValue = retValue + document.all(obj).value + "|";
			            tempQuence = tempQuence.substring(chPos + 1);
			         }
					 window.returnValue= retValue;
                }
		    }
		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("��ѡ����Ʒ��Ϣ��",0);
		    return false;
		}
/*
var d2= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString())+" "+new Date().getHours()+":"+new Date().getMinutes()+":"+new Date().getSeconds();
alert("start time:"+d1+"\r\n"+"end time:"+d2);
*/
window.close(); 
}
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
	<%@ include file="/npage/include/header_pop.jsp" %>      
<table cellspacing="0">
	
<%  //���ƽ����ͷ  
     chPos = fieldName.indexOf("|");
     out.print("<TR> ");
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
    //���ݴ��˵�Sql��ѯ���ݿ⣬�õ����ؽ��
	try
 	{
  		//retArray = callView.view_spubqry32(fieldNum,sqlStr);
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
		<wtc:param value="<%=sqlStr%>"/>	
		</wtc:service>	
		<wtc:array id="result" scope="end"/>
<%
  		int recordNum = result.length;
  		String tdClass = "";
  		for(int i=0;i<recordNum;i++)
  		{
  			if(i%2==0)
  				tdClass="";
  			else
  				tdClass="Grey";
  		    typeStr = "";
  		    inputStr = "";
  		    out.print("<TR>");
  		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
  		    {
                if(j==0)
                {
                    typeStr ="<TD class='"+tdClass+"'>&nbsp;<input type='" + selType +  
      		            "' name='List' style='cursor:hand' RIndex='" + i + "'" +  
                        "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                    typeStr = typeStr + "<input type='text' " +
      		            " id='Rinput" + i + j + "' value='" + 
      		            result[i][j] + "'readonly class='InputGrey'></TD>";          		            
                }
                else if(j==7)
                {
      		        inputStr = inputStr + "<TD class='"+tdClass+"'><input type='password' " +
      		            " id='Rinput" + i + j + "' value='" + 
      		            result[i][j] + "'readonly class='InputGrey'></TD>";                      
                }
                else
                {        		        
      		        inputStr = inputStr + "<TD class='"+tdClass+"'><input type='text' " +
      		            " id='Rinput" + i + j + "' value='" + 
      		            result[i][j] + "'readonly class='InputGrey'></TD>";          		            
                }          		            
  		    }
  		    out.print(typeStr + inputStr);
  		    out.print("</TR>");
  		}
 	}catch(Exception e){
   		
 	}          
%>
</table>


<!------------------------------------------------------>
<TABLE cellspacing="0">
<TBODY>
    <TR id="footer"> 
        <TD align=center>
            <input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ��>&nbsp;
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
