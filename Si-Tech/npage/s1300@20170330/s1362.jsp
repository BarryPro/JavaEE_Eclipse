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
	<%@ include file="/npage/client4A/connect4A.jsp" %>
<%@ include file="/npage/client4A/XMLHelper.jsp" %>
<%@ include file="/npage/client4A/BASE64Crypt.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
	<%@ page import="com.sitech.common.*" %>
	
<%
 	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	String flag="";
	String flag1="";
	if(opCode.equals("1366")){
		flag="checked";
	}else{
		flag1="checked";
	}
	String phoneNo = (String)request.getParameter("activePhone");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
  	String pwrf1="N";
    
        
	Date date = new Date();
	DateFormat df = new SimpleDateFormat("yyyyMMdd");   
	String now = df.format(date);
	String sql_reason="select reason_node,reason_code from Sreasoncode where op_code='1362' and reason_class='1'  ";
       
    		/* ����ʱ�� requestTime�ڵ� */
	String currTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
	/* ��ȡ�������ݺ����в��� */
	String readPath = request.getRealPath("npage/properties")+"/treasury.properties";
	/* ��ԴID */
	String appId = readValue("treasury",opCode,"appId",readPath);
	/* ��Դ���� */
	String appName = readValue("treasury",opCode,"appName",readPath);
	/* ����ID sceneId */
	String sceneId = readValue("treasury",opCode,"sceneId",readPath);
	/* �����ó���ID������ɾ�� by zhangyta at 20120824*/
	/*sceneId = "ff808081395641c901395641c9220000";*/
	/* �������� sceneName */
	String sceneName = readValue("treasury",opCode,"sceneName",readPath);
	String ipAddr = (String)session.getAttribute("ipAddr");
	String flag4A = (String)session.getAttribute("flag4A");
	String appSessionId = (String)session.getAttribute("appSessionId");
	if(flag4A == null){
		flag4A = "0";
	}
	if(appSessionId == null){
		appSessionId = "0";
	}
	
%>
<!--
	<jsp:include page="/npage/client4A/treasuryStatus.jsp">
	<jsp:param name="opCode" value="1362"  />
	<jsp:param name="opName" value="��Ԥ���"  />
	</jsp:include>	
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>������BOSS-��Ԥ���</title>
	<META content="text/html; charset=gbk" http-equiv=Content-Type>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
</head>
<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=sql_reason%>"/>
 	
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<%
System.out.println("QQQQQQQQQQQ sql_reason is "+sql_reason+" and ret_val is "+ret_val.length);
%>
<body onLoad="form_load();">
<form action="s1362_2.jsp" method="post" name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="busy_type"  value="2">
	<div class="title">
		<div id="title_zi">ѡ���û�����</div>
	</div>
<table cellspacing="0" >
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
			<input class="b_text"  type=button value="�� ѯ" onClick="getTKDate();">
		</td>
	</tr>
	<!-- end -->
	
	<!--xl add begin-->
	<tr id="tfyy">
		<td class="blue">��Ԥ���ԭ��</td>
		<td class="blue" colspan="3">			
			<select name="reason" style= "width:135px;" onChange="checkReason(this,reason_name,reason_code)">
				<option value="0" selected>---��ѡ���˿�ԭ��</option>
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
		<td align="center" colspan="4" id="footer"> 
			<input class="b_foot" name=sure type=button value=ȷ��>
			&nbsp;
			<!--<input class="b_foot" name=clear type=reset value=���>-->
			<input class="b_foot" name=clear type=button value=��� onClick="doClean()">
			&nbsp;
			<input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
			&nbsp; 
		</td>
	</tr>
</table>
<input type="hidden" id="ifsmz" value="">
<input type="hidden" name="ifKdNo" value="N">
<input type="hidden" name="reason1" value="0">
<input type="hidden" name="reason2">
	<%@ include file="/npage/include/footer_simple.jsp" %>
	<%@ include file="../../npage/common/pwd_comm.jsp" %>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
</form>
</body>
 <script language="JavaScript">

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
	  if ( CodeArray[x] == choose.value &&choose.value=="1004" )
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

