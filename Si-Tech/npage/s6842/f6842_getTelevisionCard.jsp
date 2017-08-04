<%
    /*************************************
    * 功  能: 新版促销品统一付奖 输入有线电视卡卡号
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-10-16
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
     String opCode="6842";
    String opName="输入有线电视卡卡号";

%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>输入有线电视卡卡号</title>
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
            function subInfo(submitBtn2)
            {
                /* 按钮延迟 */
    			controlButt(submitBtn2);
    			/* 事后提醒 */
    			getAfterPrompt();
                if(!check(frm6842T))
                { 
                    return false;
                }
                var televisionCard=$.trim($("#televisionCard").val());
                
                if(televisionCard.length<16){
                    rdShowMessageDialog("电视卡卡号位数不够！请重新输入");
                    return false;	
                }
                
                  window.returnValue = televisionCard;
                  window.close();
             }
             
             function closeOpenWin(){
                window.returnValue = "";
                window.close();
             }
        </script>
    </head>
    <body>
        <form name="frm6842T" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">输入有线电视卡号条件</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">有线电视卡卡号</td>
                    <td colspan="3">
                        <input type="text" id="televisionCard" name="televisionCard" v_must="1" v_type="0_9" maxlength="16" size="16" value="" />
                        &nbsp;<font color="orange">(卡号格式为16位数字)</font>
                    </td>
                </tr>			
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="确定" onClick="subInfo(this)" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="closeOpenWin()" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>