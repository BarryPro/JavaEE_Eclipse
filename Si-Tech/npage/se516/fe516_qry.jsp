<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%//------查看手机用户是否是实名制用户
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="";
	
		String PhoneNo = request.getParameter("PhoneNo");

			
	String[] inParamsss1 = new String[2];
	inParamsss1[0] = "select to_char(id_no) from dcustmsg where phone_no=:phonesNO";
	inParamsss1[1] = "phonesNO="+PhoneNo;
	

%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
	<wtc:param value="<%=inParamsss1[0]%>"/>
	<wtc:param value="<%=inParamsss1[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust" scope="end" />
<%
if(retCode1ss.equals("000000")) {
System.out.println("--wanghyd"+dcust.length);
if(dcust.length>0) {
System.out.println("--wanghyd"+dcust.length);
	String[] inParamsss2 = new String[2];
	inParamsss2[0] = "select to_char(TRUE_CODE) from dTrueNamemsg where id_no=:ids_no";
	inParamsss2[1] = "ids_no="+dcust[0][0];
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2ss" retmsg="retMsg2ss" outnum="1">			
	<wtc:param value="<%=inParamsss2[0]%>"/>
	<wtc:param value="<%=inParamsss2[1]%>"/>	
	</wtc:service>	
  <wtc:array id="dcust2" scope="end" />
<%
System.out.println("--wanghyd"+dcust2.length);
if(dcust2.length>0) {
smzflag=dcust2[0][0];

%>

<body>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询信息</div>
			</div>

							<table >
									<tr >
								<th>用户手机号码</th>						
								<th>实名制状态</th>
							
							</tr>
							<tr> 
								<td width="7%"><%=PhoneNo%></td>
								<td width="7%"><%if(smzflag.trim().equals("1")){out.print("实名");}if(smzflag.trim().equals("2")){out.print("准实名");}if(smzflag.trim().equals("3")){out.print("非实名");}%></td>
						  </tr>
						</talbe>
					</div>
				</div>
</body>
</html>
<%
}
else {
	%>
<body>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询信息</div>
			</div>

							<table >
																	<tr >
								<th>用户手机号码</th>						
								<th>实名制状态</th>
							
							</tr>
             <tr height='25' align='center'><td colspan='2'>查询信息为空！</td></tr>
						</talbe>
					</div>
				</div>
</body>
</html>
<%
}

}
else {
	%>
	<body>
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询信息</div>
			</div>

							<table >
																	<tr >
								<th>用户手机号码</th>						
								<th>实名制状态</th>
							
							</tr>
             <tr height='25' align='center'><td colspan='2'>查询信息为空！</td></tr>
						</talbe>
					</div>
				</div>
</body>
</html>
	<%
	}
}
	
else {

		%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode1ss%>"+"<%=retMsg1ss%>",0);	
					</script>
					<%
	}
%>
