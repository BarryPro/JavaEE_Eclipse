<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String offerstrbuffer = request.getParameter("offerstrbuffer");
		String statusbuffer = request.getParameter("statusbuffer");
		String typebuffer = request.getParameter("typebuffer");
		String phoneNo = request.getParameter("phoneNo");
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String password = (String)session.getAttribute("password");

		
		String  inputParsm [] = new String[10];
		inputParsm[0] = "";
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = password;
		inputParsm[5] = phoneNo;
		inputParsm[6] = "";
		inputParsm[7] = offerstrbuffer;
		inputParsm[8] = statusbuffer;
		inputParsm[9] = typebuffer;
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept" />
		<wtc:service name="sSPOfferChgCfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="1">
				<wtc:param value="<%=loginAccept%>"/>
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
		<wtc:array id="ret" scope="end"/>
<%
	
	if("000000".equals(retCode)){
		%>
		<span id="totalSecond" style="display:none">0</span>
		<script language="javascript" type="text/javascript">
			rdShowMessageDialog("操作成功！",2);
			//alert('<%=phoneNo%>'+"8888"+'<%=opName%>'+"77777"+'<%=opCode%>');
 <!--定义js变量及方法-->

	
var second = document.getElementById('totalSecond').textContent;
if (navigator.appName.indexOf("Explorer") > -1){
	second = document.getElementById('totalSecond').innerText; 
	} else{
		second = document.getElementById('totalSecond').textContent; 
		}
		
		setInterval("redirect()", 1000); 
		function redirect(){
			if (second < 0){
			 <!--定义倒计时后跳转页面-->
			 location.href ="fg538.jsp?activePhone=<%=phoneNo%>&opName=<%=opName%>&opCode=<%=opCode%>";
			 } else{if (navigator.appName.indexOf("Explorer") > -1){
			 	document.getElementById('totalSecond').innerText = second--; 
			 	} else{
			 		document.getElementById('totalSecond').textContent = second--; 
			 		}
			 		}
			 		}

		</script>
		<%
	}else {
				%>
		<script language="javascript">
			rdShowMessageDialog("错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
			window.history.go(-1);
		</script>
		<%
		}
%>

