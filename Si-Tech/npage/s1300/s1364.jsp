<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �˻�ת��1364
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<%
	String opCode="1364";
	String opName="�˻�ת��";
	String phoneno = (String)request.getParameter("activePhone");
	String orgCode = (String)session.getAttribute("orgCode");
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");
	String[] favStr = new String[favInfo.length];
  for(int i=0;i<favStr.length;i++) {
       favStr[i]=favInfo[i][0].trim();
	}
	  boolean pwrf = false;
    if(WtcUtil.haveStr(favStr,"a272")){
	  	pwrf=true;
	  }
	String sql_reason="select reason_node,reason_code from Sreasoncode where op_code='1364' and reason_class='1'  ";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������BOSS-�ʻ�ת��</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<!--
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
-->
<script language="JavaScript">
<!--
function loads()
{
	document.getElementById("groupId").style.display="none";
	document.getElementById("groupId").style.display="none";
	document.getElementById("reason_id").style.display="none";
}
function isKeyNumberdot(ifdot)
{
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0)
		if(s_keycode>=48 && s_keycode<=57)
			return true;
		else
			return false;
    else
    {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
		{
		      return true;
		}
		else if(s_keycode==45)
		{
		    rdShowMessageDialog('���������븺ֵ,����������!');
		    return false;
		}
		else
			  return false;
    }
}

function isNumberString (InString,RefString)
{
	if(InString.length==0) return (false);
	for (Count=0; Count < InString.length; Count++)  {
		TempChar= InString.substring (Count, Count+1);
		if (RefString.indexOf (TempChar, 0)==-1)
		return (false);
	}
	return (true);
}

function docheck()
{
	//xl add for һ����ԭ��
	var reason1 = document.all.reason1.value;
	var reason2 = document.all.reason2.value;
	var reason2_txt = document.all.otherReason.value;
	//alert("reason1 is "+reason1+" and reason2 is "+reason2+" and reason2_txt is "+reason2_txt);
	//xl add for һ����ԭ��
	var reason1 = document.all.reason1.value;
	var reason2 = document.all.reason2.value;
	var reason2_txt = document.all.otherReason.value;
	//alert("reason1 is "+reason1+" and reason2 is "+reason2);
	
	if(reason1=="0")
	{
		rdShowMessageDialog("��ѡ��ת��һ��ԭ��");
		return false;
	}	
	else if(reason2=="show" &&reason2_txt=="")
	{
		rdShowMessageDialog("������ת�˶���ԭ��");
		return false;
	}
	else if(reason2=="show" &&reason2_txt.length>64)
	{
		rdShowMessageDialog("ת�˶���ԭ�򳤶Ȳ��ɳ���64��");
		return false;
	}
	 
	
	
	if(form.phoneno.value==""){
		rdShowMessageDialog("�������ֻ����� !!")
		document.form.phoneno.focus();
		return false;
	}else if(form.contractno.value=="") {
		rdShowMessageDialog("�������ʺ� !!")
		document.form.contractno.focus();
		return false;
	}		/*HARVEST  wangmei xiugai ���ж��û������û�н��д�����˽����޸� 20060829*/


	else if (!checkPhone(form.phoneno.value) && form.contractno.value.length<5)
	{
		rdShowMessageDialog("<%=PhoneHeadErrMsg%>,��ֱ�������ʺ� !");
		return false;
	}
	else if (!form.accountpassword.disabled) {
	   if( form.accountpassword.value.length<1 || isNumberString(form.accountpassword.value,"1234567890")!=1 ) {
			rdShowMessageDialog("�������ʻ�����!!")
			document.form.accountpassword.focus();
			return false;
	   }else{
	      //document.form.action="s1362_select.jsp?reason1="+reason1+"&reason2_txt="+reason2_txt;
			document.form.action="s1364_select.jsp?reason1="+reason1+"&reason2_txt="+reason2_txt;
			form.submit();
			return true;
	   }
	} else {
		  document.form.action="s1364_select.jsp?reason1="+reason1+"&reason2_txt="+reason2_txt;
		  form.submit();
		  return true;
	 }
}
function getcount()
{

	if( form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1 ) {
		rdShowMessageDialog("������������,����Ϊ11λ���� !!")
		document.form.phoneno.focus();
		return false;
	}
	else if (parseInt(form.phoneno.value.substring(0,3),10)<134 || (parseInt(form.phoneno.value.substring(0,3),10)>139&&parseInt(form.phoneno.value.substring(0,2),10)!=15&&parseInt(form.phoneno.value.substring(0,2),10)!=18&&parseInt(form.phoneno.value.substring(0,2),10)!=14)){
		rdShowMessageDialog("������134-139����15��ͷ�ķ������ !!")
		document.form.phoneno.focus();
		return false;
	}
	else {
		var h=480;
		var w=850;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		if (document.form.busy_type.value=="1") {
			var str=window.showModalDialog('getCount.jsp?phoneNo='+document.form.phoneno.value,"",prop);
		}else
		{
			//add new 
			var str=window.showModalDialog('getCountdead_new.jsp?phoneNo='+document.form.phoneno.value,"",prop);
		}
		if(document.all.busy_type.value=="2")
		{
			//ʵ����У�� returnValue����һ��id_no
			checkSmz(str.split(",")[1]);
			//alert(str);
			if(document.getElementById("ifsmz").value!="1")
			{
				rdShowMessageDialog("��ʵ���Ʋ����԰���!");
				document.form.contractno.value="";
				document.form.sure.disabled=true;
				return false;
			}
			else
			{
				document.form.contractno.value=str.split(",")[0];
				document.form.sure.disabled=false;
			}
		}
		else
		{
			if( typeof(str) != "undefined" ){
				if (parseInt(str)==0){
					rdShowMessageDialog("û���ҵ���Ӧ���ʺţ�",0);
					document.form.phoneno.focus();
					return false;
				} else {
					document.form.contractno.value=str;
					if (!document.form.accountpassword.disabled) {
					   document.form.accountpassword.focus();
					}

					return true;
				}
				return true;
			}
		}
		
	}
}
function sel1()
 {
	document.all.phoneno.focus();
	document.all.busy_type.value = "1";
 }
