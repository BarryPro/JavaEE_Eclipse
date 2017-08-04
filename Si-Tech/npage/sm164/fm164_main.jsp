<%
    /*
     * 功能:IMS固话密码变更 m164
     * 版本: 1.0
     * 日期: 2014/8/20 
     * 作者: diling
     * 版权: si-tech
    */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %> 
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String) session.getAttribute("workNo");
  String workName = (String) session.getAttribute("workName");
  String regCode = (String) session.getAttribute("regCode");
  String ip_Addr = (String) session.getAttribute("ipAddr");
  String password = (String) session.getAttribute("password");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String phoneNo = (String)request.getParameter("activePhone");
  String  inParams [] = new String[2];
	inParams[0] = "select to_char(a.id_no) from dcustmsg a where a.phone_no=:phoneno";
	inParams[1] = "phoneno="+phoneNo;
	String idNo = "";
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/>
	</wtc:service>  
	<wtc:array id="ret_idNo"  scope="end"/>
	<%
		if("000000".equals(retCode1)){
			if(ret_idNo.length>0){
				idNo = ret_idNo[0][0];
			}
		}
	%>
	
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>"  id="printAccept"/>
		
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<TITLE><%=opName%></TITLE>
    <SCRIPT type=text/javascript>
    	$(function(){
				$('input[name="newpassword"]').blur(function(){
					checkPwdEasy(document.all.newpassword.value);
				});	
    	});
    	
    	//验证密码过于简单
			function checkPwdEasy(pwd) {
				var reg = /^(?![^a-zA-Z]+$)(?!\D+$).{15}$/;
				if(pwd == ""){
					rdShowMessageDialog("密码不能为空，请重新输入！");
					$("input[name='newpassword']").focus();
					return false;
				}
				if(pwd.length < 15){
					rdShowMessageDialog("密码位数应为15位数字，请重新输入！");
					$("input[name='newpassword']").focus();
					return false;
				}
				if(!reg.test(pwd)){
					rdShowMessageDialog("必须包含字母和数字！");
					$("input[name='newpassword']").focus();
					return false;
				}
				
				var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","正在验证密码是否过于简单，请稍候......");
				checkPwd_Packet.data.add("password", pwd);
				checkPwd_Packet.data.add("phoneNo", "<%=phoneNo%>");
				checkPwd_Packet.data.add("idNo", "<%=idNo%>");
				checkPwd_Packet.data.add("opCode", "<%=opCode%>");
				core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
				checkPwd_Packet=null;
			}
			
			var v_retResult;
			function doCheckPwdEasy(packet) {
				var retResult = packet.data.findValueByName("retResult");
				v_retResult = retResult;
				if (retResult == "1") {
					rdShowMessageDialog("尊敬的客户，您本次设置的密码为相同数字类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
					return;
				} else if (retResult == "2") {
					rdShowMessageDialog("尊敬的客户，您本次设置的密码为连号类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
					return;
				} else if (retResult == "3") {
					rdShowMessageDialog("尊敬的客户，您本次设置的密码为手机号码中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
					return;
				} else if (retResult == "4") {
					rdShowMessageDialog("尊敬的客户，您本次设置的密码为证件中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
					return;
				}
			}
    	
	    /*验证登陆名称*/
	    function doValidatePwdJs() {
        if (!checkElement(document.frm.oldpassword)) return false;
        $('#doValidatePwd').attr('disabled', true);
        var myPacket = new AJAXPacket("fm164_ajax_doValidatePwd.jsp", "正在校验用户密码......");
        myPacket.data.add("oldpassword", $("#oldpassword").val());
        myPacket.data.add("id_no", "<%=idNo%>");
        myPacket.data.add("opCode", "<%=opCode%>");
        core.ajax.sendPacket(myPacket, doProcesspassword);//异步
        myPacket = null;
	    }

      function doProcesspassword(packet) {
        var retCode = unescape(packet.data.findValueByName("retCode"));
        var retMsg = unescape(packet.data.findValueByName("retMsg"));
        if (retCode == "000000"){
          rdShowMessageDialog("IMS固话密码验证成功！", 2);
          $('#commitBut').attr('disabled', false);
          $('#oldpassword').attr('readonly', true);
          $('#doValidatePwd').attr('disabled', true);
        }else{
          rdShowMessageDialog("验证失败,请重新输入密码！<br>错误代码:'" + retCode + "'<br>错误信息:'" + retMsg + "'", 0);
          $('#oldpassword').attr('readonly', false);
          $('#commitBut').attr('disabled', true);
          $('#doValidatePwd').attr('disabled', false);
          return false;
        }
      }

			/*提交服务*/
			function commitJsp(){
			  if (!check(frm)){
			  	return false;
			  }
			  if(frm.newpassword.value.length==0){
			  	rdShowMessageDialog("请输入新密码!", 0);
			  }
			  /*
			  if(!forNonNegInt(document.frm.newpassword)){
					return;
				}*/
				if(document.frm.cfmPwd.value.trim().len()==0){
					rdShowMessageDialog("校验密码不能为空!");
					return;				
				}
				/*
				if(!forNonNegInt(document.frm.cfmPwd)){
					return;
				}*/
				if(document.frm.newpassword.value != document.frm.cfmPwd.value){
					rdShowMessageDialog("两次输入的密码不一致！");
					return;
				}
				checkPwdEasy(document.all.newpassword.value);
				if(v_retResult=="0"){
				  document.all.vSystemNote.value = "操作员<%=workNo%>进行<%=opName%>操作";
				  var vOpNote = document.all.vOpNote.value.trim();
				  if(vOpNote.length == 0){
				    document.all.vOpNote.value = document.all.vSystemNote.value;
				  }
					if(rdShowConfirmDialog('确认要进行IMS固话密码变更？') == 1){
						conf();
					}
				}
			}
  
      function conf(){
        $('#commitBut').attr('disabled', false);
        document.frm.action = "fm164_subInfo.jsp";
        frm.submit();
      }
      
      function checkOpType(){
      	hiddenTip(document.all.oldpassword);
      	$("#oldpassword").val("");
        if ($('#opType').val() == 'UU'){
          $('#oldPassTr').attr('style', 'display:""');
          $('#commitBut').attr('disabled', true);
        }else{
          $('#oldPassTr').attr('style', 'display:none');
          $('#commitBut').attr('disabled', false);
        }
      }
      function formReset(){
        window.location.href="fm164_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
      }
    </SCRIPT>
	</HEAD>
	<body>
		<FORM method=post name="frm">
			<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>" />
	    <input type="hidden" id="opCode" name="opCode" value='<%=opCode%>' />
	    <input type="hidden" id="opCode" name="opName" value='<%=opName%>' />
	    <input type="hidden" id="phoneNo" name="phoneNo" value='<%=phoneNo%>' />
	    <%@ include file="/npage/include/header.jsp" %>
	    <div class="title">
	        <div id="title_zi"><%=opName%></div>
	    </div>
    	<table cellspacing="0">
        <tr>
            <td width="15%" class="Blue">操作类型</td>
            <td width="35%" colspan='3'>
                <select name="opType" id="opType" onchange="checkOpType()">
                    <option value="UU">修改密码</option>
                    <option value="DD">复位密码</option>
                </select>
            </td>
        </tr>
        <tr id='oldPassTr' style="">
          <td width="15%" class="Blue">用户旧密码</td>
          <td width="35%" colspan='3'>
            <input type="password" name="oldpassword" id="oldpassword" pwd2="oldpassword" size="21" maxlength="15"
                   v_must="1" v_minlength="15" v_maxlength="15" v_type="pwd"
                   onblur="checkElement(this)"> 
            <font class="orange">*</font>
            <input name="doValidatePwd" type="button" onClick="doValidatePwdJs();" class="b_text" style="cursor:hand"
                   id="doValidatePwd" value="验证" />
          </td>
        </tr>
        <tr>
        	<jsp:include page="/npage/sm164/pwd_2.jsp">
	        <jsp:param name="width1" value="12%"  />
	        <jsp:param name="width2" value="38%"  />
	        <jsp:param name="pname" value="newpassword" />
	        <jsp:param name="pcname" value="cfmPwd" />
	        </jsp:include>
	        <jsp:include page="/npage/sm164/pwd_comm.jsp"/>
        </tr>
        <tr>
          <td class="Blue" width="15%">
              系统备注
          </td>
          <td colspan='3'>
              <input type="text" size="60" name="vSystemNote" id='vSystemNote' v_maxlength="60" v_type="string"
                     maxlength="60" index="9"
                     onblur="checkElement(this)" readonly>
        </tr>
        <tr>
          <td class="Blue" width="11%">用户备注</td>
          <td width="89%" colspan='3'>
          	<input type="text" size="60" name="vOpNote" id='vOpNote' v_maxlength="60" v_type="string" maxlength="60"
                     index="9" onblur="checkElement(this)">
          </td>
        </tr>
        <TR>
          <TD id="footer" align=center colspan='4'>
            <input class="b_foot" name="commitBut" id='commitBut' onmouseup="commitJsp()"
                   onKeyUp="if(event.keyCode==13)commitJsp()"
                   type=button value="确认&打印" disabled>
            <input class="b_foot" name="resetForm" type=button value="清除" onclick='formReset()'>
            <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value="关闭">
          </TD>
        </TR>
    	</table>
	    <%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>