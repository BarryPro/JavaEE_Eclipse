<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.09.03
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>

<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GB2312");%>



<%!                  //���   20080903  wtc�滻 ejb liutong
    //�õ��������
   // ArrayList retArray = new ArrayList();
   // String return_code,return_message;
   // String[][] result = new String[][]{};
 	//S1100View callView = new S1100View();
%> 	
<%
/*
SQL���        sql_content
ѡ������       sel_type   
����           title      
�ֶ�1����      field_name1
*/
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String sqlStr = request.getParameter("sqlStr");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    String regionCode = request.getParameter("regionCode");
    String opName="��ͨ����";
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
%>

<HTML><HEAD><TITLE>������BOSS-<%=pageTitle%></TITLE>
</HEAD>

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
        				    // alert(document.fPubSimpSel.elements[i].value);
        			         rIndex = document.fPubSimpSel.elements[i].RIndex;
        			         tempQuence = retQuence;
        			         for(n=0;n<retNum;n++)
        			         {   
        			            chPos = tempQuence.indexOf("|");
        			            fieldNo = tempQuence.substring(0,chPos);
        			            //alert(fieldNo);
        			            obj = "Rinput" + rIndex + fieldNo;
        			           // alert(obj);
        			            retValue = retValue + document.all(obj).value + "|";
        			           // alert(retValue);    
        			            tempQuence = tempQuence.substring(chPos + 1);
        			         }
                             //alert(retValue);                                  
        					 window.returnValue= retValue;
<%
	//if (selType.equals("radio"))
	//{
	//	out.println("window.close();");
	//}
%>
                       }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("��ѡ��sim���ѣ�",0);
		    return false;
		}

window.close(); 
}
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">

<%@ include file="/npage/include/header_pop.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=pageTitle%></div>
		</div>
      
  <table cellspacing="0">
    <tr>
<%  //���ƽ����ͷ  
     chPos = fieldName.indexOf("|");
     out.print("<TR> ");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<TD>&nbsp;&nbsp;" + valueStr + "</TD>";
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

 		   //out.print(fieldNum);
      		//retArray = callView.view_spubqry32(fieldNum,sqlStr);
      		System.out.println(sqlStr);
      		//int recordNum = Integer.parseInt((String)retArray.get(0));
      		//result = (String[][])retArray.get(1);
      		//result = (String[][])retArray.get(0);
      		
      		
      		
 %>
			 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="ret_code1" retmsg="retMsg" outnum="<%=fieldNum%>">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />
 <%
 
 if(ret_code1.equals("0")||ret_code1.equals("000000")){
          System.out.println("���÷���sPubSelect in 	pubGetsimfee.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	       
 	       
 	       int recordNum = result.length;
      		System.out.print(sqlStr);
      		for(int i=0;i<recordNum;i++)
      		{
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr ="<TD>&nbsp;<input type='" + selType +  
          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" +  
                            "onkeydown='if(event.keyCode==13)saveTo();'" + ">";
                        typeStr = typeStr + "<input type='text' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            result[i][j] + "'readonly></TD>";          		            
                    }
                    else if(j==7)
                    {
          		        inputStr = inputStr + "<TD><input type='password' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            result[i][j] + "'readonly></TD>";                      
                    }
                    else
                    {        		        
          		        inputStr = inputStr + "<TD><input type='text' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            result[i][j] + "'readonly></TD>";          		            
                    }          		            
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
 	        	
 	        	
 	        	
 	        	
 	     	}else{
 			System.out.println("���÷���sPubSelect in 	pubGetsimfee.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}

 
      	
     
%>
<%


%>   
   
   
   </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellspacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer">
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
