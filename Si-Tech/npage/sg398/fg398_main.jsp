<%
    /*************************************
    * 功  能: 包年续签资费提醒配置 g398
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2013-1-15
    **************************************/
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>包年续签资费提醒配置</title> 
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

                if(!check(frm)) return false;
                
                var offerId=$.trim($("#offerId").val());
                var offerName=$.trim($("#offerName").val());
                
                if(offerId==""&&offerName==""){
                    rdShowMessageDialog("请至少输入一个查询条件！");
                    return false;	
                }
                var packet = new AJAXPacket("fg398_ajax_query.jsp","正在获得数据，请稍候......");
                	packet.data.add("offerId",offerId);
                	packet.data.add("offerName",offerName);
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
                var qryChkedState =$("input[@name=qryRadioName][@checked]").attr("v_state"); 
                if(qryChkedState!=undefined){
                  selecQryInfo(qryChkedState);
                }
                var retCode = $("#retCode").val();
                var retMsg = $("#retMsg").val();
                if(retCode!="000000"){
                   rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
                   return false;
                }
            }
            
            function selecQryInfo(val){
              if(val=="1"){
                $("#subBtn").val("增加");
                $("#subBtn").attr("v_flag","1");
              }else if(val=="2"){
                $("#subBtn").val("删除");
                $("#subBtn").attr("v_flag","2");
              }else{
                $("#subBtnTr").css("display","none");
              }
            }
            
            function subInfo(obj){
              var v_offerId = $("input[@name=qryRadioName][@checked]").attr("v_offerId");//资费代码
              var v_flag = $("#subBtn").attr("v_flag");//增加、删除标识
              var packet = new AJAXPacket("fg398_ajax_subInfo.jsp","正在提交数据，请稍候......");
                	packet.data.add("v_offerId",v_offerId);
                	packet.data.add("v_flag",v_flag);
                	packet.data.add("opCode","<%=opCode%>");
                	core.ajax.sendPacket(packet,doSubInfo);
                	packet = null;
            }
            
            function doSubInfo(packet){
              var retcode_subInfo = packet.data.findValueByName("retcode_subInfo");
              var retmsg_subInfo = packet.data.findValueByName("retmsg_subInfo");
              if(retcode_subInfo == "000000"){
                rdShowMessageDialog("提交成功！",2);        
                reSetTab();
              }else{
                rdShowMessageDialog("错误代码：" + retcode_subInfo + "，错误信息：" + retmsg_subInfo,0);
                reSetTab();
              }
            }
            
            function reSetTab(){
              window.location.href="fg398_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
                    <td class="blue">资费代码</td>
                    <td>
                        <input type="text" id="offerId" name="offerId"  value="" />
                    </td>
                    <td class="blue">资费名称</td>
                    <td>
                        <input type="text" id="offerName" name="offerName"  value="" />
                    </td>
                </tr>
                <tr>
                  <td colspan="4">
                    <font class='red'> 注，本功能说明：<br>
                        1.录入的资费必须是包年资费；<br>
                        2.录入的资费权限要小于等于2级；<br>
                        3.录入的资费为有效并且在用；<br>
                        4.当前工号只能配置归属地市相同的资费。<br>
                        5.办理了录入此界面的资费的用户，如满足以下3个条件（1、必须是此界面配置的包年资费的用户到期的最后一个月；2、发送短信时客户状态正常，非欠费，停机，报停的实名制用户；3、用户手机号码中预存款大于包年费用30元）则发送新短信：“尊敬的客户您好，您办理的包年资费本月到期，如继续使用包年资费可通过发送指令“ZBNXQ”到10086办理包年资费续签，详情咨询10086。”，回复可进行续签，不符合条件的用户和未录入此界面的包年资费代码如果原来配置了发送短信提醒则发送原有的包年到期提醒短信，没有配置的不发送短信。
                    </font> 
                  </td>
                  
                </tr>
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="查询" onClick="query(this)" />   
                        <input type="button" id="reSetBtn"  name="reSetBtn"  class="b_foot" value="重置" onClick="reSetTab();" /> 
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>