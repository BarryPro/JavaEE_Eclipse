<%
    /*************************************
    * 功  能: 营销目标客户变更 e579
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-2-3
    **************************************/
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>营销目标客户变更</title>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
		String phoneNo = request.getParameter("activePhone");
		String addrUrl = request.getRemoteAddr().trim();
		
%>
   
         
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
        	      $(function() {
					         init();
					       });
					       
					       function init() {
					      var operateNos = document.getElementsByName("operateNo");
                var operateNoVal = "";
                for(var i=0;i<operateNos.length;i++){
                	if(operateNos[i].checked){
                		operateNoVal = operateNos[i].value;
                	}
                }
                	if(operateNoVal=="0") {
                			$("#seled").append("<option value='dadd' selected>单个添加</option><option value='padd'>批量添加</option>");
                	}
					       }                    		
         function opchange() {
         				var operateNos = document.getElementsByName("operateNo");
                var operateNoVal = "";
                for(var i=0;i<operateNos.length;i++){
                	if(operateNos[i].checked){
                		operateNoVal = operateNos[i].value;
                	}
                }
                $("#seled").empty();
                  if(operateNoVal=="0") {
                  	  
                			$("#seled").append("<option value='dadd' selected>单个添加</option><option value='padd'>批量添加</option>");
                			
                	}
                	if(operateNoVal=="1") {
                		  
                			$("#seled").append("<option value='ddel' selected>单个删除</option><option value='pdel'>批量删除</option>");
                	}
               var sselected =	$("#seled").val();
				          if(sselected=="dadd") {
				           $("#dphones").show();
				           $("#pphones").hide();
				           $("#pphones1").hide();
				         }   
				    	
				          if(sselected=="ddel") {
				           $("#dphones").show();
				           $("#pphones").hide();
				           $("#pphones1").hide();
				         }

         }  
         
         function opSelectChange() {
         var sselected =	$("#seled").val();
         if(sselected=="dadd") {
           $("#dphones").show();
           $("#pphones").hide();
           $("#pphones1").hide();
         }   
          if(sselected=="padd") {
           $("#dphones").hide();
           $("#pphones").show();
           $("#pphones1").show();
         }      	
          if(sselected=="ddel") {
           $("#dphones").show();
           $("#pphones").hide();
           $("#pphones1").hide();
         }
          if(sselected=="pdel") {
           $("#dphones").hide();
           $("#pphones").show();
           $("#pphones1").show();
         	}  
         }         					     
         function subInfo(submitBtn)
         {
			          /* 按钮延迟 */
			    			controlButt(submitBtn);
			    			/* 事后提醒 */
			    			getAfterPrompt();
                var operateNos = document.getElementsByName("operateNo");
                var operateNoVal = "";
                for(var i=0;i<operateNos.length;i++){
                	if(operateNos[i].checked){
                		operateNoVal = operateNos[i].value;
                	}
                }
                
                var sselected =	$("#seled").val();
				         if(sselected=="dadd") {
				         	
				         		var phoneNos = document.frme163.phoneNo.value.trim();
										if(checkElement(document.frme163.phoneNo)==false) {
										 return false;
										}
										  if(!check(frme163))
											  {
											    return false;
											  }
											if(phoneNos.trim()=="") {
																rdShowMessageDialog("请输入要录入的单个号码！");
																return false;
											}
									var packet = new AJAXPacket("fe579_ajax_subInfo.jsp","正在获得数据，请稍候......");
                	packet.data.add("phoneNo",phoneNos);
                	packet.data.add("addrUrl","<%=addrUrl%>");
                	packet.data.add("opCode","<%=opCode%>");
                	packet.data.add("operateNoVal",operateNoVal);
                	core.ajax.sendPacket(packet,doSubInfo);
                	packet = null;

				         }   
				          if(sselected=="padd") {
                 if(frme163.feefile.value.length<1)
									{
										rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
										return false;
									}
									document.frme163.action="fe579_1.jsp?addrUrl=<%=addrUrl%>&opCode=<%=opCode%>&opName=<%=opName%>&operateNoVal="+operateNoVal;
									document.frme163.submit();
				         }      	
				          if(sselected=="ddel") {
				         		var phoneNos = document.frme163.phoneNo.value.trim();
										if(checkElement(document.frme163.phoneNo)==false) {
										 return false;
										}
										  if(!check(frme163))
											  {
											    return false;
											  }
											if(phoneNos.trim()=="") {
																rdShowMessageDialog("请输入要删除的单个号码！");
																return false;
											}
									var packet = new AJAXPacket("fe579_ajax_subInfo.jsp","正在获得数据，请稍候......");
                	packet.data.add("phoneNo",phoneNos);
                	packet.data.add("addrUrl","<%=addrUrl%>");
                	packet.data.add("opCode","<%=opCode%>");
                	packet.data.add("operateNoVal",operateNoVal);
                	core.ajax.sendPacket(packet,doSubInfo);
                	packet = null;
				         }
				          if(sselected=="pdel") {
                 if(frme163.feefile.value.length<1)
									{
										rdShowMessageDialog("数据文件错误，请重新选择数据文件！");
										return false;
									}
								document.frme163.action="fe579_1.jsp?addrUrl=<%=addrUrl%>&opCode=<%=opCode%>&opName=<%=opName%>&operateNoVal="+operateNoVal;
								document.frme163.submit();
				         	}


             }
        	
            function doSubInfo(packet)
            {
                var retCode = packet.data.findValueByName("retCode");
                var retMsg = packet.data.findValueByName("retMsg");
                if(retCode=="000000"){
                  rdShowMessageDialog("提交成功！",2);
                  window.location="fe579_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
                }else{
                	rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
                	window.location="fe579_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
                }
            }

        </script>
    </head>
    <body>
        <form name="frme163" method="post" ENCTYPE="multipart/form-data">
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">选择操作方式</div>
        	</div>
            <table cellspacing="0">

                <tr>
                		<td class="blue">选择操作</td>
                    <td>
                        <input type = "radio" name="operateNo" checked="checked" value="0" onclick="opchange()"/>添加
                        <input type = "radio" name="operateNo" value="1" onclick="opchange()"/>删除
                    </td>
                   <td class="blue">操作类型</td>
                    <td>
                    	<select id="seled" onChange="opSelectChange()">
										 </select>
                    </td>

                </tr>
                  <tr style="display:block" id="dphones" >
                    <td class="blue">单个号码</td>
                    <td colspan="3" >
                        <input type = "text" name="phoneNo" id="phoneNo"  v_type="mobphone"  maxlength="11" size="17"/>
                    </td>
                </tr>
                      <tr style="display:none" id="pphones" >
			              	<td class="blue"  >号码导入</td>
			                <td colspan="3"> 
			                  <input type="file" name="feefile">
			                </td>
                      </tr>
                      <tr style="display:none" id="pphones1">
                      	<td colspan="4" >说明：<br>
				        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">号码导入格式为TXT文件</font>：<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">请注意号码的正确性</font>：<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;手机号码  回车<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如： <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13604511111 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13704511111 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13804511111 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13904511111 
				                </td>
                      </tr>
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="提交" onClick="subInfo(this)" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
          <input type="hidden" name="opCode" value="<%=opCode%>">
          <input type="hidden" name="opName" value="<%=opName%>">
        </form>
    </body>
</html>