<%
/********************
version v1.0
开发商: si-tech
add by zhangleij
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%@ page import="java.text.*"%>

<%

    String getopCode=request.getParameter("opCode");
    String getopName=request.getParameter("opName");
    System.out.println("-----------getopCode="+getopCode);
    System.out.println("-----------getopName="+getopName);
    String opCode="zgap";
    String opName="托收用户明细查询";
  	String workNo =  (String)session.getAttribute("workNo");
  	String workname = (String)session.getAttribute("workName");
    String belongName = (String)session.getAttribute("orgCode");
    String regionCode = belongName.substring(0,2);
    
        
  	Date date = new Date();
    String todayyearmonth = new java.text.SimpleDateFormat("yyyyMM").format(date);
    
%>
<HEAD>
<TITLE>黑龙江BOSS-明细帐单查询</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<script language="JavaScript" src="/npage/s1300/common_1300.js"></script>

<script language="JavaScript">

function docheck() {
    var todayym = "<%=todayyearmonth%>";
    var billym = document.form.bill_ym.value;
    var todaymonth = parseInt(todayym.substring(0,4)*12) + parseInt(todayym.substring(4,6));
    var billmonth = parseInt(billym.substring(0,4)*12) + parseInt(billym.substring(4,6));
    
 if (document.form.contract_no.value.length == 0) {
    rdShowMessageDialog("合同号不可为空！");
    return false;
  } else if (document.form.contract_no.value.length < 11){
    rdShowMessageDialog("合同号不能小于11位！");
    return false;
  }

  if (isValidYYYYMM(document.form.bill_ym.value) != 0) {
        rdShowMessageDialog("出账年月格式不对! <br>应为：YYYYMM ");
      document.form.bill_ym.focus();
      return false;
  }
  
  if (billym > todayym) {
        rdShowMessageDialog("出账年月不能大于当前年月! ");
      document.form.bill_ym.focus();
      return false;
  }
  
  if (todaymonth - billmonth > 5) {
        rdShowMessageDialog("出账年月不能早于当前年月前五个月! ");
      document.form.bill_ym.focus();
      return false;
  }
  
  if (document.form.con_pwd.value.length == 0) {
    rdShowMessageDialog("密码不可为空！");
    return false;
  } else if (document.form.con_pwd.value.length < 6){
    rdShowMessageDialog("密码不能小于6位！");
    return false;
  }

 	checkConPwd();
        
}

function checkConPwd() {
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
		checkPwd_Packet.data.add("custType", "03");						//01:手机号码 02 客户密码校验 03帐户密码校验
		checkPwd_Packet.data.add("phoneNo", document.form.contract_no.value);		//移动号码,客户id,帐户id
		checkPwd_Packet.data.add("custPaswd", document.form.con_pwd.value);			//用户.客户.帐户密码
		checkPwd_Packet.data.add("idType", "");							//en 密码为密文，其它情况 密码为明文
		checkPwd_Packet.data.add("idNum", "");							//传空
		checkPwd_Packet.data.add("loginNo", "<%=workNo%>"); //工号
		core.ajax.sendPacket(checkPwd_Packet, doSubmit);
		checkPwd_Packet=null;
}

function doSubmit(packet) 
{
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog(" 密码校验失败! ");
			document.form.con_pwd.value = "";
      return false;
		} 
		else 
		{
			 form.submit();
		}
}

</script>

</HEAD>
<BODY>
    <FORM action="zgap_2.jsp" method=post name="form">
        <%@ include file="/npage/include/header.jsp"%>
        <div class="title">
            <div id="title_zi">托收用户明细查询</div>
        </div>
        <table cellspacing="0">
            <tr>
                <td class="blue" width="8%" align="right">合同号</td>
                <td width="18%"><input type="text" name="contract_no" maxlength="20" class="button"
                    onKeyPress="return isKeyNumberdot(0)"> <font class="orange"> *</font></td>
                <td class="blue" width="8%" align="right">密码</td>
                <td width="18%"><input type="password" name="con_pwd" maxlength="6" class="button"
                    onKeyPress="return isKeyNumberdot(0)"> <font class="orange"> *</font></td>
                <td class="blue" width="8%" align="right">出账年月</td>
                <td width="40%"><input type="text" name="bill_ym" value="<%=todayyearmonth%>" maxlength="6"
                    class="button" onKeyPress="return isKeyNumberdot(0)"> <font class="orange"> *
                        可查询当前月及前五个月的托收用户明细信息</font></td>
            </tr>
        </table>

        <table width="100%" border=0 align=center cellpadding="4" cellspacing=1>
            <tbody>
                <tr>
                    <td align=center width="100%" id="footer"><input class="b_foot" name=sure type="button"
                        value="查询" onclick="docheck()"> &nbsp; <input class="b_foot" name=reset type=reset
                        value="关闭" onclick="removeCurrentTab()"></td>
                </tr>
            </tbody>
        </table>
        <%@ include file="/npage/include/footer_simple.jsp"%>
    </FORM>
</BODY>
</HTML>