function sel2()
 {
	document.all.phoneno.focus();
	document.all.busy_type.value = "2";
 }
function checkSmz(id_no)
{
	//alert("id_no is "+id_no);
	var myPacket = new AJAXPacket("s1362_checksmz.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("id_no",id_no);	
		core.ajax.sendPacket(myPacket,get_smz);
    myPacket=null;
}
function get_smz(packet)
{
	var s_flag1=packet.data.findValueByName("s_flag1");
//	alert("s_flag1 is "+s_flag1);
	document.getElementById("ifsmz").value=s_flag1;
}
 	//  add liuxmc
	function getZZDate(){
    
		var path = "<%= request.getContextPath()%>/npage/s1300/s1364_selectZZ.jsp";
		window.showModelessDialog(path);
	}	
	
	//  end 
//-->
//ԤԼ�����ѯ
function checkOrder()
{
	if(document.all.orderId.value=="")
	{
		rdShowMessageDialog("����������վԤԼ��ID����!");
		return false;
	}
	var myPacket = new AJAXPacket("s1364Order.jsp","�����ύ�����Ժ�......");
	myPacket.data.add("orderId",document.all.orderId.value);
	if (document.all.busy_type.value=="2")
	{
		myPacket.data.add("flag","2");//����
	}
	else
	{
		myPacket.data.add("flag","1");//����
	}
	
	core.ajax.sendPacket(myPacket);
    myPacket=null;
}
function doProcess(packet)
{
	var flag1 = packet.data.findValueByName("flag1");
	var custPhone= packet.data.findValueByName("custPhone");
	var custPass= packet.data.findValueByName("custPass");
	//alert("phone is "+custPhone+" and custPass is "+custPass+" and flag1 is  "+flag1);
	var phone_no2 = packet.data.findValueByName("phone_no2");
	var group_name = packet.data.findValueByName("groupName");
	if(flag1==0)
	{
		//alert("phone is "+custPhone+" and custPass is "+custPass);
		document.all.phoneno.value=custPhone;
		document.all.accountpassword.value=custPass;
		document.all.phone2.value=phone_no2;
		document.getElementById("groupId").style.display="block";
		document.getElementById("groupId").innerHTML="ԤԼ����Ӫҵ����"+group_name;
	}
	else if(flag1==1)
	{
		rdShowMessageDialog("�û���Ϣ������");
		return false;
	}
	else
	{
		rdShowMessageDialog("�û�������δѡ���Ӫҵ������ԤԼ��ԤԼ�ѹ���!");
		return false;
	}
}
</script>
</HEAD>
<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=sql_reason%>"/>
 	
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<BODY onload="loads()">
<FORM action="s1364_select.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" id="ifsmz" value="">
<input type="hidden" name="busy_type"  value="1">
<!--xl add ������ ת�˺���-->
<input type="hidden" name="phone2">
 
<table cellspacing="0">
    <tr> 
		<td  class="blue">ԤԼ����</td>
		<td  class="blue" colspan=2>
			<input type="text" name="orderId">
			ԤԼ����ID
			<input class="b_text" type=button onClick="checkOrder()" value="ԤԼ����">
		</td>
		<td><div id="groupId"></div></td> 
	</tr>
	<tr>
		<th>�û�����</th>
		<th>
			<input name="busyType" type="radio" onClick="sel1()" value="1" checked>
				�����û�
			<input name="busyType" type="radio" onClick="sel2()" value="2">
				�����û� </th>
		<th colspan="2">���ţ�<%=orgCode%></th>
	</tr>
	<tr>
		<td class="blue">�������</td>
		<td>
			<input type="text" name="phoneno" maxlength="11" onkeydown="if(event.keyCode==13)getcount()" onKeyPress="return isKeyNumberdot(0)">
			<input class="b_text" name=sure22 type=button value=��ѯ�ʺ� onClick="getcount();">
		</td>
		<td class="blue">�ʻ�����</td>
		<td>
			<input type="text" class="button" maxlength="20" onKeyPress="return isKeyNumberdot(0)" onkeydown="if(event.keyCode==13)document.form.accountpassword.focus()" name="contractno">
		</td>
	</tr>
	
	<tr>
		<td class="blue">�ʻ�����</td>
		<td colspan="3">
			<%if(pwrf) {%>
			<input type="password" class="button" name="accountpassword" size="20" maxlength="8" disabled>
			<% } else { %>
			<jsp:include page="/npage/common/pwd_1.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="accountpassword" />
				<jsp:param name="pwd" value="12345"  />
			</jsp:include>
			<%}%>
		</td>
	</tr>
	<!--  add liuxmc-->
	<!--xl add begin-->
	<tr id="tfyy">
		<td class="blue">��Ԥ���ԭ��</td>
		<td class="blue" colspan="3">			
			<select name="reason" style= "width:135px;" onChange="checkReason(this,reason_name,reason_code)">
				<option value="0" selected>---��ѡ��ת��ԭ��</option>
				<%for(int i=0; i<ret_val.length; i++)
					{%>
						<option value="<%=ret_val[i][1]%>"><%=ret_val[i][0]%></option>
				  <%}%>
			</select>
		</td>
	</tr>
	<tr id="reason_id">
		<td class="blue">����ԭ��</td>
		<td class="blue" colspan="3">			
			<input type="text" name="otherReason">
		</td>
	</tr>
	<!--xl add end-->
	<tr>
		<td colspan="4">
			<input class="b_text"  type=button value="��ѯ�����˻�ת����Ϣ" onClick="getZZDate();">
		</td>
	</tr>
	<!-- end -->
	<tr>
		<td align=center id="footer" colspan="4">
			<input class="b_foot" id="s_sure" name=sure type=button value=ȷ�� onclick="docheck()">
			&nbsp;
			<input class="b_foot" name=clear type=reset value=���>
			&nbsp;
			<input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
			&nbsp;
		</td>
	</tr>
</table>
<input type="hidden" name="reason1" value="0">
<input type="hidden" name="reason2">
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY>

</HTML>
<script language="javascript">
//����ȫ�ֱ���
  var reason_name = new Array();
  var reason_code = new Array();//where���� �� projectCode Ҫ��ѯ��ʾ���� fee
<%
	System.out.println("qweqwe1888888888888888888888888888881111111111111");
	if(ret_val.length >0){
		for(int m=0;m<ret_val.length;m++)
		  {
			out.println("reason_name["+m+"]='"+ret_val[m][0]+"';\n");
			out.println("reason_code["+m+" ]='"+ret_val[m][1]+"';\n");
		  }
	}
	else{
	System.out.println("qweqwe9888800000000000000000111");
	}

%> 
function checkReason(choose,NameArray,CodeArray)
{
	if(choose.value=="0")
	{
		rdShowMessageDialog("��ѡ���˷�ԭ��");
		return false;
	}
	document.all.otherReason.value="";
	//alert("1 "+choose+" 2 "+NameArray+" 3 "+CodeArray);
	for ( x = 0 ; x < CodeArray.length  ; x++ )
    {
	  //alert("CodeArray[x] is "+CodeArray[x]+" and choose.value is "+choose.value);
	  if ( CodeArray[x] == choose.value &&choose.value=="1009" )
	  {
		 document.getElementById("reason_id").style.display="block";
		 document.all.reason1.value=choose.value;
		 document.all.reason2.value="show";
	  }
	  else
	  {
		  document.getElementById("reason_id").style.display="none";
		  document.all.reason1.value=choose.value;
		  document.all.reason2.value="none";
	  }	
    }
	
}
</script>