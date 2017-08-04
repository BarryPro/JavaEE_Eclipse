<%
    /*************************************
    * 功  能: m200·IDC交换机端口信息维护 
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2014/11/22
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginNo= (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=opName%></title>
		<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
			<script language="javascript">
				$(document).ready(function(){
					//judgeLoginNo();
				});
	           
				//增加
				function uptInfo(obj){
					var portName = "";
					var unitCustName = "";
					var portId = "";
					var opType = "";
					if(obj.id == "addBtn"){ //增加
						portName = $("#portName").val();
						unitCustName = $("#unitCustName").val();
						opType = "1";
						if(portName == "" || portName == ""){
							rdShowMessageDialog("设备端口号名称 和 集团客户名称 为必填内容，请输入！");
							return false;
						}
					}else if(obj.id == "uptBtn"){ //修改
						var v_sum = $(obj).attr("v_sum");
						if(obj.value == "修改"){
							obj.value = "提交";
							$("#qryPortName"+v_sum).removeAttr("class");
							$("#qryPortName"+v_sum).removeAttr("readonly");
							$("#qryUnitCustName"+v_sum).removeAttr("class");
							$("#qryUnitCustName"+v_sum).removeAttr("readonly");
							return false;
						}else{
							obj.value = "修改";
							$("#qryPortName"+v_sum).attr("class","InputGrey");
							$("#qryPortName"+v_sum).attr("readonly");
							$("#qryUnitCustName"+v_sum).attr("class","InputGrey");
							$("#qryUnitCustName"+v_sum).attr("readonly");
						}
						portName = $("#qryPortName"+v_sum).val();
						unitCustName = $("#qryUnitCustName"+v_sum).val();
						portId = $("#qryTr"+v_sum).attr("v_portId");
						opType = "2";
					}else{ //删除
						var v_sum = $(obj).attr("v_sum");
						v_state = $("#qryTr"+v_sum).attr("v_state");
						if(v_state != "0"){
							rdShowMessageDialog("当前状态已占用，不允许被删除！");
							return false;
						}else{
							var confirmFlag = rdShowConfirmDialog("是否进行删除操作？");
							if (confirmFlag==1){
								portName = $("#qryTr"+v_sum).attr("v_portName");
								unitCustName = $("#qryTr"+v_sum).attr("v_unitCustName");
								portId = $("#qryTr"+v_sum).attr("v_portId");
								opType = "3";
							}else{
								return false;	
							}
						}
					}
					
					var packet = new AJAXPacket("fm200_ajax_addAndUptInfo.jsp","正在获得数据，请稍候......");
					packet.data.add("opCode","<%=opCode%>");
					packet.data.add("portName",portName);
					packet.data.add("unitCustName",unitCustName);
					packet.data.add("portId",portId);
					packet.data.add("opType",opType);
					core.ajax.sendPacket(packet);
					packet = null;
				}
				
				function doProcess(packet){
					var opType = packet.data.findValueByName("opType");
			    var retCode = packet.data.findValueByName("retCode");
			    var retMsg=packet.data.findValueByName("retMsg");
			    //if(opType == "1"){//增加
			    	if(retCode != "000000"){
			    		rdShowMessageDialog("错误代码：" + retCode + "<br>错误信息：" + retMsg,0);
            	window.location.href="fm200_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			    	}else{
			    		rdShowMessageDialog("提交成功！",2);
            	window.location.href="fm200_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			    	}
			    //}
				}
				
				function query(obj){
					/* 按钮延迟 */
    			controlButt(obj);
    			/* 事后提醒 */
    			//getAfterPrompt();
    			var portName = $("#portName").val();
					var unitCustName = $("#unitCustName").val();
					var packet = new AJAXPacket("fm200_ajax_query.jsp","正在获得数据，请稍候......");
					packet.data.add("opCode","<%=opCode%>");
					packet.data.add("opName","<%=opName%>");
					packet.data.add("portName",portName);
					packet.data.add("unitCustName",unitCustName);
					core.ajax.sendPacketHtml(packet,doQuery);
					packet = null;
				}
				
				function doQuery(data){
					//找到添加表格的div
					var markDiv=$("#intablediv"); 
					markDiv.empty();
					markDiv.append(data);
					var retCode = $("#retCode").val();
					var retMsg  = $("#retMsg").val();
					if(retCode!="000000"){
						rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
						return false;
					}
        }
				
	      $("table[vColorTr='set']").each(function(){
          $(this).find("tr").each(function(i,n){
            $(this).bind("mouseover",function(){
            	$(this).addClass("even_hig");
            });
            $(this).bind("mouseout",function(){
            	$(this).removeClass("even_hig");
            });
            if(i%2==0){
            	$(this).addClass("even");
            }
          });
        });
				
				
            

		</script>
	</head>
    <body>
        <form name="frm" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
         	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">输入查询条件</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">设备端口号名称</td>
                    <td>
                        <input type="text" id="portName" name="portName" value="" />
                    </td>
                    <td class="blue">集团客户名称</td>
                    <td colspan="3">
                        <input type="text" id="unitCustName" name="unitCustName"  value="" />
                    </td>
                </tr>			
                <tr>
                    <td colspan="6" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="查询" onClick="query(this)" />   
                        &nbsp;
                        <input type="button" id="addBtn"  name="addBtn"  class="b_foot" value="增加" onClick="uptInfo(this)" /> 
                        &nbsp;
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>