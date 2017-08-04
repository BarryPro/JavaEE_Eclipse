<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  
  
  String opCode = "m337";
  String opName = "宽带资源与资费配置";
  
  String xiaoqucanshu = request.getParameter("xiaoqucanshu");
  String offeridcanshu = request.getParameter("offeridcanshu");
  String chuzhuangfeicanshu = request.getParameter("chuzhuangfeicanshu");
  String shenpirencanshu = request.getParameter("shenpirencanshu");
  String optypess = request.getParameter("optypess");
  String xiaoqujsxgstr = request.getParameter("xiaoqujsxgstr");
  String shuliangbz = request.getParameter("shuliangbz");
  
  String xiaoqucanshu2 = request.getParameter("xiaoqucanshu2");
  String xiaoqujsxgstr2 = request.getParameter("xiaoqujsxgstr2");
  String yingxiaohuodongcanshu = request.getParameter("yingxiaohuodongcanshu");
  String yingxiaobeizhucanshu = request.getParameter("yingxiaobeizhucanshu");
  String shuliangbz2 = request.getParameter("shuliangbz2");
  
  String beizhuss ="";
  
  String org_code = (String)session.getAttribute("orgCode");
  String ipAddrss = (String)session.getAttribute("ipAddr");
  String resultMsgsuc="";
  String resultMsgfail="";
  if(optypess.equals("3")) {
  resultMsgsuc="删除小区和资费配置成功";
  resultMsgfail="删除小区和资费配置失败";
  beizhuss=workNo+"进行删除小区和资费配置";
  
}else {
	resultMsgsuc="宽带资源与资费配置成功";
	resultMsgfail="宽带资源与资费配置失败";
	beizhuss=workNo+"宽带资源与资费配置";
	}
%>
		
<wtc:service name="sM337Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">	
	<wtc:param value=""/>
  <wtc:param value="01"/>
  <wtc:param value="m337"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=beizhuss%>"/>
	<wtc:param value="<%=optypess%>"/>
	<wtc:param value="<%=xiaoqucanshu%>"/>
	<wtc:param value="<%=xiaoqujsxgstr%>"/>
	<wtc:param value="<%=offeridcanshu%>"/>
	<wtc:param value="<%=shenpirencanshu%>"/>
	<wtc:param value="<%=shuliangbz%>"/>
	<wtc:param value="<%=chuzhuangfeicanshu%>"/>
	
	<wtc:param value="<%=xiaoqucanshu2%>"/>
	<wtc:param value="<%=xiaoqujsxgstr2%>"/>
	<wtc:param value="<%=yingxiaohuodongcanshu%>"/>
	<wtc:param value="<%=yingxiaobeizhucanshu%>"/>
	<wtc:param value="<%=shuliangbz2%>"/>	
	
	</wtc:service>
	<wtc:array id="result" scope="end"/>
				
<%
	if("000000".equals(retCode)){

%>	
    <script language="javascript">
 	      rdShowMessageDialog("<%=resultMsgsuc%>！",2);
 	      window.location="f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{

%>
  	<script language="javascript">
 	    rdShowMessageDialog("<%=resultMsgfail%>！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
