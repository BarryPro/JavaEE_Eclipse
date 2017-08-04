<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%
  /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年12月20日
　 * 作者: wuxy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<!--新分页用到的类-->
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
	String opCode = WtcUtil.repNull(request.getParameter("pageOpCode"));	
	String opName = WtcUtil.repNull(request.getParameter("pageOpName"));	
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String workName = (String)session.getAttribute("workName");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String orgCode = (String)session.getAttribute("orgCode");
	String productId = request.getParameter("productID");
	System.out.println("productID="+productId);
	String orderSource = request.getParameter("orderSource");
	System.out.println("orderSource="+orderSource);
	String operType = request.getParameter("operType");
	String regionCode = orgCode.substring(0,2);
	String sqlStr="";
	String tMemberProperty = "";
	
	String workNo = (String)session.getAttribute("workNo");
	String loginPwd  = (String)session.getAttribute("password");
	
	/**分页要用的代码**/
    Map map = request.getParameterMap();
    String totalNumber = "";
    String currentPage = request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage");
    String pageSize = "11";
    /******************/    
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link href="s2002.css" rel="stylesheet" type="text/css">
	<script>
	
	function getPropertyMember(imemberNo,obj){
		var winUrl = "f2035_6.jsp?memberNo="+imemberNo+"&productId=<%=productId%>";
		var winResult=window.showModalDialog(winUrl,"","scroll:yes;dialogHeight:700px;dialogWidth:600px;dialogTop:458px;dialogLeft:166px");
	}
	
	</script>
<!--************************分页的样式表**************************-->
<link rel="stylesheet" type="text/css" href="/nresources/default/css/fenye.css" media="all"/>
</head>
<body>
<form name="form1" method="post">
	<input type="hidden" name="pageOpCode" value="<%=opCode%>">
	<input type="hidden" name="pageOpName" value="<%=opName%>">
<%@ include file="/npage/include/header.jsp" %>

<div id="productList" >
<div class="title"><div id="title_zi">成员信息列表</div></div>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
<wtc:service name="s2035MemberQry" routerKey="region" routerValue="<%=regionCode%>" 
	retcode="retCode" retmsg="retMsg" outnum="7">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=loginPwd%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=productId%>"/> 
	<wtc:param value="0"/><%/* 操作类型：0-实时数据查询；1-异步数据导出 */%>
</wtc:service>
<wtc:array id="rows"  scope="end"/>
<%
	if(!"000000".equals(retCode)){
%>
		<script>
			rdShowMessageDialog("错误代码：<%=retCode%><br>错误信息：<%=retMsg%>",0);
			window.location.href="f2035_1.jsp";
		</script>
<%
	}else{
		System.out.println("rows.length="+rows.length);
	}
%>
	
	
<table cellspacing="0" id="productTab" >
    <tr align="center">
        <th nowrap>成员号码</th>
        <th nowrap>成员类型 </th>
        <th nowrap>成员群组</th>   
        <th nowrap>开始时间</th>   
        <th nowrap>结束时间</th> 
        <th nowrap>成员状态</th> 
        <th nowrap>是否归档</th>
        <th nowrap>操作</th>
    </tr>
    <%
       for(int i=0;i<rows.length;i++){
       tMemberProperty = "";
       System.out.println(rows[i][0]);
       System.out.println(rows[i][1]);
       System.out.println(rows[i][2]);
       System.out.println(rows[i][3]);
       System.out.println(rows[i][4]);
       System.out.println(rows[i][5]);
       System.out.println(rows[i][6]);
    %>
    <tr align="center">

 <td nowrap>
        	<input type="hidden" name="tMemberProperty" id="tMemberProperty" value="<%=tMemberProperty%>" >
        	<input type="hidden" name="tMemberNo" value="<%=rows[i][0]%>" ><%=rows[i][0]%>
        </td>
        <td nowrap><input type="hidden" name="tMemberType" value="<%=rows[i][1]%>" ><%=rows[i][1]%></td>
        <td nowrap><input type="hidden" name="tMemberGroup" value="<%=rows[i][2]%>" ><%=rows[i][2]%></td>   
        <td nowrap><input type="hidden" name="tBeginTime" value="<%=rows[i][3]%>" ><%=rows[i][3]%></td>   
        <td nowrap><input type="hidden" name="tEndTime" value="<%=rows[i][4]%>" ><%=rows[i][4]%></td>
        <td nowrap><input type="hidden" name="tpoductstatus" value="<%=rows[i][5]%>" ><%=rows[i][5]%></td> 
        <td nowrap><input type="hidden" name="tguidangstatus" value="<%=rows[i][6]%>" ><%=rows[i][6]%></td> 
        <td nowrap>
        	
        	<input type="button" name="b_getProperty" onclick="getPropertyMember('<%=rows[i][0]%>',this)" class="b_text" value="查看成员属性" >
        </td>
    </tr>
    <%
       }
    %>
</table>
</div>

<table cellSpacing=0> 
  <tr>
    <td align="center" id="footer" colspan="4">
    	<input type="button"  id="exportBtn" class='b_foot' value="全量导出" name="exportBtn" />
      <input class="b_foot" name=next id=nextoper type=button value="返回" onclick="history.go(-1)" >
      <input class="b_foot" name=reset type=button value="关闭" onClick="parent.removeTab('<%=opCode%>')">
    </td>
  </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script type=text/javascript>
	$('#exportBtn').click(function() {
		var myPacket = new AJAXPacket("syncExport.jsp","正在获得记录总数，请稍候...");
		myPacket.data.add("opCode","<%=opCode%>");
		myPacket.data.add("productId", "<%=productId%>");
		
		core.ajax.sendPacket(myPacket, function(packet){
			var errorCode = packet.data.findValueByName('retCode');
			var errorMsg = packet.data.findValueByName('retMsg');
			if (errorCode == '000000'){
				rdShowMessageDialog("导出申请记录成功，请到g079模块查询导出结果！");
			}else{
				rdShowMessageDialog("导出失败！" + errorCode + errorMsg);
			}
		});
		myPacket=null;
	});
</script>
</BODY>
</HTML>
