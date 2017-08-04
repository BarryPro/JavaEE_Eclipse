<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  
  
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  

  String xiaoqudaima = request.getParameter("xiaoqudaima");
  String offeriddaima = request.getParameter("offeriddaima");
  String shenpizhuangtai = request.getParameter("shenpizhuangtai");
  String shenpiyuanyinstr = request.getParameter("shenpiyuanyinstr");
  String shenpinums = request.getParameter("shenpinums");
  
  String xiaoqudaima2 = request.getParameter("xiaoqudaima2");
  String shenpizhuangtai2 = request.getParameter("shenpizhuangtai2");
  String shenpiyuanyinstr2 = request.getParameter("shenpiyuanyinstr2");
  String shenpinums2 = request.getParameter("shenpinums2");     

  String org_code = (String)session.getAttribute("orgCode");
  String ipAddrss = (String)session.getAttribute("ipAddr");
  String beizhu=workNo+"进行宽带资源与资费配置审批操作";

String  inputParsm [] = new String[10];
	inputParsm[0] = "";
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";
	inputParsm[7] = beizhu;  

%>
		
	<wtc:service name="sM339Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="A"/>
			<wtc:param value="<%=xiaoqudaima %>"/>
			<wtc:param value="<%=offeriddaima %>"/>
			<wtc:param value="<%=shenpizhuangtai %>"/>
      <wtc:param value="<%=shenpiyuanyinstr %>"/>
      <wtc:param value="<%=inputParsm[3]%>"/>	
      <wtc:param value="<%=shenpinums %>"/>
      <wtc:param value="<%=xiaoqudaima2 %>"/>
			<wtc:param value="<%=shenpizhuangtai2 %>"/>
      <wtc:param value="<%=shenpiyuanyinstr2 %>"/>
      <wtc:param value="<%=inputParsm[3]%>"/>	
      <wtc:param value="<%=shenpinums2%>"/>

	</wtc:service>
	<wtc:array id="dcust2"scope="end"/>
				
<%
	if("000000".equals(retCode)){

%>	
    <script language="javascript">
 	      rdShowMessageDialog("审批操作成功！",2);
 	      window.location="f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{

%>
  	<script language="javascript">
 	    rdShowMessageDialog("审批操作失败！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
