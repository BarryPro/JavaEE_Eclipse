<%
/********************
 version v2.0
������: si-tech
update:anln@2009-02-18 ҳ�����,�޸���ʽ
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
   	 //�õ��������
   	String opCode = "3171";
	String opName = "֧����ϵ����";
	String regionCode= (String)session.getAttribute("regCode");
	
  	String return_code,return_message;
  	String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
 	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String workno = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String nopass = (String)session.getAttribute("password");
%> 	

<%


	String pageTitle 	= request.getParameter("pageTitle");
	String fieldNum 	= "";
	String fieldName 	= request.getParameter("fieldName");    
	
	String sqlFilter 	= "";
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;	
	
	String idCard=request.getParameter("idCard");
	//String sqlStr = "select count(*) from dconmsg  where account_type in ('0','1') and CONTRACT_NO not in (select CONTRACT_NO from dconconmsg)  and con_cust_id in(select cust_id from dCustDoc where ID_ICCID='"+idCard+"') ";
	//String sqlStr1 = "select * from (select CONTRACT_NO,BANK_CUST,rownum id from dconmsg  where account_type in ('0','1') and CONTRACT_NO not in (select CONTRACT_NO from dconconmsg) and con_cust_id in(select cust_id from dCustDoc where ID_ICCID='"+idCard+"')) where id <="+iEndPos+" and id>"+iStartPos;
	/*
	String sqlStr =  "  SELECT COUNT(*)                                                    "
					+" FROM   DCONMSG                                                     "
					+" WHERE  ACCOUNT_TYPE IN ('0', '1')                                  "
					+" AND    CONTRACT_NO NOT IN                                          "
					+" 	   (SELECT CONTRACT_NO                                            "
					+" 		 FROM   DCONCONMSG A1                                         "
					+" 		 WHERE  A1.CONTRACT_NO NOT IN                                 "
					+" 				(SELECT A11.ACCOUNT_ID                                "
					+" 				 FROM   DGRPUSERMSG A11                               "
					+" 				 WHERE  A11.SM_CODE = 'hl'))                          "
					+" AND    CON_CUST_ID IN                                              "
					+" 	   (SELECT CUST_ID FROM DCUSTDOC WHERE ID_ICCID = '"+idCard+"')  ";
	String sqlStr1 = "SELECT *                                                                      "
					+"  FROM   (SELECT CONTRACT_NO, BANK_CUST, ROWNUM ID                              "
					+"  		 FROM   DCONMSG                                                       "
					+"  		 WHERE  ACCOUNT_TYPE IN ('0', '1')                                    "
					+"  		 AND    CONTRACT_NO NOT IN                                            "
					+"  				(SELECT CONTRACT_NO                                           "
					+"  				  FROM   DCONCONMSG A1                                        "
					+"  				  WHERE  A1.CONTRACT_NO NOT IN                                "
					+"  						 (SELECT A11.ACCOUNT_ID                               "
					+"  						  FROM   DGRPUSERMSG A11                              "
					+"  						  WHERE  A11.SM_CODE = 'hl'))                         "
					+"  		 AND    CON_CUST_ID IN                                                "
					+"  				(SELECT CUST_ID FROM DCUSTDOC WHERE ID_ICCID = '"+idCard+"')) ";
					
	*/					
	/*String sqlStr =  "       SELECT COUNT(1)                                                               "
					+" 		 FROM   DCONMSG A                                                              "
					+" 		 WHERE  ACCOUNT_TYPE IN ('0', '1')                                             "
					+" 		 AND    ( NOT exists                                                           "
					+" 			   (SELECT count(1)                                                        "
					+" 				  FROM   DCONCONMSG A1                                                 "
					+" 				  WHERE  A1.CONTRACT_NO = A.CONTRACT_NO) OR                            "
					+" 			   exists                                                                  "
					+" 			   (SELECT count(1)                                                 	   "
					+" 				  FROM   DGRPUSERMSG A11                                               "
					+" 				  WHERE  A11.SM_CODE = 'hl'                                            "
					+" 				  AND    A11.ACCOUNT_ID = A.CONTRACT_NO))                              "
					+" 		 AND    CON_CUST_ID IN                                                         "
					+" 				(SELECT CUST_ID FROM DCUSTDOC WHERE ID_ICCID = '"+idCard+"')           ";	
					*/
	String sqlStr1 = " SELECT *                                                                            "
					+" FROM   (SELECT CONTRACT_NO, BANK_CUST, ROWNUM ID                                    "
					+" 		 FROM   DCONMSG A                                                              "
					+" 		 WHERE  ACCOUNT_TYPE IN ('0', '1')                                             "
					+" 		 AND    (CONTRACT_NO NOT IN                                                    "
					+" 			   (SELECT CONTRACT_NO                                                     "
					+" 				  FROM   DCONCONMSG A1                                                 "
					+" 				  WHERE  A1.CONTRACT_NO = A.CONTRACT_NO) OR                            "
					+" 			   CONTRACT_NO IN                                                          "
					+" 			   (SELECT A11.ACCOUNT_ID                                                  "
					+" 				  FROM   DGRPUSERMSG A11                                               "
					+" 				  WHERE  A11.SM_CODE = 'hl'                                            "
					+" 				  AND    A11.ACCOUNT_ID = A.CONTRACT_NO))                              "
					+" 		 AND    CON_CUST_ID IN                                                         "
					+" 				(SELECT CUST_ID FROM DCUSTDOC WHERE ID_ICCID = '"+idCard+"'))          ";


  	String selType = request.getParameter("selType");
	String retQuence = request.getParameter("retQuence");
	
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
%>

