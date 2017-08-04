<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%
	String opCode = "4100";
  String opName = "跨区入网";
%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html; charset=GBK" %>

<%
       String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
       String RetCode = "444444";
       String login_no = (String)session.getAttribute("workNo");
       String Department = (String)session.getAttribute("orgCode");
       String belongCode = Department.substring(0,7);
       String regionCode = Department.substring(0,2);
	   String phone_no =request.getParameter("phone_no");
	   String Maxaccept =request.getParameter("Maxaccept");
	   
	   String  inputParsm [] = new String[7];
	   inputParsm[0] = Maxaccept;
	   inputParsm[1] = "16";
	   inputParsm[2] = "4840"; 
	   inputParsm[3] = login_no; 
	   inputParsm[4] = ""; 
	   inputParsm[5] = phone_no; 
	   inputParsm[6] = "";
	   try{
	   %>
	        <wtc:service name="s4840Cfm" outnum="12" retmsg="msgs4840Cfm" retcode="codes4840Cfm" routerKey="region" routerValue="<%=regionCode%>">
	            <wtc:param value="<%=inputParsm[0]%>" />
			    <wtc:param value="<%=inputParsm[1]%>" />
			    <wtc:param value="<%=inputParsm[2]%>" />
			    <wtc:param value="<%=inputParsm[3]%>" />
			    <wtc:param value="<%=inputParsm[4]%>" />
			    <wtc:param value="<%=inputParsm[5]%>" />
			    <wtc:param value="<%=inputParsm[6]%>" />
			</wtc:service>
		    <wtc:array id="result" scope="end"  />
	   <%
System.out.println("---------------codes4840Cfm----------------"+codes4840Cfm);
System.out.println("---------------msgs4840Cfm-----------------"+msgs4840Cfm);
            RetCode=codes4840Cfm;
            errorMsg=msgs4840Cfm;
	    }
	    catch(Exception e){
			System.out.println("call s4840Cfm is failed="+e);
     	}                     
%>
<html>
<head>
<title>跨区入网完成确认</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<FORM method=post name="frm1903" action=""  onKeyUp="chgFocus(frm1903)">
    <TABLe cellSpacing=0 >
        <TBODY>
        <tr>
            <td>
                <%=errorMsg%>
            </td>
        </tr>
        </TBODY>
    </table>
    <TABLe cellSpacing=0 >
        <TBODY>
        <tr>
            <TD align=center id="footer">
                  <input class="b_foot" name=back type=button onclick="window.close()" value=关闭 index="41">
            </TD>
        </tr>
        </TBODY>
    </table>
</form>
</body>
</html>