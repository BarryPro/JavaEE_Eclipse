<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-14
********************/
%>


<%request.setCharacterEncoding("GB2312");%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=Gb2312"%>
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
  String opCode = "6726";
  String opName = "���Ų������ӳ�Ա";
%>

<%
    String[][] result = new String[][]{};
	  String[][] allNumStr =  new String[][]{};
	  
	  
    String fieldNum = "";
    String pageTitle = request.getParameter("pageTitle");
    String fieldName = request.getParameter("fieldName");
	  String op_code = request.getParameter("op_code");
    String sm_code = request.getParameter("sm_code");
    String regionCode = request.getParameter("regionCode");
    String groupFlag = request.getParameter("groupFlag")==null?"N":request.getParameter("groupFlag");
	  String grpProductCode = request.getParameter("grpProductCode");
	  String  smName = request.getParameter("smName");	
	  String  mebMonthFlag = request.getParameter("mebMonthFlag");
	  String mode_type  = request.getParameter("mode_type");
	  String pay_type = request.getParameter("payType");

	  //System.out.println("grpProductCode="+grpProductCode);
	  String product_attr = "";
	  String grpProductAttr = request.getParameter("grpProductAttr");
	   
	  //��ҳ����
    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    int iPageSize = 25;
    int iStartPos = (iPageNumber-1)*iPageSize;
    int iEndPos = iPageNumber*iPageSize;

	  String sqlStr = null;
	  String sqlStr1 = null;
	  
  	if ("2".equals(pay_type)){
		 pay_type="0";
		 }else{
		 pay_type="1";
	   }
	
	 sqlStr1 = "select distinct meb_prodcode,mode_name"
						+" from sColorMemberMode a, scolorMode b,sbillmodecode c "
						+" where a.region_code= '"+regionCode+"'"
						+" and   a.grp_prodcode='"+smName+"'"
						+" and   a.month_flag='"+mebMonthFlag+"'"
						+" and   a.meb_prodcode=b.product_code"
						+" and   a.region_code=b.region_code"
						+" and   c.start_time<sysdate  and c.stop_time>sysdate"
						+" and   a.region_code=c.region_code"
						+" and   b.PRODUCT_CODE=c.MODE_CODE"
						+" and   b.MODE_BIND='0'";
						
												
   sqlStr = "select nvl(count(*),0) num "
					+" from sColorMemberMode a, scolorMode b,sbillmodecode c "
					+" where a.region_code= '"+regionCode+"'"
					+" and   a.grp_prodcode='"+smName+"'"
					+" and   a.month_flag='"+mebMonthFlag+"'"
					+" and   a.meb_prodcode=b.product_code"
					+" and   a.region_code=b.region_code"
					+" and   c.start_time<sysdate  and c.stop_time>sysdate"
					+" and   a.region_code=c.region_code"
					+" and   b.PRODUCT_CODE=c.MODE_CODE"
					+" and   b.MODE_BIND='0'";
					
 	if(mebMonthFlag.equals("N"))
		{
		  System.out.println("AAAA"+mebMonthFlag);
			sqlStr=sqlStr+" and   b.group_flag='"+pay_type+"'";
			sqlStr1=sqlStr1+" and   b.group_flag='"+pay_type+"'";
    }		
       
    
       System.out.print("sqlStr="+sqlStr);
       System.out.print("sqlStr1="+sqlStr1);

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
<TITLE>������BOSS-���ų�Ա��Ʒ��ѯ</TITLE>
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
		<div id="title_zi">������BOSS-���Ų�Ʒ��ѯ</div>
	</div>
  <table cellpadding="0" >
    <tr>
<TR>
<td class="blue">&nbsp;&nbsp;��Ʒ����</TD>
<td class="blue">&nbsp;&nbsp;��Ʒ����</TD></TR> 
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

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="allNumStr_l" scope="end"/>


		<wtc:pubselect name="sPubSelect" outnum="<%=fieldNum%>" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_l" scope="end"/>

<% 	
 	try
 	{          	
			 		 result = result_l;
	         allNumStr = allNumStr_l;
						//System.out.println("-----------allNumStr[0][0]------------hjw-----------"+allNumStr[0][0]);
            int recordNum = Integer.parseInt(allNumStr[0][0]);
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
    int iQuantity = Integer.parseInt(allNumStr[0][0]);
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
	