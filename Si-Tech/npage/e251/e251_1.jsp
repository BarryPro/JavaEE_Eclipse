<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����Ԥ��� 8379
   * �汾: 1.0
   * ����: 2010/3/12
   * ����: sunaj
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>����Ԥ���</title>
<%
    //String opCode="8379";
	//String opName="����Ԥ���";

    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
    String[][] favInfo=(String[][])session.getAttribute("favInfo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("k"))
		workNoFlag=true;
%>
<%
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();

  //xl add �����ж� beign
  String[] inParas_hm = new String[2];
  inParas_hm[0]="select to_char(count(*)) from sactivtrans where phone_no = :s_no ";
  inParas_hm[1]="s_no="+phoneNo;
  //end of �����ж�
%>
	
<wtc:service name="TlsPubSelCrm"  retcode="retCode_hm" retmsg="retMsg_hm" outnum="1">
		<wtc:param value="<%=inParas_hm[0]%>"/>
		<wtc:param value="<%=inParas_hm[1]%>"/> 
</wtc:service>
<wtc:array id="result_hm" scope="end" />	
<%
	String s_count_hm = result_hm[0][0];
%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body onload="init1()">
<form action="e251_2.jsp" name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" value = "e251" >
	<input type="hidden" name="opname" value = "��ֵ���ֹ���ֵ" >
	<input type="hidden" name="o_opcode"   >
	<input type="hidden" name="o_login_accept"   >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">�ֹ���ֵ</div>
</div>	 
	<table cellspacing="0">
	   
		<tr> 
			<td class="blue">�ֻ����� </td>
			<td> 
				<input type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				&nbsp;&nbsp;&nbsp;&nbsp;	 
		 
				<select name=sopcodename id="sOpcodeId" >
					<option value="00">��ѡ�����Ϳ���ҵ�����</option>
					<option value="2289">2289</option>
					<option value="2266">e177</option>
					<option value="g794">g794</option> 
				</select>
			 
				<input type=button class="b_foot" name="check2" value="��ѯ" onclick="check1()" >
			</td>
		</tr>
		
		<!--
		<tr> 
			<td class="blue">�ֻ����� </td>
			<td> 
				<jsp:include page="/npage/query/pwd_one.jsp">
		      	<jsp:param name="width1" value="16%"  />
		      	<jsp:param name="width2" value="34%"  />
		      	<jsp:param name="pname" value="cus_pass"  />
		      	<jsp:param name="pwd" value="12345"  />
	    	   	</jsp:include>	 
		 
				
			</td>
			
		</tr>
		<tr> 
			<td class="blue">��ѡ��������ʾ </td>
			<td> 
				<select name=channelCode id="channelCodeId" >
					<option value="00">��ѡ��</option>
					<option value="01">BOSS</option>
					<option value="02">����Ӫҵ��</option>
					<option value="03">����Ӫҵ��</option>
					<option value="04">����Ӫҵ��</option>
					<option value="05">��ý���ѯ��</option>
					<option value="06">10086</option>
				</select>
				<input type=button class="b_foot" name="check2" value="��ѯ" onclick="check1()" >
			</td>
			
		</tr>
		-->
	</table>
</div>
<!-- xl add ���ת���ͻ�-->
<div id="Operation_Table1"> 
<div class="title">
	<div id="title_zi">ת���ͻ���ֵ</div>
</div>
<table cellspacing="0">
	 
	<tr> 
		<td class="blue">�����</td>
		<td> 
			<input type="text"  name="zzhdmc"  class="InputGrey" >
			
		</td>
		<td class="blue">ת��ʱ��</td>
		<td> 
			<input type="text"  name="zzcysj" class="InputGrey" >
		</td>
	 
	</tr>
	<tr> 
		<td class="blue">ת���ͻ�����</td>
		<td> 
			<input type="text"   name="zzname" class="InputGrey"  >
			
		</td>
		<td class="blue">ת���ֻ�����</td>
		<td> 
			<input type="text"  name="zzphone" class="InputGrey">
		</td>
	 
	</tr>
	<tr> 
		<td class="blue" >��ת�����</td>
		<td> 
			<input type="text"  name="zzje" class="InputGrey" >
			
		</td>
		<!-- 
	   <TD class="blue" >�ֻ�����</TD>
                  <TD width="34%">
                    <input type="password" name="password2zz" maxlength=6  /> 
       </TD>
	   -->
	</tr>
  
</table>
</div>
<!--  xl add end ���ת���ͻ�-->  
<!-- xl add ��Է�ת���ͻ�-->
<div id="Operation_Table2"> 
<div class="title">
	<div id="title_zi">�ͻ���ֵ</div>
</div>
<table cellspacing="0">

	<tr> 
		<td class="blue">�����</td>
		<td> 
			<input type="text"  name="fzzhdmc"  class="InputGrey" >
			
		</td>
		<td class="blue">����ʱ��</td>
		<td> 
			<input type="text"  name="fzzcysj" class="InputGrey" >
		</td>
	 
	</tr>
	<tr> 
		<td class="blue">�ͻ�����</td>
		<td> 
			<input type="text"   name="fzzname" class="InputGrey" >
			
		</td>
		<td class="blue">�ֻ�����</td>
		<td> 
			<input type="text"  name="fzzphone" class="InputGrey">
		</td>
	 
	</tr>
	<tr> 
		<td class="blue" >�����ͽ��</td>
		<td> 
			<input type="text"   name="fzzje" class="InputGrey" >
			
		</td>
		<!--
		<TD class="blue" >�ֻ�����</TD>
                  <TD width="34%">
                    <input type="password" name="password2fzz" maxlength=6  /> 
       </TD>
	   -->
	 
	</tr>
	 
</table>
</div>
<!--  xl add end ��Է�ת���ͻ�--> 
<!--xl add for ��ֵ����Ϣ-->
<div id="Operation_Table3"> 
<div class="title">
	<div id="title_zi">��ֵ����Ϣ</div>
</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" >���ͳ�ֵ���ܽ��</td>
		<td  > 
			<input type="text" name="czkje" readonly class="InputGrey">
			
		</td>
		<td class="blue" >�ѳ�ֵ���</td>
		<td  > 
			<input type="text"  name="yczje" readonly class="InputGrey">
			
		</td>
		<td class="blue" >���˿ɳ�ֵ���</td>
		<td  > 
			<input type=text class="InputGrey" readOnly   name="grje"   >
			
		</td>
	</tr>
	<input type="hidden" name="show">
	<tr><!--Ӫ������������ƣ��������ƣ�����ʱ�䣬���ͽ�ת��ʱ��--> 
		<td class="blue">��ֵ������</td>
		<td> 
			<input class=button  name="czkkh" >
			
		</td>
		
		<td class="blue">��ֵ������</td>
		<td > 
			<input class=button  name="ppsCardPin" size="40" maxlength="18" type="password" >
			
		</td>

		<td class="blue">��ֵ����ֵ</td>
		<td colspan=3> 
			<input name="czkmz" class="InputGrey" readonly >(ϵͳ��ȡ,��������)
			
		</td>
 
		
		<input type = hidden name="beginNo"><input type = hidden name="endNo">
	</tr>
	<!---->
 
	<tr align="center" id="footer">
		<td colspan="8">
			
			<input class="b_foot" name=doCfm  type=button index="8" value="����У��" onclick="checkCard2()">
		 
		 
			<input class="b_foot" name=doCfm2 type=button  value="Ϊ���˳�ֵ" onclick="doCfmP()">
		</td>
	</tr>
	<tr align="center" id="footer">
		<td colspan="8">
			<!--
			
			<input class="b_foot" name=back type=button value="���" onclick="window.location='e068.jsp?activePhone=<%=activePhone%>'">
			
			
			-->
			 
			<input class="b_foot" name=doCfm3  type=button index="8" value="����У��" onclick="checkCard1()">
		 
		 
			<input class="b_foot" name=doCfm4 type=button  value="Ϊ���˳�ֵ" onclick="doCfm1()">
		</td>
	</tr>
</table>
</div>
<!--��ֵ����Ϣ����-->
</table>
<input type = "hidden" name="custName">
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
		
	function init1()
	{
		//alert("s_count_hm is "+"<%=s_count_hm%>");
		if("<%=s_count_hm%>">0)
		{
			rdShowMessageDialog("�ú�������zgag���г�ֵ����ֵ����!");
			removeCurrentTab();
		}
		document.getElementById("Operation_Table1").style.display="none";
		document.getElementById("Operation_Table2").style.display="none";
		document.getElementById("Operation_Table3").style.display="none";
		document.all.doCfm4.disabled=true;
		document.all.doCfm2.disabled=true;
	}
	function check1()
	{
		//var channelId = document.getElementById("channelCodeId").value;
		//alert("channelId is "+channelId);
		 
		
		document.all.yczje.value="";
		document.all.doCfm4.disabled=true;
		document.all.doCfm2.disabled=true;
		//xl add ����op_code 2289 2266
		var sOpcode = document.getElementById("sOpcodeId");
		var s_opcode=sOpcode.value;
		//alert(s_opcode);
		if(s_opcode=="00")
		{
			rdShowMessageDialog("��ѡ��������ҵ�����!");
			return false;
		}
		var myPacket = new AJAXPacket("e251_check.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("phoneNo",document.frm.srv_no.value);
		myPacket.data.add("op_codes",s_opcode);
		//myPacket.data.add("channelId",channelId);
		//myPacket.data.add("pwd",document.frm.cus_pass.value);
		//core.ajax.sendPacket(myPacket);
    	core.ajax.sendPacket(myPacket,doPosSubInfo3);
		myPacket=null;
	}
	function doPosSubInfo3(packet) //��ѯ����� չʾ������ĵط�
	{
		var flagConfirm =  packet.data.findValueByName("flag1");
		var oProjectName = packet.data.findValueByName("oProjectName");
		var oPartInTime  = packet.data.findValueByName("oPartInTime");
		var oOnlyMyFlag  = packet.data.findValueByName("oOnlyMyFlag");
		var oAllFee  = packet.data.findValueByName("oAllFee");
		var oMyFee  = packet.data.findValueByName("oMyFee");
		var oStoreNo  = packet.data.findValueByName("oStoreNo");
		var oEndStoreNo  = packet.data.findValueByName("oEndStoreNo");
		var oTranFee  = packet.data.findValueByName("oTranFee");
		var oTranTime   = packet.data.findValueByName("oTranTime");
		var oTranPhone  = packet.data.findValueByName("oTranPhone");
		var oCustName= packet.data.findValueByName("oCustName");
		var phoneFlag =packet.data.findValueByName("phoneFlag"); // 0-->��� 1--������
		var cardFlag =packet.data.findValueByName("cardFlag");   // 0-->��� 1--������
		var custName = packet.data.findValueByName("custName"); 
		//var yczje = packet.data.findValueByName("add_money"); 
		var flagMoney = packet.data.findValueByName("flagMoney"); 
		var o_money = packet.data.findValueByName("o_money");
		//alert("flagMoney is "+flagMoney+" and o_money is "+o_money);
		var newFlag = packet.data.findValueByName("newFlag");
		//alert("newFlag is "+newFlag);
		//xl add begin 1029
		var oTranOpCode = packet.data.findValueByName("oTranOpCode");
		var oTranAccept = packet.data.findValueByName("oTranAccept");
		//alert("��ˮ�� "+oTranAccept);
		document.all.o_opcode.value=oTranOpCode;
		document.all.o_login_accept.value=oTranAccept;
		//xl add end
	//	alert("oProjectName is "+oProjectName);
		if(flagMoney=="1")
		{
			document.all.yczje.value=o_money;
			document.all.doCfm.disabled=false;
			document.all.doCfm2.disabled=false;
		}
		if(flagMoney=="0")
		{
			document.all.yczje.value="0";
			document.all.doCfm.disabled=false;
			document.all.doCfm2.disabled=false;
		}
		//922 add 
		if(newFlag==1)
		{
			document.all.doCfm4.disabled=false;
			document.all.doCfm2.disabled=true;
		}
		if(newFlag==2)
		{
			document.all.doCfm2.disabled=false;
			document.all.doCfm4.disabled=true;
		}
		//alert("final o_money is "+o_money);
		if(flagConfirm==1)
		{
			var errCode2 =  packet.data.findValueByName("errCode");
			var errMsg2 =  packet.data.findValueByName("errMsg");
			rdShowMessageDialog("����ʧ�ܣ�������룺"+errCode2+",ʧ��ԭ��"+errMsg2);
			return false;
		}
		
		if(flagConfirm==0)
		{
			//rdShowMessageDialog("�����ɹ�!");
			//add ���
			//printCommit();
			//���ر�ҳ�� location=
			//alert("oMyFee is "+oMyFee);
			document.all.grje.value=oMyFee;
			//alert("test oOnlyMyFlag is "+oOnlyMyFlag+" and oMyFee is "+oMyFee); 
			if(oOnlyMyFlag=="1")//ת�� �Ȳ��� 
			{
				//alert("ת��"+oTranFee+" and oTranFee is "+oTranFee+" and oTranTime is "+oTranTime+" and oTranPhone is "+oTranPhone+" and oCustName is "+oCustName);
				document.getElementById("Operation_Table1").style.display="block";
				document.getElementById("Operation_Table3").style.display="block";
				if(phoneFlag=="0")
				{
					var h=480;
					var w=650;
					var t=screen.availHeight/2-h/2;
					var l=screen.availWidth/2-w/2;
					var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
					var  returnValue ; 
					var returnValue=window.showModalDialog('getUserMore.jsp?phoneNo='+document.frm.srv_no.value,"",prop);
					//myPacket.data.add("phoneNo",document.frm.srv_no.value); myPacket.data.add("channelId",channelId); "pwd",document.frm.cus_pass.value);
						
					if(returnValue==null)
					{
						rdShowMessageDialog("û���ҵ���Ӧ���û���",0);
						//document.form.phoneNo.focus();
						return false;
					}
					if(returnValue=="")
					{
						rdShowMessageDialog("��û��ѡ���û���",0);
						//document.form.phoneNo.focus();
						return false;
					}
					//new ���ݵ�ѡ��ʵ��
					//alert("���⴦��");
					 
					document.all.zzname.value = returnValue.split(",")[0];
					document.all.zzphone.value=returnValue.split(",")[1];
					document.all.zzcysj.value=returnValue.split(",")[2];
					document.all.zzje.value=returnValue.split(",")[3];
					
			 
				}
				else
				{
					document.all.zzname.value = oCustName;
					document.all.zzphone.value=oTranPhone;
					document.all.zzcysj.value=oTranTime;
					document.all.zzje.value=oTranFee;
				}
				//new ������� begin
				//alert("cardFlag is "+cardFlag+"0-->��� 1-->����");
				if(cardFlag=="0")
				{
					var h=480;
					var w=650;
					var t=screen.availHeight/2-h/2;
					var l=screen.availWidth/2-w/2;
					var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
					//var  returnValue ; 
					var sOpcode = document.getElementById("sOpcodeId");
					var s_opcode=sOpcode.value;
					//alert("2 "+s_opcode);
					var returnValue=window.showModalDialog('getCardMore.jsp?phoneNo='+document.frm.srv_no.value+"&s_opcode="+s_opcode,"",prop);
					//myPacket.data.add("phoneNo",document.frm.srv_no.value); myPacket.data.add("channelId",channelId); "pwd",document.frm.cus_pass.value);
						
					if(returnValue==null)
					{
						rdShowMessageDialog("û���ҵ���Ӧ�Ŀ��ţ�",0);
						//document.form.phoneNo.focus();
						return false;
					}
					if(returnValue=="")
					{
						rdShowMessageDialog("��û��ѡ�񿨺ţ�",0);
						//document.form.phoneNo.focus();
						return false;
					}
					//new ���ݵ�ѡ��ʵ��
					//alert("���⴦��");
					 
					document.all.beginNo.value = returnValue.split(",")[0];
					document.all.endNo.value=returnValue.split(",")[1];
					//xl add
					//alert("������� "+returnValue.split(",")[3]);
					document.all.o_opcode.value = returnValue.split(",")[2];
					document.all.o_login_accept.value = returnValue.split(",")[3];
					
			 
				}
				else
				{
					document.all.beginNo.value = oStoreNo;
					document.all.endNo.value=oEndStoreNo;
					 
				}
				//new ������� end
				document.all.zzhdmc.value=oProjectName;
				/*document.all.zzcysj.value=oPartInTime;
				document.all.zzphone.value=oTranPhone;
				document.all.zzname.value=oCustName;
				*/
				document.all.czkje.value=oAllFee;
				//document.all.czkmz.value=oTranFee;
				
				//document.all.beginNo.value=oStoreNo;
				//document.all.endNo.value=oEndStoreNo;
				document.all.show.value="1"; //Ϊ�˳�ֵ��ʱ�� �ж��Ƿ���ת��
				
			}//�������ת����
			//��ת��	
			if(oOnlyMyFlag=="0")
			{
				//alert("��ת��");
				document.getElementById("Operation_Table2").style.display="block";
				document.getElementById("Operation_Table3").style.display="block";
				document.all.show.value="0"; //Ϊ�˳�ֵ��ʱ�� �ж��Ƿ���ת��
				
				document.all.fzzname.value = custName;
				document.all.fzzphone.value=document.all.srv_no.value;
				
				document.all.fzzje.value=oMyFee;
				document.all.czkje.value=oAllFee;
				//new ������� begin
				//alert("cardFlag is "+cardFlag+"0-->��� 1-->����");
				if(cardFlag=="0")
				{
					var h=480;
					var w=850;
					var t=screen.availHeight/2-h/2;
					var l=screen.availWidth/2-w/2;
					var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
					//var  returnValue ; 
					var sOpcode = document.getElementById("sOpcodeId");
					var s_opcode=sOpcode.value;
					//alert("1 ������� getCardMore.jsp");
					var returnValue=window.showModalDialog('getCardMore.jsp?phoneNo='+document.frm.srv_no.value+"&s_opcode="+s_opcode,"",prop);
					//myPacket.data.add("phoneNo",document.frm.srv_no.value); myPacket.data.add("channelId",channelId); "pwd",document.frm.cus_pass.value);
						
					if(returnValue==null)
					{
						rdShowMessageDialog("û���ҵ���Ӧ�Ŀ��ţ�",0);
						//document.form.phoneNo.focus();
						return false;
					}
					if(returnValue=="")
					{
						rdShowMessageDialog("��û��ѡ�񿨺ţ�",0);
						//document.form.phoneNo.focus();
						return false;
					}
					//new ���ݵ�ѡ��ʵ��
					//alert("���⴦��");
					 
					document.all.beginNo.value = returnValue.split(",")[0];
					document.all.endNo.value=returnValue.split(",")[1];
				 
					//xl add
					//alert("111 ������� "+returnValue.split(",")[3]);
					document.all.o_opcode.value = returnValue.split(",")[2];
					document.all.o_login_accept.value = returnValue.split(",")[3];
					document.all.fzzhdmc.value=returnValue.split(",")[4];
					document.all.fzzcysj.value=returnValue.split(",")[5];
				}
				else//����
				{
					document.all.beginNo.value = oStoreNo;
					document.all.endNo.value=oEndStoreNo;
					document.all.fzzhdmc.value=oProjectName;
					document.all.fzzcysj.value=oPartInTime;
					 
				}
				//new ������� end
				//document.all.beginNo.value=oStoreNo;
				//document.all.endNo.value=oEndStoreNo;
			}
			//window.location="e251_1.jsp?activePhone=<%=activePhone%>&opCode=e232&opName="+document.all.opname.value;
		}
		

	}
	 
 	
/*��ѯ�ֻ���ֵ��*/
function checkCard()
{
    var prop="dialogHeight:300px; dialogWidth:550px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    //card_num = parseInt(document.forms[0].cardNum.value);
	card_num =1
    if(card_num == -1)
    {
        //card_num = document.forms[0].rescode_sum.value;
		card_num = 0;
    }
    //card_type = document.forms[0].cardType.value;
	card_type = 0;
    var ret = window.showModalDialog("e251_query_card.jsp?card_num="+card_num+"&card_type="+card_type,"",prop);
    if(ret)
    {
        document.all.card_no.value = ret;
    }
    else
    {
        //do Nothing
        ;
    }
}
function doCfm1()
{
	var flag = document.all.show.value; //Ϊ�˳�ֵ��ʱ�� �ж��Ƿ���ת��
	//alert("��Ϊת���ͷ�ת���� �ֻ����룡"+flag);
	var new_money = "";
	var new_money_final = "";
	//alert("flag is "+flag);
	if(flag=="1")
	{
		//alert("ת��");
		new_money = document.all.zzje.value;
		/*
		if(document.all.password2zz.value=="")
		{
			rdShowMessageDialog("���������룡");
			document.all.password2zz.focus();
			return false;
		}*/
	}
	if(flag=="0")
	{
	//	alert("��ת��");
		new_money = document.all.fzzje.value;
		/*
		if(document.all.password2fzz.value=="")
		{
			rdShowMessageDialog("���������룡");
			document.all.password2fzz.focus();
			return false;
		}*/
	}
	
	if (document.frm.czkkh.value=="")
	{
		rdShowMessageDialog("�������ֵ���ţ�");
		document.frm.czkkh.focus();
		return false;
	}
	if (document.frm.czkmz.value=="")
	{
		rdShowMessageDialog("�������ֵ����ֵ��");
		document.frm.czkmz.focus();
		return false;
	}
	if(document.frm.czkmz.value!="10"&&document.frm.czkmz.value!="30"&&document.frm.czkmz.value!="50"&&document.frm.czkmz.value!="100"&&document.frm.czkmz.value!="300"&&document.frm.czkmz.value!="500")
	{
		rdShowMessageDialog("��������ȷ�ĳ�ֵ����ֵ��");
		document.frm.czkmz.focus();
		return false;
	}
	if (document.frm.ppsCardPin.value.length != 18)
	{
		rdShowMessageDialog("��ֵ������Ϊ18λ������ȷ���룡");
		document.frm.ppsCardPin.focus();
		return false;
	}
	//alert("czkmz is "+document.frm.czkmz.value+" and czkje is "+document.all.czkje.value);
	
	//����������֤
	
	if((parseFloat(document.frm.czkkh.value)<parseFloat(document.all.beginNo.value))||(parseFloat(document.frm.czkkh.value)>parseFloat(document.all.endNo.value)) )
	//if((Number(document.frm.czkkh.value)<Number(document.all.beginNo.value))||(Number(document.frm.czkkh.value)>Number(document.all.endNo.value)) )
	{
		rdShowMessageDialog("��������ȷ�ĳ�ֵ�����ţ�");
		document.frm.czkkh.value="";
		document.frm.czkkh.focus();
		return false;
	}
	//alert("password2 is "+document.all.password2.value);
	
	//new begin
	var total_money = document.all.czkje.value;
	var yczje = document.all.yczje.value;
	var czkmz = document.all.czkmz.value;
	new_money_final = parseInt(total_money)-parseInt(yczje)-parseInt(new_money)-parseInt(czkmz);
	var new_money_kz =parseInt(new_money)-parseInt(czkmz)-parseInt(yczje);
	var new_money_fzz =parseInt(new_money)-parseInt(czkmz)-parseInt(yczje);
//	alert("final flag is "+flag);
	if(flag =="1")//ת��
	{
		if(new_money_kz<0)
		{
			rdShowMessageDialog("��ֵ����ѳ����ɳ�ֵ��ȣ���ȷ�ϳ�ֵ��ֵ��");
			document.frm.czkmz.value="";
			document.frm.czkmz.focus();
			return false;
		}
	}
	if(flag =="0")//��ת��
	{
		alert("��ת���� new_money_fzz is "+new_money_fzz);
		if(new_money_fzz<0)
		{
			rdShowMessageDialog("��ֵ����ѳ����ɳ�ֵ��ȣ���ȷ�ϳ�ֵ��ֵ��");
			document.frm.czkmz.value="";
			document.frm.czkmz.focus();
			return false;
		}
	}
	
	//new end

	var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ����ֵ��");
	if (prtFlag==1)
	{
		frm.submit();
	}
	else
	{
		return false;
	}
	

}
function checkCard1() //����У��
{
	//�Ƿ��ת
	var sfkz = document.all.show.value; 
	if(sfkz=="1")
	{
		//alert("ת��");
		var phoneNo2 = document.all.zzphone.value;
	}
	if(sfkz=="0")
	{
		//alert("��ת��");
		var phoneNo2 = document.all.fzzphone.value;
	}
	//alert("sfkz is "+sfkz+" and phoneNo2 is "+phoneNo2);
	//Sql =  select from where phone1= and phone2=
	var myPacket = new AJAXPacket("e251_query_card.jsp","�����ֻ���ֵ����Ϣ�����Ժ�......");
	myPacket.data.add("phoneNo1",document.all.srv_no.value );
	myPacket.data.add("phoneNo2",phoneNo2 );
	myPacket.data.add("newFlag","1" );//��ʾ��У������
	//core.ajax.sendPacket(myPacket);
	core.ajax.sendPacket(myPacket,doPosSubInfo2);
	document.all.show.value="1";
	myPacket=null;
	 
}
function doCfmP()
{
	document.all.czkmz.value="";
	var myPacket = new AJAXPacket("e251_getmz.jsp","�����ύ�����Ժ�......");
	if (document.frm.czkkh.value=="")
	{
		rdShowMessageDialog("�������ֵ���ţ�");
		document.frm.czkkh.focus();
		return false;
	}
	if (document.frm.ppsCardPin.value.length != 18)
	{
		rdShowMessageDialog("��ֵ������Ϊ18λ������ȷ���룡");
		document.frm.ppsCardPin.focus();
		return false;
	}
	if(((document.frm.czkkh.value)<(document.all.beginNo.value))||((document.frm.czkkh.value)>(document.all.endNo.value)) )
	{
		rdShowMessageDialog("��������ȷ�ĳ�ֵ�����ţ�");
		document.frm.czkkh.value="";
		document.frm.czkkh.focus();
		return false;
	}
	
	myPacket.data.add("czkkh",document.frm.czkkh.value);
	core.ajax.sendPacket(myPacket,doPosMz);
	myPacket=null;
}	
function doPosMz(packet)
{
	//var flag = document.all.show.value; //Ϊ�˳�ֵ��ʱ�� �ж��Ƿ���ת��
	//alert("��Ϊת���ͷ�ת���� �ֻ����룡"+flag);
	document.all.show.value="2";
	
	var flagMoney =  packet.data.findValueByName("flagMoney");
	var mz =  packet.data.findValueByName("mz");
	//alert("flagMoney is "+flagMoney+" and mz is "+mz);
	if(flagMoney=="1")
	{
		rdShowMessageDialog("��ֵ����¼������,��˶Կ��ź���������!");
		document.all.czkmz.value="";
		return false;
	}
	else
	{
		document.all.czkmz.value=mz;
		var total_money = document.all.czkje.value;
		var yczje = document.all.yczje.value;
		var czkmz = document.all.czkmz.value;
		var PerMoney = document.all.grje.value;
		new_money_final = parseInt(PerMoney)-parseInt(yczje)-parseInt(mz);
		if(new_money_final<0)
		{
				rdShowMessageDialog("��ֵ����ѳ����ɳ�ֵ��ȣ���ȷ�ϳ�ֵ��ֵ��");
				document.frm.czkmz.value="";
				document.frm.czkmz.focus();
				return false;
		}
		 
		 
		
		//new end

		var	prtFlag = rdShowConfirmDialog("��ֵ����ֵ"+czkmz+"Ԫ,�Ƿ�ȷ����ֵ��");
		if (prtFlag==1)
		{
			frm.submit();
		}
		else
		{
			return false;
		}
	}
			
	//new begin
	
}
function checkCard2()//����
{
	
	//Sql =  select from where phone1= and phone2=
	var myPacket = new AJAXPacket("e251_query_card.jsp","�����ֻ���ֵ����Ϣ�����Ժ�......");
	myPacket.data.add("phoneNo1",document.all.srv_no.value );
	myPacket.data.add("phoneNo2",document.all.srv_no.value );
	myPacket.data.add("newFlag","2" );//��ʾ��У���Լ�
	//core.ajax.sendPacket(myPacket);
	core.ajax.sendPacket(myPacket,doPosSubInfo1);
	myPacket=null;
}
function doPosSubInfo1(packet)
{
		//alert("123");
		var flagConfirm =  packet.data.findValueByName("flag1");
		var oProjectName = packet.data.findValueByName("oProjectName");
		var oPartInTime  = packet.data.findValueByName("oPartInTime");
		var oOnlyMyFlag  = packet.data.findValueByName("oOnlyMyFlag");
		var oAllFee  = packet.data.findValueByName("oAllFee");
		var oMyFee  = packet.data.findValueByName("oMyFee");
		var oStoreNo  = packet.data.findValueByName("oStoreNo");
		var oEndStoreNo  = packet.data.findValueByName("oEndStoreNo");
		var oTranFee  = packet.data.findValueByName("oTranFee");
		var oTranTime   = packet.data.findValueByName("oTranTime");
		var oTranPhone  = packet.data.findValueByName("oTranPhone");
		var oCustName= packet.data.findValueByName("oCustName");
		var phoneFlag =packet.data.findValueByName("phoneFlag"); // 0-->��� 1--������
		var cardFlag =packet.data.findValueByName("cardFlag");   // 0-->��� 1--������
		var custName = packet.data.findValueByName("custName"); 
		//var yczje = packet.data.findValueByName("add_money"); 
		var flagMoney = packet.data.findValueByName("flagMoney"); 
		var o_money = packet.data.findValueByName("o_money");
		//alert("flagMoney is "+flagMoney+" and o_money is "+o_money);
		var newFlag = packet.data.findValueByName("newFlag");
		//alert("newFlag is "+newFlag);
		//xl add begin 1029
		 
		
		//xl add end
		if(flagMoney=="1")
		{
			document.all.yczje.value=o_money;
			document.all.doCfm.disabled=false;
			document.all.doCfm2.disabled=false;
		}
		if(flagMoney=="0")
		{
			document.all.yczje.value="0";
			document.all.doCfm.disabled=false;
			document.all.doCfm2.disabled=false;
		}
		//922 add 
		if(newFlag==1)
		{
			document.all.doCfm4.disabled=false;
			document.all.doCfm2.disabled=true;
		}
		if(newFlag==2)
		{
			document.all.doCfm2.disabled=false;
			document.all.doCfm4.disabled=true;
		}
		//alert("final o_money is "+o_money);
		if(flagConfirm==1)
		{
			var errCode2 =  packet.data.findValueByName("errCode");
			var errMsg2 =  packet.data.findValueByName("errMsg");
			rdShowMessageDialog("����ʧ�ܣ�������룺"+errCode2+",ʧ��ԭ��"+errMsg2);
			return false;
		}
		
		if(flagConfirm==0)
		{
			//rdShowMessageDialog("�����ɹ�!");
			//add ���
			//printCommit();
			//���ر�ҳ�� location=
			//alert("oMyFee is "+oMyFee);
			document.all.grje.value=oMyFee;
			//alert("oOnlyMyFlag is "+oOnlyMyFlag.split(',')+" and oTranPhone is "+oTranPhone);
			if(oOnlyMyFlag=="1")
			{
				//alert("ת��"+oTranFee+" and oTranFee is "+oTranFee+" and oTranTime is "+oTranTime+" and oTranPhone is "+oTranPhone+" and oCustName is "+oCustName);
				document.getElementById("Operation_Table1").style.display="block";
				document.getElementById("Operation_Table3").style.display="block";
				if(phoneFlag=="0")
				{
					var h=480;
					var w=650;
					var t=screen.availHeight/2-h/2;
					var l=screen.availWidth/2-w/2;
					var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
					var  returnValue ; 
					var returnValue=window.showModalDialog('getUserMore.jsp?phoneNo='+document.frm.srv_no.value,"",prop);
					//myPacket.data.add("phoneNo",document.frm.srv_no.value); myPacket.data.add("channelId",channelId); "pwd",document.frm.cus_pass.value);
						
					if(returnValue==null)
					{
						rdShowMessageDialog("û���ҵ���Ӧ���û���",0);
						//document.form.phoneNo.focus();
						return false;
					}
					if(returnValue=="")
					{
						rdShowMessageDialog("��û��ѡ���û���",0);
						//document.form.phoneNo.focus();
						return false;
					}
					//new ���ݵ�ѡ��ʵ��
					//alert("���⴦��");
					 
					document.all.zzname.value = returnValue.split(",")[0];
					document.all.zzphone.value=returnValue.split(",")[1];
					document.all.zzcysj.value=returnValue.split(",")[2];
					document.all.zzje.value=returnValue.split(",")[3];
					
			 
				}
				else
				{
					document.all.zzname.value = oCustName;
					document.all.zzphone.value=oTranPhone;
					document.all.zzcysj.value=oTranTime;
					document.all.zzje.value=oTranFee;
				}
				//new ������� begin
				//alert("cardFlag is "+cardFlag+"0-->��� 1-->����");
				if(cardFlag=="0")
				{
					var h=480;
					var w=650;
					var t=screen.availHeight/2-h/2;
					var l=screen.availWidth/2-w/2;
					var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
					//var  returnValue ; 
					var sOpcode = document.getElementById("sOpcodeId");
					var s_opcode=sOpcode.value;
					//alert("2 "+s_opcode);
					var returnValue=window.showModalDialog('getCardMore.jsp?phoneNo='+document.frm.srv_no.value+"&s_opcode="+s_opcode,"",prop);
					//myPacket.data.add("phoneNo",document.frm.srv_no.value); myPacket.data.add("channelId",channelId); "pwd",document.frm.cus_pass.value);
						
					if(returnValue==null)
					{
						rdShowMessageDialog("û���ҵ���Ӧ�Ŀ��ţ�",0);
						//document.form.phoneNo.focus();
						return false;
					}
					if(returnValue=="")
					{
						rdShowMessageDialog("��û��ѡ�񿨺ţ�",0);
						//document.form.phoneNo.focus();
						return false;
					}
					//new ���ݵ�ѡ��ʵ��
					//alert("���⴦��");
					 
					document.all.beginNo.value = returnValue.split(",")[0];
					document.all.endNo.value=returnValue.split(",")[1];
					//xl add
					//document.all.o_opcode.value = returnValue.split(",")[2];
					//document.all.o_login_accept.value = returnValue.split(",")[3];
					
			 
				}
				else
				{
					document.all.beginNo.value = oStoreNo;
					document.all.endNo.value=oEndStoreNo;
					 
				}
				//new ������� end
				document.all.zzhdmc.value=oProjectName;
				/*document.all.zzcysj.value=oPartInTime;
				document.all.zzphone.value=oTranPhone;
				document.all.zzname.value=oCustName;
				*/
				document.all.czkje.value=oAllFee;
				//document.all.czkmz.value=oTranFee;
				
				//document.all.beginNo.value=oStoreNo;
				//document.all.endNo.value=oEndStoreNo;
				document.all.show.value="1"; //Ϊ�˳�ֵ��ʱ�� �ж��Ƿ���ת��
				
			}
			if(oOnlyMyFlag=="0")
			{
				//alert("��ת��");
				document.getElementById("Operation_Table2").style.display="block";
				document.getElementById("Operation_Table3").style.display="block";
				document.all.show.value="0"; //Ϊ�˳�ֵ��ʱ�� �ж��Ƿ���ת��
				document.all.fzzhdmc.value=oProjectName;
				document.all.fzzname.value = custName;
				document.all.fzzphone.value=document.all.srv_no.value;
				document.all.fzzcysj.value=oPartInTime;
				document.all.fzzje.value=oMyFee;
				document.all.czkje.value=oAllFee;
				//new ������� begin
				//alert("cardFlag is "+cardFlag+"0-->��� 1-->����");
				if(cardFlag=="0")
				{
					var h=480;
					var w=650;
					var t=screen.availHeight/2-h/2;
					var l=screen.availWidth/2-w/2;
					var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
					//var  returnValue ; 
					var sOpcode = document.getElementById("sOpcodeId");
					var s_opcode=sOpcode.value;
				//	alert("1 "+s_opcode);
					var returnValue=window.showModalDialog('getCardMore.jsp?phoneNo='+document.frm.srv_no.value+"&s_opcode="+s_opcode,"",prop);
					//myPacket.data.add("phoneNo",document.frm.srv_no.value); myPacket.data.add("channelId",channelId); "pwd",document.frm.cus_pass.value);
						
					if(returnValue==null)
					{
						rdShowMessageDialog("û���ҵ���Ӧ�Ŀ��ţ�",0);
						//document.form.phoneNo.focus();
						return false;
					}
					if(returnValue=="")
					{
						rdShowMessageDialog("��û��ѡ�񿨺ţ�",0);
						//document.form.phoneNo.focus();
						return false;
					}
					//new ���ݵ�ѡ��ʵ��
					//alert("���⴦��");
					 
					document.all.beginNo.value = returnValue.split(",")[0];
					document.all.endNo.value=returnValue.split(",")[1];
				 
					//xl add
					//document.all.o_opcode.value = returnValue.split(",")[2];
					//document.all.o_login_accept.value = returnValue.split(",")[3];
			 
				}
				else
				{
					document.all.beginNo.value = oStoreNo;
					document.all.endNo.value=oEndStoreNo;
					 
				}
				//new ������� end
				//document.all.beginNo.value=oStoreNo;
				//document.all.endNo.value=oEndStoreNo;
			}
			//window.location="e251_1.jsp?activePhone=<%=activePhone%>&opCode=e232&opName="+document.all.opname.value;
		}
		

	}

function doPosSubInfo2(packet)
{
		//alert("123");
		var flagConfirm =  packet.data.findValueByName("flag1");
		var oProjectName = packet.data.findValueByName("oProjectName");
		var oPartInTime  = packet.data.findValueByName("oPartInTime");
		var oOnlyMyFlag  = packet.data.findValueByName("oOnlyMyFlag");
		var oAllFee  = packet.data.findValueByName("oAllFee");
		var oMyFee  = packet.data.findValueByName("oMyFee");
		var oStoreNo  = packet.data.findValueByName("oStoreNo");
		var oEndStoreNo  = packet.data.findValueByName("oEndStoreNo");
		var oTranFee  = packet.data.findValueByName("oTranFee");
		var oTranTime   = packet.data.findValueByName("oTranTime");
		var oTranPhone  = packet.data.findValueByName("oTranPhone");
		var oCustName= packet.data.findValueByName("oCustName");
		var phoneFlag =packet.data.findValueByName("phoneFlag"); // 0-->��� 1--������
		var cardFlag =packet.data.findValueByName("cardFlag");   // 0-->��� 1--������
		var custName = packet.data.findValueByName("custName"); 
		//var yczje = packet.data.findValueByName("add_money"); 
		var flagMoney = packet.data.findValueByName("flagMoney"); 
		var o_money = packet.data.findValueByName("o_money");
		//alert("flagMoney is "+flagMoney+" and o_money is "+o_money);
		var newFlag = packet.data.findValueByName("newFlag");
		//alert("newFlag is "+newFlag);
		//xl add begin 1029
		 
		
		//xl add end
		if(flagMoney=="1")
		{
			document.all.yczje.value=o_money;
			document.all.doCfm.disabled=false;
			document.all.doCfm2.disabled=false;
		}
		if(flagMoney=="0")
		{
			document.all.yczje.value="0";
			document.all.doCfm.disabled=false;
			document.all.doCfm2.disabled=false;
		}
		//922 add 
		if(newFlag==1)
		{
			document.all.doCfm4.disabled=false;
			document.all.doCfm2.disabled=true;
		}
		if(newFlag==2)
		{
			document.all.doCfm2.disabled=false;
			document.all.doCfm4.disabled=true;
		}
		//alert("final o_money is "+o_money);
		if(flagConfirm==1)
		{
			var errCode2 =  packet.data.findValueByName("errCode");
			var errMsg2 =  packet.data.findValueByName("errMsg");
			rdShowMessageDialog("����ʧ�ܣ�������룺"+errCode2+",ʧ��ԭ��"+errMsg2);
			return false;
		}
		
		if(flagConfirm==0)
		{
			//rdShowMessageDialog("�����ɹ�!");
			//add ���
			//printCommit();
			//���ر�ҳ�� location=
			//alert("oMyFee is "+oMyFee);
			document.all.grje.value=oMyFee;
			//alert("oOnlyMyFlag is "+oOnlyMyFlag.split(',')+" and oTranPhone is "+oTranPhone);
			if(oOnlyMyFlag=="1")
			{
				//alert("ת��"+oTranFee+" and oTranFee is "+oTranFee+" and oTranTime is "+oTranTime+" and oTranPhone is "+oTranPhone+" and oCustName is "+oCustName);
				document.getElementById("Operation_Table1").style.display="block";
				document.getElementById("Operation_Table3").style.display="block";
				if(phoneFlag=="0")
				{
					var h=480;
					var w=650;
					var t=screen.availHeight/2-h/2;
					var l=screen.availWidth/2-w/2;
					var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
					var  returnValue ; 
					var returnValue=window.showModalDialog('getUserMore.jsp?phoneNo='+document.frm.srv_no.value,"",prop);
					//myPacket.data.add("phoneNo",document.frm.srv_no.value); myPacket.data.add("channelId",channelId); "pwd",document.frm.cus_pass.value);
						
					if(returnValue==null)
					{
						rdShowMessageDialog("û���ҵ���Ӧ���û���",0);
						//document.form.phoneNo.focus();
						return false;
					}
					if(returnValue=="")
					{
						rdShowMessageDialog("��û��ѡ���û���",0);
						//document.form.phoneNo.focus();
						return false;
					}
					//new ���ݵ�ѡ��ʵ��
					//alert("���⴦��");
					 
					document.all.zzname.value = returnValue.split(",")[0];
					document.all.zzphone.value=returnValue.split(",")[1];
					document.all.zzcysj.value=returnValue.split(",")[2];
					document.all.zzje.value=returnValue.split(",")[3];
					
			 
				}
				else
				{
					document.all.zzname.value = oCustName;
					document.all.zzphone.value=oTranPhone;
					document.all.zzcysj.value=oTranTime;
					document.all.zzje.value=oTranFee;
				}
				//new ������� begin
				//alert("cardFlag is "+cardFlag+"0-->��� 1-->����");
				if(cardFlag=="0")
				{
					var h=480;
					var w=650;
					var t=screen.availHeight/2-h/2;
					var l=screen.availWidth/2-w/2;
					var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
					//var  returnValue ; 
					var sOpcode = document.getElementById("sOpcodeId");
					var s_opcode=sOpcode.value;
					//alert("2 "+s_opcode);
					var returnValue=window.showModalDialog('getCardMore.jsp?phoneNo='+document.frm.srv_no.value+"&s_opcode="+s_opcode,"",prop);
					//myPacket.data.add("phoneNo",document.frm.srv_no.value); myPacket.data.add("channelId",channelId); "pwd",document.frm.cus_pass.value);
						
					if(returnValue==null)
					{
						rdShowMessageDialog("û���ҵ���Ӧ�Ŀ��ţ�",0);
						//document.form.phoneNo.focus();
						return false;
					}
					if(returnValue=="")
					{
						rdShowMessageDialog("��û��ѡ�񿨺ţ�",0);
						//document.form.phoneNo.focus();
						return false;
					}
					//new ���ݵ�ѡ��ʵ��
					//alert("���⴦��");
					 
					document.all.beginNo.value = returnValue.split(",")[0];
					document.all.endNo.value=returnValue.split(",")[1];
					//xl add
					//document.all.o_opcode.value = returnValue.split(",")[2];
					//document.all.o_login_accept.value = returnValue.split(",")[3];
					
			 
				}
				else
				{
					document.all.beginNo.value = oStoreNo;
					document.all.endNo.value=oEndStoreNo;
					 
				}
				//new ������� end
				document.all.zzhdmc.value=oProjectName;
				/*document.all.zzcysj.value=oPartInTime;
				document.all.zzphone.value=oTranPhone;
				document.all.zzname.value=oCustName;
				*/
				document.all.czkje.value=oAllFee;
				//document.all.czkmz.value=oTranFee;
				
				//document.all.beginNo.value=oStoreNo;
				//document.all.endNo.value=oEndStoreNo;
				document.all.show.value="1"; //Ϊ�˳�ֵ��ʱ�� �ж��Ƿ���ת��
				
			}
			if(oOnlyMyFlag=="0")
			{
				//alert("��ת��");
				document.getElementById("Operation_Table2").style.display="block";
				document.getElementById("Operation_Table3").style.display="block";
				document.all.show.value="0"; //Ϊ�˳�ֵ��ʱ�� �ж��Ƿ���ת��
				document.all.fzzhdmc.value=oProjectName;
				document.all.fzzname.value = custName;
				document.all.fzzphone.value=document.all.srv_no.value;
				document.all.fzzcysj.value=oPartInTime;
				document.all.fzzje.value=oMyFee;
				document.all.czkje.value=oAllFee;
				//new ������� begin
				//alert("cardFlag is "+cardFlag+"0-->��� 1-->����");
				if(cardFlag=="0")
				{
					var h=480;
					var w=650;
					var t=screen.availHeight/2-h/2;
					var l=screen.availWidth/2-w/2;
					var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
					//var  returnValue ; 
					var sOpcode = document.getElementById("sOpcodeId");
					var s_opcode=sOpcode.value;
				//	alert("1 "+s_opcode);
					var returnValue=window.showModalDialog('getCardMore.jsp?phoneNo='+document.frm.srv_no.value+"&s_opcode="+s_opcode,"",prop);
					//myPacket.data.add("phoneNo",document.frm.srv_no.value); myPacket.data.add("channelId",channelId); "pwd",document.frm.cus_pass.value);
						
					if(returnValue==null)
					{
						rdShowMessageDialog("û���ҵ���Ӧ�Ŀ��ţ�",0);
						//document.form.phoneNo.focus();
						return false;
					}
					if(returnValue=="")
					{
						rdShowMessageDialog("��û��ѡ�񿨺ţ�",0);
						//document.form.phoneNo.focus();
						return false;
					}
					//new ���ݵ�ѡ��ʵ��
					//alert("���⴦��");
					 
					document.all.beginNo.value = returnValue.split(",")[0];
					document.all.endNo.value=returnValue.split(",")[1];
				 
					//xl add
					//document.all.o_opcode.value = returnValue.split(",")[2];
					//document.all.o_login_accept.value = returnValue.split(",")[3];
			 
				}
				else
				{
					document.all.beginNo.value = oStoreNo;
					document.all.endNo.value=oEndStoreNo;
					 
				}
				//new ������� end
				//document.all.beginNo.value=oStoreNo;
				//document.all.endNo.value=oEndStoreNo;
			}
			//window.location="e251_1.jsp?activePhone=<%=activePhone%>&opCode=e232&opName="+document.all.opname.value;
		}
		

	}
</script>
 
 