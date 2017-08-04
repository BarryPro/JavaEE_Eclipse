
<%
System.out.println("----------------------------getInnetScheme.jsp------------------------------------");  
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>	
<%
	String groupId = (String)session.getAttribute("groupId");
	String slId = WtcUtil.repNull(request.getParameter("sl_id"));	
	String slName = WtcUtil.repNull(request.getParameter("sl_name"));
	String brandId = WtcUtil.repNull(request.getParameter("brandId"));
	String sqlStr = WtcUtil.repNull(request.getParameter("sqlStr"));
%>
<wtc:pubselect name="sPubSelect" outnum="2">
   <wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rows" scope="end" />
<%
	String strArray="var slArray; ";
	if(retCode.equals("000000") && rows.length > 0){
		strArray = CreatePlanerArray.createArray("slArray",rows.length); 
%>
		<SCRIPT language=JavaScript>
			<%=strArray%>	
		</script>	 		
<%	 	
		for(int i=0;i<rows.length;i++){
%>
			<SCRIPT language=JavaScript>
				slArray[<%=i%>][0] = "<%=rows[i][0]%>";
				slArray[<%=i%>][1] = "<%=rows[i][1]%>";
			</script>	 
<%		 	
		}	
	}
%>	
<html>
<SCRIPT type=text/javascript>
$().ready(function(){	
	$("#btn_query").bind("click",query);
	
	if(typeof(slArray) != "undefined"){
		$("#showInfoDiv").css("display","");
		for(var i=0;i<slArray.length;i++){
			$("#innetSchemeInfoTab").append("<tr><td><input type='radio' name='schemeInfo' id='"+slArray[i][0]+"|"+slArray[i][1]+"'>"+slArray[i][0]+"</td><td>"+slArray[i][1]+"</td></tr>");
		}
	}
});	
function saveTo()
{		
	var retValue = $("#innetSchemeInfoTab :checked").attr("id");
	if(typeof(retValue) != "undefined"){
		var innetScheme = retValue.split("|")[0];
		var schemeName = retValue.split("|")[1]
		window.opener.$("input[name='innetScheme']").val(innetScheme);
		window.opener.$("input[name='schemeName']").val(schemeName);
		window.close();
	}else{	
		rdShowMessageDialog("请选择受理方案！",0);
	}	
}

function query()
{		
	var scheme_id = document.all.sl_id.value.trim();
	var scheme_name1 = document.all.sl_name.value.trim();
	var sqlStr ="";						 
	sqlStr = "SELECT a.innet_scheme, scheme_name FROM sInnetSchemeCode a, band b WHERE a.sm_code = b.sm_code AND group_id IN  (SELECT parent_group_id FROM dChnGroupInfo WHERE group_id = '<%=groupId%>') AND b.band_id = '<%=brandId%>'"; 
	if(scheme_id!=""){
		sqlStr = sqlStr + " and a.innet_scheme like '%"+scheme_id+"%'";
	}
	if(scheme_name1!=""){
		sqlStr = sqlStr + " and a.scheme_name like '"+ encodeURI("%")+scheme_name1+"%'";
	}
	document.frm1.action="getInnetScheme.jsp?sqlStr="+sqlStr;
	document.frm1.submit();
}
</SCRIPT>	
<body>
<div id="operation">
<FORM method="post" name="frm1"  action="">	
	<%@ include file="/npage/include/header_pop.jsp" %>                         

<div id="operation_table">	
 
<div class="title"><div id="title_zi">用户受理方案查询</div></div>
	<div class="input">	 
	 <table cellSpacing=0>
		<tr>
    	<td class=blue>受理方案编号</td>
    	<td>
    		<input type="text" name="sl_id" id="sl_id" />
    	</td>
    	<td class=blue>受理方案名称</td>
    	<td><input type="text" size="30" name="sl_name" id="sl_name" /></td>	
    </tr>
    <tr>
    	<td id=footer colspan=4>
    		
	<div id="operation_button">
		<input class="b_foot" name=query  id="btn_query" type=button value="查询">
	</div>
    	</td>
    </tr>
</table>
</div>
</div>

	
<div id="showInfoDiv" style="display:none">	
<div id="operation_table">	
	<div class="list">
		<div style="overflow-y:scroll;height:200px;width:98%;">
		<table cellSpacing=0 id="innetSchemeInfoTab">
			<tr>
	    	<th>方案编号</th>
	    	<th>方案名称</th>
	    </tr>
	    <tr>
	    	<td id=footer colspan=2>
	    		<div id="operation_button">
	<input class="b_foot" name=confm  type=button onClick="saveTo()" value="确认">
	&nbsp; 
	<input class="b_foot" name=back onClick="window.close()" type=button value="返回">
</div>
	    	</td>
	    </tr>
		</table>
		</div>
	</div>
</div>			

</div>
	

<input type="hidden" name="brandId" value="<%=brandId%>" />
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM> 
</div>
</body>
</html>