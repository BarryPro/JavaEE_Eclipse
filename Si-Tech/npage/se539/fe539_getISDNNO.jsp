<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=Gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);

	String opCode = "";
	String opName = "基本接入号";
    String workNo = (String)session.getAttribute("workNo");
    String org_code = (String)session.getAttribute("orgCode");
    String  powerRight= (String)session.getAttribute("powerRight");
    String workPwd = (String)session.getAttribute("password");
    String regionCode=org_code.substring(0,2);	
    
    String pageTitle = request.getParameter("pageTitle");
    String fieldNum  = "1";
    String fieldName = request.getParameter("fieldName");
    String retQuence = request.getParameter("retQuence");    
    String sqlFilter = "";   
    String selType   = "S";  
    String BaseCodeType= request.getParameter("BaseCodeType")==null?"":request.getParameter("BaseCodeType" );    
    System.out.println("BaseCodeType="+ BaseCodeType);   
    
                         
    
    if (selType.compareTo("S") == 0) {
        selType = "radio";
    }
    if (selType.compareTo("M") == 0) {
        selType = "checkbox";
    }
    if (selType.compareTo("N") == 0) {
        selType = "";
    }
    //=====================
    int chPos = 0;
    String typeStr = "";
    String inputStr = "";
    String valueStr = "";
    String[][] result = new String[][]{};
    
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
    <TITLE>基本接入号选择
    </TITLE>
    <META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
	<SCRIPT type=text/javascript>
	function saveTo()
	{
		window.returnValue =  $("input[name='List']:checked").val();
		window.close();
	}
    </SCRIPT>
</HEAD>
<BODY>
<%@ include file="/npage/include/header_pop.jsp" %>   
<wtc:service name="se539ProcQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1" >
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="e539"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=workPwd%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="<%=BaseCodeType%>"/>
</wtc:service>
<wtc:array id="retArr1" scope="end"/>  	
<table cellspacing="0">
    <tr align="center">
        <th nowrap>基本接入号</th>
    </tr>
	<%
		if (retCode.equals("000000")){
			result = retArr1;
		}else{
	%>
		<script type=text/javascript>
			rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
			window.close();
		</script>
	<%
		}  	
	
	
		String tbclass="";
		for (int i = 0; i < result.length; i++) {
			tbclass = (i%2==0)?"Grey":"";
			typeStr = "";
			inputStr = "";
			out.print("<TR align='center'>");
			for (int j = 0; j < Integer.parseInt(fieldNum); j++) {
	
				if (j == 0) {
					typeStr = "<TD class='"+tbclass+"'>&nbsp;";
					if (selType.compareTo("") != 0) {
						typeStr = typeStr + "<input type='" + selType +
								"' name='List' style='cursor:hand' RIndex='" + i + "'" +
								"onkeydown='if(event.keyCode==13)saveTo();'" + " value='"+(result[i][j]).trim()+"' >";
					}
					typeStr = typeStr + (result[i][j]).trim() + "<input type='hidden' " +
						" id='Rinput" + i + j + "' value='" +
						(result[i][j]).trim() + "'readonly></TD>";
				}
				else {
					inputStr = inputStr + "<TD class='"+tbclass+"'>&nbsp;" + (result[i][j]).trim() + "<input type='hidden' " +
						" id='Rinput" + i + j + "' value='" +
						(result[i][j]).trim() + "'readonly></TD>";
				} 
			}
		out.print(typeStr + inputStr);
		out.print("</TR>");
	}
	%>
</table>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                
                <input class='b_foot' name=commit onClick="saveTo()" style="cursor:hand" type=button value=确认>&nbsp;
                
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=返回>&nbsp;
            </TD>
        </TR>
    </TBODY>
</TABLE>
<%@ include file="/npage/include/footer_pop.jsp" %> 
</FORM>
</BODY>
</HTML>   
	