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
<%
 	//String opCode=request.getParameter("opCode");
	//String opName=request.getParameter("opName");
	String opCode="zg65";
	String opName="��ͨ����˷�";
	String flag="";
	String flag1="";
	if((opCode.equals("zg65")) || (opCode=="zg65")){
		flag="checked";
	}else{
		flag1="checked";
	}
	String phoneNo = (String)request.getParameter("activePhone");
	String orgCode = (String)session.getAttribute("orgCode");
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");
//    System.out.println("temfavStr============"+temfavStr);
//    System.out.println("favInfo============"+favInfo);
  	String[] favStr = new String[favInfo.length];
  	for(int i=0;i<favStr.length;i++)
   		favStr[i]=favInfo[i][0].trim();
  	String pwrf="N";
  	if(WtcUtil.haveStr(favStr,"a272"))
			pwrf="N";
	Date date = new Date();
  DateFormat df = new SimpleDateFormat("yyyyMMdd");   
	String now = df.format(date);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>������BOSS-��Ԥ���</title>
	<META content="text/html; charset=gbk" http-equiv=Content-Type>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
</head>
<body onLoad="form_load();">
<form action="s1362_2.jsp" method="post" name="form">
<input type ="hidden" id ="phoneNo" name="phoneNo">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="busy_type"  value="2">
	<div class="title">
		<div id="title_zi">ѡ���û�����</div>
	</div>
<table cellspacing="0" >
	<tr> 
		<th>�û�����</th>
		<th>
			<input name="busytype" type="radio" onClick="sel1()" value="2" <%=flag%>>
			�����û�
			<input name="busytype" type="radio" onClick="sel2()" value="1" <%=flag1%>>
			�����û�
		</th>
		<th colspan="2">���ţ�<%=orgCode%> </th>
	</tr>
	<tr> 
		<td class="blue">�������</td>
		<td> 
			<input type="text" name="phoneno" maxlength="25" onKeyDown="if(event.keyCode==13) getPhoneKd()" >
		</td>
		<td class="blue">�û�����</td>
		<td>
			<jsp:include page="/npage/common/pwd_one.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="cus_pass"  />
				<jsp:param name="pwd" value="12345"  />
			</jsp:include>
			<input class="b_text" type=button value="��ѯ" onClick="getPhoneKd();">
		</td>
	</tr>
	<tr> 
		<td class="blue">�ʻ�����</td>
		<td> 
			<input type="text" name="contractno" maxlength="20" class="button"  onkeydown="if(event.keyCode==13) getPhoneKd()" onKeyPress="return isKeyNumberdot(0)">
		</td>
		<td class="blue">�û�����</td>
		<td>
			<input type="text" name="textfield7" class="InputGrey" readonly>
		</td>
	</tr>
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
	<tr> 
		<td class="blue"> ���˽��</td>
		<td>
			<input type="text" name="textfield" class="InputGrey" readonly>
		</td>
		<td class="blue">�˷ѽ��</td>
		<td> 
			<input class="button" name=remark2 size=20 value="0.00">
		</td>
	</tr>
	<!--  add liuxmc-->
	<tr>
		<td class="blue">��Ԥ�����Ϣ��ѯ��</td>
		<td class="blue" colspan="3">			
			���ڣ�<input type="text" class="button" name="reuturn_time" value="<%=now%>">��ʽ��YYYYMMDD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="b_text"  type=button value="�� ѯ" onClick="getTKDate();"> <!--�˴�����s1362_selectTK.jsp-->
		</td>
		<input type="hidden" id="cfm_lg">
	</tr>
	<!-- end -->
	<tr> 
		<td align="center" colspan="4" id="footer"> 
			<input class="b_foot" name=sure type=button value=ȷ�� disabled>
			&nbsp;
			<input class="b_foot" name=clear type=reset value=���>
			&nbsp;
			<input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
			&nbsp; 
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
	<%@ include file="../../npage/common/pwd_comm.jsp" %>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
