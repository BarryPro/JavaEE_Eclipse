<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.08.26
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>

<% request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>





<%!
    //�õ��������
    ////Logger logger = Logger.getLogger("pubMainBill.jsp");
    ////ArrayList retArray = new ArrayList();
   ///// String return_code,return_message;
    //String[][] retInfo = new String[][]{};
    //String[][] result = new String[][]{};
 	////S1100View callView = new S1100View();
%> 	
<%
/*
SQL���        sql_content
ѡ������       sel_type   
����           title      
�ֶ�1����      field_name1
*/
    String fieldNum = "";
    String pageTitle = "���ʷ���Ϣ��ѯ";
    String fieldName = "�ʷ�ģʽ����|�ʷ�ģʽ����|�ʷ�����|";
	String opName = "��ͨ����";
    String orgCode = request.getParameter("orgCode");
    String regionCode = orgCode.substring(0,2);
    String smCode = request.getParameter("smCode");
    String innetCode =  request.getParameter("innetCode");
	String existModeCode=request.getParameter("existModeCode");
	String phoneNo=request.getParameter("phoneNo");
	
    String selType = "S";
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
	String flagStr = "";
    String valueStr = "";  

%>

<HTML><HEAD><TITLE>������BOSS-<%=pageTitle%></TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

<SCRIPT type=text/javascript>
function turnToDepend()
{
          for(i=0;i<pubBillChg.elements.length;i++)
          { 
    		      if (pubBillChg.elements[i].name=="List")
    		      {    //�ж��Ƿ��ǵ�ѡ��ѡ��
    			 if (pubBillChg.elements[i].checked==true)
    			 {     //�ж��Ƿ�ѡ��
	 				rIndex = pubBillChg.elements[i].RIndex;
	 				obj = "Rinput" + rIndex + 0;
	        		modeCode = document.all(obj).value;
	 				obj = "Rinput" + rIndex + 1;
	        		modeName = document.all(obj).value;	  
					obj = "Rinput" + rIndex + 3;
	        		modeFlag = document.all(obj).value;	 
					window.returnValue= modeCode + "|" + modeName+"~"+modeFlag;     
					window.close();                                               
                 }
    		    }
    	   }
}

function blank()
{
  //window.returnValue="";
  window.close();
}

//---------------------------
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
         
<FORM method=post name="pubBillChg">
	
	<%@ include file="/npage/include/header_pop.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">���ʷ���Ϣ��ѯ</div>
		</div>
	
	
  <table cellspacing="0">
  	<tbody>
    <tr>
