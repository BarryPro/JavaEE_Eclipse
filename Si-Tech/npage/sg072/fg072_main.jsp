<%
    /*************************************
    * 功  能: 报停状态查询 g072
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-9-7
    **************************************/
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String phoneNo=request.getParameter("activePhone");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>报停状态查询</title>
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
          function query(submitBtn2){
            /* 按钮延迟 */
	    			controlButt(submitBtn2);
	    			/* 事后提醒 */
	    			getAfterPrompt();
			
            var markDiv=$("#intablediv"); 
            markDiv.empty();

            var packet = new AJAXPacket("fg072_ajax_query.jsp","正在获得数据，请稍候......");
          	packet.data.add("phoneNo","<%=phoneNo%>");
          	packet.data.add("opCode","<%=opCode%>");
          	core.ajax.sendPacketHtml(packet,doQuery);
          	packet = null;
         }
        	
          function doQuery(data)
          {
            //找到添加表格的div
						var markDiv=$("#intablediv"); 
						markDiv.empty();
        		markDiv.append(data);
            var retCode = $("#retCode").val();
            var retMsg = $("#retMsg").val();
            if(retCode!="000000"){
                 rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
                 return false;
            }
          }
            
          function chgMsg(obj,phoneNo){
            var _thisTd = obj.parentNode.parentNode.childNodes;
            var _qryPromptPhoneNo = _thisTd[1].children[0].id;
            if(obj.value=="修改"){
              var objId = obj.id;
              $("#"+objId).attr("disabled","");
              //obj.className = "InputGrey";
              obj.value="确定";
              $("#"+_qryPromptPhoneNo).removeClass("InputGrey");
              $("#"+_qryPromptPhoneNo).removeAttr("readonly");
            }else{
              obj.onClick=saveMsg(obj,phoneNo);
            }
          }
          
          function saveMsg(obj,phoneNo){
            if(!check(frmg072)) return false;
            var _thisTd = obj.parentNode.parentNode.childNodes;
            var _promptphoneNo = _thisTd[1].children[0].id;
            var v_promptPhoneNo = $("#"+_promptphoneNo).val();
            var packet = new AJAXPacket("fg072_ajax_saveMsg.jsp","正在获得数据，请稍候......");
            packet.data.add("uptPromptPhoneNoVal",v_promptPhoneNo);
            packet.data.add("phoneNoVal",phoneNo);
            packet.data.add("opCode","<%=opCode%>");
            packet.data.add("opName","<%=opName%>");
            core.ajax.sendPacket(packet,doSaveMsg);
            packet = null;
          }
          
          function doSaveMsg(packet){
            var retCode = packet.data.findValueByName("retcode");
            var retMsg = packet.data.findValueByName("retmsg");
            if(retCode!="000000"){
              rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
              window.location.href="fg072_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
            }else{
              rdShowMessageDialog("提交成功！",2);
              window.location.href="fg072_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
            }
          }
        </script>
    </head>
    <body>
        <form name="frmg072" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
         	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">输入查询条件</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">手机号码</td>
                    <td colspan="3">
                        <input type="text" id="phoneNo" name="phoneNo"  value="<%=phoneNo%>" class="InputGrey" readonly />
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="查询" onClick="query(this)" />   
                        <input type="button" id="reSetBtn"  name="reSetBtn"  class="b_foot" value="重置" onClick="location.reload();" /> 
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>