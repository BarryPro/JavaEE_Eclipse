<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
			String opCode = "7160";
			String opName = "订报送好礼";
			
			String phoneNo = WtcUtil.repNull(request.getParameter("phone_no"));
			String work_no = WtcUtil.repNull((String)session.getAttribute("workNo"));
			
			String paraAray[] = new String[15];
			paraAray[0] =request.getParameter("login_accept");
			paraAray[1] = request.getParameter("opcode");
			paraAray[2] = work_no;
			paraAray[3] = request.getParameter("phone_no");
			paraAray[4] = request.getParameter("paper_code");
			paraAray[5] = request.getParameter("paper_money");
			paraAray[6] = request.getParameter("sp_code");
			paraAray[7] = request.getParameter("server_code");
			paraAray[8] = request.getParameter("oper_code");
			paraAray[9] = request.getParameter("award_code");
			paraAray[10] = request.getParameter("award_detailcode");
			paraAray[11] = request.getParameter("opNote");
			paraAray[12] = request.getParameter("ip_Addr");
			paraAray[13] = request.getParameter("gift_code");
			paraAray[14] = request.getParameter("consume_term");
			
			for(int i=0;i<paraAray.length;i++){
				if(paraAray[i]==null){
					paraAray[i]="";
				}
			}
		
  		//String[] ret = impl.callService("s7160Cfm",paraAray,"2","region",org_code.substring(0,2));
%>
		<wtc:service name="s7160Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
		<wtc:param value="<%=paraAray[12]%>"/>
		<wtc:param value="<%=paraAray[13]%>"/>
		<wtc:param value="<%=paraAray[14]%>"/>
		</wtc:service>
		<wtc:array id="s7160CfmArr" scope="end"/>
<%
			//增加统一接触记录
			//服务没有返回流水
			String loginAccept = "";
			String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&retMsgForCntt="+retMsg1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[3]+"&opBeginTime="+opBeginTime+"&contactId="+paraAray[3]+"&contactType=user";
%>
			<jsp:include page="<%=url%>" flush="true" />
<%
			int errCode = retCode1==""?999999:Integer.parseInt(retCode1);
			String errMsg = retMsg1;
			if(errCode==0){
%>
					<script language="JavaScript">
						rdShowMessageDialog("确认成功！",2);
						parent.removeTab("<%=opCode%>");
					</script>
	
<%
			}else{%>
					<script language="JavaScript">
							rdShowMessageDialog("确认失败!<%=errMsg%>");
							parent.removeTab("<%=opCode%>");
					</script>
<%	
			}
%>
