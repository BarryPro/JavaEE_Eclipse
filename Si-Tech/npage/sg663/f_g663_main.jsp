
<%
/*
 * ����: g663.������������Ա��� 
 * �汾: 1.0
 * ����: 2012/9/3 11:05:33
 * ����: zhangyan
 * ��Ȩ: si-tech
 * update:
*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/public/pubSASql.jsp" %>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String s_loginacc= sLoginAccept;
String s_chnSrc="01";
String opCode=request.getParameter("opCode");
String s_workNo = (String)session.getAttribute("workNo");
String s_passwd = (String)session.getAttribute("password");
String s_phone="";
String s_userPwd="";

String opName=request.getParameter("opName");
String s_orgCode=(String)session.getAttribute("orgCode");
String s_ipAddr = (String)session.getAttribute("ipAddr");
String s_orgId = (String)session.getAttribute("orgId");
String s_belongCode = (String)session.getAttribute("orgCode");
String s_groupId = (String)session.getAttribute("groupId");
%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<title><%=opCode%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/zalidate.js"></script>
	<script src="../public/json2.js" type="text/javascript"></script>	
	<script language="javascript" type="text/javascript" src="f_g663.js"></script>
</head>
<body >
<form  name="frm" action="" method="POST" >
	<input type="hidden" id="hd_loginacc" name ="hd_loginacc"	value= "<%=s_loginacc%>">
	<input type="hidden" id="hd_chnSrc" name ="hd_chnSrc"	value= "<%=s_chnSrc%>">
	<input type="hidden" id="hd_opCode" name ="hd_opCode"	value= "<%=opCode%>">
	<input type="hidden" id="hd_workNo" name ="hd_acc"	value= "<%=s_workNo%>">
	<input type="hidden" id="hd_passwd" name ="hd_passwd"	value= "<%=s_passwd%>">
	<input type="hidden" id="hd_phone" name ="hd_phone"	value= "<%=s_phone%>">
	<input type="hidden" id="hd_userPwd" name ="hd_userPwd"	value= "<%=s_userPwd%>">
	<input type="hidden" id="hd_opType" name ="hd_opType"	value= "m01">
	<input type="hidden" id="hd_unitOffer" name ="hd_unitOffer"	value= "">
	<input type='hidden' id='inputFile' name='inputFile' value='' />
	<input type='hidden' id='filenames' name='filenames' value='' />
	<input type="hidden" id="hd_custId" name ="hd_custId"	value= "">
	<input type="hidden" id="hd_unitChkFlag" name="hd_unitChkFlag" value="0">
	<input type="hidden" id="hd_unitPwdChkFlag" name="hd_unitPwdChkFlag" value="0">
	<input type="hidden" id="hd_retPho" name="hd_retPho" value="0">

	<input type="hidden" id="hd_bizType" name="hd_bizType" value="0">
	<input type="hidden" id="jsonText" name ="jsonText"	value= "">
	<input type="hidden" id="hd_prodAttr" 		name="hd_prodAttr" value = "0">
	<input type="hidden" id="hd_prodAttr1" 		name="hd_prodAttr1" value = "0">
	<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>

	<%@ include file="/npage/include/header.jsp" %>

	<DIV id="Operation_Table">
		<div id="d0" name="d0">
			<div class="title" id="d_1">
				<div id="title_zi">�����û���Ϣ��ѯ</div>
			</div>
			<table id="tb_1">
				<tr>
					<td class="blue" align="center" width="25%">֤������:</th>
					<td width="25%">
						<input type="text" id="t_idIccid" name="t_idIccid" ch_name="֤������" size="20" />	
						<input type="button" class="b_text" value="��ѯ" onclick="fn_selUnit()">	
					</td>	
					<td class="blue" align="center">ECΨһ��ʶ:</th>
					<td>
						<input type="text" id="t_customerNumber" name="t_customerNumber" ch_name="ECΨһ��ʶ" size="20" />	
					</td>	
				<tr>
				<tr>
					<td class="blue" align="center">���ű��:</th>
					<td>
						<input type="text" ch_name="���ű��" id="t_UnitId" name="t_UnitId"/>	
					</td>	
					<td class="blue" align="center">��ҵ��Ʒ����ʵ��<br>Ψһ��ʶ:</th>
					<td>
						<input type="text" ch_name="��ҵ��Ʒ����ʵ��Ψһ��ʶ" id="t_ECProdInstID" name="t_ECProdInstID"/>	
					</td>	
				<tr>		
				<tr>
					<td class="blue" align="center">��Ʒ����:</th>
					<td>
						<input type="text" name="t_prodName" id="t_prodName" ch_name="��Ʒ����"/>	
						<input type="hidden" ch_name="��ƷID" value = "" name="hd_prodId" id="hd_prodId">
					</td>	
					<td class="blue" align="center">EC��ҵ��Ʒʵ��<br>��Ӧ���û�ID:</th>
					<td>
						<input type="text" name="t_ECSubsID" id="t_ECSubsID" ch_name="EC��ҵ��Ʒʵ����Ӧ���û�ID"/>	
					</td>	
				<tr>					
				<tr>
					<td class="blue" align="center">Ʒ������:</th>
					<td>
						<input type="text" ch_name="Ʒ������" name='t_smName' class="InputGrey" value='PA-->����������'/>
						<input type="hidden" name='hd_smCode' value='PA'>	
					</td>	
					<td class="blue" align="center">����ʡ����:</th>
					<td>
						<select id='provid' name='provname' disabled>
							<option value='100'>100-->�����ƶ�</option>
							<option value='200'>200-->�㶫�ƶ�</option>
							<option value='210'>210-->�Ϻ��ƶ�</option>
							<option value='220'>220-->����ƶ�</option>
							<option value='230'>230-->�����ƶ�</option>
							<option value='240'>240-->�����ƶ�</option>
							<option value='250'>250-->�����ƶ�</option>
							<option value='270'>270-->�����ƶ�</option>
							<option value='280'>280-->�Ĵ��ƶ�</option>
							<option value='290'>290-->�����ƶ�</option>
							<option value='991'>991-->�½��ƶ�</option>
							<option value='002'>002-->��������˾</option>
							<option value='311'>311-->�ӱ��ƶ�</option>
							<option value='351'>351-->ɽ���ƶ�</option>
							<option value='371'>371-->�����ƶ�</option>
							<option value='431'>431-->�����ƶ�</option>
							<option value='451' selected>451-->�������ƶ�</option>
							<option value='471'>471-->�����ƶ�</option>
							<option value='531'>531-->ɽ���ƶ�</option>
							<option value='551'>551-->�����ƶ�</option>
							<option value='571'>571-->�㽭�ƶ�</option>
							<option value='591'>591-->�����ƶ�</option>
							<option value='000'>000-->ȫ��ƽ̨</option>
							<option value='731'>731-->�����ƶ�</option>
							<option value='771'>771-->�����ƶ�</option>
							<option value='791'>791-->�����ƶ�</option>
							<option value='851'>851-->�����ƶ�</option>
							<option value='871'>871-->�����ƶ�</option>
							<option value='891'>891-->�����ƶ�</option>
							<option value='898'>898-->�����ƶ�</option>						
						</select>
					</td>	
				<tr>
				<tr>
			        <td class='blue'  align="center" nowrap>���ſͻ�����</td>
			        <td>
			            <jsp:include page="/npage/common/pwd_8.jsp">
			                <jsp:param name="width1" value="16%"  />
			                <jsp:param name="width2" value="34%"  />
			                <jsp:param name="pname" value="product_pwd"  />
			                <jsp:param name="pwd" value=""  />
			            </jsp:include>
			            <input type='button' class='b_text' id='chk_productPwd' name='chk_productPwd' onClick='chkProductPwd()' value='У��' />
			            <font class="orange">*</font>
			        </td>
					<td class="blue" align="center">����¼�뷽ʽ:</th>
					<td>
						<input type="radio" name ="r_opType" id ="r_opType" value="1" checked/>�ļ�
					</td>	
				<tr>				
					
					<!-- hejwa add 2015/5/25 10:18:00  �������ƣ�����Э���ڼ��Ų�Ʒ������������SA�����̷�չѡ������ĺ� -->
		<tr>
			<td class="blue"  align="center">���۴�����</td>
			<td >
				<input type="text" name="F1006" id="F1006" readOnly class="InputGrey" >
				<input type="button" value="��ѯ" class="b_text" onclick="selSales();" >
			</td>
			
			<td class="blue"  align="center">��Ա�ײ��ۿ�</td>
			<td>
				<select id="mem_off_disc" name="mem_off_disc">
					<option value="100" selected>���ۿ�</option>
					<option value="70" >7��</option>
				</select>
			</td>
		</tr>
		
		
		<tr>
			<td class="blue"  align="center">���ѷ�ʽ </td>
			<td>
					<select name="pay_flag" id="pay_flag">
        	    <option value="0" selected>0--����ͳ��</option> 
            	<option value="1">1--���˸���</option>
          </select>
			</td>
			
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			
		</tr>
		
		
		
			</table>
		</div>
		<div class="title" id="d_ttl2" style="display:none">
			<div id="title_zi">��Ա��Ϣ�б�</div>
		</div>
		<table id="tb_ifo2" style="display:none">
			<tr>
				<th class="blue" align="center">��Ա����</th>
				<th class="blue" align="center">��Ա���û�ID</th>
				<th class="blue" align="center">��Ա��Ʒ����</th>
				<th class="blue" align="center">��Ա��Ʒ����ʵ��Ψһ��ʶ</th>
				<th class="blue" align="center">����</th>
			<tr>
		</table>		
		<table id="tb_opr2" style="display:none">
			<tr> 
				<td align = "center">
					<input class="b_text" type="button"  value="����" name="b_addMem" onclick="fn_addMeb()" >						
				</td>
			</tr>
		</table>		
			
		<div name="d1" id="d1">
			<div class="title" id="d_ttlf2">
				<div id="title_zi">��Աԭ�Ӳ�Ʒ��Ϣ</div>
			</div>
			<table id="tb_ifof2" >
				<tr>
					<th align="center" >�ʷѴ���</th>
					<th align="center" >�ʷ�����</th>
					<th align="center" >ԭ�Ӳ�Ʒ����</th>
					<th align="center" >������Ʒ������</th>
					<th align="center" >��Ʒ����ʵ��Ψһ��ʶ</th>
					<th align="center" >����</th>
				</tr>							
			</table>		
			<table >
				<tr>
					<td align="center" >
						<input type="button" class="b_text" value="����" onclick="fn_addMeb2()">
					</td>
				</tr>							
			</table>				
		</div>			
		
			
		<div name="d2" id="d2">
			<div class="title" >
				<div id="title_zi">������Ϣ</div>
			</div>
			<table id="tb_oIfo">
				<tr>
					<th align="center" >��Ϣ����<input type="hidden" name="hd_mngHd"></th>
					<th align="center" >��Ϣֵ</th>
					<th align="center" >����</th>
				</tr>							
			</table>	
			<table >
				<tr>
					<td align="center" >
						<input type="button" class="b_text" value="����" onclick="fn_addOther()">
					</td>
				</tr>							
			</table>					
		</div>		
		<div name="d3" id="d3">		
			<div class="title" id="d_ttlf2">
				<div id="title_zi">��Ա�ļ�</div>
			</div>
			<table id="tb_ifof3">
				<tr>
					<td align = "center"><input type="file"  value="" name="b_addMemf" id="b_addMemf" >	</td>	
					<td align="left">
						<font color='red' >
							�ļ���ÿ������ռһ��,��:&nbsp&nbsp1064802090011
							<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp14702090014
						</font>
					</td>		
				</tr>
			</table>
		</div>
			
		<table>
			<tr> 
				<td  id="footer">
					<input class="b_foot" type="button" name=btnChk id='btnChk' value="��һ��"
						onClick="fn_chkIfo();">
					<input class="b_foot" type="button" name=btnClr value="���"
						onClick="location.reload();">
					<input class="b_foot" type="button" name=btnCls value="�ر�"
						onClick="removeCurrentTab();">								
				</td>
			</tr>
		</table>	
	</div>
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
</form>
<script>		
	
	

/**
 * hejwa add 2015/5/25 10:19:13
 * ��̨��Ա��wangleic
 * �������ƣ�����Э���ڼ��Ų�Ʒ������������SA�����̷�չѡ������ĺ�
 * ���ӳ�Ա�������ԣ����۴����̣�ѡ����ڲ����Ա��
 * ���������Է���3690ģ�����������۴����̾��У������ѯ��ť�����ù���ҳ���ѯ
 */
