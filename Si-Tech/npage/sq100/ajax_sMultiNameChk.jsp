<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) -2017/4/7 星期五 16:05:20------------------
 
3、修改客户开户-1100、客户资料变更-1210、实名登记-m058、GSM过户-1238、宽带过户-e972、
校园迎新入网-m275、宽带入网-4977、网站开户(b893)、集团客户开户(1993)、
批量开户(i067)、批量普通开户(m349)、单位批量实名登记(m389)、集团产品用户信息补全(m296)、
年龄超限客户经办人信息补全(m417)、实际使用人信息修改(m245)功能，
当证件号码相同时如果客户姓名、经办人姓名、实际使用人姓名、
责任人姓名这4个中的任何一个姓名与经分提供的数据(讨论稿第2点)存在一证多名，
则提示“此证件号码存在一证多名的情况，请与‘m366-身份证查询号码信息’查询明细。”
要求：1）这四个名称都要增加一证多名的提示。
      2）批量导入文件时出现一证多名，则进行限制，不允许办理。
      
 -------------------------后台人员：xiahk--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	
	String iIdIccid       = WtcUtil.repNull(request.getParameter("Chk_iIdType"));
	String iIdType        = WtcUtil.repNull(request.getParameter("Chk_iIdIccid"));
	String iCustName      = WtcUtil.repNull(request.getParameter("Chk_iCustName"));			
 
 
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[10];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = "";                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = iIdIccid;
	paraAray[8] = iIdType;
	paraAray[9] = iCustName;

	String serverName = "sMultiNameChk";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
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
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

	System.out.println("--hejwa--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--hejwa--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
