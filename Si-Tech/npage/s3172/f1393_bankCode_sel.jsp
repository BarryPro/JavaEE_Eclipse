
   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-11
********************/
%>
              
<%
  String opCode = "3172";
  String opName = "һ��֧���ʻ��ɷ�";
%>              
<%
	request.setCharacterEncoding("ISO-8859-1"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>

<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
  //�õ��������
  String return_code,return_message;
  String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
 	
	
	String orgCode = (String)session.getAttribute("orgCode");
	
	String regionCode = orgCode.substring(0,2);
	String districtCode = orgCode.substring(2,4);
%> 	

<%
/*
SQL���        sql_content
ѡ������       sel_type   
����           title      
�ֶ�1����      field_name1
*/
    String pageTitle 	= new String(request.getParameter("pageTitle").getBytes("ISO-8859-1"),"GB2312");
    String fieldNum 	= "";
    String fieldName 	= new String(request.getParameter("fieldName").getBytes("ISO-8859-1"),"GB2312");
    String bankName = new String(request.getParameter("bankName").getBytes("ISO-8859-1"),"GB2312");//���������ѯ�����Ĳ���
    String bankCode = new String(request.getParameter("bankCode").getBytes("ISO-8859-1"),"GB2312");
    String sqlFilter 	= "";
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	
   if (bankName.trim().length() > 0)
        sqlFilter = sqlFilter + "a.bank_name like'%" + bankName + "%' and ";
	 if (bankCode.trim().length() > 0)
        sqlFilter = sqlFilter + "a.bank_code like'%" + bankCode + "%' and ";
		sqlFilter = sqlFilter + " a.region_code = '" + regionCode + "' and a.district_code = '" + districtCode + "'";
    String sqlStr = "select to_char(nvl(count(*),0)) num from sbankcode a where " + sqlFilter;
	String sqlStr1 = "select * from (select a.bank_code, a.bank_name, rownum id from sbankcode a where " + sqlFilter + ") where id <="+iEndPos+" and id>"+iStartPos;
		System.out.println(sqlStr1);
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

<HTML><HEAD>
<TITLE><%=pageTitle%></TITLE>
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
		opener.getvalue(retValue);
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
<BODY >
<FORM method=post name="fPubSimpSel">
      <%@ include file="/npage/include/header_pop.jsp" %>


	<div class="title">
		<div id="title_zi">ѡ������</div>
	</div>
   <TABLE>
   <BODY>
    <TR>     

  <table cellspacing="0">
  	   
<%  //���ƽ����ͷ  
     chPos = fieldName.indexOf("|");
     out.print("<TR>");
     String titleStr = "";
     int tempNum = 0;
     while(chPos != -1)
     {  
        valueStr = fieldName.substring(0,chPos);
        titleStr = "<TD class='blue'>&nbsp;&nbsp;" + valueStr + "</TD>";
        out.print(titleStr);
        fieldName = fieldName.substring(chPos + 1);
        tempNum = tempNum +1;
        chPos = fieldName.indexOf("|");
     }
     out.print("</TR>");
     fieldNum = String.valueOf(tempNum+1);
%> 

<%
    //���ݴ����Sql��ѯ���ݿ⣬�õ����ؽ��
	try
 	{      
 	
%>


		<wtc:pubselect name="TlsPubSelBoss" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="allNumStr_t" scope="end"/>


		<wtc:pubselect name="TlsPubSelBoss" outnum="<%=fieldNum%>" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_t" scope="end"/>

<% 		
      		//retArray = callView.sPubSelect(fieldNum,sqlStr1);
			    //retArray1 = callView.sPubSelect("1",sqlStr);
      		result = result_t;      		
      		
			allNumStr = allNumStr_t;
            int recordNum = Integer.parseInt(allNumStr[0][0].trim());
            
      		for(int i=0;i<recordNum;i++)
      		{
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR bgcolor='#EEEEEE' style='font-size:12px'>");
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
          		            " id='Rinput" + i + j + "' class='button' value='" + 
          		            (result[i][j]).trim() + "'readonly></TD>";          		            
                    }
                    else
                    {        		        
          		        inputStr = inputStr + "<TD>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
          		            " id='Rinput" + i + j + "' class='button' value='" + 
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
<%	
    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
    //int iQuantity = 500;
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	PageView view = new PageView(request,out,pg); 
%>
		<div style="position:relative;font-size:12px" align="center">
<%
    view.setVisible(true,true,0,0);      
%>
		</div>
<!------------------------------------------------------>
    <TABLE  cellSpacing="0">
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
	
    <TR> 
    <BODY>
   <TABLE>

  <!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <!------------------------> 
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY></HTML>    