// ��ѯ���۴�����
function selSales(){
    var pageTitle = "���۴����̲�ѯ";
    var fieldName = "�����̴���|����������|";
    /* ningtn �����Ż����ſͻ�SA������ϵͳ�ĺ�*/
    // ningtn SQLע����졣
		var sqlStr="90000017";
		var params = "<%=s_groupId%>" + "|";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "1|0|";
    var retToField = "F1006|";
    PubSimpSelSales(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params);
}

function PubSimpSelSales(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params)
{
    var path = "/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    path = path + "&params=" + params;
    retInfo = window.showModalDialog(path);
    if(typeof(retInfo)=="undefined")      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
}



var stepNum;
$(document).ready(
	function()
	{
		$("#d0").show("slow");	
		$("#d1").hide();	
		$("#d2").hide();	
		$("#d3").hide();	
		stepNum=1;
	}
);
	
	/*ɾ����ѡ��Ĳ�Ʒ*/
	function delrow(k)
	{
		$(k).parent().parent().remove(); 
	}
	/* У�鼯�Ų�Ʒ���� */
	function chkProductPwd()
	{
		document.all.hd_unitPwdChkFlag.value="0";
		if ( document.all.hd_unitChkFlag.value!="1" )
		{
			rdShowMessageDialog("�����ѯ������Ϣ");
			return false;
		}
		
		var cust_id = document.all.hd_custId.value;
		var Pwd1 = document.all.product_pwd.value;
		var checkPwd_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s7983/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
		checkPwd_Packet.data.add("retType","checkPwd");
		checkPwd_Packet.data.add("cust_id",cust_id);
		checkPwd_Packet.data.add("Pwd1",Pwd1);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet = null;
    }
	
	function doProcess(packet)
	{
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMessage=packet.data.findValueByName("retMessage");
		
		var backArrMsg = packet.data.findValueByName("backArrMsg");
		var backArrMsg1 = packet.data.findValueByName("backArrMsg1");
		var backArrMsg2=packet.data.findValueByName("backArrMsg2");
		
		self.status="";
		if(retType == "checkPwd") //���ſͻ�����У��
		{
			if(retCode == "000000")
			{
				var retResult = packet.data.findValueByName("retResult");
				if (retResult == "false") 
				{
					rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
					frm.product_pwd.value = "";
					frm.product_pwd.focus();
					document.all.hd_unitPwdChkFlag.value="0";
					return false;
				} 
				else 
				{
					rdShowMessageDialog("�ͻ�����У��ɹ���",2);
					document.all.product_pwd.disabled=true;
					document.all.hd_unitPwdChkFlag.value="1";
				}
			}
			else
			{
				rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
				document.all.hd_unitPwdChkFlag.value="0";
				return false;
			}
		}
	}    

	function fn_addMeb()
	{
		
		/*������Ա���ҳ��*/
		var retVal=window.showModalDialog("f_g663_addMeb.jsp"
			+"?hd_loginacc="+document.all.hd_loginacc.value
			+"&hd_chnSrc="+document.all.hd_chnSrc.value
			+"&hd_opCode="+document.all.hd_opCode.value
			+"&hd_workNo="+document.all.hd_workNo.value
			+"&hd_passwd="+document.all.hd_passwd.value
			+"&hd_phone="+document.all.hd_phone.value
			+"&hd_userPwd="+document.all.hd_userPwd.value
			+"&t_UnitId="+document.all.t_UnitId.value
			+"&hd_unitOffer="+document.all.hd_unitOffer.value
			+"&hd_prodId="+document.all.hd_prodId.value
			+"&t_ECSubsID="+document.all.t_ECSubsID.value
			,"","dialogWidth=800px;dialogHeight=600px");	

		if ($("#tb_ifo2 th").length==0 )
		{
			$("#tb_ifo2").append("<tr>"
				+"<th align='center'>��Ա����</th>"
				+"<th align='center'>��Ա���û�ID</th>"
				+"<th align='center'>��Ա��Ʒ����</th>"
				+"<th align='center'>��Ա��Ʒ����ʵ��Ψһ��ʶ</th>"
				+"<th align='center'>����</th>	"
			+"</tr>");
		}

		if ( typeof (retVal)!="undefined" )
		{
	
		
			
		var mbIfo=retVal.split("#")[0];

			$("#tb_ifo2").append("<tr>"
				+"<td align='center'>"
					+"<input type='text' id='mebPho' name='mebPho' value='"+mbIfo.split("@")[0]+"' class='InputGrey'>"	
					+"<input type='hidden' id='mebIfo' name='mebIfo' value='"+retVal+"' class='InputGrey'>"	
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' id='mebUsrId' name='mebUsrId' value='"+mbIfo.split("@")[1]+"' class='InputGrey'>"	
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' id='mebProdId' name='mebProdId' value='"+mbIfo.split("@")[4]+"' class='InputGrey'>"	
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' id='mebOdId' name='mebOdId' value='"+mbIfo.split("@")[2]+"' class='InputGrey'>"	
				+"</td>"
				+"<td align='center'>"
					+"<img src='/nresources/default/images/task-item-close1.gif' name = 'i_delProd'"
						+"style='cursor:Pointer;' class='del_cls'  alt='' "
						+"onclick='delrow(this)'>"	
				+"</td>"	
			+"</tr>");		
		}
	}
	

	function fn_chkIfo ()
	{
		if ( 1==stepNum )
		{
			if ( document.all.hd_unitChkFlag.value!="1" )
			{
				rdShowMessageDialog("�����ѯ������Ϣ",0);
				//stepNum=stepNum-1;
				return false;
			}
			if ( document.all.hd_unitPwdChkFlag.value!="1")
			{
				rdShowMessageDialog("����У�鼯�ſͻ�����",0);
				//stepNum=stepNum-1;
				return false;	
			}
			
			if ( 0==$(":radio:checked").val() )
			{
				$("#d_ttl2").show("slow");		
				$("#tb_ifo2").show("slow");		
				$("#tb_opr2").show("slow");		
			}
			else if (1==$(":radio:checked").val())
			{
				$("#d1").show("slow");		
			}
			
			else
			{
				rdShowMessageDialog("����ѡ���������",0);
				//stepNum=stepNum-1;
				return false;	
			}
			$("#tb_1 input").attr("disabled" , "ture");
		}
		else if ( 2==stepNum )
		{
			if ( 0==$(":radio:checked").val() ) {
			}			
			else if (1==$(":radio:checked").val())
			{
				$("#d2").show("slow");		
			}			
		}
		else if ( 3==stepNum )
		{ 
			if ( 0==$(":radio:checked").val() )
			{

			}
			else if (1==$(":radio:checked").val())
			{
				$("#d3").show("slow");		
				$("#btnChk").val("ȷ��");		
			}			
		}
		else if ( 4==stepNum )
		{
			if ( 0==$(":radio:checked").val() )
			{

			}
			else if (1==$(":radio:checked").val())
			{
				document.frm.target="hidden_frame";
				document.frm.encoding="multipart/form-data";
				document.frm.action="f_g663_upload.jsp";
				document.frm.method="post";
				for ( var i=0;i<document.getElementsByName("t_otherCode").length;i++ )
				{
					if ( fn_notNull( document.getElementsByName("t_otherCode")[i])!=0 ) return false;
						
					if ( fn_notNull( document.getElementsByName("t_otherValue")[i])!=0 )  return false;		
		
					if (document.getElementsByName("t_otherCode")[i].value.length!=3  )
					{
						rdShowMessageDialog("������Ϣ���������λ",0);
						return false;
					}
					 
				}				
				if ("1"!=rdShowConfirmDialog("ȷ���ύ��?"))
				{
					return false;
				}
				$("#btnChk").attr("disabled" , true)				
				document.frm.submit();	
			}	
		}
		stepNum=stepNum+1; 
	}
	
	function refMain()
	{
		var ipt = new input();
		
		var a_pho=$("#hd_retPho").val().substring(0,$("#hd_retPho").val().length-1);

		for ( var i=0;i<1;i++ )
		{
			
			var v_pho=a_pho.split("@")[i];
								

			var s_pServId="";
			var s_pAttrKey="";
			var s_pAttrValue="";
			for ( var j=0;j<document.getElementsByName("bs_prodid").length;j++ )
			{
				var pIfo = new ProdInfo();
				pIfo.setOfferId(document.getElementsByName("bs_OfrId")[j].value);
				pIfo.setProdID(document.getElementsByName("bs_prodid")[j].value);
				pIfo.setPkgProdID(document.getElementsByName("bs_pkgid")[j].value);
				var a_retStr =  document.getElementsByName("a_retStr")[j].value;
				if(""!=a_retStr){
					s_pServId=a_retStr.split("~")[0];
					s_pAttrKey=a_retStr.split("~")[1];
					s_pAttrValue=a_retStr.split("~")[3];
					for ( var k=0;k<s_pServId.split("@").length;k++ )
					{
						
							var pAIfo= new ProdAttrInfo();
							pAIfo.setServiceID(s_pServId.split("@")[k]);
							pAIfo.setAttrKey(s_pAttrKey.split("@")[k]);
							pAIfo.setAttrValue(s_pAttrValue.split("@")[k]);
							pIfo.setProdAttrInfo(pAIfo);		
						

					}
					
				}
				var a_retStr_1 =  document.getElementsByName("a_retStr_1")[j].value;
				if(""!=a_retStr_1){
					s_pServId=a_retStr_1.split("~")[0];
					s_pAttrKey=a_retStr_1.split("~")[1];
					s_pAttrValue=a_retStr_1.split("~")[3];
					for ( var k=0;k<s_pServId.split("@").length;k++ )
					{
						
							var pAIfo= new ProdServiceAttrInfo();
							pAIfo.setServiceID(s_pServId.split("@")[k]);
							pAIfo.setAttrKey(s_pAttrKey.split("@")[k]);
							pAIfo.setAttrValue(s_pAttrValue.split("@")[k]);
							pIfo.setProdServiceAttrInfo(pAIfo);		
						

					}
					
				}	
				
				ipt.setProdInfo(pIfo);
			}	
			
			for ( var ii=0;ii<document.getElementsByName("t_otherCode").length;ii++ )
			{
				var oIfo = new OtherInfo();
				oIfo.setInfoCode(document.getElementsByName("t_otherCode")[ii].value);
				oIfo.setInfoValue(document.getElementsByName("t_otherValue")[ii].value);
				ipt.setOtherInfo(oIfo);	
			}				
			
		}

		var qka = new jqk();
		qka.setInput(ipt);
		qka.setSa($("#F1006").val());	
		qka.setMemDiscount($("#mem_off_disc").val());	
		qka.setIpAddress("<%=s_ipAddr%>");		
		qka.setIdIccid(document.all.t_idIccid.value);			
		qka.setCustomerNumber(document.all.t_customerNumber.value);			
		qka.setUnitId(document.all.t_UnitId.value);			
		qka.setECProdInstID(document.all.t_ECProdInstID.value);			
		qka.setECSubsID(document.all.t_ECSubsID.value);			
		qka.setPayFlag(document.all.pay_flag.value);	

		/*ƴjson��*/
		var myJSONText = JSON.stringify(qka,function(key,value){
			return value;
		});
			
		document.getElementById("jsonText").value=myJSONText;	
		document.frm.target="_self";
	  document.frm.encoding="application/x-www-form-urlencoded";		
		document.frm.action="f_g663_cfm.jsp";
		document.frm.submit();		
	}
	
	function doUnLoading()
	{
	
	  stepNum="4"
		$("#btnChk").attr("disabled",false);
		unLoading();
	}
	
	function fn_selUnit()
	{
		document.all.hd_unitChkFlag.value="0";
		var a_chkIfo = [ document.all.t_idIccid,document.all.t_UnitId,document.all.t_customerNumber ];
		
		if (0!=fn_chkAllNull(a_chkIfo)) return false;
		if (0!=fn_forInt(document.all.t_UnitId)) return false;
		if (0!=fn_forInt(document.all.t_customerNumber)) return false;

		var s_unitIfo=window.showModalDialog("f_g663_unitIfo.jsp"
			+"?hd_loginacc="+document.all.hd_loginacc.value
			+"&hd_chnSrc="+document.all.hd_chnSrc.value
			+"&hd_opCode="+document.all.hd_opCode.value
			+"&hd_workNo="+document.all.hd_workNo.value
			+"&hd_passwd="+document.all.hd_passwd.value
			+"&hd_phone="+document.all.hd_phone.value
			+"&hd_userPwd="+document.all.hd_userPwd.value
			+"&t_UnitId="+document.all.t_UnitId.value
			+"&t_customerNumber="+document.all.t_customerNumber.value
			+"&t_idIccid="+document.all.t_idIccid.value
			+"&hd_opType="+document.all.hd_opType.value
			,"","dialogWidth=800px;dialogHeight=600px");

		if ( typeof (s_unitIfo)!="undefined" )
		{
			document.all.t_idIccid.value=s_unitIfo.split("@")[0];
			document.all.t_UnitId.value=s_unitIfo.split("@")[2];
			document.all.t_customerNumber.value=s_unitIfo.split("@")[3];
			document.all.hd_unitOffer.value=s_unitIfo.split("@")[4];
			document.all.t_prodName.value=s_unitIfo.split("@")[5];
			document.all.hd_prodId.value=s_unitIfo.split("@")[6];
			//document.all.t_customerNumber.value=a_unitIfo.split("@")[3];
			document.all.t_ECProdInstID.value=s_unitIfo.split("@")[7];
			document.all.t_ECSubsID.value=s_unitIfo.split("@")[8];
			document.all.hd_custId.value=s_unitIfo.split("@")[13];
			document.all.hd_bizType.value=s_unitIfo.split("@")[14];
			document.all.hd_unitChkFlag.value="1";
			
			$("#t_idIccid").attr("disabled" , true);
			$("#t_UnitId").attr("disabled" , true);
			$("#t_customerNumber").attr("disabled" , true);
			$("#t_prodName").attr("disabled" , true);
			$("#t_ECProdInstID").attr("disabled" , true);
			$("#t_ECSubsID").attr("disabled" , true);
			
			if(s_unitIfo.split("@")[15]!="1"){//��ֱ�ܿͻ���־
				$("#mem_off_disc").find("option[value='60']").remove();
			}
		}
	}

	
