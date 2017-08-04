<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:liutong@2008-8-18
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
        String opCode = "2327";
        String opName = "缴费(托收账号)";
        String workno = (String)session.getAttribute("workNo");
        String org_code = (String)session.getAttribute("orgCode");
        String workname = (String)session.getAttribute("workName");
        String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>
<HTML>
<HEAD>


<script language="JavaScript">
    <!--	
     
    var h=480;
    var w=650;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    
    function docheck()
    {
        if(document.frm.phoneNo.value=="")
        {
             rdShowMessageDialog("请输入服务号码!");
              document.frm.phoneNo.focus();
              return false;
        }
        
   
      if( document.frm.phoneNo.value.length != 11 )
        {
              rdShowMessageDialog("服务号码只能是11位!");
              document.frm.phoneNo.value = "";
              document.frm.phoneNo.focus();
              return false;
        }
	
	  var checkPwd_Packet = new AJAXPacket("../s1300/pubCheckPwd_new.jsp","正在进行密码校验，请稍候......");
	  checkPwd_Packet.data.add("phone_no",document.frm.phoneNo.value);
	  checkPwd_Packet.data.add("qry_flag","2");//托收查询
	  core.ajax.sendPacket(checkPwd_Packet);
	  checkPwd_Packet=null;	
	 } 
    function doProcess(packet)
	{
		var retResult   = packet.data.findValueByName("retResult");
		var s_sm_code   = packet.data.findValueByName("s_sm_code");
		if(retResult=="0")
		{
			if(s_sm_code=="PB")
			{
				rdShowMessageDialog("物联网用户不允许账号缴费!");
				return false;
			}
			else
			{
				 if(!querylast()){
					return false;       	
				   };
				   
				   document.frm.action="s1300Cfm.jsp";
				   document.frm.query.disabled=true;
				   document.frm.return1.disabled=true;
				   document.frm.return2.disabled=true;
				   document.frm.submit();
			}
		}
		else
		{
			rdShowMessageDialog("用户账户信息不存在!");
			return false;
		}
	}

     function sel1() {
                window.location.href='s1300.jsp';
     }
    
     function sel2(){
               window.location.href='s1300_2.jsp';
     }
    
     function sel3() {
               window.location.href='s1300_3.jsp';
     }
    
     function sel4() {
               window.location.href='s1300_4.jsp';
     }
     function sel5() {
               window.location.href='s1300_5.jsp';
     }
    function sel6() {
    window.location.href='s1300_v.jsp';
 }
     function doclear() {
                 frm.reset();
     }
    
    
    function querylast()
    {
        var opcode = document.all.op_code.value;
        var returnValue="-1";
        if(frm.phoneNo.value.length<11  )
        {
             rdShowMessageDialog("请输入正确的服务号码！");
             document.frm.phoneNo.focus();
             return false;
        }
         returnValue = window.showModalDialog('getCountCon.jsp?phoneNo='+document.frm.phoneNo.value,"",prop);
  
        if(returnValue==null)
         {
                rdShowMessageDialog("没有找到对应的帐号！");
                document.frm.phoneNo.focus();
                return false;
          }
          if(returnValue=="")
         {
                rdShowMessageDialog("你没有选择帐号！");
                document.frm.phoneNo.focus();
                return false;
          }
        document.frm.contractno.value = returnValue;   


        return true;
    }
    
    
    -->
</script>

<title>黑龙江BOSS-普通缴费</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<form action="" method="post" name="frm">
    <input type="hidden" name="busy_type" value="5">
    <input type="hidden" name="op_code" value="2327">
    <input type="hidden" name="totaldate" value="<%=dateStr1%>">
    <input type="hidden" name="yearmonth" value="<%=dateStr%>">
    <input type="hidden" name="billdate" value="<%=dateStr.substring(0,6)%>">
    <input type="hidden" name="water_number">


    <%@ include file="/npage/include/header.jsp" %>

    <div class="title">
        <div id="title_zi">请选择缴费方式</div>
    </div>

    <table cellspacing="0">
        <tbody>
            <tr>
                <td width="15%" class="blue">缴费方式</td>
                <td colspan="4">
                	<q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel1()" value="1">
                    服务号码
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType2" type="radio" onClick="sel2()" value="2">
                    帐户号码
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType5" type="radio" onClick="sel5()" value="5" checked>
                    托收用户交费
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType3" type="radio" onClick="sel3()" value="3">
                    托收单
                  </q>
				   	
                    <!--<input name="busyType4" type="radio" onClick="sel4()" value="4"  >付费号码-->
                </td>
            </tr>
        </tbody>
    </table>
    <table cellspacing="0">
        <tr>
            <td nowrap width="15%" class="blue">服务号码</td>
            <td>
                <input type="text" name="phoneNo" size="20" maxlength="11" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) docheck();">
            </td>
            <td class="blue">帐户号码</td>
            <td>
                <input type="text" name="contractno" size="20" maxlength="20" Class="InputGrey" readOnly>
            </td>
        </tr>
    </table>
    <TABLE cellspacing="0">
        <TR>
            <TD noWrap align="centre" id="footer">
                <input type="button" name="query" class="b_foot" value="查询" onclick="docheck()">
                &nbsp;
                <input type="button" name="return1" class="b_foot" value="清除" onclick="doclear()">
                &nbsp;
                <input type="button" name="return2" class="b_foot" value="关闭" onClick="parent.removeTab('<%=opCode%>')">
            </TD>
        </TR>
    </TABLE>
      
	<%@ include file="/npage/include/footer_simple.jsp"%>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
</BODY>
</HTML>