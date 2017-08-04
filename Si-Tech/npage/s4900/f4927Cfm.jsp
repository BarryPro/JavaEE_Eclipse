<%
    /*************************************
    * 功  能: 应收资金管理系统@营业员上交款录入(提交页)
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-12-9
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String group_id = (String)session.getAttribute("workGroupId");
	String work_no=(String)session.getAttribute("workNo");
	String org_code=(String)session.getAttribute("orgCode");
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    System.out.println("------regionCode="+regionCode);
	String paraAray[] = new String[13];
	paraAray[0] = request.getParameter("pay_type"); //交款类型
	paraAray[1] = request.getParameter("check_no"); //支票号
    paraAray[2] = request.getParameter("money_type"); //营业款类型
	paraAray[3] = request.getParameter("pay_money"); //上交金额
	paraAray[4] = "4927";
	paraAray[5] = work_no;
	paraAray[6] = org_code;
	paraAray[7] = group_id;
	paraAray[8] = request.getParameter("bank_cust"); //支票单位
	paraAray[9] = request.getParameter("account_id"); //帐号
	paraAray[10] = request.getParameter("is_user"); //是否开通业务
	paraAray[11] = request.getParameter("total_date"); //营业款归属日期
	paraAray[12] = request.getParameter("begin_account"); //开户银行代码
	for (int i =0;i<paraAray.length;i++)
	{
		System.out.println("paraAray[]"+i+"="+paraAray[i]);
	}

%>
    <wtc:service name="s4927Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" 
		retcode="errCode" retmsg="errMsg" outnum="2">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
		<wtc:param value="<%=paraAray[12]%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
	System.out.println("f4927---errCode="+errCode);
	System.out.println("f4927---errMsg="+errMsg);
	if("000000".equals(errCode))
	{
%>
        <script language="javascript">
           rdShowMessageDialog("操作成功！",2);
           window.location.href="f4927.jsp?opCode=4927&opName=营业员上交款";
        </script>
<%
	}else{
%>
        <script language="javascript">
        	rdShowMessageDialog("错误代码：<%=errMsg%><br>错误信息：<%=errCode%>", 0);
            window.location.href = "f4927.jsp?opCode=4927&opName=营业员上交款";
        </script>
<%}%>
