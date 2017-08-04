<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
String workNo = (String)session.getAttribute("workNo");
String regionCode= (String)session.getAttribute("regCode");
String showInfoFlag = "0";
String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
System.out.println("cccTime : " + cccTime);
String nowTime = cccTime.substring(11,19);
System.out.println("nowTime : " + nowTime);
String amStr = "09:30:00";
System.out.println("compareTo : " + amStr.compareTo(nowTime));
String powerFlag = "0";
if(amStr.compareTo(nowTime) > 0){
	/* 查询是否有班前提醒的权限 */
	String getSql1 = "SELECT rela_type  FROM sloginpdomrelation a, spopedomcode b"
		+" WHERE a.popedom_code = b.popedom_code"
		+"  AND a.login_no = '" + workNo + "'"
		+"  AND b.pdt_code IN ('03', '05')"
		+"  AND a.end_date > SYSDATE"
		+"  AND b.reflect_code = 'd955'";
%>
	<wtc:pubselect name="sPubSelect" outnum="1" 
		 routerKey="region" routerValue="<%=regionCode%>" 
		  retcode="retCode1" retmsg="retMsg1">
		<wtc:sql><%=getSql1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end"/>
<%
	System.out.println("@@@@@@@@@@@@ retCode1 |" + retCode1 + "|");
	if(result1 == null || result1.length == 0){
		/* 继续验证 */
		String getSql2 = "SELECT COUNT (*)"
			+"  FROM srolepdomrelation a, sloginroalrelation b, spopedomcode c"
			+" WHERE a.role_code = b.role_code"
			+"   AND a.popedom_code = c.popedom_code"
			+"   AND b.login_no = '" + workNo + "'"
			+"   AND c.reflect_code = 'd955'"
			+"   AND b.end_date > SYSDATE";
%>
			<wtc:pubselect name="sPubSelect" outnum="1" 
				 routerKey="region" routerValue="<%=regionCode%>" 
				  retcode="retCode2" retmsg="retMsg2">
				<wtc:sql><%=getSql2%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result2" scope="end"/>
<%
		if(result2 != null){
			if(Integer.parseInt(result2[0][0]) > 0){
				System.out.println("有权限");
				powerFlag = "1";
			}
		}
	}else if(result1 != null && result1.length > 0){
		if(!"1".equals(result1[0][0])){
			System.out.println("~~~ 用户有权限");
			powerFlag = "1";
		}
	}
	
	if("1".equals(powerFlag)){
		/* 查看今天操作了么 */
		String getSql3 = "SELECT DISTINCT to_char(a.createtime,'yyyy-mm-dd')"
       +" FROM dbinfoadm.loginoperate a,"
            +" dbinfoadm.jobrule b,"
            +" dbinfoadm.jobgist c,"
            +" dbinfoadm.jobcontent d,"
            +" dbinfoadm.busproject e"
     +" WHERE b.jobruleid = a.jobrule"
       +" AND b.jobgistid = c.jobgistid"
       +" AND d.jobcontentid = c.jobcontentid"
       +" AND e.projectid = d.projectid"
       +" AND e.classtype = '0'"
       +" AND a.login_no = '" + workNo + "'"
   +" ORDER BY to_char(a.createtime,'yyyy-mm-dd') DESC";
	
	%>
		<wtc:pubselect name="sPubSelect" outnum="1" 
			 routerKey="region" routerValue="<%=regionCode%>" 
			  retcode="retCode3" retmsg="retMsg3">
			<wtc:sql><%=getSql3%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result3" scope="end"/>
	<%
		if(result3 != null && result3.length > 0){
			String lastTime = result3[0][0];
			System.out.println("~~~" + lastTime + "->" + result3[0][0]);
			if(cccTime.substring(0,9).compareTo(lastTime) > 0){
				showInfoFlag = "1";
			}
		}else if(result3 != null && result3.length == 0){
			System.out.println("~~~ 用户从来没有操作过");
			showInfoFlag = "1";
		}
	}
}
%>

<%
%>




	var response = new AJAXPacket();
	response.data.add("showInfoFlag","<%=showInfoFlag%>");
	core.ajax.receivePacket(response);
