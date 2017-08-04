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
	
	function getPropertyMember(imemberNo,obj,label){
		var tr = obj.parentNode.parentNode;
		var tMemberProperty = tr.childNodes[0].childNodes[0];
		var winUrl = "f2035_8.jsp?memberNo="+imemberNo+"&productId=<%=productId%>"+"&operType=<%=operType%>&tMemberProperty="+tMemberProperty.value;
		var winResult=window.showModalDialog(winUrl,"","scroll:yes;dialogHeight:700px;dialogWidth:600px;dialogTop:458px;dialogLeft:166px");
		document.getElementById("tMemberProperty"+label).value =winResult;
	}
	function doCfm(){
	    vLen = $("#row_len").val();
		var chkFlag = "false";
		if(vLen == 1){
		    if(document.all.chkbx.checked == true){
		        chkFlag = "true";
		    }
		}else{
    		for(var i=0;i<vLen;i++){
    		    if(document.all.chkbx[i].checked == true){
    		        chkFlag = "true";
    		        break;
    		    }
    		}
    	}
		
		var attrFlag = "true";
		if(vLen == 1){
		    if(document.all.chkbx.checked == true && (document.getElementById("tMemberProperty0").value == "" || document.getElementById("tMemberProperty0").value == undefined || document.getElementById("tMemberProperty0").value == "undefined")){
		        attrFlag = 0;
		    }
		}else{
    		for(var i=0;i<vLen;i++){
    		    if(document.all.chkbx[i].checked == true && (document.getElementById("tMemberProperty"+i).value == "" || document.getElementById("tMemberProperty"+i).value == undefined || document.getElementById("tMemberProperty"+i).value == "undefined")){
    		        attrFlag = i;
    		        break;
    		    }
    		}
    	}
		if(attrFlag != "true"){
		    rdShowMessageDialog("请修改成员属性！",0);
		    $("#b_getProperty"+attrFlag).focus();
		    return false;
		}
		
		if(chkFlag == "true"){
		    confirmFlag = rdShowConfirmDialog("是否提交本次操作？");
			if (confirmFlag==1){
    		    document.form1.action="f2035_cfm.jsp";
    		    document.form1.submit();
    		}
		}else{
		    rdShowMessageDialog("请选择要操作的号码信息",0);
		    return false;
		}
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
<wtc:pubselect name="sPubSelect" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:sql>select member_no,decode(member_type,'0','黑名单','1','签约成员','2','白名单') as member_type,member_group,to_char(begin_time,'yyyymmdd'),to_char(end_time,'yyyymmdd') ,
    	     decode(product_status,'1','正常','3','暂停','2','删除') as a,
    	     decode(guidang_status,'0','未归档','1','已归档','未知')as b  from dproductSignInfo where ProductID = '?'</wtc:sql>
    <wtc:param value="<%=productId%>"/>
</wtc:pubselect>
<wtc:array id="rows"  scope="end" />
<table cellspacing="0" id="productTab" >
    <tr align="center">
        <th nowrap>选择</th>
        <th nowrap>成员号码</th>
        <th nowrap>成员类型</th>
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
        <input type='checkbox' id='chkbx' name='chkbx' value='<%=i%>'/>
    </td>
    <td nowrap>
        	<input type="hidden" name="tMemberNo" value="<%=rows[i][0]%>" ><%=rows[i][0]%> &nbsp;
        	<input type="hidden" name="tMemberProperty" id="tMemberProperty<%=i%>" value="<%=tMemberProperty%>" > &nbsp;
        </td>
        <%
        	String member_type="";
        	if(rows[i][1].equals("黑名单")){
        		member_type="0";
       	  }else if(rows[i][1].equals("签约成员")){
        		member_type="1";
       	  }else if(rows[i][1].equals("白名单")){
        		member_type="2";
       	  }
        %>
        <td nowrap><input type="hidden" name="tMemberType" value="<%=member_type%>" ><%=rows[i][1]%> &nbsp;</td>
        <td nowrap><input type="hidden" name="tMemberGroup" value="<%=rows[i][2]%>" ><%=rows[i][2]%> &nbsp;</td>   
        <td nowrap><input type="hidden" name="tBeginTime" value="<%=rows[i][3]%>" ><%=rows[i][3]%> &nbsp;</td>   
        <td nowrap><input type="hidden" name="tEndTime" value="<%=rows[i][4]%>" ><%=rows[i][4]%></td>
        <td nowrap><input type="hidden" name="tpoductstatus" value="<%=rows[i][5]%>" ><%=rows[i][5]%></td> 
        <td nowrap><input type="hidden" name="tguidangstatus" value="<%=rows[i][6]%>" ><%=rows[i][6]%></td> 
        <td nowrap>
        	
        	<input type="button" name="b_getProperty" id="b_getProperty<%=i%>" onclick="getPropertyMember('<%=rows[i][0]%>',this,'<%=i%>')" class="b_text" value="修改成员属性" >
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
    	<input class="b_foot" name=next id=nextoper type=button value="提交" onclick="doCfm()" >
      <input class="b_foot" name=next id=nextoper type=button value="返回" onclick="history.go(-1)" >
      <input class="b_foot" name=reset type=button value="关闭" onClick="parent.removeTab('<%=opCode%>')">
    </td>
  </tr>
</table>
<input type="hidden" name="operType" value="<%=operType%>">
<input type="hidden" name="productId" value="<%=productId%>" >
<input type="hidden" name="orderSource" value="<%=orderSource%>" >
<input type='hidden' id='row_len' name='row_len' value='<%=rows.length%>' />
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
