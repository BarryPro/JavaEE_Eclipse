<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="import java.text.SimpleDateFormat;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  

  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
	String beizhu=activePhone+"进行银行卡副号签约查询";
	String password    = (String)session.getAttribute("password");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
<%
String  inputParsm [] = new String[10];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = activePhone;
	inputParsm[6] = "";
	inputParsm[7] = beizhu;
	inputParsm[8] = "01";
	inputParsm[9] = activePhone;


	
%>
	<wtc:service name="sG941Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
			<wtc:param value="<%=inputParsm[9]%>"/>


	</wtc:service>
	<wtc:array id="ret2"scope="end"/>
		<%
    if(!"000000".equals(retCode)){
%>
      <script language=javascript>
        rdShowMessageDialog('查询失败，错误代码：<%=retCode%><br>错误信息：<%=retMsg%>');
        window.close();
      </script>
<%
      return;
    }
 %>   
  <script language="javascript">
   
    function frmCfm(){
      frm.submit();
      return true;
    }
			
		
    
    function reSetTab(){
      window.location.href="fg941.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
    }
    

	
	function save() {
			frmCfm();
	}
	
			function frmCfm(){
      frm.submit();
      return true;
    }

		</script>
		<body>
		  <form name="frm" method="POST" action="fg941Cfm.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
        <table cellspacing="0">
			    
          <tr>
          				      <td class="blue" width="15%">手机号码</td>
			      <td>
						  <input type="text" id="phoneNo" name="phoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			        
	          </td>
         
          
        </table>

        <table cellspacing="0">		
        	<tr>   		
			    		<th>此主号下的所有副号手机号码</th>
			    	</tr>
			    		
			    		<%
							for(int j=0;j<ret2.length ;j++) {
							%>
							<tr>  
							 <td align="center"><%= ret2[j][1]%></td>
							 </tr>
							<%
							}
          %>

        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
                <input type="button" name="quchoose" class="b_foot" value="确定" onclick="save()" />		
                &nbsp;
                <input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
              </div>
            </td>
          </tr>
        </table>
        <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
        <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
      	<input type="hidden" name="phoneNo"  value="<%=activePhone%>" />
      	<input type="hidden" name="fuphoneno"  value="" />
      	<input type="hidden" name="loginAccept"  value="<%=loginAccept%>">
      </form>
    </body>
</html>