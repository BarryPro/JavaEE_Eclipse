<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
*���ҳ����1270�����ʷ��õ�ҳ��,������
*zhanghonga��bill/f1255Main.jsp���ٶ�����.ԭ��:���õ�PubSimpSele()����δ�ܺܺô������ӷ�"+",�������ӵ�(+),������ʱʹ�ô�ҳ��
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
		response.setHeader("Pragma","No-cache");
		response.setHeader("Cache-Control","no-cache");
		response.setDateHeader("Expires", 0);
%>
<%
		String opCode = "";
		String opName = WtcUtil.repNull(request.getParameter("pageTitle"));
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));
		String loginNo = (String)session.getAttribute("workNo");
		System.out.println("-----------------------offerId----------------------"+offerId);
		
		
		String newOfferId = WtcUtil.repNull(request.getParameter("newOfferId"));
		System.out.println("-----------------------newOfferId----------------------"+newOfferId);
		
		if(newOfferId.equals("")) newOfferId="NULL";
		System.out.println("-----------------------newOfferId----------------------"+newOfferId);
		String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
    int recordNum = 0;
    int iQuantity = 0;
    ArrayList retArray = new ArrayList();
    String return_code,return_message;
		/*
		SQL���        sql_content
		ѡ������       sel_type   
		����           title      
		�ֶ�1����      field_name1
		*/
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String sqlStr1 = request.getParameter("sqlStr1")==null?"":request.getParameter("sqlStr1");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
		int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		String op_code = "";
		op_code = (String)request.getParameter("opCode");
		int iPageSize = 25;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;

   
    System.out.println("sqlStr1="+sqlStr1);
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

<HTML><HEAD><TITLE><%=pageTitle%></TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>

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
        					 window.returnValue= retValue ;   
               }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("��ѡ����Ϣ�");
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
  <table cellspacing="0">
    <tr>
<%  //���ƽ����ͷ  
     chPos = fieldName.indexOf("|");
     out.print("<tr align='center'>");
     String titleStr = "";
     int tempNum = 0;
		 int k=0;
     while(chPos != -1)
     {  
				++k;
        valueStr = fieldName.substring(0,chPos);
        if(valueStr.equals("����С��"))
        	titleStr = "<th nowrap style='display:none'>&nbsp;&nbsp;" + valueStr + "</th>";
        else
        	titleStr = "<th nowrap  >&nbsp;&nbsp;" + valueStr + "</th>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum);
     String outNum = String.valueOf(tempNum+1);
%> 

<%
    //���ݴ����Sql��ѯ���ݿ⣬�õ����ؽ��
	try
 	{      	
            if (sqlStr1.trim().length() > 0) {
    %>
							<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
							<wtc:sql><%=sqlStr1%></wtc:sql>
							</wtc:pubselect>
							<wtc:array id="numArr" scope="end" />    						
    <%
                iQuantity = numArr.length>0?Integer.parseInt(numArr[0][0].trim()):0;
            }
   System.out.println("----------------offerId------------------------"+offerId);         
   System.out.println("----------------loginNo------------------------"+loginNo);         
   System.out.println("----------------newOfferId---------------------"+newOfferId);         
   
            
    %>
		    <wtc:service name="s1259Query" outnum="7" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
					<wtc:param value="<%=offerId%>" />
					<wtc:param value="<%=loginNo%>" />
					<wtc:param value="<%=newOfferId%>" />	
					<wtc:param value="<%=op_code%>" />	
				</wtc:service>
				<wtc:array id="result" scope="end"  />   						
    <%
    
    System.out.println("----------------code------------------------"+code);
    String styleType = "";
   	for(int iii=0;iii<result.length;iii++){
				for(int jjj=0;jjj<result[iii].length;jjj++){
					System.out.println("---------------------result["+iii+"]["+jjj+"]=-----------------"+result[iii][jjj]);
				}
		}
            recordNum = result.length;
           	if (result[0][0].trim().length() == 0||(!code.equals("000000")))
                recordNum = 0;
            
      		for(int i=0;i<recordNum;i++)
      		{
      		    typeStr = "";
      		    inputStr = "";
							String tbclass=(i%2==0)?"Grey":"";
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        typeStr = "<TD class='"+tbclass+"'>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            "onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
												}	          		            
                        typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }else{
                    	
                    if(j==Integer.parseInt(fieldNum)-1)   styleType = "none";  else styleType= "";
                    	
                    	System.out.println("-------------------------styleType------------------"+styleType);
                    	
          		        inputStr = inputStr + "<TD style='display:"+styleType+"' class='"+tbclass+"'   >&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
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

<%	
    if (sqlStr1.trim().length() > 0) {
        Page pg = new Page(iPageNumber,iPageSize,iQuantity);
		    PageView view = new PageView(request,out,pg); 
	     	view.setVisible(true,true,0,0);       
    }
%>

<!------------------------------------------------------>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD id="footer">
<%
			    if(selType.compareTo("checkbox") == 0)
			    {           
			        out.print("<input class='b_foot' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
			        out.print("<input class='b_foot' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");       
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
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value="�ر�">&nbsp;        
            </TD>
        </TR>
    </TBODY>
    </TABLE>
<%@ include file="/npage/include/footer_pop.jsp" %>  
  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------>  
</FORM>
</BODY></HTML> 
