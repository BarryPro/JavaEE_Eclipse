<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
     //�õ��������
     ArrayList retArray = new ArrayList();
     ArrayList retArray1 = new ArrayList();
     String return_code,return_message;
     String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
 	SPubCallSvrImpl callView = new SPubCallSvrImpl();
%> 	

<%
/*
SQL���       sql_content
ѡ������       sel_type   
����                title      
�ֶ�1����     field_name1
*/
    String retToField 	= request.getParameter("retToField");
    
    String pageTitle 	= request.getParameter("pageTitle");
    String fieldNum 	= "";
    String fieldName 	= request.getParameter("fieldName");

	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;

     String sqlFilter 	= "";
     String sqlStr =  "select nvl(count(*),0) num from sBizTargetType where 1=1 " + sqlFilter;
	String sqlStr1 = "select * from (select target_code,target_name,rownum id  from sBizTargetType  where 1=1 " + sqlFilter + ") where id <"+iEndPos+" and id>="+iStartPos;

    String selType = request.getParameter("selType");
    System.out.println("selType===="+selType);

    String retQuence = request.getParameter("retQuence");
    String num = request.getParameter("num");
    
    System.out.println("sqlStr===="+sqlStr);    
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
    String op_name = "����BOSS-ҵ�������ѯ";

%>

<HTML><HEAD>
<TITLE><%=op_name%></TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0">

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
		opener.getValueBizTarget(retValue, document.fPubSimpSel.num.value);
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
 <link rel="stylesheet" href="../../css/style.css" type="text/css">
</HEAD>
<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0" background="<%=request.getContextPath()%>/images/jl_background_2.gif">
<table width="767" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
  <tr>
      <td background="<%=request.getContextPath()%>/images/jl_background_1.gif" bgcolor="#E8E8E8">
              
<FORM method=post name="fPubSimpSel">
	<input type="hidden" name="retToField" value="<%=retToField%>">
	  <div id="Operation_Table">   
   <TABLE>
   <BODY>
    <TR>
  <table  bgcolor="#FFFFFF" width="98%" border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
<TR bgcolor='649ECC' height=25>
	<TD>&nbsp;&nbsp;��������</TD>
	<TD>&nbsp;&nbsp;��������</TD>
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
 	          System.out.print("1---------------------------");
      		retArray = callView.sPubSelect(fieldNum,sqlStr1);
			retArray1 = callView.sPubSelect("1",sqlStr);
      		result = (String[][])retArray.get(0);
			allNumStr = (String[][])retArray1.get(0);
               int recordNum = Integer.parseInt(allNumStr[0][0].trim());                   

      		for(int i=0;i<recordNum;i++)
      		{
      		    System.out.print("2---------------------fieldNum="+fieldNum);
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR bgcolor='#EEEEEE'>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
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
   	view.setVisible(true,true,0,0);       
%>

<!------------------------------------------------------>
    <TABLE width="98%" border=0 align=center cellpadding="4" cellSpacing=1>
    <TBODY>
        <TR bgcolor="#EEEEEE"> 
            <TD align=center bgcolor="#EEEEEE">
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
         <input class="button" name=commit onClick="saveTo()" style="cursor:hand" type=button value=ȷ��>&nbsp;
<%
	     }
%>             
            <input class="button" name=back onClick="window.close()" style="cursor:hand" type=button value=����>&nbsp;        
        </TD>
    </TR>
    </TBODY>
    </TABLE>
   	<!------------------------> 
  <input type="hidden" name="retFieldNum" value=<%=fieldNum%>>
  <input type="hidden" name="retQuence" value=<%=retQuence%>>
  <input type="hidden" name="num" value=<%=num%>>
  <!------------------------>  
   	</div>
	<%@ include file="../public/foot.jsp" %>
</FORM>
</BODY></HTML>    
