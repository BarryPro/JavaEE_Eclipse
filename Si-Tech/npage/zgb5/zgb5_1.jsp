<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��Ԥ���1362
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
	
<%
 	String opCode="zgb5";
	String opName=request.getParameter("opName");
	String flag="";
	String flag1="";
	if(opCode.equals("zgb5")){
		flag="checked";
	}else{
		flag1="checked";
	}
	String phoneNo = (String)request.getParameter("activePhone");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
  	//String pwrf1="Y";
    String pwrf1="";
    /*
	Date date = new Date();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMM");
    java.util.Date sourceDate = sdf.parse(dateStr);
	
	Calendar cal = Calendar.getInstance();
	cal.setTime(sourceDate);
	cal.add(Calendar.YEAR,addYear);
	cal.add(Calendar.MONTH, addMonth);
	cal.add(Calendar.DATE, addDate); 
	java.text.SimpleDateFormat returnSdf = new java.text.SimpleDateFormat("yyyyMM");
	String dateTmp = returnSdf.format(calendar.getTime());
	java.util.Date returnDate = returnSdf.parse(dateTmp);*/

	/*
	DateFormat df = new SimpleDateFormat("yyyyMMdd");   
	String now = df.format(date);
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	*/
	Date date = new Date();//��ȡ��ǰʱ��  
	Calendar calendar = Calendar.getInstance();  
	calendar.setTime(date);  
	calendar.add(Calendar.YEAR,0);//��ǰʱ���ȥһ�꣬��һ��ǰ��ʱ��  
	calendar.add(Calendar.MONTH,0);//��ǰʱ��ǰȥһ���£���һ����ǰ��ʱ��  
	calendar.getTime();//��ȡһ��ǰ��ʱ�䣬����һ����ǰ��ʱ�� 
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(calendar.getTime());
	//ǰһ��
	Calendar calendar1 = Calendar.getInstance();  
	calendar1.setTime(date);  
	calendar1.add(Calendar.YEAR, -1);//��ǰʱ���ȥһ�꣬��һ��ǰ��ʱ��  
	calendar1.add(Calendar.MONTH,0);//��ǰʱ��ǰȥһ���£���һ����ǰ��ʱ��  
	calendar1.getTime();//��ȡһ��ǰ��ʱ�䣬����һ����ǰ��ʱ�� 
	String dateStr1 = new java.text.SimpleDateFormat("yyyyMM").format(calendar1.getTime());
	
%>
 
	<jsp:param name="opCode" value="zgb5"  />
	<jsp:param name="opName" value="��Ԥ���(��ʵ��)"  />
	</jsp:include>	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>������BOSS-��Ԥ���</title>
	<META content="text/html; charset=gbk" http-equiv=Content-Type>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
</head>
 
<body onLoad="form_load();">
<form action="" method="post" name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="busy_type"  value="2">
	<input type="hidden" name="cust_name"   >
	<div class="title">
		<div id="title_zi">ѡ���û�����</div>
	</div>
<table cellspacing="0" >
	 
	<tr> 
		<th>��������</th>
		<th>
			<input name="busytype" type="radio" onClick="sel1()" value="2" <%=flag%>>
			�����û���Ԥ��
			 
		</th>
		<th colspan="2">���ţ�<%=orgCode%> </th>
	</tr>
	<tr> 
		<td class="blue">�������</td>
		<td> 
			<input type="text" name="phoneno"   onKeyDown="if(event.keyCode==13)docheck()" onKeyPress="return isKeyNumberdot(0)">
		</td>
		<td class="blue">�û�����</td>
		<td>
			<jsp:include page="/npage/common/pwd_one.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="cus_pass"  />
				<jsp:param name="pwd" value="12345"  />
			</jsp:include>
			<input class="b_text" type=button value="��ѯ" onClick="docheck();">
		</td>
	</tr>
	<tr> 
		<td class="blue">�ʻ�����</td>
		<td> 
			<input type="text" name="contractno" maxlength="20" class="button"  onkeydown="if(event.keyCode==13)docheck()" onKeyPress="return isKeyNumberdot(0)">
		</td>
		<td class="blue">����ʱ��</td>
		<td>
			<input type="text" name="khsj" class="InputGrey" readonly>
		</td>
	</tr>
	<!--
	<tr> 
		<td class="blue">����Ԥ���� </td>
		<td> 
			<input type="text" name="textfield3" class="InputGrey" readonly>
		</td>
		<td class="blue">��Ƿ�� </td>
		<td> 
			<input type="text" name="textfield2" class="InputGrey" readonly>
		</td>
	</tr>
	-->
	<input type="hidden" name="end_ym" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)">
	<input type="hidden" name="begin_ym" value="<%=dateStr%>"  onKeyPress="return isKeyNumberdot(0)">
	<!--	
	<tr> 
		<td class="blue"> ��ѯ�ɷѼ�¼��ʼ����(YYYYMM)</td>

		<td>
			</td>
		<td class="blue">��ѯ�ɷѼ�¼��������(YYYYMM)</td>
		<td> 
			
		</td>
	</tr> 
	-->
