<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *废弃了页面密码验证功能
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
  	request.setCharacterEncoding("GBK");

	  HashMap hm=new HashMap();
	  hm.put("1","没有客户ID！");
	  hm.put("3","密码错误！");
	  hm.put("4","手续费不确定，您不能进行任何操作！");
	  ///////
	  //  孙振兴添加 START
	  hm.put("5","对不起，此号码为特殊特殊号码，您的工号权限不足！");
	  hm.put("6","对不起，此号码办理过“邮寄帐单”业务，请先取消！");
	  hm.put("7","对不起，此号码办理过“电子帐单”业务，请先取消！");
	  hm.put("8","对不起，此号码办理过“邮寄帐单”和“电子帐单”业务，请先取消！");
	  hm.put("9","未能取得用户完整的基本信息!");
	  ///////
	  //  孙振兴添加 END
	  hm.put("2", "用户资料不存在1，请核查数据或咨询系统管理员！");
	  hm.put("10","用户资料不存在2，请核查数据或咨询系统管理员！");
	  hm.put("11","用户资料不存在3，请核查数据或咨询系统管理员！");
	  hm.put("12","用户资料不存在4，请核查数据或咨询系统管理员！");
	  hm.put("13","用户资料不存在5，请核查数据或咨询系统管理员！");
	  hm.put("14","用户资料不存在6，请核查数据或咨询系统管理员！");
	  hm.put("15","对不起，此号码办理过“亲情通业务”业务，请先取消！");
	  hm.put("30","此用户为异地用户，不能进行GSM过户！");
	  hm.put("31","省内携号用户，只能在原归属地进行GSM过户！");
%>
<%
		String opCode = WtcUtil.repNull(request.getParameter("opCode"))==""?"1238":WtcUtil.repNull(request.getParameter("opCode"));
		String opName = WtcUtil.repNull(request.getParameter("opName"))==""?"GSM过户":WtcUtil.repNull(request.getParameter("opName"));
		String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
		System.out.println("#############ReqPageName->"+ReqPageName);
		String accept = WtcUtil.repNull(request.getParameter("accept"));
		String work_no = (String)session.getAttribute("workNo");
		String activePhone1=WtcUtil.repNull(request.getParameter("activePhone"));
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>GSM过户</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>

 onload=function()
 {
 		self.status="";
 		<%
 		if(accept.equals("")) {
 		%>
 		document.all.cus_pass.disabled = false;
 		<%
 	}
 	%>
		<%
			if(ReqPageName.equals("s1238Main"))
			{
			  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));			 
		 	  if(!retMsg.equals("100") && !retMsg.equals("101"))
			  {
		%>
			    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");
		<%
			  }
			  else if(retMsg.equals("100"))
			  {
		%>
				rdShowMessageDialog('帐户<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>已欠费，不能办理业务！');

		<%
			  }
		      else if(retMsg.equals("101"))
			  {
		%>
		rdShowMessageDialog('错误<%=WtcUtil.repNull(request.getParameter("errCode"))%>：<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
		       		<%
			  }
			}
		%>

  }

var passflag="no";
	//验证及提交函数
	function doCfm()
	{
	
	<%
		if(accept.equals("")) {
		%>
		
			if(checkElement(document.frm.srv_no)==false) {
				 return false;
				}
		
				var jiamiqianmima= document.all.cus_pass.value;		
				var phones_no= $("#srv_no").val();		
				if(jiamiqianmima=="") {
				 rdShowMessageDialog("用户密码不能为空！");
				 return false;
				}
				if(phones_no.trim()=="") {
				 rdShowMessageDialog("手机号码不能为空！");
				 return false;
				}
				var checkPwd_Packets = new AJAXPacket("queryENPass.jsp","取得加密后用户输入的密码");
				checkPwd_Packets.data.add("jiamiqianmima",jiamiqianmima);			
				core.ajax.sendPacket(checkPwd_Packets, doqueryjiami);
				checkPwd_Packets=null;
		
		
		
				
				var jiamipasswords= $("#jiamipassword").val();			
				var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
				checkPwd_Packet.data.add("custType","01");				//01:手机号码 02 客户密码校验 03帐户密码校验
				checkPwd_Packet.data.add("phoneNo",phones_no);	//移动号码,客户id,帐户id
				checkPwd_Packet.data.add("custPaswd",jiamipasswords);//用户/客户/帐户密码
				checkPwd_Packet.data.add("idType","en");				//en 密码为密文，其它情况 密码为明文
				checkPwd_Packet.data.add("idNum","");					//传空
				checkPwd_Packet.data.add("loginNo","<%=work_no%>");		//工号
				core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
				checkPwd_Packet=null;
				
				if(passflag=="no") {
				return false;
				}
	 <%			
		}	
		%>	
			
    frm.action="s1238Main.jsp";
    frm.submit();
	}
	
			function doqueryjiami(packet) {
					var retResult = packet.data.findValueByName("jiamimima");
					$("#jiamipassword").val(retResult);
			}
			
			function doCheckPwd(packet) {
				var retResult = packet.data.findValueByName("retResult");
				var msg = packet.data.findValueByName("msg");
				if (retResult != "000000") {
					rdShowMessageDialog(msg);						
					passflag="no";	
					document.all.cus_pass.value="";		
				}else {
				 rdShowMessageDialog("用户密码校验成功！",2);
				  passflag="yes";			
				}
			}
</script>
</head>
	<body>
		<form name="frm" method="POST">
 			<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1238Login">
 			<input type="hidden" name="accept" value="<%=accept%>"/>
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">GSM过户</div>
			</div>
	    <table cellspacing="0">
          <tr>
            <td width="16%" class="blue">服务号码</td>
      			<td width="34%">
                <input type="text" size="17" maxLength="13" name="srv_no" id="srv_no" v_type="mobphone"  maxlength="11" value="<%=activePhone1%>"  <%if(!activePhone1.equals("")){out.print(" readOnly");}%>>
      			</td>
      			    <td width="16%" class="blue">用户密码</td>
    <td>
        <jsp:include page="/npage/common/pwd_one_new.jsp">
            <jsp:param name="width1" value="16%"/>
            <jsp:param name="width2" value="34%"/>
            <jsp:param name="pname" value="cus_pass"/>
            <jsp:param name="pwd" value="12345"/>
        </jsp:include>
    </td>
      		</tr>
          <tr>
            <td id="footer" colspan="4">
			          <input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()">
					  		<input class="b_foot" type=button name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>')">
      			</td>
    			</tr>
  			</table>
  			 <input type="hidden" name="jiamipassword" id="jiamipassword"  >
	<%@ include file="/npage/include/footer_simple.jsp"%>
		<%@ include file="/npage/common/pwd_comm.jsp" %>
   </form>
</body>
</html>