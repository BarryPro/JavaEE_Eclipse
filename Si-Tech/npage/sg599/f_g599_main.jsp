
<%
/*
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
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String s_passwd = (String)session.getAttribute("password");
String s_regCode = (String)session.getAttribute("regCode");
String s_orgCode = (String)session.getAttribute("orgCode");
String s_ipAddr = (String)session.getAttribute("ipAddr");
String s_orgId = (String)session.getAttribute("orgId");
String s_belongCode = (String)session.getAttribute("orgCode");
String s_groupId = (String)session.getAttribute("groupId");
		
String s_sqlClassCode=	"select nvl(b.innet_type,'99') as class_code  "
	+" from dLoginMsg a, sTownCode b "
	+" where a.login_no ='"+workNo+"' and a.group_id = b.group_id(+)";
String s_classCode="";
%>
<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=s_regCode%>">
	<wtc:sql><%=s_sqlClassCode%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rst_classCode" scope="end"/> 
<%
if ( rst_classCode.length!=0 )
{
	s_classCode=rst_classCode[0][0];
}
%>	
				
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<title><%=opCode%></title>
	<script language="javascript" type="text/javascript" src="f_g599_input.js"></script>
	<script language="javascript" type="text/javascript" src="/npage/public/zalidate.js"></script>
	<script src="../public/json2.js" type="text/javascript"></script>
</head>
<body >
<form  name="frm" action="" method="POST" >
	<input type="hidden" id="hd_opCode" name	="hd_opCode"	value= "<%=opCode%>">
	<input type="hidden" id="hd_opName" name	="hd_opName"	value= "<%=opName%>">
	<input type="hidden" id="hd_accept" name	="hd_accept"	value= "<%=sLoginAccept%>">
	<input type="hidden" id="hd_unitSelFlg" 	name="hd_unitSelFlg" value = "0">
	<input type="hidden" id="hd_prodAttr" 		name="hd_prodAttr" value = "0">
	<input type="hidden" id="hd_prodAttr1" 		name="hd_prodAttr1" value = "0">
	<%@ include file="/npage/include/header.jsp" %>

	<DIV id="Operation_Table">

		<div class="title" name="d_unitIfo" id="d_unitIfo">
			<div id="title_zi">������֤</div>
		</div>
		<table width="100%" name="tb_unitIfo" id="tb_unitIfo">
			<tr>
				<td class="blue" align="center" >֤������:</td>
				<td>
					<input type="text" id="t_idIccid" name="t_idIccid" ch_name="֤������" size="20" />	
					<input type="button" class="b_text" value="��ѯ" onclick="fn_selUnit()">	
					<font color="red">*</font>
				</td>	
				<td class="blue" align="center">���ſͻ�ID:</td>
				<td>
					<input type="text" id="t_custId" name="t_custId" ch_name="���ſͻ�ID" size="20" />	
					<font color="red">*</font>
				</td>	
			<tr>	
			<tr>
				<td class="blue" align="center">���ű��:</td>
				<td>
					<input type="text" id="t_unitId" name="t_unitId" ch_name="���ű��" size="20" />	
					<font color="red">*</font>
				</td>	
				<td class="blue" align="center">EC���ſͻ�����:</td>
				<td>
					<input type="text" id="t_customerNumber" name="t_customerNumber" ch_name="EC���ſͻ�����" size="20" />	
					<font color="red">*</font>
				</td>	
			<tr>
			<tr>
				<td class="blue" align="center">���ſͻ�����:</td>
				<td>
					<input type="text" id="t_unitName" name="t_unitName" size="20" ch_name="���ſͻ�����" class="InputGrey"/>	
					<font color="red">*</font>
				</td>	
				<td class="blue" align="center">ҵ�����:</td>
				<td>
					<select name="s_servCode" id="s_servCode" ch_name="ҵ�����">
						<option value="$$$$$$">---��ѡ��---</option>
						<%
						String s_sqlSrvCode="select external_code,biztypename , main_type from sBizTypeCode where sm_code = 'PA' and to_number(external_code)<800 order by external_code asc ";
						%>
						<wtc:pubselect name="sPubSelect" outnum="3" routerKey="region" routerValue="<%=s_regCode%>">
							<wtc:sql><%=s_sqlSrvCode%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="rst_srvCode" scope="end"/> 	
					
						<%
						for (int i=0;i<rst_srvCode.length;i++)
						{
						%>
							<option value="<%=rst_srvCode[i][0]%>@<%=rst_srvCode[i][2]%>"><%=rst_srvCode[i][0]%>--><%=rst_srvCode[i][1]%></option>
						<%
						}
						%>												
					</select>
					<font color="red">*</font>
				</td>	
			<tr>		
			<tr>
				<td class="blue" align="center">���Ų�Ʒ:</td>
				<td colspan="3">
					<input type="text" name="t_ofrIfo" class="InputGrey" size="60" readOnly ch_name="���Ų�Ʒ"/>
					<input type="hidden" name="hd_offerId" size="20" />
					<input type="button" class="b_text" value="ѡ��" onclick="fn_selProd()">	
					<font color="red">*</font>
				</td>		
			<tr>			
			<tr>
				<td class="blue" align="center">���۴�����:</td>
				<td colspan="3">
					<input type="text" name="t_agent" class="InputGrey" size="60" readOnly ch_name="���۴�����"/>
					<input type="button" class="b_text" value="ѡ��" onclick="selSales()">	
				</td>		
			<tr>											
		</table>		
		<div class="title" id="d_bizIfo" style="display:none">
			<div id="title_zi">ҵ����Ϣ</div>
		</div>	
		<table width="100%"  id="tb_bizIfo" style="display:none">
			<tr>
				<td class="blue" align="center">��ҵ��Ʒ����:</td>
				<td>
					<input type="text" name="t_entType" class="InputGrey" ch_name="��ҵ��Ʒ����" readOnly />	
					<font color="red">*</font>
				</td>	
				<td class="blue" align="center">��ҵ��Ʒ����ʵ��Ψһ��ʶ:</td>
				<td>
					<input type="text" name="t_prodInstIDU" ch_name="��ҵ��Ʒ����ʵ��Ψһ��ʶ" class="InputGrey" readOnly/>	
					<input type="button" class="b_text" name="b_prodInstID" onclick="fn_getProdInstID()" value="��ȡ" >
					<font color="red">*</font>
				</td>	
			<tr>	
			<tr>
				<td class="blue" align="center">�û�Ψһ��ʶ:</td>
				<td>
					<input type="text" id = 't_usrId' name="t_usrId" ch_name="�û�Ψһ��ʶ" class="InputGrey" readOnly/>	
					<input type="button" class="b_text" value="��ȡ" name="b_getUsrId" onclick="fn_getUsrId()">
					<font color="red">*</font>
				</td>	
				<td class="blue" align="center">�������:</td>
				<td>
					<input type="text" ch_name="�������" name="t_bizServCode" maxlength='128' />	
					<font color="red">*</font>
				</td>	
			<tr>				
			<tr>
				<td class="blue" align="center">��������Ȩ��ʽ:</td>
				<td>
					<select  name="s_autoMode" ch_name="��������Ȩ��ʽ" >
						<option value="$$$$$$" >---��ѡ��---</option>
						<option value="0" >0-->��ȷƥ��</option>
						<option value="0" >1-->ģ��ƥ��</option>
					</select>	
					<font color="red">*</font>
				</td>	
				<td class="blue" align="center">��ҵ��Ʒʵ����Ӧ����ҵ:</td>
				<td>
					<select name="s_indId" ch_name="��ҵ��Ʒʵ����Ӧ����ҵ"   >
						<option value="$$$$$$" >---��ѡ��---</option>
						<option value="01">01-->������ҵ</option>
						<option value="02">02-->��������</option>
						<option value="03">03-->�����ͼҾ�</option>
						<option value="04">04-->��ͨ����</option>
						<option value="05">05-->��ҵ����</option>
						<option value="06">06-->ҽ������</option>
						<option value="07">07-->���ڷ���</option>
						<option value="08">08-->ũҵ</option>
						<option value="09">09-->ˮ��</option>
					</select>	
					<font color="red">*</font>
				</td>	
			<tr>	
			<tr>
				<td class="blue" align="center">�Ƿ�֧������ǩ��:</td>
				<td>
					<select  name="s_isText" ch_name="�Ƿ�֧������ǩ��" onchange="fn_chgIsText()" >
						<option value=""  >---��ѡ��---</option>
						<option value="0" >0-->��֧��</option>
						<option value="1" >1-->֧��</option>
					</select>	
					<font color="red">*</font>
				</td>	
				<td class="blue" align="center">ȱʡǩ������:</td>
				<td>
					<select name ="s_defLan" ch_name="ȱʡǩ������" onchange="fn_chgDefLan()" disabled>
						<option value="" >---��ѡ��---</option>
						<option value="0" >0-->����</option>
						<option value="1" >1-->Ӣ��</option>
					</select>	
					<font color="red">*</font>
				</td>	
			<tr>	
			<tr>
				<td class="blue" align="center" >Ӣ������ǩ��:</td>
				<td>
					<input type="text" name="t_enText" ch_name="Ӣ������ǩ��" />	
					<font color="red">*</font>
				</td>	
				<td class="blue" align="center">��������ǩ��:</td>
				<td>
					<input type="text" name="t_chText" ch_name="��������ǩ��" />	
					<font color="red">*</font>
				</td>	
			<tr>												
		</table>	
					
		<div class="title" id="d_prodIfo" style="display:none">
			<div id="title_zi">��Ʒ��Ϣ</div>
		</div>	
		<table width="100%" id="tb_prodIfo"style="display:none"></table>	
		
		<table id="tb_prodIfoAdd" style="display:none">
			<tr> 
				<td align = "center">
					<input class="b_text" type="button" name="b_addProd" value="����" onclick="fn_AddProd()" >						
				</td>
			</tr>
		</table>					
		<div class="title" id="d_ecIfo" style="display:none">
			<div id="title_zi">EC�����������Ϣ</div>
		</div>	
		<table id="tb_ecIfo"style="display:none">	
			<tr>
				<td class="blue" align="center">EC���������:</td>
				<td>
					<input type="text" name="t_ecBsCode" ch_name="EC���������"/>	
				</td>	
				<td class="blue" align="center">EC��������ŵ�����:</td>
				<td>
					<select name="s_ecBsAttr" ch_name="EC��������ŵ�����">
						<option value="$$$$$$" >---��ѡ��---</option>
						<option value="01" >01-->SMS</option>
						<option value="02" >02-->MMS</option>
						<option value="03" >03-->WAPPush</option>
					</select>	
				</td>	
			<tr>	
			<tr>
				<td class="blue" align="center">ҵ����ط�ʽ:</td>
				<td colspan="3">
					<select name="s_ecMod" ch_name="ҵ����ط�ʽ">
						<option value="$$$$$$" >---��ѡ��---</option>
						<option value="01" >01-->����</option>
						<option value="02" >02-->SMS</option>
						<option value="03" >03-->GPRS</option>
						<option value="04" >04-->MMS</option>
					</select>	
				</td>	
			<tr>															
		</table>		
		
		<div class="title" id="d_mIfo" style="display:none">
			<div id="title_zi">����Ա��Ϣ</div>		
		</div>	
		<table id="tb_mIfo" style="display:none">	
			<tr>
				<th class="blue" align="center"><input type="hidden" name="hd_mngHd">EC����Ա��ʶ</th>
				<th class="blue" align="center">EC��������</th>
				<th class="blue" align="center">EC����Ա�ֻ���</th>
				<th class="blue" align="center">����</th>	
			<tr>															
		</table>
		<table id="tb_mOpr" style="display:none">
			<tr> 
				<td align = "center">
					<input class="b_text" type="button"  value="����" name="b_addMng" onclick="fn_addMng()" >						
				</td>
			</tr>
		</table>		
						
		<div class="title" id="d_oIfo" style="display:none">
			<div id="title_zi">������Ϣ</div>		
		</div>	
		<table id="tb_oIfo" style="display:none">	
			<tr>
				<th class="blue" align="center"><input type="hidden" name="hd_otherHd">��Ϣ����</th>
				<th class="blue" align="center">��Ϣֵ</th>
				<th class="blue" align="center">����</th>	
			<tr>															
		</table>
		<table id="tb_oOpr" style="display:none">
			<tr> 
				<td align = "center">
					<input class="b_text" type="button"  value="����" name="b_addOther" onclick="fn_addOther()" >						
				</td>
			</tr>
		</table>				
		<table>
			<tr> 
				<td  id="footer">
					<input class="b_foot" type="button" name="b_cfm" value="��һ��"
						onClick="fn_cfm();">
					<input class="b_foot" type="button" name="b_clr" value="���"
						onClick="location.reload();">
					<input class="b_foot" type="button" name="b_cls" value="�ر�"
						onClick="removeCurrentTab();">								
				</td>
			</tr>
		</table>	
	</div>	
	<input type="hidden" value="" name="jsonText" id="jsonText">
</form>
<script>
	
	function fn_chgIsText()
	{
		if ( document.all.s_isText.value=="0" )
		{
			document.all.s_defLan.value="$$$$$$"
			document.all.s_defLan.disabled=true;
			document.all.t_enText.value=""
			document.all.t_enText.disabled=true;
			document.all.t_chText.value=""			
			document.all.t_chText.disabled=true;			
		}	
		else
		{
			document.all.s_defLan.disabled=false;
			document.all.t_enText.disabled=false;
			document.all.t_chText.disabled=false;
		}
	}
	
	
	function fn_addMng()
	{
		if ( document.getElementsByName("hd_otherHd").length==0 )
		{
			$("#tb_mIfo").append("<tr>"
				+"<th align='center'><input type='hidden' name='hd_otherHd'>EC����Ա��ʶ</th>"
				+"<th align='center'>EC��������</th>"
				+"<th align='center'>EC����Ա�ֻ���</th>"
				+"<th align='center'>ɾ��</th>	"
			+"</tr>");
		}	

		$("#tb_mIfo").append("<tr>"
			+"<td align='center'>"
				+"<input type='text' name='t_mngId' value='' ch_name='EC����Ա��ʶ' maxlength='16' >"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' name='t_mngName' value='' ch_name='EC��������' maxlength='32' >"
			+"</td>"		
			+"<td align='center'>"
				+"<input type='text' name='t_mngPho' value=''  ch_name='EC����Ա�ֻ���' maxlength='16'>"
			+"</td>"					
			+"<td align='center'>"
				+"<img src='/nresources/default/images/task-item-close1.gif' name = 'i_delOther'"
					+"style='cursor:Pointer;' class='del_cls'  alt='ɾ��ѡ�����Ϣ' "
					+"onclick='delrow(this)'>"	
			+"</td>"		
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
	var stepNum=1;	
	function fn_cfm()
	{
		if (stepNum==1)
		{
			
			document.getElementById("d_unitIfo").style.display="";
			document.getElementById("tb_unitIfo").style.display="";
			document.getElementById("d_bizIfo").style.display="none";
			document.getElementById("tb_bizIfo").style.display="none";
			document.getElementById("d_prodIfo").style.display="none";
			document.getElementById("tb_prodIfo").style.display="none";
			document.getElementById("tb_prodIfoAdd").style.display="none";
			document.getElementById("d_ecIfo").style.display="none";
			document.getElementById("tb_ecIfo").style.display="none";
			
			document.getElementById("d_mIfo").style.display="none";
			document.getElementById("tb_mIfo").style.display="none";
			document.getElementById("tb_mOpr").style.display="none";	
					
			document.getElementById("d_oIfo").style.display="none";
			document.getElementById("tb_oIfo").style.display="none";
			document.getElementById("tb_oOpr").style.display="none";
			if ( document.all.hd_unitSelFlg.value=="0")
			{
				rdShowMessageDialog("�����ѯ������Ϣ!" , 0);
				return false;
			}
			
			if ( fn_notNull( document.all.s_servCode )!=0 ) return false;
			if ( fn_notNull( document.all.t_ofrIfo )!=0 ) return false;
			
			document.getElementById("d_unitIfo").style.display="";
			document.getElementById("tb_unitIfo").style.display="";
			document.getElementById("d_bizIfo").style.display="";
			document.getElementById("tb_bizIfo").style.display="";
			document.getElementById("d_prodIfo").style.display="none";
			document.getElementById("tb_prodIfo").style.display="none";
			document.getElementById("tb_prodIfoAdd").style.display="none";
			document.getElementById("d_ecIfo").style.display="none";
			document.getElementById("tb_ecIfo").style.display="none";
			document.getElementById("d_oIfo").style.display="none";
			document.getElementById("tb_oIfo").style.display="none";
			document.getElementById("tb_oOpr").style.display="none";			
			document.getElementById("d_mIfo").style.display="none";
			document.getElementById("tb_mIfo").style.display="none";
			document.getElementById("tb_mOpr").style.display="none";			
			document.all.s_servCode.disabled=true;		
			
			stepNum=stepNum+1;		
		}
		else if (stepNum==2)
		{
			if ( fn_notNull( document.all.t_entType )!=0 ) return false;
			if ( fn_notNull( document.all.t_prodInstIDU )!=0 ) return false;
			if ( fn_notNull( document.all.t_usrId )!=0 ) return false;
			if ( fn_notNull( document.all.t_bizServCode )!=0 ) return false;

			if ( fn_notNull( document.all.s_autoMode )!=0 ) return false;
			if ( fn_notNull( document.all.s_indId )!=0 ) return false;
			
			if (  document.all.s_isText.value=="" )
			{
				rdShowMessageDialog("�Ƿ�֧������ǩ�� ����ѡ��" , 0);
				return false;
			}
			else if ( document.all.s_isText.value=="1")
			{
				if ( document.all.s_defLan.value=="" )
				{
					rdShowMessageDialog("ȱʡǩ������ ����ѡ��" , 0);
					return false;
				}
				else if ( document.all.s_defLan.value=="0"  )
				{
				
					if ( fn_notNull( document.all.t_chText )!=0 ) return false;
					document.all.t_enText.disabled=false;
				}
				else 
				{
					if ( fn_notNull( document.all.t_enText )!=0 ) return false;
					document.all.t_chText.disabled=false;
				}
			}
			
			/*
			if ( fn_notNull( document.all.s_isText )!=0 ) return false;
			if ( fn_notNull( document.all.s_defLan )!=0 ) return false;
			*/
			

			document.getElementById("d_unitIfo").style.display="";
			document.getElementById("tb_unitIfo").style.display="";
			document.getElementById("d_bizIfo").style.display="";
			document.getElementById("tb_bizIfo").style.display="";
			document.getElementById("d_prodIfo").style.display="";
			document.getElementById("tb_prodIfo").style.display="";
			document.getElementById("tb_prodIfoAdd").style.display="";
			document.getElementById("d_ecIfo").style.display="none";
			document.getElementById("tb_ecIfo").style.display="none";
			document.getElementById("d_oIfo").style.display="none";
			document.getElementById("tb_oIfo").style.display="none";
			document.getElementById("tb_oOpr").style.display="none";		
			document.getElementById("d_mIfo").style.display="none";
			document.getElementById("tb_mIfo").style.display="none";
			document.getElementById("tb_mOpr").style.display="none";
			document.all.t_entType.disabled=true; 		
			document.all.t_prodInstIDU.disabled=true; 			
			document.all.t_usrId.disabled=true; 		 		
			document.all.t_bizServCode.disabled=true; 			
			document.all.s_autoMode.disabled=true; 		 	
			document.all.s_indId.disabled=true; 		 		
			document.all.s_isText.disabled=true; 		 		
			document.all.s_defLan.disabled=true; 				
			document.all.t_chText.disabled=true; 				
			document.all.t_enText.disabled=true; 				
				
			stepNum=stepNum+1;		
			
		}
		else if (stepNum==3)
		{
			/*
			if ( document.getElementsByName("t_prodId").length==0 )
			{
				rdShowMessageDialog("��Ʒ��Ϣ����Ϊ��",0);
				return false;
			}
			*/
			document.getElementById("d_unitIfo").style.display="";
			document.getElementById("tb_unitIfo").style.display="";
			document.getElementById("d_bizIfo").style.display="";
			document.getElementById("tb_bizIfo").style.display="";
			document.getElementById("d_prodIfo").style.display="";
			document.getElementById("tb_prodIfo").style.display="";
			document.getElementById("tb_prodIfoAdd").style.display="";
			document.getElementById("d_ecIfo").style.display="";
			document.getElementById("tb_ecIfo").style.display="";
			document.getElementById("d_oIfo").style.display="none";
			document.getElementById("tb_oIfo").style.display="none";
			document.getElementById("tb_oOpr").style.display="none";		
			document.getElementById("d_mIfo").style.display="none";
			document.getElementById("tb_mIfo").style.display="none";
			document.getElementById("tb_mOpr").style.display="none";
			
			document.all.t_entType.disabled=true; 		
			document.all.t_prodInstIDU.disabled=true; 			
			document.all.t_usrId.disabled=true; 		 		
			document.all.t_bizServCode.disabled=true; 			
			document.all.s_autoMode.disabled=true; 		 	
			document.all.s_indId.disabled=true; 		 		
			document.all.s_isText.disabled=true; 		 		
			document.all.s_defLan.disabled=true; 				
			document.all.t_enText.disabled=true; 				
			document.all.t_chText.disabled=true; 
			document.all.b_addProd.disabled=true;
			for ( var i=0;i< document.getElementsByName("i_delProd").length;i++	)
			{
				document.getElementsByName("i_delProd")[i].src
					='/nresources/default/images/task-item-close.gif';
				document.getElementsByName("i_delProd")[i].disabled=true;
			}
			
			stepNum=stepNum+1;		
			
		}
		else if ( stepNum==4 )
		{
			if ( fn_notNull( document.all.t_ecBsCode )!=0 ) return false;
			if ( fn_notNull( document.all.s_ecMod )!=0 ) return false;
			if ( fn_notNull( document.all.s_ecBsAttr )!=0 ) return false;
			
			document.getElementById("d_unitIfo").style.display="";
			document.getElementById("tb_unitIfo").style.display="";
			document.getElementById("d_bizIfo").style.display="";
			document.getElementById("tb_bizIfo").style.display="";
			document.getElementById("d_prodIfo").style.display="";
			document.getElementById("tb_prodIfo").style.display="";
			document.getElementById("tb_prodIfoAdd").style.display="";
			document.getElementById("d_ecIfo").style.display="";
			document.getElementById("tb_ecIfo").style.display="";
			document.getElementById("d_oIfo").style.display="";
			document.getElementById("tb_oOpr").style.display="";	
			document.getElementById("tb_oIfo").style.display="";
			document.getElementById("d_mIfo").style.display="";
			document.getElementById("tb_mIfo").style.display="";
			document.getElementById("tb_mOpr").style.display="";	
			
			document.all.t_ecBsCode.disabled=true;			
			document.all.s_ecMod.disabled=true;	 
			document.all.s_ecBsAttr.disabled=true;	
			document.all.b_cfm.value="ȷ��";
			stepNum=stepNum+1;	
		}
		else if ( stepNum==5 )
		{
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
			/*ƴjson*/
			/*�����input*/
			var ipt = new input();
			ipt.setOrgCode("<%=s_orgCode%>");	
			ipt.setIpAddress("<%=s_ipAddr%>");	
			ipt.setOpNote("[<%=workNo%>]����[<%=opName%>]����");	
			ipt.setOrgId("<%=s_orgId%>");	
			ipt.setBelongCode("<%=s_belongCode%>");	
			
			ipt.setGroupId("<%=s_groupId%>");	
			ipt.setIdIccid(document.all.t_idIccid.value);	
			ipt.setCustId(document.all.t_custId.value);	
			ipt.setUnitId(document.all.t_unitId.value);	
			ipt.setCustomerNumber(document.all.t_customerNumber.value);	
			
			ipt.setCustName(document.all.t_unitName.value);	
			ipt.setSrvCode(document.all.s_servCode.value.split("@")[0]);	
			ipt.setOfferId(document.all.hd_offerId.value);	
			ipt.setProdID(document.all.t_entType.value);	
			ipt.setProdInstID(document.all.t_prodInstIDU.value);
			
			ipt.setSubsID(document.all.t_usrId.value);	
			ipt.setBizServCode(document.all.t_bizServCode.value);	
			ipt.setAuthMode(document.all.s_autoMode.value);	
			ipt.setIndustryID(document.all.s_indId.value);	
			ipt.setISTextSign(document.all.s_isText.value);	
			
			ipt.setDefaultSignLang(document.all.s_defLan.value);	
			ipt.setTextSignEn(document.all.t_enText.value);	
			ipt.setTextSignZh(document.all.t_chText.value);
			ipt.setSA(document.all.t_agent.value);
			
			//var s_pAttr = document.all.hd_prodAttr.value;
			var s_pServId="";
			var s_pAttrKey="";
			var s_pAttrValue="";
			

			//document.getElementsByName();
			for ( var i=0;i<document.getElementsByName("t_prodId").length;i++)
			{
				var pInfo = new ProdInfo();
				pInfo.setOfferId( document.getElementsByName("t_prodAId")[i].value );
				pInfo.setOfferName( document.getElementsByName("t_prodName")[i].value );
				pInfo.setProdID( document.getElementsByName("t_prodId")[i].value );
				pInfo.setPkgProdID( document.getElementsByName("t_prdPkgId")[i].value );
				pInfo.setProdInstID( document.getElementsByName("t_prodInstID")[i].value );	
				pInfo.setSubsID( document.all.t_usrId.value);	
				alert(pInfo.getProdID());
				var s_prodAttr = document.getElementsByName("s_prodAttr")[i].value;
		
				if (""!=s_prodAttr)
				{
					s_pServId=s_prodAttr.split("~")[0];
					s_pAttrKey=s_prodAttr.split("~")[1];
					s_pAttrValue=s_prodAttr.split("~")[2];	
					
	
					for ( var j=0;j<s_pServId.split("@").length;j++ )
					{
						var pAttIfo = new ProdAttrInfo();
						pAttIfo.setServiceID(s_pServId.split("@")[j] );
						pAttIfo.setAttrKey(s_pAttrKey.split("@")[j] );
						pAttIfo.setAttrValue(s_pAttrValue.split("@")[j] );
						pInfo.setProdAttrInfo(pAttIfo);
					}
				}
				
				var s_prodAttr1 = document.getElementsByName("s_prodAttr1")[i].value;
				
				if (""!=s_prodAttr1)
				{
					s_pServId=s_prodAttr1.split("~")[0];
					s_pAttrKey=s_prodAttr1.split("~")[1];
					s_pAttrValue=s_prodAttr1.split("~")[2];
					
	
					for ( var j=0;j<s_pServId.split("@").length;j++ )
					{
						var pAttIfo = new ProdServiceAttrInfo();
						pAttIfo.setServiceID(s_pServId.split("@")[j] );
						pAttIfo.setAttrKey(s_pAttrKey.split("@")[j] );
						pAttIfo.setAttrValue(s_pAttrValue.split("@")[j] );
						pInfo.setProdServiceAttrInfo(pAttIfo);
					}
				}

				ipt.setProdInfo(pInfo);
			}
			
			
			var ecBs = new ECBaseServCode();
			ecBs.setBaseServCode( document.all.t_ecBsCode.value);
			ecBs.setBaseServCodeProp( document.all.s_ecBsAttr.value);
			ecBs.setBizServMode( document.all.s_ecMod.value);
			ipt.setECBaseServCode(ecBs);
			
			for ( var i=0;i<document.getElementsByName("t_mngId").length;i++ )
			{
				var mIfo=new MgrInfo();
				mIfo.setMgrID(document.getElementsByName("t_mngId")[i].value);
				mIfo.setMgrName(document.getElementsByName("t_mngName")[i].value);
				mIfo.setMgrMSISDN(document.getElementsByName("t_mngPho")[i].value);
				ipt.setMgrInfo(mIfo);
			}

			for ( var i=0;i<document.getElementsByName("t_otherCode").length;i++ )
			{
				var oIfo=new OtherInfo();
				oIfo.setInfoCode(document.getElementsByName("t_otherCode")[i].value);
				oIfo.setInfoValue(document.getElementsByName("t_otherValue")[i].value);
				ipt.setOtherInfo(oIfo);
			}			
			var qka = new jqk();
			qka.setInput(ipt);
			/*ƴjson��*/
			var myJSONText = JSON.stringify(qka,function(key,value){
				return value;
			});
			document.getElementById("jsonText").value=myJSONText;
		

			if ("1"!=rdShowConfirmDialog("ȷ���ύ��?"))
			{
				return false;
			}
			document.all.b_cfm.disabled=true;
			document.frm.action="f_g599_cfm.jsp";
			document.frm.submit();			
		}
		
	}
	
	function fn_AddProd()
	{
		if ( document.all.hd_unitSelFlg.value=="0")
		{
			rdShowMessageDialog("�����ѯ������Ϣ!" , 0);
			return false;
		}
		
		if ( fn_notNull( document.all.s_servCode )!=0 ) return false;
		if ( fn_notNull( document.all.t_bizServCode )!=0 ) return false;
		
		var prodIfo=window.showModalDialog("f_g599_addProd.jsp?hd_accept="+document.all.hd_accept.value
			+"&hd_opCode="+document.all.hd_opCode.value
			+"&hd_opName="+document.all.hd_opName.value
			+"&t_idIccid="+document.all.t_idIccid.value
			+"&t_custId="+document.all.t_custId.value
			+"&t_unitId="+document.all.t_unitId.value
			+"&hd_offerId="+document.all.hd_offerId.value
			+"&s_servCode="+document.all.s_servCode.value.split("@")[1]
			+"&t_bizServCode="+document.all.t_bizServCode.value
			+"&t_entType="+document.all.t_entType.value
			+"&classCode=<%=s_classCode%>"
			,"","dialogWidth=800px;dialogHeight=600px");	
		var a_prodBs=prodIfo.split("|")[0];
		var s_prodAttr=prodIfo.split("|")[1];
		var s_prodAttr1=prodIfo.split("|")[2];
		
		document.all.hd_prodAttr.value=s_prodAttr;
		document.all.hd_prodAttr1.value=s_prodAttr1;
		
		var s_prodAId=a_prodBs.split("@")[0];//���Ӳ�Ʒ���
		var s_prodId=a_prodBs.split("@")[1];//��Ʒ����
		var s_prdPkgId=a_prodBs.split("@")[2];//������Ʒ������
		var s_prodInstID=a_prodBs.split("@")[3];//��Ʒ����ʵ��
		var s_userId=a_prodBs.split("@")[4];//�û�Ψһ��ʶ
		var s_prodName=a_prodBs.split("@")[5];//���Ӳ�Ʒ����
		if (document.getElementsByName("hd_prodHd").length==0 )
		{
			$("#tb_prodIfo").append("<tr>"
				+"<th align='center'>�ʷѴ���</th>"
				+"<th align='center'>�ʷ�����</th>"
				+"<th align='center'><input type='hidden' name='hd_prodHd'>��Ʒ����</th>"
				+"<th align='center'>������Ʒ������</th>"
				+"<th align='center'>��Ʒʵ��Ψһ��ʶ</th>"
				+"<th align='center'>�û�Ψһ��ʶ</th>"
				+"<th align='center'>ɾ��</th>	"
			+"</tr>");
		}
		
		$("#tb_prodIfo").append("<tr>"
			+"<td align='center'>"
				+"<input type='text' name='s_prodAId'  ch_name='������Ʒ������' value='"+s_prodAId+"' class='InputGrey' readOnly >"
				+"<input type='hidden' name='s_prodAttr'  ch_name='������Ʒ������' value='"+s_prodAttr+"' class='InputGrey' readOnly >"
				+"<input type='hidden' name='s_prodAttr1'  ch_name='������Ʒ������' value='"+s_prodAttr1+"' class='InputGrey' readOnly >"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' name='s_prodName'  ch_name='������Ʒ������' value='"+s_prodName+"' class='InputGrey' readOnly >"
			+"</td>"		
			+"<td align='center'>"
				+"<input type='text' name='t_prodId'  ch_name='��Ʒ����' value='"+s_prodId+"' class='InputGrey' readOnly >"
				+"<input type='hidden' name='t_prodName' value='"+s_prodName+"' class='InputGrey' readOnly >"
				+"<input type='hidden' name='t_prodAId' value='"+s_prodAId+"' class='InputGrey' readOnly >"
			+"</td>"
			
			+"<td align='center'>"
				+"<input type='text' name='t_prdPkgId'  ch_name='������Ʒ������' value='"+s_prdPkgId+"' class='InputGrey' readOnly >"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' name='t_prodInstID'   ch_name='��Ʒʵ��Ψһ��ʶ'  value='"+s_prodInstID+"' class='InputGrey' readOnly >"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' name='t_userId'  ch_name='�û�Ψһ��ʶ'   value='"+$("#t_usrId").val()+"' class='InputGrey' readOnly >"
			+"</td>"		
			+"<td align='center'>"
				+"<img src='/nresources/default/images/task-item-close1.gif' name = 'i_delProd'"
					+"style='cursor:Pointer;' class='del_cls'  alt='ɾ��ѡ��Ĳ�Ʒ' "
					+"onclick='delrow(this)'>"	
			+"</td>"		
		+"</tr>")
		
	}
	/*ɾ����ѡ��Ĳ�Ʒ*/
	function delrow(k)
	{
		$(k).parent().parent().remove(); 
	}
	
	function fn_getUsrId()
	{
		var packet = new AJAXPacket("f_g599_ajax.jsp","���Ժ�...");
		packet.data.add("iLoginAccept" 		,"<%=sLoginAccept%>");
		packet.data.add("iOpCode" 			,"<%=opCode%>");
		packet.data.add("iLoginNo" 			,"<%=workNo%>");
		packet.data.add("iLoginPwd" 		,"<%=s_passwd%>");
		packet.data.add("iPhoneNo" 			,"");
		packet.data.add("iUserPwd" 			,"");
		packet.data.add("ajaxType"			,"fn_doGetUsrId");

		core.ajax.sendPacket(packet		,fn_doGetUsrId,true);//�첽		
	}
	
	function fn_doGetUsrId(packet)
	{
		var v_oRetCode=packet.data.findValueByName("oRetCode");
		var v_oRetMsg=packet.data.findValueByName("oRetMsg");
		if ( "000000"==v_oRetCode )
		{
			document.all.t_usrId.value=packet.data.findValueByName("outSeq");
			document.all.b_getUsrId.disabled=true;
		}
		else
		{
			rdShowMessageDialog(v_oRetCode+":"+v_oRetMsg , 0);	
			document.all.b_getUsrId.disabled=false;		
		}
	
	}
	
	
	function fn_getProdInstID()
	{
		var packet = new AJAXPacket("f_g599_ajax.jsp","���Ժ�...");
		packet.data.add("iLoginAccept" 		,"<%=sLoginAccept%>");
		packet.data.add("iOpCode" 			,"<%=opCode%>");
		packet.data.add("iLoginNo" 			,"<%=workNo%>");
		packet.data.add("iLoginPwd" 		,"<%=s_passwd%>");
		packet.data.add("iPhoneNo" 			,"");
		packet.data.add("iUserPwd" 			,"");
		packet.data.add("ajaxType"			,"fn_doGetProdInst");

		core.ajax.sendPacket(packet		,fn_doGetProdInst,true);//�첽
	}
	
	function fn_doGetProdInst(packet)
	{
		var v_oRetCode=packet.data.findValueByName("oRetCode");
		var v_oRetMsg=packet.data.findValueByName("oRetMsg");
		if ( "000000"==v_oRetCode )
		{
			document.all.t_prodInstIDU.value=packet.data.findValueByName("outSeq");
			document.all.b_prodInstID.disabled=true;
		}
		else
		{
			rdShowMessageDialog(v_oRetCode+":"+v_oRetMsg , 0);	
			document.all.b_prodInstID.disabled=false;		
		}
	
	}
	
	function fn_selProd()
	{
		if ( document.all.hd_unitSelFlg.value=="0")
		{
			rdShowMessageDialog("�����ѯ������Ϣ!" , 0);
			return false;
		}
		
		if (document.all.s_servCode.value=="$$$$$$")
		{
			rdShowMessageDialog("ҵ��������ѡ��" , 0);
			return false;
		}
		
		var unitProd=window.showModalDialog("f_g599_prodCho.jsp?hd_accept="+document.all.hd_accept.value
			+"&hd_opCode="+document.all.hd_opCode.value
			+"&hd_opName="+document.all.hd_opName.value
			+"&t_idIccid="+document.all.t_idIccid.value
			+"&t_custId="+document.all.t_custId.value
			+"&classCode=<%=s_classCode%>"
			+"&s_servCode="+document.all.s_servCode.value.split("@")[1]
			,"","dialogWidth=800px;dialogHeight=600px");
		var unitProd=unitProd.split("@");	
		
		document.all.t_ofrIfo.value=unitProd[0]+"-->"+unitProd[1];
		document.all.hd_offerId.value=unitProd[0];
		document.all.t_entType.value=unitProd[2];
		
	}
	
	function fn_selUnit()
	{
		var a_chkIfo = [ document.all.t_idIccid,document.all.t_custId
			,document.all.t_unitId,document.all.t_customerNumber ];
			
		if (0!=fn_chkAllNull(a_chkIfo)) return false;
		if (0!=fn_forInt(document.all.t_unitId)) return false;
		if (0!=fn_forInt(document.all.t_customerNumber)) return false;
				
		var unitIfo=window.showModalDialog("f_g599_unitIfo.jsp?hd_accept="+document.all.hd_accept.value
			+"&hd_opCode="+document.all.hd_opCode.value
			+"&hd_opName="+document.all.hd_opName.value
			+"&t_idIccid="+document.all.t_idIccid.value
			+"&t_custId="+document.all.t_custId.value
			+"&t_unitId="+document.all.t_unitId.value
			+"&t_customerNumber="+document.all.t_customerNumber.value
			+"&classCode=<%=s_classCode%>"
			,"","dialogWidth=800px;dialogHeight=600px");
		if ( typeof (unitIfo)!="undefined" )
		{
			var a_unitIfo=unitIfo.split("@");
			document.all.t_idIccid.value=a_unitIfo[0];
			document.all.t_custId.value=a_unitIfo[1];
			document.all.t_unitId.value=a_unitIfo[3];
			document.all.t_unitName.value=a_unitIfo[4];
			document.all.t_customerNumber.value=a_unitIfo[5];
			
			document.all.t_idIccid.disabled=true;
			document.all.t_custId.disabled=true;
			document.all.t_unitId.disabled=true;
			document.all.t_unitName.disabled=true;
			document.all.t_customerNumber.disabled=true;
			document.all.hd_unitSelFlg.value="1";
		}
	}
	
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
    var retToField = "t_agent|";
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
    var chPos_field = retInfo.split("|")
    $("input[name='t_agent']").val(chPos_field[0]);
}
</script>

</body>
</html>