</form>
</body>
 <script language="JavaScript">
<!--
function form_load(){
	var op_code = "<%=opCode%>";
	if(op_code=="zg65"){
		document.all.busy_type.value = "2";
	}else{
		document.all.busy_type.value = "1";
	}
}
function sel1()
 {
	document.all.phoneno.focus();
	document.all.busy_type.value = "2";
 	document.all.opCode.value ="zg65";
 	document.all.opName.value ="��������û��˿�";
 }
function sel2()
 {
	//alert("����service name = ?");
	document.all.phoneno.focus();
	document.all.busy_type.value = "1";
	document.all.opCode.value ="zg65";
	document.all.opName.value ="��������û��˿�";
  }
 // xl add for ��ѯ�������
function getPhoneKd()
{
	if(document.form.phoneno.value==""){
  		rdShowMessageDialog("������벻��Ϊ��!");
  		document.form.phoneno.focus();
		return false;
  	}
	document.getElementById("cfm_lg").value=document.form.phoneno.value;
	var busy_type = document.all.busy_type.value;
	var myPacket = new AJAXPacket("../zg62/getKdNo_new.jsp","���ڲ�ѯ�ͻ������Ժ�......");
		myPacket.data.add("contractNo",(document.all.phoneno.value).trim());
		myPacket.data.add("busyType",busy_type);
		myPacket.data.add("return_page","zg65_1.jsp");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
}
function doProcess(packet)
{
    var i_dp = packet.data.findValueByName("i_dp"); 
	var contract_new=packet.data.findValueByName("contract_out");
	var phone_new=packet.data.findValueByName("phone_new"); 
	document.all.contractno.value=contract_new;
	document.getElementById("phoneNo").value= phone_new;
	//xl add ����Ʒ�ƺ���ˮ��ѯ
	var sm_code = packet.data.findValueByName("s_sm_code");
	//alert(sm_code);
	//rdShowMessageDialog("test phone_new is "+phone_new);
    //alert("phone_new is "+phone_new);
	//docheck(); 
	if(sm_code!="kh")
	{
		rdShowMessageDialog("ֻ��khƷ�ƿ����ڸ�ҳ������˷�!");
		return false;
	}
	else if(i_dp==0)
    {
		rdShowMessageDialog("�ǵ�Ʒ����e033���п���˷�!");
		return false;
	}
	else
	{
		docheck(); 
	}
}
function docheck()
{
	var busy_type=document.all.busy_type.value;
	/*
	if(form.phoneno.value.length<11 )
	{
		rdShowMessageDialog("������������,����Ϊ11λ���� !!")
		document.form.phoneno.focus();
		return false;
	}*/

	var returnValue;
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	//alert("busy_type is "+busy_type);
    if (document.all.busy_type.value=="2") {
    	//alert("e033 begin "+document.getElementById("phoneNo").value);
		returnValue =window.showModalDialog('../e033/getCountdead.jsp?phoneNo_new='+document.getElementById("phoneNo").value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf%>'+'&cfm_lg='+document.getElementById("cfm_lg").value,"",prop);
		//alert("e033 end");
    } else {
		//alert("��дservice");
	     returnValue=window.showModalDialog('../e033/getCount.jsp?phoneNo='+document.getElementById("phoneNo").value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf%>',"",prop);
	}
	//alert("ff "+returnValue);
	if(returnValue=='0')
	 {
		rdShowMessageDialog("��������޿����˷���Ϣ��",0);
		document.form.phoneno.focus();
		return false;
	  }
	  if(returnValue=="")
	 {
		rdShowMessageDialog("��û��ѡ���ʺţ�",0);
		document.form.phoneno.focus();
		return false;
	  }

	document.form.contractno.value = returnValue;
	document.form.action="zg65_select.jsp";
	form.submit(); 
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