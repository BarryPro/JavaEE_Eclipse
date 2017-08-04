<%
/********************
* 功能: 主资费冲正 127b
* version v3.0
* 开发商: si-tech
* update by qidp @ 2008-12-01
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode = "127b";
    String opName = "主资费冲正";
/*
 * 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
 *		部分变量的命名依据对此变量使用的意义，或用途。
 */
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>主资费冲正</TITLE>
</HEAD>
<!----------------------------------页头显示区域----------------------------------------->
<body>
<FORM action="" method=post name="form1">
<%
    //在此处读取session信息
    
    String[][] favInfo = (String[][])session.getAttribute("favInfo");//读取优惠资费代码
    
    /*******************************定义全局变量*******************************/
    String hdword_no = (String)session.getAttribute("workNo");//工号
    String hdpowerright = (String)session.getAttribute("powerRight");//角色权限
    
    
    /**************************************************************************/
%>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
   <div id="title_zi">用户登录</div>
</div>
    <TABLE border=0>
        <TR>
            
            <TD class="blue" width="15%">服务号码</TD>
            <TD>
                <input name="i1" size="20" value="<%=activePhone%>" maxlength=11  v_must=1 v_minlength=1 v_maxlength=16 v_type="mobphone" class="InputGrey" readOnly>
            </TD>
        
        </TR>
        
        
        <tr>
            <td nowrap colspan="4" id="footer">
                <div align="center"> 
                
                    <input class="b_foot" name=sure  type=button value=确认 onclick="if(check(form1))  pageSubmit();" >
                    <input class="b_foot" name=kkkk  onClick="removeCurrentTab()" type=button value=关闭>
                </div>
            </td>
        </tr>
        
    </TABLE>

<!-------------------------文本隐藏域必须在form1中----------------------------->
<input type="hidden" name="pw_favor">
<input type="hidden" name="iOpCode" value="127b">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="iAddStr" value=""> 
<%@ include file="/npage/include/footer_simple.jsp" %>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
</FORM>
</BODY>
</HTML>
<%/*-----------------------------javascript区-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------load页面时读取----------------------------------*/

function pageSubmit(){

form1.action="f127a_2.jsp";
form1.submit();
}
</script>
