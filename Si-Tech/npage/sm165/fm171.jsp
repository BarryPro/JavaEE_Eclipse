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
	String beizhu=activePhone+"����һ����Ų�ѯ";
	String password    = (String)session.getAttribute("password");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
	<%
String  inputParsm [] = new String[8];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "08";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = activePhone;
	inputParsm[6] = "";
	inputParsm[7] = beizhu;


	
%>
	<wtc:service name="sm171Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="10">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>


	</wtc:service>
	<wtc:array id="ret2" start="0" length="7" scope="end"/>
	<wtc:array id="ret3" start="7" length="3" scope="end"/>
		<%

    if(!"000000".equals(retCode)){
%>
      <script language=javascript>
        rdShowMessageDialog('��ѯʧ�ܣ�������룺<%=retCode%><br>������Ϣ��<%=retMsg%>');
        window.close();
      </script>
<%
      return;
    }else{
    	
    	
    }
 %>   
  <script language="javascript">
    var ioprcode="";
    function frmCfm(){
      frm.submit();
      return true;
    }
    

	

	
			function frmCfm(){
      frm.submit();
      return true;
    }

		</script>
		<body>
		  <form name="frm" method="POST" action="fg969Cfm.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
        <table cellspacing="0">
			    
          <tr>
          				      <td class="blue" width="25%">�ֻ�����</td>
			      <td>
						  <input type="text" id="phoneNo" name="phoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			        
	          </td>
         
          
        </table>

        <table cellspacing="0" id="">	
        	<tr>
        
			    		<th>����</th>
			    		<th>����</th>
			    		<th>��������</th>
			    		<th>sim����</th>
			    		<th>imsi����</th>

			    	</tr>
			    		
			    		
			    		<%
							for(int j=0;j<ret2.length ;j++) {
							%>
							<tr>

							 <td ><%= ret2[j][0]%></td>
							 <td ><%= ret2[j][1]%></td>
							 <td ><%if("0".equals(ret2[j][2])){out.print("����");}if("1".equals(ret2[j][2])){out.print("ʵ��");}%></td>
							 <td ><%= ret2[j][3]%></td>
							 <td ><%= ret2[j][4]%></td>

							 </tr>
							<%
							}

							
							if(ret2.length==0) {
							%>
							<tr height='25' align='center' ><td colspan='5'>��ѯ��ϢΪ�գ�</td></tr>
							<%
							}
          %>
          
          
				</table>
				<% if(ret3.length > 0){
				%>
				<div class="title">
		      <div id="title_zi">��ҵһ�������Ϣ</div></p>
	      </div>
				<table cellspacing="0" id="">	
        	<tr>
        
			    		<th>����</th>
			    		<th>����</th>
			    		<th>��������</th>
			    		
			    		<%
							for(int k=0;k<ret3.length ;k++) {
							%>
							<tr>

							 <td ><%= ret3[k][0]%></td>
							 <td ><%= ret3[k][1]%></td>
							 <td ><%=ret3[k][2]%></td>
							 </tr>
							<%
							}
							%>

			    	</tr>
			    </table>
			    <%}%>
        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
                <input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
              </div>
            </td>
          </tr>
        </table>
        <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
        <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
      	<input type="hidden" id="fuphoneno" name="fuphoneno"  value="" />
      	<input type="hidden" name="loginAccept"  value="<%=loginAccept%>">
      </form>
    </body>
</html>