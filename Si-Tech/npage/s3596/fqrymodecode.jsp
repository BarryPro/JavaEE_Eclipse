<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-14
********************/
%>
<%request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>

<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<%
  String opCode = request.getParameter("opCode");//huangrong update for ������ְͨҵ��֧�ŵĺ�  2011-8-1
  String opName = "����SIҵ������";
%>

<%
    String[][] result = new String[][]{};
	  
    String fieldNum = "";
    String pageTitle = request.getParameter("pageTitle");
    String fieldName = request.getParameter("fieldName");
    String regionCode = request.getParameter("regionCode");
    String bizcode = request.getParameter("bizcode");
	  String loginNo = (String)session.getAttribute("workNo"); 
	  //System.out.println("grpProductCode="+grpProductCode);
	   
	  //��ҳ����
    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 25;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;

	  String sqlStr = null;
	  String sqlStr1 = null;
	/*
	 sqlStr1 = "select mode_code,mode_name "            
						+" from dbvipadm.scommoncode a,sbillmodecode b "
						+" where b.mode_code=a.field_code3 "          
						+" and b.region_code=a.field_code2 "         
						+" and common_code='1001' and b.region_code='"+regionCode+"' "         
						+" and a.field_code1='"+bizcode+"'";             

												
  	 sqlStr = "select nvl(count(*),0) num "              
						+" from dbvipadm.scommoncode a,sbillmodecode b "
						+" where b.mode_code=a.field_code3 "          
						+" and b.region_code=a.field_code2 "         
						+" and common_code='1001' and b.region_code='"+regionCode+"' "          
						+" and a.field_code1='"+bizcode+"'";        
					
       System.out.println("sqlStr="+sqlStr);
       System.out.println("sqlStr1="+sqlStr1);
	*/
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
<TITLE>������BOSS-�����ײ�ѡ��</TITLE>
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
      var retFieldNum = document.fpubmebProdCodesel.retFieldNum.value;
      var retQuence = document.fpubmebProdCodesel.retQuence.value;  //�����ֶ��������
      var retNum = retQuence.substring(0,retQuence.indexOf("|"));
      retQuence = retQuence.substring(retQuence.indexOf("|")+1);
      var tempQuence;
      if(retFieldNum == "")	
      {     return false;   }
          //���ص�����¼
          for(i=0;i<document.fpubmebProdCodesel.elements.length;i++)
          { 
    		      if (document.fpubmebProdCodesel.elements[i].name=="List")
    		      {    //�ж��Ƿ��ǵ�ѡ��ѡ��
    				   if (document.fpubmebProdCodesel.elements[i].checked==true)
    				   {     //�ж��Ƿ�ѡ��
        				     //alert(document.fpubmebProdCodesel.elements[i].value);
        			         rIndex = document.fpubmebProdCodesel.elements[i].RIndex;
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
                   //alert("retValue="+retValue);                                  
        					 window.returnValue= retValue;
                }
    		    }
    		}		
		if(retValue =="")
		{
		    rdShowMessageDialog("��ѡ����Ϣ�",0);
		    return false;
		}
		opener.getmebProdCode(retValue);
		window.close(); 
}
	
</SCRIPT>

<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fpubmebProdCodesel"> 
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">������BOSS-�����ײ�ѡ��</div>
	</div>
  <table cellpadding="0" >
    <tr>
<TR>
<td class="blue">&nbsp;&nbsp;�ʷѴ���</TD>
<td class="blue">&nbsp;&nbsp;�ʷ�����</TD></TR> 
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
     fieldNum = String.valueOf(tempNum+1);
%> 

<%
    //���ݴ����Sql��ѯ���ݿ⣬�õ����ؽ��

%>
	<wtc:service name="s3596ModeQryEXC" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=regionCode%>" />
		<wtc:param value="<%=bizcode%>" />
	</wtc:service>
	<wtc:array id="result_l" scope="end" />	  	

<% 	
	int allNumStr_l = result_l.length;
 	try
 	{          	
			 		 result = result_l;
            int recordNum =allNumStr_l;
            for(int i=0;i<recordNum;i++)
      		  {
      		    typeStr = "";
      		    inputStr = "";
      		    out.print("<TR>");
      		    for(int j=0;j<Integer.parseInt(fieldNum)-1;j++)
      		    {
                    if(j==0)
                    {
                        typeStr = "<TD>&nbsp;";
                        if(selType.compareTo("") != 0)
                        {
	                        typeStr = typeStr + "<input type='" + selType +  
	          		            "' name='List' style='cursor:hand' RIndex='" + i + "'" + 
	          		            " onkeydown='if(event.keyCode==13)saveTo();'" + ">"; 
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
    int iQuantity = allNumStr_l;
    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
	  PageView view = new PageView(request,out,pg); 
   	view.setVisible(true,true,0,0);       
%>

<!------------------------------------------------------>
    <TABLE cellpadding="0" >
    <TBODY>
        <TR> 
            <TD align=center>
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
  <%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY></HTML>    
	
