<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-6 二人世界情侣号码
     *
     ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="loginAccept"/>

<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String workNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	String phone = WtcUtil.repStr(request.getParameter("phone"), "");
	
	String qryType = WtcUtil.repStr(request.getParameter("qryType"), "");
	//0:情侣号码信息 1：销售品订购信息 2：业务办理信息 3：最近6个月套餐办理记录 4：最近六月情侣业务办理记录
	
	System.out.println("===========wanghfa===0====== loginAccept = " + loginAccept);
	System.out.println("===========wanghfa===1====== 渠道 = 01");
	System.out.println("===========wanghfa===2====== opCode = " + opCode);
	System.out.println("===========wanghfa===3====== workNo = " + workNo);
	System.out.println("===========wanghfa===4====== noPass = " + noPass);
	System.out.println("===========wanghfa===5====== 号码1 = " + phone);
	System.out.println("===========wanghfa===6====== 密码1 = ");
	System.out.println("===========wanghfa===7====== 查询类型 = " + qryType);
	
%>
	<wtc:service name="sB553Qry" routerKey="phone" routerValue="<%=phone%>" retcode="retCode1" retmsg="retMsg1" outnum="10">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value="<%=phone%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=qryType%>"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>

<%
	System.out.println("==========wanghfa========== sB553Qry : " + retCode1 + "," + retMsg1);

	for (int i = 0; i < result1.length; i ++) {
		for (int j = 0; j < result1[i].length; j ++) {
			System.out.println("==========wanghfa==================== result1[" + i + "]["+j+"] = " + result1[i][j]);
		}
	}
	
	if ("0".equals(qryType)) {	//0：情侣号码信息
		System.out.println("==========wanghfa========== sB553Qry 0：情侣号码信息");
		if (!"000000".equals(retCode1)) {
%>
			<table>
				<tr>
					<td>
						<%=retMsg1%>
					</td>
				</tr>
			</table>
<%
		} else {
%>
			<table>
				<tr>
					<td class="blue" width="20%">
						用户号码
					</td>
					<td width="30%">
						<input type="text" value="<%=phone%>" class="InputGrey" readOnly>
					</td>
					<td class="blue" width="20%">
						情侣号码
					</td>
					<td width="30%">
						<input type="text" value="<%=result1[0][0]%>" class="InputGrey" readOnly>
					</td>
				</tr>
				<tr>
					<td class="blue" width="20%">
						生效时间
					</td>
					<td width="30%">
						<input type="text" value="<%=result1[0][1]%>" class="InputGrey" readOnly>
					</td>
					<td class="blue" width="20%">
						失效时间
					</td>
					<td width="30%">
						<input type="text" value="<%=result1[0][2]%>" class="InputGrey" readOnly>
					</td>
				</tr>
			</table>
<%
		}
	} else if ("1".equals(qryType)) {	//1：销售品订购信息
		System.out.println("==========wanghfa========== sB553Qry 1：销售品订购信息");
		if (!"000000".equals(retCode1)) {
%>
			<table>
				<tr>
					<td>
						<%=retMsg1%>
					</td>
				</tr>
			</table>
<%
		} else {
%>
			<table>
				<tr>
					<th width="20%">
						销售品ID
					</th>
					<th width="20%">
						销售品名称
					</th>
					<th width="20%">
						销售品类型
					</th>
					<th width="20%">
						生效时间
					</th>
					<th width="20%">
						失效时间
					</th>
				</tr>
<%
			for (int i = 0; i < result1.length; i ++) {
%>
				<tr>
					<td width="10%">
						<input type="text" value="<%=result1[i][0]%>" class="InputGrey" readOnly>
					</td>
					<td width="30%">
						<input type="text" size="40" value="<%=result1[i][1]%>" class="InputGrey" readOnly>
					</td>
					<td width="20%">
						<input type="text" value="<%=result1[i][4]%>" class="InputGrey" readOnly>
					</td>
					<td width="20%">
						<input type="text" value="<%=result1[i][2]%>" class="InputGrey" readOnly>
					</td>
					<td width="20%">
						<input type="text" value="<%=result1[i][3]%>" class="InputGrey" readOnly>
					</td>
				</tr>
<%			
			}
		}
%>
		</table>
<%
	} else if ("2".equals(qryType)) {	//2：业务办理信息
		System.out.println("==========wanghfa========== sB553Qry 2：业务办理信息");
%>
	<table>
		<tr>
			<td class="blue" width="20%">
				手机支付业务
			</td>
			<td width="30%">
<%
			if ("NO".equals(result1[0][0])) {
%>
				<input type="text" value="未开通" class="InputGrey" readOnly>
<%
			} else if ("YES".equals(result1[0][0])) {
%>
				<input type="text" value="已开通" class="InputGrey" readOnly>
<%
			}
%>
			</td>
			<td class="blue" width="20%">
				合帐分享业务
			</td>
			<td width="30%">
<%
			if ("NO".equals(result1[0][1])) {
%>
				<input type="text" value="未开通" class="InputGrey" readOnly>
<%
			} else if ("YES".equals(result1[0][1])) {
%>
				<input type="text" value="已开通" class="InputGrey" readOnly>
<%
			}
%>
			</td>
		</tr>
	</table>
<%
	} else if ("3".equals(qryType)) {	//3：最近6个月套餐办理记录
		System.out.println("==========wanghfa========== sB553Qry 3：最近6个月套餐办理记录");
		
		if (!"000000".equals(retCode1)) {
%>
			<table>
				<tr>
					<td>
						<%=retMsg1%>
					</td>
				</tr>
			</table>
<%
		} else {
%>
			<table>
				<tr>
					<th width="20%">
						受理时间
					</th>
					<th width="20%">
						业务代码/业务名称
					</th>
					<th width="15%">
						操作类型（订购/退订）
					</th>
					<th width="25%">
						资费
					</th>
					<th width="20%">
						资费类型
					</th>
				</tr>
<%
			if (result1.length == 0) {
%>
				<tr>
					<td colspan="5">
						最近6个月无套餐办理记录......
					</td>
				</tr>
<%
			}
			for (int i = 0; i < result1.length; i ++) {
%>
				<tr>
					<td>
						<input type="text" value="<%=result1[i][0]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" value="<%=result1[i][1]%>-<%=result1[i][2]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" value="<%=result1[i][3]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" size="40" value="<%=result1[i][4]%>--<%=result1[i][5]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" value="<%=result1[i][6]%>" class="InputGrey" readOnly>
					</td>
				</tr>
<%
			}
		}
%>
	</table>
<%
	} else if ("4".equals(qryType)) {	//4：最近6月情侣业务办理记录
		System.out.println("==========wanghfa========== sB553Qry 4：最近六月情侣业务办理记录");

		if (!"000000".equals(retCode1)) {
%>
			<table>
				<tr>
					<td>
						<%=retMsg1%>
					</td>
				</tr>
			</table>
<%
		} else {
%>
			<table>
				<tr>
					<th width="20%">
						时间
					</th>
					<th width="30%">
						业务代码/业务名称
					</th>
					<th width="20%">
						类型（新增/取消）
					</th>
					<th width="30%">
						情侣号码
					</th>
				</tr>
<%
			if (result1.length == 0) {
%>
				<tr>
					<td colspan="5">
						最近6个月无情侣业务办理记录......
					</td>
				</tr>
<%
			}
			for (int i = 0; i < result1.length; i ++) {
%>
				<tr>
					<td>
						<input type="text" value="<%=result1[i][0]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" size="40" value="<%=result1[i][1]%>-<%=result1[i][2]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" value="<%=result1[i][3]%>" class="InputGrey" readOnly>
					</td>
					<td>
						<input type="text" value="<%=result1[i][4]%>" class="InputGrey" readOnly>
					</td>
				</tr>
<%
			}
		}
%>
	</table>
<%
	}
%>
