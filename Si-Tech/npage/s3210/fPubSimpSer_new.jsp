<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<!-------------------------------------------->
<%/*
* ����    : 
* �汾    : 1.0
* ����    : 2003-11-01
* ����    : zhangwjl
* ��Ȩ    : si-tech
* update  @ 2008-5-20
*/%>
<!-------------------------------------------->

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName = request.getParameter("pageTitle");
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String grpId = request.getParameter("grpId");
    String grpName = request.getParameter("grpName");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    
    System.out.println("---------------selType---------------"+selType);
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    if(selType.compareTo("N") == 0)
    {   selType = "";   }
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";   
    
    String workNo = (String)session.getAttribute("workNo");
    String opCodes = "3218";
    String regionCode = (String)session.getAttribute("regCode"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������BOSS-<%=pageTitle%></TITLE>
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
      //var tempQuence;
      var tmpArr = retQuence.split('|');
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
        			         //tempQuence = retQuence;
        			         for(n=0;n<retNum;n++)
        			         {   
        			            //chPos = tempQuence.indexOf("|");
        			            //fieldNo = tempQuence.substring(0,chPos); 
        			            obj = "Rinput" + rIndex + tmpArr[n];
        			            retValue = retValue + document.all(obj).value + "|";
        			            //tempQuence = tempQuence.substring(chPos + 1);
        			         }
        					 window.returnValue= retValue     
                       }
    		    }
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
</HEAD>
<body style="overflow-x:hidden">
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
        titleStr = "<TH nowrap>&nbsp;&nbsp;" + valueStr + "</TH>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
%> 
        <wtc:service name="s3218EXC" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=opCodes%>" />
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=grpId%>" />
			<wtc:param value="<%=grpName%>" />			
		</wtc:service>
		<wtc:array id="result" start="0" length="3" scope="end" />
<%

		for(int iii=0;iii<result.length;iii++){
				for(int jjj=0;jjj<result[iii].length;jjj++){
					System.out.println("---------------------result["+iii+"]["+jjj+"]=-----------------"+result[iii][jjj]);
				}
		}
		
		
    //���ݴ��˵�Sql��ѯ���ݿ⣬�õ����ؽ��

      		int recordNum = result.length;
      		for(int i=0;i<recordNum;i++)
      		{
      		   String tdClass = ((i%2)==1)?"Grey":"";
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr = "<TD title=\'"+(result[i][j]).trim()+"\' class='"+tdClass+"'>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
						}	          		            
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "'  value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }
                    else
                    {        		        
          		        inputStr = inputStr + "<TD title=\'"+(result[i][j]).trim()+"\' class='"+tdClass+"'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "'  value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }          		            
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		    }
%>
  
   </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellspacing="0">
        <TR> 
            <TD id="footer">
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input  name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
        out.print("<input  name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");       
    } 
%> 

<%
				if(selType.compareTo("") != 0)
				{
%>              
                <input  name=commit onClick="saveTo()" class="b_foot" style="cursor:hand" type=button value=ȷ��>&nbsp;
<%
				}
%>             
                <input  name=back onClick="window.close()" class="b_foot" style="cursor:hand" type=button value=����>&nbsp;        
            </TD>
        </TR>
    </TABLE>

  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>  
 <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</body></HTML>    
