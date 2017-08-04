<%
/********************
 version v2.0
开发商: si-tech
*
*create by lipf 20120326
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/common/pwd_comm.jsp" %>	
<html>
<head>
<title>用户密码重置</title>
<%	
		activePhone=request.getParameter("activePhone");
		String idNo= request.getParameter("idNo");
		System.out.println("lipf    ===1600_pwdMain.jsp  activePhone=== "+ activePhone);

		String op_code = request.getParameter("opCode");
		String op_name = request.getParameter("opName");
		String broadPhone = request.getParameter("broadPhone");
		String opCode = op_code;
		String opName = op_name;

    String ReqPageName=request.getParameter("ReqPageName");
    String phone_no = request.getParameter("cus_id");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="sLoginAccept"/>
	<%
		String loginAccept = sLoginAccept;

	%>

			<script language=javascript>
				var operPwd_packet = new AJAXPacket("/npage/query/f1600_submit.jsp","请稍候......");
				operPwd_packet.data.add("t_new_pass",'<%=request.getParameter("t_new_pass")%>');				
				operPwd_packet.data.add("opCode","<%=opCode%>");
				operPwd_packet.data.add("phone_no","<%=phone_no%>");					
				operPwd_packet.data.add("opName","<%=opName%>");
				operPwd_packet.data.add("broadPhone","<%=broadPhone%>");
				operPwd_packet.data.add("activePhone","<%=activePhone%>");
				operPwd_packet.data.add("loginAccept","<%=loginAccept%>");
				core.ajax.sendPacket(operPwd_packet, doOperPwd);
				operPwd_packet=null;
				function doOperPwd(packet) {
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					if(retCode=="000000"){
						rdShowMessageDialog("操作成功!",2);
						window.location="f1600_publicValidate.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>&broadPhone=<%=broadPhone%>&phone_no=<%=phone_no%>&idNo=<%=idNo%>";
					}else{
						rdShowMessageDialog("操作失败 !"+retMsg);
						window.location="f1600_publicValidate.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>&broadPhone=<%=broadPhone%>&phone_no=<%=phone_no%>&idNo=<%=idNo%>";
					}
				}
			</script>
		

</html>
