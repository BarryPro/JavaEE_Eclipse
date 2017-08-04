<%
    /********************
     * @ OpCode    :  6991
     * @ OpName    :  SIM卡变更历史和详细信息查询
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
    String opCode = "6991";
    String opName = "SIM卡变更历史和详细信息查询";
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<table cellspacing=0>
<tr>
    <td class="blue">手机号</td>
    <td colspan="3">
        <input type="text" id="phoneNo" name="phoneNo" value="" size="11" v_must="1" />
        <font class="orange">*</font>
        <input type="button" id="sel_sim_no" name="sel_sim_no" class="b_text" value="详细" />
    </td>
</tr>
<tr id="footer">
    <td colspan="4">
        <input type="reset" id="bClear" name="bClear" value="清除" class="b_foot" />
        <input type="button" id="bClose" name="bClose" value="关闭" class="b_foot" />
    </td>
</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>

<script type=text/javascript>
    $(document).ready(function(){
        $("#sel_sim_no").bind("click",selSimNo);
        $("#bClose").bind("click",removeCurrentTab);
    });
    
    function selSimNo(){
        var vSimNo = $("#sim_no").val();
        if(vSimNo == ""){
            rdShowMessageDialog("请输入手机号码！",0);
            $("#phoneNo").focus();
            return false;
        }
        
        frm.action="f6991_2.jsp";
    	frm.method="post";
    	frm.submit();
    }
</script>

</body>
</html>