
<%
	/*
	 * 功能: 省内携号
	 * 版本: 1.0
	 * 日期: 2012/3/9 14:19:13
	 * 作者: zhangyan
	 * 版权: si-tech
	 * update:
	 */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String offerId = WtcUtil.repNull(request.getParameter("offid"));
	String msType = WtcUtil.repNull(request.getParameter("msType"));
	String id_no = WtcUtil.repNull(request.getParameter("id_no"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String offidInt = WtcUtil.repNull(request.getParameter("offidInt"));
	String regionCode = (String) session.getAttribute("regCode");
	String inputSql = "select OFFER_ATTR_CHARACTER,OFFER_ATTR_VALUE "
			+ "from  product_offer_attr where offer_id = " + offerId
			+ " and EXCLUABLITY='1' ";
%>

<wtc:utype name="sQryChgOfferMS" id="retVal" scope="end">
	<wtc:uparam value="<%=msType%>" type="INT" />
	<wtc:uparam value="<%=offerId%>" type="STRING" />
	<wtc:uparam value="<%=id_no%>" type="LONG" />
	<wtc:uparam value="<%=opCode%>" type="STRING" />
	<wtc:uparam value="<%=offidInt%>" type="LONG" />
</wtc:utype>

<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code"
	routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=inputSql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result_t" scope="end" />
<%
	String retCode = retVal.getValue(0);
	String retMsg = retVal.getValue(1);
	if (retCode.equals("0")) 
	{
		String offerType = retVal.getValue("2.0.0");
		String offerName = retVal.getValue("2.0.1");
		String offerDesc = retVal.getValue("2.0.2.0");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<body style="overflow-y: auto; overflow-x: hidden;">
		<form>
			<%@ include file="/npage/include/header_pop.jsp"%>
			<div class="title">
				<div id="title_zi">
					销售品详情查询
				</div>
			</div>
			<table cellspacing=0>
				<%
					for (int ia = 0; ia < retVal.getSize(2); ia++) {
				%>
				<tr>
					<td class="blue" width="30%"><%=retVal.getValue("2." + ia + ".1")%></td>
					<td><%=retVal.getUtype("2." + ia + ".2").getValue(0)%></td>
				</tr>
				<%
					}
				%>
				<%
					for (int iw = 0; iw < result_t.length; iw++) {
				%>
				<tr>
					<td class="blue"><%=result_t[iw][0]%></td>
					<td><%=result_t[iw][1]%></td>
				</tr>
				<%
					}
				%>
			</table>

			<table cellspacing=0>
				<tr>
					<td id="footer">
						<input type="button" class="b_foot" value="关闭"
							onclick="window.close();">
					</td>
				</tr>
			</table>
			<%@ include file="/npage/include/footer_pop.jsp"%>
		</form>
	</body>
</html>
<%
	} else {
%>
	<script>
		alert("没有此销售品的描述信息");
		window.close();
	</script>
<%
	}
%>		