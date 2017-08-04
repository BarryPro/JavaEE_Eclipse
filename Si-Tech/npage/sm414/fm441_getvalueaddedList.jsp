<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: liangyl 2016/12/08 省内魔百和平台点播功能和支付功能开发需求
   * 作者: liangyl
   * 版权: si-tech
  */
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	//String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	//String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	                      
  	String regionCode     = (String)session.getAttribute("regCode");
  	String workNo     = (String)session.getAttribute("workNo");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	String sql_str =  "select a.offer_id,a.offer_name from product_offer a,product_offer_scene b,dloginmsg c,region d where a.offer_id =b.offer_id and b.op_type='1' and b.op_code ='m441' and c.login_no =:login_no and a.offer_id =d.offer_id and c.power_right>=d.right_limit and d.group_id in(select e.parent_group_id from dchngroupinfo e where e.group_id =c.group_id) and a.exp_date>sysdate and a.eff_date<sysdate";
	String sql_param = "login_no="+workNo;									
	//7个标准化入参
	String paraAray[] = new String[2];
	
	paraAray[0] = sql_str;                                       // 
	paraAray[1] = sql_param;                                     // 

	String serverName = "TlsPubSelCrm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="4" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	
	//拼装返回数组
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
