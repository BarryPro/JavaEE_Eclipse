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
String  inputParsm [] = new String[8];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = activePhone;
	inputParsm[6] = "";
	inputParsm[7] = beizhu;


	
%>
	<wtc:service name="sG969Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>


	</wtc:service>
	<wtc:array id="ret2" scope="end"/>
		<%

    if(!"000000".equals(retCode)){
%>
      <script language=javascript>
        rdShowMessageDialog('错误代码：<%=retCode%><br>错误信息：<%=retMsg%>');
        window.close();
      </script>
<%
      return;
    }
 %>   
  <script language="javascript">
    var ioprcode="";
    function frmCfm(){
      frm.submit();
      return true;
    }
    
    function reSetTab(){
      window.location.href="fg949.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
    }
	
	function save() {
	   var zhide="";
	   var sm= new Array();
	   var zhuphoness="";
	   var fuphoness="";
			var a=document.getElementsByName("zhufuhao");
				for(i=0;i <a.length;i++) 
				{ 
						if(a[i].checked) {
						zhide=a[i].value; 
						sm =a[i].value.split("|");
						zhuphoness=sm[0];
						fuphoness=sm[1];
						}	  	
				} 
				/* 2013/11/29 10:50:43 gaooeng*/
				/*
					var checkRadioVal = $("input[name='zhufuhao'][checked]").val();
					zhuphoness = checkRadioVal.split("|")[0];
					fuphoness = checkRadioVal.split("|")[1];
				*/
				if(zhide=="") {
					rdShowMessageDialog("请选择要解约的副号！");
					return ;
				}
				$("#zhuphone").val(zhuphoness);
				$("#fuphoneno").val(fuphoness);
			frmCfm();
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
          				      <td class="blue" width="25%">手机号码</td>
			      <td>
						  <input type="text" id="phoneNo" name="phoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			        
	          </td>
         
          
        </table>

        <table cellspacing="0">	
        	<tr>
        			<th>操作</th>	 
			    		<th>主号手机号码</th>
			    		<th>副号手机号码</th>
			    	</tr>
			    		
			    		
			    		<%
							for(int j=0;j<ret2.length ;j++) {
							%>
							<tr>
							<td ><input type="radio" name="zhufuhao" value="<%=ret2[j][0]%>|<%= ret2[j][1]%>"  ></td>
							 <td ><%= ret2[j][0]%></td>
							 <td ><%= ret2[j][1]%></td>
							 </tr>
							<%
							}
          %>
          
				</table>
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
      	<input type="hidden" id="zhuphone"  name="zhuphone"  value="" />
      	<input type="hidden" id="fuphoneno" name="fuphoneno"  value="" />
      	<input type="hidden" name="loginAccept"  value="<%=loginAccept%>">
      </form>
    </body>
</html>