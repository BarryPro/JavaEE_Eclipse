<% 
  /*
   * 功能: 查询用户可选的BlackBerry个人资费
　 * 版本: v1.00
　 * 日期: 2010/04/07
　 * 作者: daixy
　 * 版权: sitech
   * 描述：根据传入的业务类型查询用户可选的BlackBerry个人资费 
   * 修改历史
   * 修改日期      修改人      修改目的
   *  
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%> 
<%
	String iBusiType = request.getParameter("iBusiType");
	String orgCode = (String)session.getAttribute("orgCode");
   	String regionCode = orgCode.substring(0,2);
	String levelsql = "select level_id,offer_name from sBlackBerrylevel where busi_type="+iBusiType;
%>
 		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=levelsql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />
<%
		if(retCode1.equals("0")||retCode1.equals("000000"))
		{
			System.out.println("result1.length="+result1.length);
		}else{
 			System.out.println("调用服务sPubSelect in select_offer.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			System.out.println("retCode1="+retCode1+"retMsg1"+retMsg1);
%>
		<script language=javascript>
		rdShowMessageDialog("查询用户可选的BlackBerry个人资费出错，错误代码："+retCode1+"错误信息："+retMsg1);
		</script>
<%
 		}
%>
		
var response = new AJAXPacket();
var myArrayId=new Array();
var myArrayName=new Array();
<%
		for(int i=0;i<result1.length;i++)
		{
%>	
	myArrayId.push("<%=result1[i][0]%>");
	myArrayName.push("<%=result1[i][1]%>");
<%
		}
%>

response.data.add("retType","0");
response.data.add("length","<%=result1.length%>");
response.data.add("myArrayId",myArrayId);
response.data.add("myArrayName",myArrayName);
core.ajax.receivePacket(response);