<HTML>
	<HEAD>
		<TITLE>֧���ʻ���Ϣ</TITLE>
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
</SCRIPT>
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">      
  	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">֧���ʻ���Ϣ</div>
	</div>
  	<table  cellspacing="0">      
		<TR>
			<th>&nbsp;&nbsp;�ʺ�</th>
			<th>&nbsp;&nbsp;�ʻ�����</th>
		</TR> 
<%  	
	//���ƽ����ͷ  
	chPos = fieldName.indexOf("|");
	out.print("");
	String titleStr = "";
	int tempNum = 0;
	while(chPos != -1)
	{  
	valueStr = fieldName.substring(0,chPos);
	titleStr = "";
	out.print(titleStr);
	fieldName = fieldName.substring(chPos + 1);
	tempNum = tempNum +1;
	chPos = fieldName.indexOf("|");
	}
	out.print("");
	fieldNum = String.valueOf(tempNum+1);
%> 

<%
    //���ݴ��˵�Sql��ѯ���ݿ⣬�õ����ؽ��
	try
 	{      	
      			//retArray = callView.sPubSelect(fieldNum,sqlStr1);
			//retArray1 = callView.sPubSelect("1",sqlStr);
		%>
<!--xl add for -->
<wtc:service name="sGrpCustQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="<%=fieldNum%>">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="3171"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=idCard%>"/>
			<wtc:param value=""/>
			<wtc:param value="3171"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="2"/>
			<wtc:param value=""/>
			<wtc:param value="2"/>
			<wtc:param value=""/>
		</wtc:service>
		<wtc:array id="retArray" scope="end"/>
			 
			
	           
<!--xl add for-->	
<wtc:service name="sGrpCustQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="3171"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=idCard%>"/>
			<wtc:param value=""/>
			<wtc:param value="3171"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="1"/>
			<wtc:param value=""/>
			<wtc:param value="2"/>
			<wtc:param value=""/>
		</wtc:service>
		<wtc:array id="retArray1" scope="end"/>

			 
		<%
      			//result = (String[][])retArray.get(0);      		
      			result=retArray;;
			//allNumStr = (String[][])retArray1.get(0);
			allNumStr=retArray1;
            		int recordNum = Integer.parseInt(allNumStr[0][0].trim());     
            		       
	      		for(int i=0;i<recordNum;i++)
	      		{
	      		    typeStr = "";
	      		    inputStr = "";
	      		    out.print("<TR  style='font-size:12px;'>");
	      		    for(int j=0;j<Integer.parseInt(fieldNum)-1;j++)
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
	          		            " id='Rinput" + i + j + "'  value='" + 
	          		            (result[i][j]).trim() + "'readonly></TD>";          		            
	                    }
	                    else
	                    {        		        
	          		        inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
	          		            " id='Rinput" + i + j + "'  value='" + 
	          		            (result[i][j]).trim() + "'readonly></TD>";          		            
	                    }          		            
	      		    }
	      		    out.print(typeStr + inputStr);
	      		    out.print("</TR>");
	      		}
     	}catch(Exception e){
       		
     	}          
%>
<%


%>   
  </table>
<%
    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
    PageView view = new PageView(request,out,pg);
%>

<div style="position:relative;font-size:12px;" align="center">
<%
   	view.setVisible(true,true,0,0);       
%>

    <TABLE  cellSpacing=0>
    	<TBODY>
        	<TR> 
            		<TD id="footer">
				<%
				    if(selType.compareTo("checkbox") == 0)
				    {           
				        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
				        out.print("<input class='b_foot_long' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");       
				    } 
				%> 
	
				<%
					if(selType.compareTo("") != 0)
					{
				%>              
	                			<input class="b_foot" name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ��>&nbsp;
				<%
					}%>             
	                	<input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=����>&nbsp;        
            		</TD>
        </TR>
    </TBODY>
    </TABLE>
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
   <%@ include file="/npage/include/footer_pop.jsp" %> 
</FORM>
</BODY></HTML>    
