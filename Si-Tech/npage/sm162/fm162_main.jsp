<%
    /*************************************
    * 功  能: 关于为客服工号开放强开权限的需求
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2013/9/6 
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
%>
<%	
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=opName%></title>
		<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
			<script language="javascript">
			$(document).ready(function(){
				var packet = new AJAXPacket("fm162_ajax_getOpType.jsp","正在获得支票相关信息，请稍候......");
				packet.data.add("opCode","<%=opCode%>");
				packet.data.add("opName","<%=opName%>");
				packet.data.add("opFlag","q");
				packet.data.add("opType","");
				core.ajax.sendPacket(packet,doGetOpType);
				packet=null;
			});
			
			function doGetOpType(packet){
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");
				var bakOpType = packet.data.findValueByName("bakOpType");
				if(retCode != "000000"){
					rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
					removeCurrentTab();
				}else{
					if(bakOpType != ""){
						$("input[@type=radio][name=radiobutton][@value='"+bakOpType+"']").attr("checked",true); 
					}
				}
			}
			
			function subCfm(){
				if(rdShowConfirmDialog("请确认是否提交？")==1){
					var opType = $("input[@name=radiobutton][@checked]").val(); 
					var packet = new AJAXPacket("fm162_ajax_getOpType.jsp","正在获得支票相关信息，请稍候......");
					packet.data.add("opCode","<%=opCode%>");
					packet.data.add("opName","<%=opName%>");
					packet.data.add("opFlag","");
					packet.data.add("opType",opType);
					core.ajax.sendPacket(packet,doSubCfm);
					packet=null;
				}
			}
			
			function doSubCfm(packet){
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");
				var bakOpType = packet.data.findValueByName("bakOpType");
				if(retCode != "000000"){
					rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
					window.location.href="fm162_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				}else{
					rdShowMessageDialog("提交成功!",2);
					window.location.href="fm162_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				}
			}
			
			</script>
  </head>
  <body>
  	<form name="frm" method="post" >
     	<input type="hidden" id="opCode" name="opCode"  value="" />
     	<input type="hidden" id="opName" name="opName"  value="" />
    	<%@ include file="/npage/include/header.jsp" %>
    	<div class="title">
    		<div id="title_zi"><%=opName%></div>
    	</div>
      <table cellspacing="0">
        <tr>
          <td class="blue" width="20%">
              操作类型
          </td>
          <td width="80%">&nbsp;
        		<input type="radio" name="radiobutton" id="radiobutton1"  value="1" />开&nbsp;&nbsp;
            <input type="radio" name="radiobutton" id="radiobutton2"  value="0" />关
          </td>
        </tr>
        <tr>
          <td colspan="2" align="center" id="footer">
            <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="确定" onClick="subCfm()" />   
            <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
          </td>
        </tr>
      </table>
      <%@ include file="/npage/include/footer.jsp" %>
    </form>
  </body>
</html>