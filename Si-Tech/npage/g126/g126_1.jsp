<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-19 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "g126";
	String opName = "铁通补打收据";
	String belongName = (String) session.getAttribute("orgCode");
	//String phoneNo = activePhone;
	String op_code = "g126";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.add(Calendar.MONTH, -1);
	String mon = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
%>

<HTML>
<HEAD><TITLE>黑龙江BOSS-补打收据</TITLE>
    <META content="text/html; charset=gb2312" http-equiv=Content-Type>
    <script language="JavaScript">
         // xl add for 查询宽带号码
		function getPhoneKd()
		{
			if(document.form.phoneno.value==""){
				rdShowMessageDialog("宽带号码不能为空!");
				document.form.phoneno.focus();
				return false;
			}
			document.getElementById("cfmid").value=document.form.phoneno.value;
			var myPacket = new AJAXPacket("getKdNo_new.jsp","正在查询客户，请稍候......");
				myPacket.data.add("contractNo",(document.all.phoneno.value).trim());
				myPacket.data.add("busyType",1);
				myPacket.data.add("return_page","g126_1.jsp");
				core.ajax.sendPacket(myPacket);
				myPacket=null;
		}
		function doProcess(packet)
		{
			 
			//alert("1");
			var contract_new=packet.data.findValueByName("contract_out");
			var phone_new=packet.data.findValueByName("phone_new"); 
			//alert("2 "+phone_new);
			document.all.contractno.value=contract_new;
			document.getElementById("phoneNo").value= phone_new;
			//alert("contract_new is "+contract_new);
			//rdShowMessageDialog("test phone_new is "+phone_new);
			//alert("no is "+phone_new);
			docheck(); 
		}
		<!--
        
        function docheck()
        {
            /* HARVEST  wangmei 把限制去掉，主要是在处理申告的时候发现 企业信息机的号码是2开头的且没有规律 因此去掉次条件 20060914
            else if(parseInt(form.phoneno.value.substring(0,3),10)<134 || (parseInt(form.phoneno.value.substring(0,3),10)>139&&parseInt(form.phoneno.value.substring(0,3),10)<159)||parseInt(form.phoneno.value.substring(0,3),10)>159)
            {rdShowMessageDialog("请输入134-139 和159 之间的服务号码！");
                document.form.phoneno.focus();
                return false;
                }
            */
            
            if(!forDate(document.all.beginym)){
            	return false;	
            }
            
            if(!forDate(document.all.endym)){
            	return false;	
            }
            
            if (form.beginym.value.length < 6){
                rdShowMessageDialog("请输入正确的开始月份！");
                document.form.beginym.focus();
                return false;
            }else if (form.endym.value.length < 6){
                rdShowMessageDialog("请输入正确的结束月份！");
                document.form.endym.focus();
                return false;
            }else {
var h=480;
var w=650;
var t=screen.availHeight/2-h/2;
var l=screen.availWidth/2-w/2;
var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
                var str = window.showModalDialog('getCount.jsp?phoneNo='+ document.getElementById("phoneNo").value, "", prop);
				//alert("str is "+str);
								if(typeof(str) == "undefined"){
									rdShowMessageDialog("你没有选择账号!");
									return false;
								}
								
								if(str==null||str==""){
										rdShowMessageDialog("你没有选择账号!");
										return false;										
								}
								
                if (typeof(str) != "undefined") {
                    if (parseInt(str) == 0) {
                        rdShowMessageDialog("没有找到对应的帐号！");
                        return false;
                    }else {
                        document.form.contractno.value = str;
                        document.form.action = "g059_select.jsp";
                        form.submit();
                    }
                }
                return true;
            }
        }
        //-->
    </script>
</HEAD>
<BODY>
<FORM action=" " method=post name=form>

    <%@ include file="/npage/include/header.jsp" %>
    <div class="title">
        <div id="title_zi">铁通补打收据</div>
    </div>
    <table cellspacing="0">
        <tbody>
            <tr>
                <td width="13%" class="blue">业务类型</td>
                <td width="37%"><font class="orange">铁通补打发票</font></td>
                <td width="13%" class="blue">部门</td>
                <td width="37%"><%=belongName%>
                </td>
            </tr>
            <tr>
                <td class="blue"> 服务号码</td>
                <td>
				<input type="hidden" id="cfmid" name="cfmname"  >
                    <input type="text" name="phoneno" id="phoneNo"   >
                </td>
                <td class="blue"> 月份区间</td>
                <td>
                    <input type="text" name="beginym" maxlength="6" v_format="yyyyMM" size="8" value="<%=mon%>" class="button" onKeyDown="if(event.keyCode==13)form.endym.focus()" onKeyPress="return isKeyNumberdot(0)">~
                    <input type="text" name="endym" maxlength="6" v_format="yyyyMM" size="8" value="<%=dateStr%>" class="button" onKeyDown="if(event.keyCode==13)docheck()" onKeyPress="return isKeyNumberdot(0)">
                    &nbsp;
                    <input class="b_text" name=sure22 type=button value=查询 onClick="getPhoneKd();">
                </td>
            </tr>
            <tr>
                <td class="blue">帐户号码</td>
                <td>
                    <input type="text" readonly name="contractno" class="InputGrey">
                </td>
                <td class="blue">运行状态</td>
                <td>
                    <input type="text" readonly name="textfield9" class="InputGrey">
                </td>
            </tr>
            <tr>
                <td class="blue">客户名称</td>
                <td>
                    <input type="text" readonly name="textfield7" class="InputGrey">
                </td>
                <td class="blue">客户地址</td>
                <td>
                    <input type="text" readonly name="textfield8" class="InputGrey">
                </td>
            </tr>
            <tr>
                <td class="blue">当前预存</td>
                <td>
                    <input type="text" readonly name="textfield1" class="InputGrey">
                </td>
                <td class="blue">当前欠费</td>
                <td>
                    <input type="text" readonly name="textfield2" class="InputGrey">
                </td>
            </tr>
    </table>
    <table cellspacing="0">
        <tbody>
            <tr>
                <td id="footer">
                    <input class="b_foot" name=sure type="button" value=确认 onclick="docheck()">
                    &nbsp;
                    <input class="b_foot" name=clear type=reset value=清除>
                    &nbsp;
                    <input class="b_foot" name=reset type=button value=关闭 onClick="parent.removeTab('<%=opCode%>')">
                </td>
            </tr>
        </tbody>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
