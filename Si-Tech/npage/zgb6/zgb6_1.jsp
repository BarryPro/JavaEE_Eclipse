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
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
<%
	String opCode="zgb6";
	String opName="�ʻ�ת��(��ʵ��)";
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
	Date date = new Date();//��ȡ��ǰʱ��  
	Calendar calendar = Calendar.getInstance();  
	calendar.setTime(date);  
	calendar.add(Calendar.YEAR,0);//��ǰʱ���ȥһ�꣬��һ��ǰ��ʱ��  
	calendar.add(Calendar.MONTH,0);//��ǰʱ��ǰȥһ���£���һ����ǰ��ʱ��  
	calendar.getTime();//��ȡһ��ǰ��ʱ�䣬����һ����ǰ��ʱ�� 
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(calendar.getTime());
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>�ʻ�ת��(��ʵ��)</TITLE>
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
	else if (!form.cus_pass.disabled) {
	   if( form.cus_pass.value.length<1 || isNumberString(form.cus_pass.value,"1234567890")!=1 ) {
			rdShowMessageDialog("�������ʻ�����!!")
			document.form.cus_pass.focus();
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
	//xl add for һ����ԭ��
	/*
	var reason1 = document.all.reason1.value;
	var reason2 = document.all.reason2.value;
	var reason2_txt = document.all.otherReason.value;
	var reason1 = document.all.reason1.value;
	var reason2 = document.all.reason2.value;
	var reason2_txt = document.all.otherReason.value;
	 	
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
	}/**/
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
		var returnValue=window.showModalDialog('../zgb5/getCountdead.jsp?phoneNo='+document.form.phoneno.value,"",prop);
		//alert(returnValue);
		if( typeof(returnValue) != "undefined" ){
			if (parseInt(returnValue)==0){
		   		rdShowMessageDialog("û���ҵ���Ӧ���ʺţ�",0);
		   		document.form.phoneno.focus();
		   		return false;
			} else {
				document.form.contractno.value = returnValue.split(",")[0];
				document.form.user_passwd.value = returnValue.split(",")[1];
				document.form.s_id_no.value = returnValue.split(",")[2];
				document.form.khsj.value=returnValue.split(",")[3];
				document.form.cust_name.value=returnValue.split(",")[4];
				 

		   		checkSzm(document.form.user_passwd.value,document.form.s_id_no.value);
			}
			return true;
		}
		else
		{
			rdShowMessageDialog("��ѯ��Ϣ������!");
			return false;
		}		
	}
}

