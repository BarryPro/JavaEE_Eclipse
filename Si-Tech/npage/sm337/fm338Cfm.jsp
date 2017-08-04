<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  
  
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  
  String optypess = request.getParameter("optypess");
  String worknos = request.getParameter("worknos");
  
  String worknodel = request.getParameter("worknodel");
  String delnums = request.getParameter("delnums");
  
  String beizhu="";
  
  String shenpigonghaos ="";
  
  String succesmsg="";
  String faildmsg="";
  if("a".equals(optypess)) {
    succesmsg="增加操作成功";
    faildmsg="增加操作失败";
    beizhu=workNo+"增加审批工号"+worknos;
    shenpigonghaos=worknos;
  }else {
    succesmsg="删除操作成功";	
    faildmsg="删除操作失败";
    beizhu=workNo+"删除审批工号"+worknodel;
    shenpigonghaos=worknodel;
	}
  
  String org_code = (String)session.getAttribute("orgCode");
  String ipAddrss = (String)session.getAttribute("ipAddr");

  String  inputParsm [] = new String[17];
	inputParsm[0] = "0";
	inputParsm[1] = "01";
	inputParsm[2] = "m338";
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";
	inputParsm[7] = beizhu;

%>
		
	<wtc:service name="sM338Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="4">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=optypess%>"/>
			<wtc:param value="<%=shenpigonghaos%>"/>
			<wtc:param value="<%=delnums%>"/>
		</wtc:service>
				
<%
	if("000000".equals(retCode)){

%>	
    <script language="javascript">
 	      rdShowMessageDialog("<%=succesmsg%>！",2);
 	      window.location="f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{

%>
  	<script language="javascript">
 	    rdShowMessageDialog("<%=faildmsg%>！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
