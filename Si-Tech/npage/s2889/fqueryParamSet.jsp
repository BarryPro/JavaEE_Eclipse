<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.02.10
 ģ�飺�������ҵ������
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>

<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String regCode = (String)session.getAttribute("regCode");
	//�õ��������
	String return_code,return_message;
	String[][] allNumStr =  new String[][]{};
%> 	

<%
/*
SQL���       sql_content
ѡ������       sel_type   
����                title      
�ֶ�1����     field_name1
*/
	String opName = "ҵ�������ѯ";
    String retToField 	= request.getParameter("retToField");
    String flag 	= request.getParameter("flag");
    
    String pageTitle 	= request.getParameter("pageTitle");
    String fieldNum 	= "";
    String fieldName 	= request.getParameter("fieldName");

	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

     String sqlFilter 	= "";
     String sqlStr = "select nvl(count(*),0) num from sBizParamSet where 1=1 and srv_code ='' or srv_code is null " + sqlFilter;
	String sqlStr1 = "select * from (select param_set,set_name,rownum id  from sBizParamSet  where 1=1  and srv_code ='' or srv_code is null " + sqlFilter + ") where id <"+iEndPos+" and id>="+iStartPos;

    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    
    System.out.print("sqlStr===="+sqlStr);
    
    //չ�ֵ�ѡ
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
    String op_name = "������BOSS-ҵ�������ѯ";
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=op_name%></TITLE>
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
		var flag=document.fPubSimpSel.flag.value;
		opener.getValueParamSet(retValue,flag);
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
		<div id="title_zi"><%=opName%></div>
	</div>	
<input type="hidden" name="flag"  value="<%=flag%>">

  <table cellspacing="0">
    <tr>
	<TR>
		<TH>��������</TH>
		<TH>��������</TH>
	</TR> 
<%  //���ƽ����ͷ  
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
     fieldNum = String.valueOf(tempNum);
%> 

<%
    //���ݴ��˵�Sql��ѯ���ݿ⣬�õ����ؽ��
	try
 	{      	
      		//retArray = callView.sPubSelect(fieldNum,sqlStr1);
			//retArray1 = callView.sPubSelect("1",sqlStr);
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="<%=fieldNum+1%>">
			<wtc:sql><%=sqlStr1%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />
				
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="allNumStrTemp" scope="end" />
<%
      		//result = (String[][])retArray.get(0);
			allNumStr = allNumStrTemp;
			if(allNumStr.length==0){
				allNumStr = new String[1][1];
				allNumStr[0][0] = "0";
			}
            int recordNum = Integer.parseInt(allNumStr[0][0].trim());
      		for(int i=0;i<recordNum;i++)
      		{
      			String tdClass = (i%2==0)?"Grey":"";
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
       		
     	}          
%>
<%


%>   
   </tr>
  </table>
  <div style="position:relative;font-size:12px;">
<%	
    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>
  </div>
<!------------------------------------------------------>
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer">
<%
    if(selType.compareTo("checkbox") == 0)
    {           
        out.print("<input class='button' name=allchoose onClick='allChoose()' style='cursor:hand' type=button value=ȫѡ>&nbsp");
        out.print("<input class='button' name=cancelAll onClick='cancelChoose()' style='cursor:hand' type=button value=ȡ��ȫѡ>&nbsp");       
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
</BODY>
</HTML>    