function fn_qryAddOfr()
{
	var s_addOfr=window.showModalDialog("f_g663_qryOfr.jsp"
		+"?s_loginacc=<%=s_loginacc%>"
		+"&s_chnSrc=<%=s_chnSrc%>"
		+"&s_opCode=<%=opCode%>"
		+"&s_workNo=<%=s_workNo%>"
		+"&s_passwd=<%=s_passwd%>"
		+"&s_phone=<%=s_phone%>"
		+"&s_userPwd=<%=s_userPwd%>"
		+"&r_opType="+$("#r_opType").val()
		+"&hd_bizType="+$("#hd_bizType").val()
		,"","dialogWidth=800px;dialogHeight=600px");
	if (  typeof (s_addOfr)!="undefined"  )
	{
		$("#t_OfferId").val(s_addOfr.split("@")[0]);
		$("#t_OfferName").val(s_addOfr.split("@")[1]);
		$("#t_ProdId").val(s_addOfr.split("@")[2]);		
	}	
}	


function fn_addMeb2()
{
	var opType="";
	for ( var i=0;i<document.getElementsByName("r_opType").length;i++ )
	{
		if ( document.getElementsByName("r_opType")[i].checked==true )
		{
			opType=document.getElementsByName("r_opType")[i].value
		}
	}
	
	var s_bsProd=window.showModalDialog("f_g663_bsProd.jsp"
		+"?s_loginacc=<%=s_loginacc%>"
		+"&s_chnSrc=<%=s_chnSrc%>"
		+"&s_opCode=<%=opCode%>"
		+"&s_workNo=<%=s_workNo%>"
		+"&s_passwd=<%=s_passwd%>"
		+"&s_phone=<%=s_phone%>"
		+"&s_userPwd=<%=s_userPwd%>"
		+"&s_unidId="+$("#t_UnitId").val()
		+"&s_unitOffer="+$("#hd_unitOffer").val()
		+"&s_prodId="+$("#hd_prodId").val()
		+"&r_opType="+opType
		,"","dialogWidth=800px;dialogHeight=600px");
	var a_bsIfo =s_bsProd.split("|")[0]; 
	var a_retStr =s_bsProd.split("|")[1]; 
	var a_retStr_1 =s_bsProd.split("|")[2];
	document.all.hd_prodAttr.value=a_retStr;
	document.all.hd_prodAttr1.value=a_retStr_1;
	var a_servId =a_retStr.split("@")[1]; 
	var a_addId =a_retStr.split("@")[2];
	var a_addName =a_retStr.split("@")[3]; 
	var a_addDef =a_retStr.split("@")[4]; 
	var a_ifNeeds =a_retStr.split("@")[5]; 
	
	
	
	$("#a_bsIfo").val(a_bsIfo);
	$("#a_servId").val(a_servId);
	$("#a_addId").val(a_addId);
	$("#a_addName").val(a_addName);
	$("#a_addDef").val(a_addDef);
	$("#a_ifNeeds").val(a_ifNeeds);
	
	if ($("#tb_ifof2 th").length==0 )
	{
		$("#tb_ifof2").append("<tr>"
			+"<th align='center'>�ʷѴ���</th>"
			+"<th align='center'>�ʷ�����</th>"
			+"<th align='center'>ԭ�Ӳ�Ʒ����</th>"
			+"<th align='center'>������Ʒ������</th>"
			+"<th align='center'>��Ʒ����ʵ��Ψһ��ʶ</th>"
			+"<th align='center'>����</th>	"
		+"</tr>");
	}
	$("#tb_ifof2").append("<tr>"
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='' value='"+	a_bsIfo.split("@")[0]+"'>"
			+"</td>"	
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='' value='"+	a_bsIfo.split("@")[1]+"'>"
			+"</td>"	
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='bs_prodid' value='"+	a_bsIfo.split("@")[2]+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_bsIfos' value='"+	a_bsIfo+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='bs_OfrId' value='"+	a_bsIfo.split("@")[0]+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_servIds' value='"+a_servId+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_addIds' value='"+a_addId+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_addNames' value='"+a_addName+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_addDefs' value='"+a_addDef+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_ifNeedss' value='"+a_ifNeeds+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_retStr' value='"+a_retStr+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_retStr_1' value='"+a_retStr_1+"'>"
				

			+"</td>"
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='bs_pkgid' value='"+	a_bsIfo.split("@")[3]+"'>"
			+"</td>"
			+"<td align='center'><input type='text' class='InputGrey' readOnly name='bs_odrId' value='"+	a_bsIfo.split("@")[4]+"'></td>"
			+"<td align='center'>"
				+"<img src='/nresources/default/images/task-item-close1.gif' name = 'i_delOther'"
					+"style='cursor:Pointer;' class='del_cls'  alt='ɾ��ѡ�����Ϣ' "
					+"onclick='delrow(this)'>"	
			+"</td>	"
		+"</tr>");
}

	function fn_addOther()
	{
		if ( document.getElementsByName("hd_mngHd").length==0 )
		{
			$("#tb_oIfo").append("<tr>"
				+"<th align='center'><input type='hidden' name='hd_otherHd'>��Ϣ����</th>"
				+"<th align='center'>��Ϣֵ</th>"
				+"<th align='center'>ɾ��</th>	"
			+"</tr>");
		}	

		$("#tb_oIfo").append("<tr>"
			+"<td align='center'>"
				+"<input type='text' name='t_otherCode' value=''  maxlength='3' ch_name='��Ϣ����' >"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' name='t_otherValue' value=''  maxlength='256' ch_name='��Ϣֵ' >"
			+"</td>"		
			+"<td align='center'>"
				+"<img src='/nresources/default/images/task-item-close1.gif' name = 'i_delOther'"
					+"style='cursor:Pointer;' class='del_cls'  alt='ɾ��ѡ�����Ϣ' "
					+"onclick='delrow(this)'>"	
			+"</td>"		
		+"</tr>");
	}	
</script>
</body>
</html>