<%  //���ƽ����ͷ  
     chPos = fieldName.indexOf("|");
     out.print("<TR>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<th nowrap>&nbsp;&nbsp;" + valueStr + "</th>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
%> 

<%
  /**  //���÷���sGetMainBill���õ����ؽ��
 	retArray = callView.view_sGetMainBill(orgCode,smCode,innetCode);
      		retInfo = (String[][])retArray.get(0);
      		if((retInfo[0][0]).compareTo("000000") == 0)
      		{
	      		result = (String[][])retArray.get(1);
	      		int recordNum = result.length;
				int jj=0;
	      		for(int i=0;i<recordNum;i++)
	      		{
	      		    typeStr = "";
	      		    inputStr = "";
					flagStr="";
	      		    out.print("<TR bgcolor='#EEEEEE'>");
	      		    for(jj=0;jj<Integer.parseInt(fieldNum);jj++)
	      		    {
	                    if(jj==0)
	                    {
	                        typeStr ="<TD>&nbsp;<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" +  
	                            "onkeydown='if(event.keyCode==13)turnToDepend();'";

							if(existModeCode.indexOf(result[i][jj])!=-1)
								typeStr+=" checked ";

	                        typeStr += " title='aaa'>"+result[i][jj] + "<input type='hidden' " +
	          		            " id='Rinput" + i + jj + "' class='button' value='" + 
	          		            result[i][jj] + "' readonly></TD>";          		            
	                    }
	                    else
	                    { 
						    System.out.println("jj222==="+jj);       		        
	          		        inputStr = inputStr + "<TD>&nbsp;" + result[i][jj] + "<input type='hidden' " +
	          		            " id='Rinput" + i + jj + "' class='button' value='" + 
	          		            result[i][jj] + "'>";          		            
	                    }    
						System.out.println("typeStr======="+typeStr); 
						System.out.println("inputStr======"+inputStr);     		            
	      		    }
					//System.out.println(""+);
                    flagStr+="<input type=hidden id=Rinput"+i+jj+" value="+result[i][jj]+"></td>";					
	      		    out.print(typeStr + inputStr+flagStr);
	      		    out.print("</TR>");
				}      		    
      		**/
     	
      
        
%>

			<wtc:service name="sGetMainBill" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg"  outnum="6" >
			        <wtc:param value="<%=orgCode%>"/>
			        <wtc:param value="<%=smCode%>"/>
			        <wtc:param value="<%=innetCode%>"/>
			        <wtc:param value="<%=phoneNo%>"/>
			</wtc:service>
			<wtc:array  id="retInfo"  start="0"  length="2"  scope="end" />
			<wtc:array  id="result"  start="2"  length="4"  scope="end" />
<%

	if(retCode.equals("0")){
 			   retCode="000000";
 			}
	
	if(retCode.compareTo("000000") == 0)
      		{


      		//int kkk=result[0].length;
      		//System.out.println(kkk+    "      result[0].length in pubMainBill.jsp");
	      	//	result = (String[][])retArray.get(1);
	      		int recordNum = result.length;
	      		System.out.println(recordNum+"    recordNum  in  sGetMainBill  pubMainbil ");
				int jj=0;
	      		for(int i=0;i<recordNum;i++)
	      		{
	      		    typeStr = "";
	      		    inputStr = "";
					flagStr="";
	      		    out.print("<TR>");
	      		    for(jj=0;jj<Integer.parseInt(fieldNum);jj++)
	      		    {
	                    if(jj==0)
	                    {
	                    int lt=jj;
	                        typeStr ="<TD>&nbsp;<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" +  
	                            "onkeydown='if(event.keyCode==13)turnToDepend();'";

							if(existModeCode.indexOf(result[i][jj])!=-1)
								typeStr+=" checked ";

	                        typeStr += " title='aaa'>"+result[i][lt] + "<input type='hidden' " +
	          		            " id='Rinput" + i + jj + "' class='button' value='" + 
	          		            result[i][lt] + "' readonly></TD>";          		            
	                    }
	                    else
	                    { 
	                    int lt=jj;
	          		        inputStr = inputStr + "<TD>&nbsp;" + result[i][lt] + "<input type='hidden' " +
	          		            " id='Rinput" + i + jj + "' class='button' value='" + 
	          		            result[i][lt] + "'>";          		            
	                    }    
	      		    }
                    flagStr+="<input type=hidden id=Rinput"+i+jj+" value="+result[i][jj]+"></td>";					
	      		    out.print(typeStr + inputStr+flagStr);
	      		    out.print("</TR>");
				}  
				}    		    
      	 

%>   
   </tr>
  </tbody>
  </table>


<!------------------------------------------------------>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer">
                <input class="b_foot" name=commit onClick="turnToDepend()" style="cursor:hand" type=button value=ȷ��>&nbsp;
                <input class="b_foot" name=back onClick="blank()" style="cursor:hand" type=button value=����>&nbsp;
            </TD>
        </TR>
    </TBODY>
    </TABLE>
  
  <!------------------------> 
  <input type="hidden" name="modeCode" >
  <input type="hidden" name="modeName" >
  <!------------------------>
   <%@ include file="/npage/include/footer_pop.jsp" %>   
</FORM>
</BODY></HTML>    

