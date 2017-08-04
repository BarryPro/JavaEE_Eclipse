<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-25 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>

<%

		String opCode = "1104";
		String opName = "普通开户";
		String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
		        String workNo = (String)session.getAttribute("workNo");
        String password = (String)session.getAttribute("password"); 
/*
SQL语句        sql_content
选择类型       sel_type   
标题           title      
字段1名称      field_name1
*/
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum = "";
    String fieldName = request.getParameter("fieldName");
    String sqlStr = request.getParameter("sqlStr");
    String selType = request.getParameter("selType");
    String retQuence = request.getParameter("retQuence");
    if(selType.compareTo("S") == 0)
    {   selType = "radio";    }
    if(selType.compareTo("M") == 0)
    {   selType = "checkbox";   }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
    String custiccid="";
        if(sqlStr.indexOf("ID_ICCID")!=-1) {
    		String[] custiccidsarry=sqlStr.split("ID_ICCID=");
    		System.out.println(custiccidsarry.length+"==custiccidsarry==========="+custiccidsarry[0]);
    		System.out.println(custiccidsarry.length+"==custiccidsarry==========="+custiccidsarry[1]);
    		custiccid=custiccidsarry[1];
    }
 
%>

<HTML><HEAD><TITLE>黑龙江BOSS-<%=pageTitle%></TITLE>
</HEAD>
<BODY>
<FORM method=post name="fPubSimpSel">
  <%@ include file="/npage/include/header_pop.jsp" %>  
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
   // tempNum1=9;
    fieldNum = String.valueOf(tempNum1);
    
    
    //根据传人的Sql查询数据库，得到返回结果
 %>
 					<wtc:service name="sCustTypeQryC"  routerKey="region" routerValue="<%=regionCode%>" outnum="<%=fieldNum%>" >
						<wtc:param value="0" />
						<wtc:param value="01" />	
						<wtc:param value="1104" />	
						<wtc:param value="<%=workNo%>" />
						<wtc:param value="<%=password%>" />
						<wtc:param value="" />
						<wtc:param value="" />
						<wtc:param value="<%=custiccid%>" />
			</wtc:service>
			<wtc:array id="result"  scope="end"/>
				
 			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="<%=fieldNum%>">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />
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
      		 chPos = fieldName.indexOf("|");
           out.print("<table cellspacing='0'><TR align='center'> ");
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
      		    out.print("<TR>");
      		    for(int j=0;j<Integer.parseInt(fieldNum);j++)
      		    {
                    if(j==0)
                    {
                        
                        typeStr = "<TD class='"+tbclass+"'><input type='text' " +
          		            " id='Rinput" + i + j + "' class='InputGrey' style='text-align:center' value='" + 
          		            result[i][j] + "'readonly></TD>";          		            
                    }
                    else
                    {        		        
          		        inputStr = inputStr + "<TD class='"+tbclass+"'><input type='text' " +
          		            " id='Rinput" + i + j + "' class='InputGrey' style='text-align:center' value='" + 
          		            result[i][j] + "'readonly></TD>";          		            
                    }          		            
      		    }
      		    out.print(typeStr + inputStr);
      		    out.print("</TR>");
      		}
      		out.print("</table>");
%> 


<!------------------------------------------------------>
    <TABLE cellspacing="0">
    <TBODY>
        <TR> 
            <TD id="footer">
                <input class="b_foot" name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
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
