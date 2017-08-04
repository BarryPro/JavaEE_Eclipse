<%
   /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: piaoyi
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>

<%
  String workNo = (String)session.getAttribute("workNo");
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  String sPOSpecNumber = request.getParameter("sPOSpecNumber");
  String sPOSpecRatePolicyID = request.getParameter("sPOSpecRatePolicyID");   
  String sRatePlanID = request.getParameter("sRatePlanID"); 
%>

<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	        <th width="25%" nowrap>资费模式</th>
	        <th width="75%" nowrap>资费模式描述</th>		        
	      </tr>
        <tbody>
<wtc:service name="s9100DetQry" outnum="6" routerKey="region" routerValue="<%=regionCode%>">		
	<wtc:param value="<%=sRatePlanID%>"/>
  <wtc:param value="2"/>
  	<wtc:param value="<%=sPOSpecRatePolicyID%>"/>
  		<wtc:param value="<%=sPOSpecNumber%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="4" scope="end" />
<%
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){
%>
  			  <tr
  			  	 a_ICBPatterNumber = "<%=result[i][1]%>"
  			  	 a_Description  = "<%=result[i][2]%>"
  			  >					
					  <td>
					  <a class="p_RICBPatterNumber" style="cursor: hand;"><%=result[i][1]%></a>						  	
					  &nbsp;</td>
					  <td class=p_Description><%=result[i][2]%>
					  &nbsp;</td>
	        </tr>
<%
    }
  }
}
%>
	      </tbody>
		</form>
	</table>
</div>
<script>
//隐藏滚动条
$("#wait2").hide();
	 //更新函数
	function POICBUpdate(){
    var RatePlanUpdateTR = $(this).parent().parent();
	 	var  POICB=[
	 	  	        $(RatePlanUpdateTR).attr("a_ICBPatterNumber"),           //0资费计划标识
	 	  	        $(RatePlanUpdateTR).attr("a_Description"),               //1资费描述    	 	  	       	 	  	       
	 	  	        '<%=sPOSpecNumber%>',                                    //2商品规格编码 
	 	  	        '<%=sPOSpecRatePolicyID%>',                              //3资费策略编码
	 	  	        '<%=sRatePlanID%>'                                       //4资费计划标识	 	  	        
	 	  	        ];
	 	
	  var retInfo = window.showModalDialog
	  (
	  'f2004_POICB_detail.jsp',
	  POICB,
	  'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
	  );
	  return true;
	}
$(document).ready(function(){
	 //注册更新函数
	 $('.p_RICBPatterNumber').bind('click', POICBUpdate);
});
</script>
