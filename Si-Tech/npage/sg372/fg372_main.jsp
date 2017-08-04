<%
    /*************************************
    * 功  能: 手机钱包应用下载及开通查询 g372
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-12-20
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String opCode=request.getParameter("opCode");
  String opName=request.getParameter("opName");
  String phoneNo=WtcUtil.repNull((String)request.getParameter("activePhone"));
  String workNo = (String)session.getAttribute("workNo");
  
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>手机钱包应用下载及开通查询</title>
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
            function query(submitBtn2)
            {
                /* 按钮延迟 */
			    			controlButt(submitBtn2);
			    			/* 事后提醒 */
			    			getAfterPrompt();
    			
                var markDiv=$("#intablediv"); 
                markDiv.empty();
                
                var packet = new AJAXPacket("fg372_ajax_query.jsp","正在获得数据，请稍候......");
                	packet.data.add("phoneNo","<%=phoneNo%>");
                	packet.data.add("opCode","<%=opCode%>");
                	packet.data.add("opName","<%=opName%>");
                	core.ajax.sendPacketHtml(packet,doQuery);
                	packet = null;
             }
        	
            function doQuery(data)
            {
                //找到添加表格的div
								var markDiv=$("#intablediv"); 
								markDiv.empty();
		        		markDiv.append(data);
		        		$("#printBtnTr").css("display","");
                var retCode = $("#retCode").val();
                var retMsg = $("#retMsg").val();
                if(retCode!="0000"){
                     rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
                     window.location.href="fg372_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
                     return false;
                }
            }
            
            function printDiv(printpage) {
              var headstr = "<html><head><title></title></head><body>";
              var footstr = "</body>";
              var newstr = document.all.item(printpage).innerHTML;
              var oldstr = document.body.innerHTML;
              document.body.innerHTML = headstr+newstr+footstr;
              window.print();
              document.body.innerHTML = oldstr;
              return false;
            }

        </script>
    </head>
    <body>
        <form name="frm" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">输入查询条件</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">手机号码</td>
                    <td>
                        <input type="text" id="phoneNo" name="phoneNo"  value="<%=phoneNo%>" class="InputGrey" readonly />
                    </td>
                </tr>			
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="查询" onClick="query(this)" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv" name="intablediv"></div>
          <table>
          <tr id="printBtnTr" style="display:none;">
              <td colspan="6" align="center" id="footer">
                  <input type="button" id="printBtn" name="printBtn" class="b_foot" value="打印" onClick="printDiv('intablediv')" />   
              </td>
          </tr>
          </table>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>