function checkSzm(u_pass,id_no)
{
	
	var myPacket = new AJAXPacket("../zgb5/checkSMZ.jsp","�����ύ�����Ժ�......");
	myPacket.data.add("u_pass",u_pass);
	myPacket.data.add("phoneno",document.all.phoneno.value);
	//document.all.cus_pass.value
	myPacket.data.add("in_pass",document.all.cus_pass.value);	//���������
	myPacket.data.add("id_no",id_no);
	//alert("��ѯ������u_pass is "+u_pass+" and id_no is "+id_no+" ��������� in_pass is "+document.all.cus_pass.value);
	//alert("u_pass is "+u_pass+" and in_pass is "+document.all.cus_pass.value);
	core.ajax.sendPacket(myPacket,checkKd);
    myPacket=null;
}
function checkKd(packet)
{
	  var s_flag_mm=packet.data.findValueByName("s_flag_mm");//�ж�����
	  var s_flag_smz = packet.data.findValueByName("s_flag_smz");//�ж�ʵ����
	 // alert("s_flag_mm1 is "+s_flag_mm+" and s_flag_smz is "+s_flag_smz);
	  //s_flag_smz="Y";
	  var phoneno = document.all.phoneno.value;
	  var contractno = document.all.contractno.value;
	  var begin_ym = document.all.begin_ym.value;//���ֵҪ�� �ĳ�ȡС��ֵ
	  var end_ym = document.all.end_ym.value;    //���ֵҪ�� �ĳ�ȡС��ֵ
	  if(s_flag_mm=="Y")
	  {
		  if(s_flag_smz=="Y")//���ü�������У��ͨ��
		  {
			 //��ת���µ�jsp չʾ����ʱ�䡢sim���š��ͻ����������Ѽ�¼����1���еķ��񣩡��ͻ��Ƿ�����˽��ѷ�Ʊ���
			 //��ӪҵԱ��ʾ�ͻ���ѡ����һ��û������Ӧ���ϵͳ��У�飬У��ͨ���ſ��Խ�������ҳ��
			 //document.form.action="zgb5_select.jsp";
			 //form.submit();
			 document.form.action="zgb6_check.jsp?phoneNo="+phoneno+"&contractNo="+contractno+"&begin_ym"+begin_ym+"&end_ym="+end_ym+"&rwsj="+document.form.khsj.value+"&id_no="+document.form.s_id_no.value+"&user_passwd="+document.form.user_passwd.value;
			 form.submit();
		  }
		  else
		  {
				rdShowMessageDialog("׼ʵ���ͷ�ʵ���û��ſ��԰���˹���!");
				return false;
		  }	
	  }	
	  else
	  {
		  rdShowMessageDialog("��������ȷ���û������ſ��԰���˹���!");
		  return false;
	  }	
	  
} 
function sel2()
 {
	document.all.phoneno.focus();
	document.all.busy_type.value = "2";
 }
 
 	//  add liuxmc
	function getZZDate(){
    
		var path = "<%= request.getContextPath()%>/npage/s1300/s1364_selectZZ.jsp";
		window.showModelessDialog(path);
	}	
	
	//  end 
//--> 
</script>
</HEAD>
<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=sql_reason%>"/>
 	
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<BODY  >
<FORM action="s1364_select.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="busy_type"  value="2">
<!--xl add ������ ת�˺���-->
<input type="hidden" name="phone2">
 <input type="hidden" name="s_id_no">
<input type="hidden" name="user_passwd">
<input type="hidden" name="cust_name"   >
<input type="hidden" name="khsj" >
<input type="hidden" name="end_ym" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)">
<input type="hidden" name="begin_ym" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)">
	
<table cellspacing="0">
    
	<tr>
		<th>�û�����</th>
		<th>
			 
			<input name="busyType" type="radio" onClick="sel2()" checked value="2">
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
			<input type="text" class="button" maxlength="20" onKeyPress="return isKeyNumberdot(0)" onkeydown="if(event.keyCode==13)document.form.cus_pass.focus()" name="contractno">
		</td>
	</tr>
	
	<tr>
		<td class="blue">�ʻ�����</td>
		<td colspan="3">
			 
			<jsp:include page="/npage/common/pwd_one.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="cus_pass"  />
				<jsp:param name="pwd" value="12345"  />
			</jsp:include>
		</td>
	</tr>
	<!--  add liuxmc-->
	<!--xl add begin-->
	<tr id="tfyy">
		<td class="blue">��Ԥ���ԭ��</td>
		<td class="blue" colspan="3">			
			<select name="reason" style= "width:135px;" onChange="checkReason(this,reason_name,reason_code)">
				<option value="1" selected>ǿ������ת��</option>
			</select>
		</td>
	</tr>
	 
	<!--xl add end-->
	<tr>
		<td colspan="4">
			<input class="b_text"  type=button value="��ѯ�����˻�ת����Ϣ" onClick="getZZDate();">
		</td>
	</tr>
	<!-- end
	<tr>
		<td align=center id="footer" colspan="4">
			<input class="b_foot" name=sure type=button value=ȷ�� onclick="docheck()">
			&nbsp;
			<input class="b_foot" name=clear type=reset value=���>
			&nbsp;
			<input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
			&nbsp;
		</td>
	</tr> -->
</table>
<input type="hidden" name="reason1" value="1">
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