</table>
<input type="hidden" name="ifKdNo" value="N">
<input type="hidden" name="reason1" value="0">
<input type="hidden" name="reason2">
<input type="hidden" name="s_id_no">
<input type="hidden" name="user_passwd">
	<%@ include file="/npage/include/footer_simple.jsp" %>
	<%@ include file="../../npage/common/pwd_comm.jsp" %>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
</form>
</body>
 <script language="JavaScript">  
 

 
<!--
function form_load(){
	sel1();
}
function sel1()
 {
	document.all.phoneno.focus();
	document.all.busy_type.value = "2";
 	document.all.opCode.value ="zgb5";
 	document.all.opName.value ="��Ԥ���(��ʵ��)";
 }
 
 
 
 


function docheck()
{
	
	
	//checkSMZ();//�ж�ʵ������Ϣ �����Ҫid_no �ŵ�����ȥУ��
	var busy_type=document.all.busy_type.value;
	//alert(busy_type);
	if(form.phoneno.value.length<11 )
	{
		rdShowMessageDialog("������������,����Ϊ11λ���� !!")
		document.form.phoneno.focus();
		return false;
	}
  /*
   if ((parseInt(form.phoneno.value.substring(0,3),10)<134) || (parseInt(form.phoneno.value.substring(0,3),10)>139 && parseInt(form.phoneno.value.substring(0,2),10)!=15))
	{
		rdShowMessageDialog("������134-139��15X��ͷ�ķ������ !!")
		document.form.phoneno.focus();
		return false;
	 }
	 */
	//���� �ǿ�У��
	if(document.all.cus_pass.value=="")
	{
		rdShowMessageDialog("�������û�����!")
		document.form.cus_pass.focus();
		return false;
	}	

	var returnValue;
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
     
	returnValue =window.showModalDialog('getCountdead.jsp?phoneNo='+document.form.phoneno.value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf1%>',"",prop);
	//alert("returnValue is "+returnValue);
	
	if(returnValue=="undefined")
	{
		rdShowMessageDialog("��ѡ���˺���Ϣ!");
		document.form.phoneno.focus();
		return false;
	}
	else
	{
		//��Ϊ��������ֵ �������� �˺� ���� �� id_no user_passwd s_id_no
		document.form.contractno.value = returnValue.split(",")[0];
		document.form.user_passwd.value = returnValue.split(",")[1];
		document.form.s_id_no.value = returnValue.split(",")[2];
		document.form.khsj.value=returnValue.split(",")[3];
		document.form.cust_name.value=returnValue.split(",")[4];
		//ʱ��У�� begin
		var begin_ym = document.all.begin_ym.value;
		var end_ym = document.all.end_ym.value;
		var khsj = document.all.khsj.value;
		 
	//	alert("s_y is "+s_y+" and khsj is "+khsj+" and y is "+y);
		//end ʱ��У��
	//	alert("document.form.contractno.value is "+document.form.contractno.value);
		
		if(document.form.contractno.value=='0')
		 {
			rdShowMessageDialog("�ʺŻ��������������",0);
			document.form.phoneno.focus();
			return false;
		 }
		  
		 if(document.form.contractno.value=="")
		 {
			rdShowMessageDialog("��û��ѡ���ʺţ�",0);
			document.form.phoneno.focus();
			return false;
		  }
		//�ж������Ƿ���ȷ
		
		//�ж�ʵ������Ϣ ��ѯ��������
		checkSzm(document.form.user_passwd.value,document.form.s_id_no.value);
		
		
	}
	 

}
function checkSzm(u_pass,id_no)
{
	
	var myPacket = new AJAXPacket("checkSMZ.jsp","�����ύ�����Ժ�......");
	myPacket.data.add("u_pass",u_pass);	
	//document.all.cus_pass.value phoneno
	myPacket.data.add("phoneno",document.all.phoneno.value);
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
	//  alert("s_flag_mm1 is "+s_flag_mm+" and s_flag_smz is "+s_flag_smz);
	  s_flag_smz="Y";
	  s_flag_mm="Y";
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
			 document.form.action="zgb5_check.jsp?phoneNo="+phoneno+"&contractNo="+contractno+"&begin_ym"+begin_ym+"&end_ym="+end_ym+"&rwsj="+document.form.khsj.value+"&id_no="+document.form.s_id_no.value;
			 //alert("begin_ym is "+begin_ym);
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
//  add liuxmc
	function getTKDate(){
		
		var time = document.form.reuturn_time.value;
		if(time == "" || time.length==0){
			alert("���ڲ���Ϊ�գ�");
			return false;
		}
		
		if(time.length != 8){
			alert("�Բ�������������ڸ�ʽ���ԣ��밴����ȷ�ĸ�ʽ(YYYYMMDD)��д!");
			return false;
		}

    if(time.length!=0){    
       var reg = /^(\d{1,4})(\d{1,2})(\d{1,2})$/;     
       var r = time.match(reg);     
       if(r==null){
         alert("�Բ�������������ڸ�ʽ����ȷ���밴����ȷ�ĸ�ʽ(YYYYMMDD)��д!");
         return false;
       }
     }
     
		var path = "<%= request.getContextPath()%>/npage/s1300/s1362_selectTK.jsp?time="+time;
		window.showModelessDialog(path);
	}
	
	//  end
 
 

</script>
</HTML>