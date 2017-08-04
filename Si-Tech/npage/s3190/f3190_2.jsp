<%
/********************
 *version v2.0
 *开发商: si-tech
 *update by qidp @ 2008-12-15 页面改造,修改样式
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD><TITLE>一点支付冲正</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<%
    //定义变量
    //输入参数：帐务日期，缴费流水，机构代码，工号，权限代码。
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    
    String totaldate  = request.getParameter("billdate").trim();//帐务月份
    String phoneNo = request.getParameter("phoneNo");
    String contractno = request.getParameter("contractNo");
    if (contractno == null) {
        contractno = request.getParameter("contractno");
    }
    String loginaccept = request.getParameter("loginaccept").trim();//流水号
     
     
    //ArrayList arr = (ArrayList)session.getAttribute("allArr");
    //String[][] baseInfo = (String[][])arr.get(0);
    //String workno = baseInfo[0][2];
    //String workname = baseInfo[0][3];
    //String orgcode = baseInfo[0][16];//机构代码
    //String[][] password = (String[][])arr.get(4);//读取工号密码 
    //String nopass = password[0][0];
    
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String orgcode = (String)session.getAttribute("orgCode");
    /*tianyang add for pos */
    String groupId = (String)session.getAttribute("groupId");
    String nopass = (String)session.getAttribute("password");
    
    String op_code = "3190" ;
     
    
    String inParas[] = new String[5];
    inParas[0] = workno;
    inParas[1] = nopass ;
	inParas[2] = contractno;
    inParas[3] = loginaccept ;
    inParas[4] = totaldate;
    /*
    String outNum="17";
     
    int[] lens={12,5};
     
    ScallSvrViewBean viewBean = new ScallSvrViewBean();//实例化viewBean
    
    CallRemoteResultValue value=  viewBean.callService("1",orgcode.substring(0,2),"s1310Init",outNum, lens, inParas); 
    ArrayList list  = value.getList();
    */
%>
    <wtc:service name="s3190Init" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" outnum="5">
    	<wtc:param value="<%=inParas[0]%>"/>
        <wtc:param value="<%=inParas[1]%>"/>
        <wtc:param value="<%=inParas[2]%>"/>
        <wtc:param value="<%=inParas[3]%>"/>
        <wtc:param value="<%=inParas[4]%>"/>
    </wtc:service>
    <wtc:array id="result" start="0"  length="5"  scope="end" />
    
<%
    //String[][] result = (String[][])list.get(0);
    
    String return_code =result[0][0];
    String return_message =result[0][1];
    String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
%>

<!--js-->
<script language = "javascript">
function docheck()
{
	//alert("check");
	var	prtFlag = rdShowConfirmDialog("本次退费金额"+document.form.jfje.value+"元,是否确定退费？");
	if (prtFlag==1)
	{
		form.submit();
	}
}
function goBack()
{
	//window.location.href = "f3190_1.jsp";
	history.go(-1);
	//alert("goBack");
}
</script>
<%
    if (return_code.equals("000000")) {
        %>
		<BODY>
<FORM action="f3190_3.jsp" method=post name=form>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<%@ include file="/npage/include/header.jsp" %>
 
    <table cellspacing="0">
        <tr> 
            <td class="blue">账户号码</td>
            <td colspan=2>
			<input type="text" name="contractNo" maxlength="11" value = "<%=contractno%>" readonly onKeyPress="return isKeyNumberdot(0)"  >
			</td>
            <td class="blue">缴费流水</td>
            <td colspan=2>
			<input type="text" name="loginaccept"  onKeyPress="return isKeyNumberdot(0)" readonly value = "<%=loginaccept%>" >
			</td>
        </tr>
        
        
        <tr> 
            <td class="blue">缴费年月</td>
            <td colspan=2>
			<input type="text" name="totaldate" value = "<%=totaldate%>" maxlength="11" onKeyPress="return isKeyNumberdot(0)" readonly  >
			</td>
            <td class="blue">缴费时间</td>
            <td colspan=2>
			<input type="text" name="jfsj" value = "<%=result[0][2]%>"  onKeyPress="return isKeyNumberdot(0)" readonly  >
			</td>
        </tr>
		<tr> 
            <td class="blue">缴费金额</td>
            <td colspan=2>
			<input type="text" name="jfje" value = "<%=result[0][3]%>"  onKeyPress="return isKeyNumberdot(0)" readonly >
			</td>
            <td class="blue">操作工号</td>
            <td colspan=2>
			<input type="text" name="workno" value = "<%=workno%>" onKeyPress="return isKeyNumberdot(0)"  readonly>
			</td>
        </tr>
        
        <tr> 
            <td class="blue">退费金额</td>
            <td colspan=2>
			<input type="text" name="tfje" value = "<%=result[0][3]%>"  onKeyPress="return isKeyNumberdot(0)" readonly  >
			</td>
            <td class="blue">用户备注</td>
            <td colspan=2>
			<input type="text" name="note"    >
			</td>
        </tr>
        </table>
		 
    <table cellspacing="0">
        <tbody>
            <tr>
                <td id="footer">
                    <input class="b_foot" name=sure type="button" value=确认 onclick="docheck()">
                    
                    <input class="b_foot" name=reset type=button value=返回 onClick="goBack()">
                </td>
            </tr>
        </tbody>
    </table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
		<%}
else{
%>
<script language='JavaScript'>
		rdShowMessageDialog("查询错误！<br>错误代码：'<%=return_code%>'。<br>错误信息：'<%=return_message%>'。",0);
		history.go(-1);
</script>
<%}%>

 
</html>