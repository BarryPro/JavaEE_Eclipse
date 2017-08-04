<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
    Logger logger = Logger.getLogger("s3608_1.jsp");
    String workno = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workname = WtcUtil.repNull((String)session.getAttribute("workName"));
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	String region_code=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String regionCode = region_code;
	String getAcceptFlag = "";
	String printAccept="";
	ArrayList retArray = new ArrayList();
	String sqlStr = "";
	String[][] result = new String[][]{};
    
    String opCode = "3608";
    String opName = "BOSS侧VPMN操作查询";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>BOSS侧VPMN操作查询</TITLE>
<SCRIPT language="JavaScript">
function refMain(){
	var phoneNo=document.all.phoneNo.value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("请填入服务号码！");
		return;
	}
	frm.submit();
}
</SCRIPT>
</HEAD>
<BODY>
<FORM action="s3608_2.jsp" method="post" name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">BOSS侧VPMN操作查询</div>
</div>
<TABLE cellSpacing=0>
    <TR>
        <td class='blue' nowrap>服务号码</TD>
        <TD>
            <input class="InputGrey" name="phoneNo"  value="<%=activePhone%>" readOnly size="20" v_must=1 v_type=string maxlength="11" index="1">
            <font class='orange'>*</font>
        </td>
    </TR>
    
    <TR id="footer">
        <TD colspan="2">
            <input class="b_foot" name="sure"  type=button value="确认"  onclick="refMain()" >
            <input class="b_foot" name="reset1"  onClick="" type=reset value="清除">
            <input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="关闭">
        </TD>
    </TR>
</TABLE>
<input name="internetIp" type="hidden" value="">
<input name="terminalIp" type="hidden" value="">
<input name="serviceIp" type="hidden" value="">
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