<!--
function form_load(){
	document.getElementById("groupId").style.display="none";
	document.getElementById("reason_id").style.display="none";
	sel2();
	var op_code = "<%=opCode%>";
	if(op_code=="1362"){
		document.all.busy_type.value = "1";
	}else{
		document.all.busy_type.value = "2";
	}
	
}
function sel1()
 {
	document.all.phoneno.focus();
	document.all.busy_type.value = "2";
 	document.all.opCode.value ="1366";
 	document.all.opName.value ="�����˿�";
	document.all.tfyy.style.display = "none";
 }
function sel2()
 {
	document.all.phoneno.focus();
	document.all.busy_type.value = "1";
	document.all.opCode.value ="1362";
	document.all.opName.value ="��Ԥ���";
	document.all.tfyy.style.display = "block";
  }
 //�ж��ǲ��ǿ���˺� add by hq
function checkKd(packet){
	  var checkResult=packet.data.findValueByName("checkResult");//����ȡ������������
	  var s_flag = packet.data.findValueByName("s_flag");//t=��ͨ w=������
	  //alert("s_flag is "+s_flag);
	  if(s_flag=="t")
	  {
		  if(checkResult==0||checkResult=="0"||checkResult=="")
		  {
				//return true;
				document.all.ifKdNo.value="N";
		  }
		  else
		  {
				//rdShowMessageDialog("�˷������Ϊ������룬������ǿ������!");
				//document.form.phoneno.focus();
				document.all.ifKdNo.value="Y";
				//return false;
		  }
	  }
	  else if(s_flag=="w")
	  {
		  //alert("������");
		  document.form.phoneno.value=checkResult;
	  }	
	  else
	  {
	  }	
	  
}

