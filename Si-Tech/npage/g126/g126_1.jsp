<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-19 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "g126";
	String opName = "��ͨ�����վ�";
	String belongName = (String) session.getAttribute("orgCode");
	//String phoneNo = activePhone;
	String op_code = "g126";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.add(Calendar.MONTH, -1);
	String mon = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
%>

<HTML>
<HEAD><TITLE>������BOSS-�����վ�</TITLE>
    <META content="text/html; charset=gb2312" http-equiv=Content-Type>
    <script language="JavaScript">
         // xl add for ��ѯ�������
		function getPhoneKd()
		{
			if(document.form.phoneno.value==""){
				rdShowMessageDialog("������벻��Ϊ��!");
				document.form.phoneno.focus();
				return false;
			}
			document.getElementById("cfmid").value=document.form.phoneno.value;
			var myPacket = new AJAXPacket("getKdNo_new.jsp","���ڲ�ѯ�ͻ������Ժ�......");
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
            /* HARVEST  wangmei ������ȥ������Ҫ���ڴ�������ʱ���� ��ҵ��Ϣ���ĺ�����2��ͷ����û�й��� ���ȥ�������� 20060914
            else if(parseInt(form.phoneno.value.substring(0,3),10)<134 || (parseInt(form.phoneno.value.substring(0,3),10)>139&&parseInt(form.phoneno.value.substring(0,3),10)<159)||parseInt(form.phoneno.value.substring(0,3),10)>159)
            {rdShowMessageDialog("������134-139 ��159 ֮��ķ�����룡");
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
                rdShowMessageDialog("��������ȷ�Ŀ�ʼ�·ݣ�");
                document.form.beginym.focus();
                return false;
            }else if (form.endym.value.length < 6){
                rdShowMessageDialog("��������ȷ�Ľ����·ݣ�");
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
									rdShowMessageDialog("��û��ѡ���˺�!");
									return false;
								}
								
								if(str==null||str==""){
										rdShowMessageDialog("��û��ѡ���˺�!");
										return false;										
								}
								
                if (typeof(str) != "undefined") {
                    if (parseInt(str) == 0) {
                        rdShowMessageDialog("û���ҵ���Ӧ���ʺţ�");
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
        <div id="title_zi">��ͨ�����վ�</div>
    </div>
    <table cellspacing="0">
        <tbody>
            <tr>
                <td width="13%" class="blue">ҵ������</td>
                <td width="37%"><font class="orange">��ͨ����Ʊ</font></td>
                <td width="13%" class="blue">����</td>
                <td width="37%"><%=belongName%>
                </td>
            </tr>
            <tr>
                <td class="blue"> �������</td>
                <td>
				<input type="hidden" id="cfmid" name="cfmname"  >
                    <input type="text" name="phoneno" id="phoneNo"   >
                </td>
                <td class="blue"> �·�����</td>
                <td>
                    <input type="text" name="beginym" maxlength="6" v_format="yyyyMM" size="8" value="<%=mon%>" class="button" onKeyDown="if(event.keyCode==13)form.endym.focus()" onKeyPress="return isKeyNumberdot(0)">~
                    <input type="text" name="endym" maxlength="6" v_format="yyyyMM" size="8" value="<%=dateStr%>" class="button" onKeyDown="if(event.keyCode==13)docheck()" onKeyPress="return isKeyNumberdot(0)">
                    &nbsp;
                    <input class="b_text" name=sure22 type=button value=��ѯ onClick="getPhoneKd();">
                </td>
            </tr>
            <tr>
                <td class="blue">�ʻ�����</td>
                <td>
                    <input type="text" readonly name="contractno" class="InputGrey">
                </td>
                <td class="blue">����״̬</td>
                <td>
                    <input type="text" readonly name="textfield9" class="InputGrey">
                </td>
            </tr>
            <tr>
                <td class="blue">�ͻ�����</td>
                <td>
                    <input type="text" readonly name="textfield7" class="InputGrey">
                </td>
                <td class="blue">�ͻ���ַ</td>
                <td>
                    <input type="text" readonly name="textfield8" class="InputGrey">
                </td>
            </tr>
            <tr>
                <td class="blue">��ǰԤ��</td>
                <td>
                    <input type="text" readonly name="textfield1" class="InputGrey">
                </td>
                <td class="blue">��ǰǷ��</td>
                <td>
                    <input type="text" readonly name="textfield2" class="InputGrey">
                </td>
            </tr>
    </table>
    <table cellspacing="0">
        <tbody>
            <tr>
                <td id="footer">
                    <input class="b_foot" name=sure type="button" value=ȷ�� onclick="docheck()">
                    &nbsp;
                    <input class="b_foot" name=clear type=reset value=���>
                    &nbsp;
                    <input class="b_foot" name=reset type=button value=�ر� onClick="parent.removeTab('<%=opCode%>')">
                </td>
            </tr>
        </tbody>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
