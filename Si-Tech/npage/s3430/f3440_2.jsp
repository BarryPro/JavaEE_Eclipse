<%
  /*************************************
  * 功  能: APN代码维护 3474
  * 版  本: version v1.0
  * 开发商: si-tech
  * 创建者: @ 2012-2-28
  **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
  String region_code = (String)request.getParameter("region_code");
  String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	String loginNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String apn_code = request.getParameter("apn_code");
	String apn_name = request.getParameter("apn_name");
	String valid_flag = request.getParameter("valid_flag");
	String repeatFlag=request.getParameter("repeatFlag");
	String apn_id = request.getParameter("apn_id");
	String apn_script=request.getParameter("apn_script");
	String opNote="APN代码维护增加操作";
	String stripadr=request.getParameter("ip_Addr");
	
	String gapnbiaoshi4g=request.getParameter("gapnbiaoshi4g");
	String apn4gbiaozhis=request.getParameter("apn4gbiaozhis");
	
	System.out.println("----------3440----------opCode="+opCode);
  System.out.println("----------3440----------loginNo="+loginNo);
  System.out.println("----------3440----------password="+password);
  System.out.println("----------3440----------apn_code="+apn_code);
  System.out.println("----------3440----------apn_name="+apn_name);
  System.out.println("----------3440----------valid_flag="+valid_flag);
  System.out.println("----------3440----------repeatFlag="+repeatFlag);
  System.out.println("----------3440----------apn_id="+apn_id);
  System.out.println("----------3440----------apn_script="+apn_script);
  System.out.println("----------3440----------stripadr="+stripadr);
  System.out.println("----------3440----------gapnbiaoshi4g="+gapnbiaoshi4g);
  System.out.println("----------3440----------apn4gbiaozhis="+apn4gbiaozhis);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
  
   <wtc:service name="s3440Add" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=region_code%>"/>
		<wtc:param value="<%=apn_code%>"/>
		<wtc:param value="<%=apn_name%>"/>
		<wtc:param value="58"/>
		<wtc:param value="<%=apn_id%>"/>
		<wtc:param value="<%=valid_flag%>"/>
		<wtc:param value="<%=repeatFlag%>"/>
		<wtc:param value="<%=apn_script%>"/>  
		<wtc:param value="<%=opNote%>"/> 
		<wtc:param value="<%=stripadr%>"/> 
    <wtc:param value="<%=gapnbiaoshi4g%>"/> 	
    <wtc:param value="<%=apn4gbiaozhis%>"/> 		
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
<%		
  if(!"000000".equals(retCode)){
%>
    <SCRIPT language="JavaScript">
      rdShowMessageDialog("错误代码：<%=retCode%><br>错误信息：<%=retMsg%>",0);
      window.location.href="s3440_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    </SCRIPT>
<%
  }else{
%>
    <SCRIPT language="JavaScript">
      rdShowMessageDialog("提交成功！",2);
      window.location.href="s3440_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    </SCRIPT>
<%
  }
%>
  