function checkKdNo()
{
	var myPacket = new AJAXPacket("checkKD.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("phoneNo",form.phoneno.value);	
		core.ajax.sendPacket(myPacket,checkKd);
    myPacket=null;
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

function docheck()
{
  checkKdNo();
	//alert(document.all.ifKdNo.value);
 if(document.all.ifKdNo.value=="Y"){
		rdShowMessageDialog("�˷������Ϊ������룬������ǿ������!");
	 	document.form.phoneno.focus();
 }else{
	var busy_type=document.all.busy_type.value;

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
	var returnValue;
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    if (document.all.busy_type.value=="2") {
    	
		returnValue =window.showModalDialog('getCountdead_new.jsp?phoneNo='+document.form.phoneno.value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf1%>',"",prop);
		//alert(returnValue);
		document.form.contractno.value = returnValue.split(",")[0];
    } else {
	     returnValue=window.showModalDialog('getCount.jsp?phoneNo='+document.form.phoneno.value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf1%>',"",prop);
		 document.form.contractno.value = returnValue;
	}
	if(document.all.busy_type.value=="2")
	{
		//ʵ����У�� returnValue����һ��id_no
		checkSmz(returnValue.split(",")[1]);
	//	alert("test value is "+document.getElementById("ifsmz").value);
		if(document.getElementById("ifsmz").value!="1")
		{
			rdShowMessageDialog("��ʵ���Ʋ����԰���!");
			return false;
		}

	}	
	if(returnValue=='0')
	 {
		rdShowMessageDialog("�ʺŻ��������������",0);
		document.form.phoneno.focus();
		return false;
	  }
	  if(returnValue=="")
	 {
		rdShowMessageDialog("��û��ѡ���ʺţ�",0);
		document.form.phoneno.focus();
		return false;
	  }
	  
	if (document.all.busy_type.value=="1")
	{
		
		//xl add for һ����ԭ��
		var reason1 = document.all.reason1.value;
		var reason2 = document.all.reason2.value;
		var reason2_txt = document.all.otherReason.value;
		//alert("reason1 is "+reason1+" and reason2 is "+reason2);
		
		if(reason1=="0")
		{
			rdShowMessageDialog("��ѡ���˷�һ��ԭ��");
			return false;
		}	
		else if(reason2=="show" &&reason2_txt=="")
		{
			rdShowMessageDialog("�������˷Ѷ���ԭ��");
			return false;
		}
		else if(reason2=="show" &&reason2_txt.length>64)
		{
			rdShowMessageDialog("�˷Ѷ���ԭ�򳤶Ȳ��ɳ���64��");
			return false;
		}
		else
		{
			/*
			 var getdataPacket = new AJAXPacket("/npage/query/fAjax5085.jsp","���ڻ�����ݣ����Ժ�......");
				getdataPacket.data.add("loginNo","<%=workNo%>");
				getdataPacket.data.add("sceneId","<%=sceneId%>");
				getdataPacket.data.add("sceneName","<%=sceneName%>");
				getdataPacket.data.add("phoneNo",document.form.phoneno.value);
				getdataPacket.data.add("currTime","<%=currTime%>");
				getdataPacket.data.add("appId","<%=appId%>");
				getdataPacket.data.add("appName","<%=appName%>");
				getdataPacket.data.add("flag4A","<%=flag4A%>");
				getdataPacket.data.add("appSessionId","<%=appSessionId%>");
				getdataPacket.data.add("ipAddr","<%=ipAddr%>");
				
				core.ajax.sendPacket(getdataPacket,doFileInput);
				getdataPacket = null;*/
				document.form.action="s1362_select.jsp";
				form.submit(); 
	     
		}
	}
	else
	{	
		   var getdataPacket = new AJAXPacket("/npage/query/fAjax5085.jsp","���ڻ�����ݣ����Ժ�......");
				getdataPacket.data.add("loginNo","<%=workNo%>");
				getdataPacket.data.add("sceneId","<%=sceneId%>");
				getdataPacket.data.add("sceneName","<%=sceneName%>");
				getdataPacket.data.add("phoneNo",document.form.phoneno.value);
				getdataPacket.data.add("currTime","<%=currTime%>");
				getdataPacket.data.add("appId","<%=appId%>");
				getdataPacket.data.add("appName","<%=appName%>");
				getdataPacket.data.add("flag4A","<%=flag4A%>");
				getdataPacket.data.add("appSessionId","<%=appSessionId%>");
				getdataPacket.data.add("ipAddr","<%=ipAddr%>");
				
				core.ajax.sendPacket(getdataPacket,doFileInput);
				getdataPacket = null;
	 
	}
 }
}
function doFileInput(packet){
			var result = packet.data.findValueByName("result");
		   // alert("test result is "+result);
			var resultDesc = packet.data.findValueByName("resultDesc");
			if(result == "1"){
			/**���óɹ� */
				if (document.all.busy_type.value=="1")
				{
					var reason1 = document.all.reason1.value;
					var reason2_txt = document.all.otherReason.value;
					document.form.action="s1362_select.jsp?reason1="+reason1+"&reason2_txt="+reason2_txt;
					form.submit();
				}else{
					document.form.action="s1362_select.jsp";
					form.submit(); 
				}

			}else{
				/**����ʧ�� */
				rdShowMessageDialog("ִ��ʧ�ܣ�ʧ��ԭ��" + resultDesc);
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
//ԤԼ�����ѯ
function checkOrder()
{
	if(document.all.orderId.value=="")
	{
		rdShowMessageDialog("����������վԤԼ��ID����!");
		return false;
	}
	var myPacket = new AJAXPacket("s1362Order.jsp","�����ύ�����Ժ�......");
	myPacket.data.add("orderId",document.all.orderId.value);
	if (document.all.busy_type.value=="2")
	{
		myPacket.data.add("flag","2");
	}
	else if (document.all.busy_type.value=="1")
	{
		myPacket.data.add("flag","1");
	}
	else
	{
		rdShowMessageDialog("��ȷ����������!");
		return false;
	}
	core.ajax.sendPacket(myPacket);
    myPacket=null;
}
function doProcess(packet)
{
	var flag1 = packet.data.findValueByName("flag1");
	var custPhone= packet.data.findValueByName("custPhone");
	var custPass= packet.data.findValueByName("custPass");
	var group_name = packet.data.findValueByName("group_name");
	//alert("phone is "+custPhone+" and custPass is "+custPass+" and flag1 is  "+flag1);
	if(flag1==0)
	{
		//alert("phone is "+custPhone+" and custPass is "+custPass);
		document.all.phoneno.value=custPhone;
		document.all.cus_pass.value=custPass;
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
		rdShowMessageDialog("�û�û��ԤԼ��¼��ԤԼ�ѹ���!");
		return false;
	}
}
function doClean()
{
	document.getElementById("groupId").style.display="none";
	document.all.orderId.value="";
	document.all.phoneno.value="";
	document.all.cus_pass.value="";
	document.all.contractno.value="";
	document.all.textfield7.value="";
	document.all.textfield3.value="";
	document.all.textfield2.value="";
	document.all.textfield.value="";
	document.all.remark2.value="";
}

</script>
</HTML>