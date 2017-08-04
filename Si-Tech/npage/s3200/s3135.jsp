<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
    Logger logger = Logger.getLogger("s3135_1.jsp");
    String workno = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workname = WtcUtil.repNull((String)session.getAttribute("workName"));
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	String region_code=WtcUtil.repNull((String)session.getAttribute("regionCode"));
	String regionCode = region_code;
	String getAcceptFlag = "";
	String printAccept="";
	ArrayList retArray = new ArrayList();
	String sqlStr = "";
	String[][] result = new String[][]{};
    
    String opCode = "3135";
    String opName = "智能网产品变更历史查询";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>智能网产品变更历史查询</TITLE>
<SCRIPT language="JavaScript">
function refMain(){
	var phoneNo=document.all.phoneNo.value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("请填入集团编码！");
		return;
	}
	
	if(document.frm.starttime.value!="")
	{
		if(!forDate(document.frm.starttime)) return;
    }
    if(document.frm.endtime.value!="")
	{
		if(!forDate(document.frm.endtime)) return;
    }
	frm.submit();
}
</SCRIPT>
</HEAD>
<BODY>
<FORM action="s3135_2.jsp" method="post" name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">智能网产品变更历史查询</div>
</div>
        <TABLE cellSpacing=0>
          <TR>
            <td class='blue' nowrap>集团号</TD>
            <TD colspan=3><input name="phoneNo"  value="" size="20" v_must=1 v_type=string index="1">
             <font class='orange'>*</font>
             </TD>
          </TR>
          <TR>
            <td class='blue' nowrap>查询开始时间</td>
            <TD><input name="starttime" id="starttime" v_format="yyyyMMdd" value="" size="20" maxlength="8">
            	(YYYYMMDD)
              </TD>
            <td class='blue' nowrap>查询结束时间</TD>
            <TD><input name="endtime" id="endtime" v_format="yyyyMMdd" value="" size="20" maxlength="8" >
            	(YYYYMMDD)
              </TD>
          </TR>
        </TABLE>
        <TABLE cellSpacing=0>
            <TR id="footer">
              <TD>
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
