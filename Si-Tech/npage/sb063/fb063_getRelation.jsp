<%
  /*
   * 功能: 老帅带新兵
   * 版本: 2.0
   * 日期: 2010/07/28
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>



<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String inPhone = request.getParameter("inPhone");
	String opCode = request.getParameter("opCode");
	String orgCode =(String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String iChnSource = "01";
	String regionCode = orgCode.substring(0,2);
	String loginAccept = "";
	String relationListStr = "<div class='title'><div id='title_zi'>关系列表</div></div>"+
							"<table cellspacing='0'><tr><th>老帅号码</th><th>新兵号码</th>"+
							"<th>办理时间</th><th>结束时间</th><th>操作工号</th></tr>";
	
%>

	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
		
<%
	loginAccept = seq;
	System.out.println("<><><><><> inphone" + inPhone + "   cpCode "+ opCode +"	  loginAccept "+loginAccept);
	
%>
	<wtc:service name="sB063Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="5">
		<wtc:param value="<%=loginAccept%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=workNo%>" />
		<wtc:param value="<%=inPhone%>" />
		<wtc:param value="<%=iChnSource%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务sB063Qry in fb063_getRelation.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println("weiguopeng test result1.length =" +result1.length);
		for(int i=0;i<result1.length;i++){
			relationListStr += "<tr><td>"+result1[i][0]+"</td><td>"+result1[i][1]+"</td><td>"+result1[i][2]+"</td><td>"+result1[i][3]+"</td><td>"+result1[i][4]+"</td></tr>";
		}
		
	}else{
	%>
		<script type="text/javascript">
			rdShowMessageDialog("操作失败:<%=errMsg%>",0);
		</script>		
	<%
		System.out.println("调用服务sB063Qry in fb063_getRelation.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
		return;
	}
	relationListStr += "</table>";
	System.out.println(relationListStr);
%>

	
var response = new AJAXPacket();
response.data.add("relationListStr","<%=relationListStr%>");
core.ajax.receivePacket(response);
