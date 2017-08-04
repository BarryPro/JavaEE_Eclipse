<%
    /********************
     * @ OpCode    :  6992
     * @ OpName    :  短信发送
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2010-01-26
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode = "6992";
    String opName = "短信发送";
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String iPhoneNo = WtcUtil.repNull((String)request.getParameter("activePhone"));

%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
    String loginAccept = seq;
    
    String iChnSource = "10086";    // 渠道标识
    String iQryType = "5002";       // 查询类型
    String iSmsCont = "";
%>
    <wtc:service name="sPCSelService" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="<%=loginAccept%>"/>
    	<wtc:param value="<%=iChnSource%>"/> 
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=workPwd%>"/>
        <wtc:param value="<%=iPhoneNo%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=iQryType%>"/>
    </wtc:service>
    <wtc:array id="retArr" scope="end"/>
<%
    if("000000".equals(retCode)){
        if(retArr.length>0){
            iSmsCont = "您的已开通业务如下:";
            for(int i=0;i<retArr.length;i++){
                iSmsCont += " "+(i+1)+"."+retArr[i][1]+";";
            }
        }else{
            iSmsCont = "您未开通任何业务。";
        }
    }
    
    if("000000".equals(retCode)){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">已开业务列表</div>
</div>
<table cellspacing=0>
<tr>
    <td class="blue" width="18%">您的已开业务如下</td>
    <td colspan="3">
        <textarea rows="7" cols="40" id="sms_cont" name="sms_cont"><%=iSmsCont%></textarea>
    </td>
</tr>
<tr>
    <td class="blue">电话号码</td>
    <td colspan="3">
        <input type="text" id="phone_no" name="phone_no" value="<%=iPhoneNo%>" readOnly class="InputGrey" />
    </td>
</tr>
<tr id="footer">
    <td colspan="4">
        <input type="button" id="bSendSMS" name="bSendSMS" value="短信发送" class="b_foot" />
        <input type="reset" id="bClear" name="bClear" value="清除" class="b_foot" />
        <input type="button" id="bClose" name="bClose" value="关闭" class="b_foot" />
    </td>
</tr>
</table>
<input type="hidden" id="op_code" name="op_code" value="<%=opCode%>" />
<input type="hidden" id="op_name" name="op_name" value="<%=opName%>" />
<input type="hidden" id="work_no" name="work_no" value="<%=workNo%>" />
<input type="hidden" id="work_name" name="work_name" value="<%=workName%>" />
<input type="hidden" id="login_accept" name="login_accept" value="<%=loginAccept%>" />
<input type="hidden" id="op_time" name="op_time" value="<%=opBeginTime%>" />
<%@ include file="/npage/include/footer.jsp" %>
</form>

<script type=text/javascript>
    $(document).ready(function(){
        $("#bSendSMS").bind("click",sendSMS);
        $("#bClose").bind("click",removeCurrentTab);
    });
    
    function sendSMS(){
        frm.action="f6992_2.jsp";
    	frm.method="post";
    	frm.submit();
    }
</script>

</body>
</html>
<%}else{%>
    <script type=text/javascript>
        rdShowMessageDialog("查询已开通业务失败！错误信息：<%=retCode%>，错误代码：<%=retMsg%>",0);
        removeCurrentTab();
    </script>
<%}%>