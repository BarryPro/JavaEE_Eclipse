<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *
     ********************/
%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	<%@ page contentType="text/html; charset=GB2312" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
		 String opCode = "1238";
		 String opName = "GSM过户";
		/*
		SQL语句        sql_content
		选择类型       sel_type   
		标题           title      
		字段1名称      field_name1
		*/
		String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String sqlStr = request.getParameter("sqlStr");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    String idIccid = request.getParameter("idIccid");
    String dWorkNo = (String)session.getAttribute("workNo");
    String dNopass = (String)session.getAttribute("password");
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

<HTML>
	<HEAD>
		<TITLE>黑龙江BOSS-<%=pageTitle%></TITLE>
	</HEAD>
	<SCRIPT type=text/javascript>
		onload=function(){
			self.status="";	
		}
	</SCRIPT>
<!--**************************************************************************************-->
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
<%@ include file="/npage/include/header_pop.jsp" %>
  <table cellspacing="0">
    <tr>
<%
    int chPos1=0;
    int tempNum1=0;
    String fieldName1=request.getParameter("fieldName");
    chPos1 = fieldName1.indexOf("|");
    while(chPos1 != -1)
   {  
      fieldName1 = fieldName1.substring(chPos1 + 1);
      tempNum1 = tempNum1 +1;
      chPos1 = fieldName1.indexOf("|");
   }

    fieldNum = String.valueOf(tempNum1);
%>	  
	<wtc:service name="sCustTypeQryC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="<%=fieldNum%>" >
    <wtc:param value="0"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=dWorkNo%>"/>	
    <wtc:param value="<%=dNopass%>"/>		
    <wtc:param value=""/>	
    <wtc:param value=""/>
    <wtc:param value="<%=idIccid%>"/>
  </wtc:service>
  <wtc:array id="result" scope="end"/>
<%
  		int recordNum = result.length;
  		int runCodeJ=0; //预拆
  		int runCodeI=0;//预销
  		int i=0;

  		for(i=0;i<recordNum;i++)
  		{
  		   if(result[i][5].trim().equals("预拆"))
  		    {
  		      runCodeJ++;
  		    }
  		    if(result[i][5].trim().equals("预销"))
  		    {
  		      runCodeI++;
  		    }
  		}
  		   out.print("<table cellspacing='0'><TR>");
	       out.print("<TD >");
         out.print("<div>总计在网数:");
         out.print(recordNum);
         out.print("</div>");
	       out.print("</TD>");
	       out.print("<TD >");
         out.print("<div>预拆数:");
         out.print(runCodeJ);
         out.print("</div>");
	       out.print("</TD>");
	       out.print("<TD >");
         out.print("<div>预销数:");
         out.print(runCodeI);
         out.print("</div>");
	       out.print("</TD>");
  		   out.print("</TR></table>");
  		 //绘制界面表头  
  		 	out.print("<table cellspacing='0'>");
  		   chPos = fieldName.indexOf("|");
         out.print("<TR align='center'> ");
         String titleStr = "";
      
       while(chPos != -1)
       {  
          valueStr = fieldName.substring(0,chPos);
          titleStr = "<th>&nbsp;&nbsp;" + valueStr + "</th>";
          out.print(titleStr);
          fieldName = fieldName.substring(chPos + 1);
          
          chPos = fieldName.indexOf("|");
       }
      out.print("</TR>");
   		String tbclass=""; 		
  		for(i=0;i<recordNum;i++)
  		{
  				if(i%2==0){
  					tbclass="Grey";
  				}else{
  					tbclass="";	
  				}
  		    typeStr = "";
  		    inputStr = "";
  		    out.print("<TR align='center'>");
  		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
  		    {
                if(j==0)
                {
                    
                    typeStr = "<TD style='text-align:center' class='"+tbclass+"'><input style='text-align:center' type='text' " +
      		            " id='Rinput" + i + j + "' class='InputGrey' value='" + 
      		            result[i][j] + "'readonly></TD>";          		            
                }
                else
                {        		        
      		        inputStr = inputStr + "<TD class='"+tbclass+"'><input style='text-align:center' type='text' " +
      		            " id='Rinput" + i + j + "' class='InputGrey' value='" + 
      		            result[i][j] + "'readonly></TD>";          		            
                }          		            
  		    }
  		    out.print(typeStr + inputStr);
  		    out.print("</TR>");
  		}
  		out.print("</table>");
%>   
   </tr>
  </table>


<!------------------------------------------------------>
    <TABLE cellspacing="0">
    <TBODY>
        <TR> 
            <TD id="footer">
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value="关闭">&nbsp;
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
