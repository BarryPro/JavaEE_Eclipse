   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-16
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
	
<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%> 
 	
<%
	Logger logger = Logger.getLogger("f8206_1.jsp");
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String loginNo = (String)session.getAttribute("workNo");
	String ip_Addr = request.getRemoteAddr();
	String regionCode = (String)session.getAttribute("regCode");
	String nopass  = (String)session.getAttribute("password");
	
	String workNo = loginNo;
	String workName = loginName;
	
	
	String returnFlag = request.getParameter("returnFlag");
	
	//��ȡϵͳʱ��
	DateFormat df = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
	Date d1=new Date();
	String sysdate=df.format(d1);
	
	

	//��ȡ��ɫ�����б�
	String sqlStr1="";
 	sqlStr1 ="select roletype_code ,roletype_name from sRoleTypeCode ";
 					 
 	//retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
%>

	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 	<wtc:sql><%=sqlStr1%></wtc:sql>
 	</wtc:pubselect>
	<wtc:array id="result_t1" scope="end"/>

<% 	
 	String[][] retListString1 = result_t1;
%>
<head>
<title><%=opName%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head> 
<script language=javascript>
	var returnFlag="<%=returnFlag%>";
    var op_code="<%=opCode%>";
	function showDiv()
	{
		if(returnFlag==null)
		{
			showtbs1_view();
		}		
		else if(returnFlag==3)
		{
			showtbs3_view();
		}
		else if(returnFlag==4)
		{
			showtbs4_view();
		}	
	}

	function fsubmit()
	{
		getAfterPrompt(op_code);
		if(document.form1.op_note.value=="")
		{
			document.form1.op_note.value="����Ա<%=loginNo%>���ӽ�ɫ"+document.form1.role_code.value;
		}
		document.form1.action="f8026_submit_add.jsp"; //insert
		document.form1.submit();
		document.form1.bSubmit.disabled=true;
	}
	
	function fsubmit4()
	{
		getAfterPrompt(op_code);
		if(document.form4.op_note.value=="")
		{
			document.form4.op_note.value="����Ա<%=loginNo%>�Խ�ɫ"+document.form4.role_code.value+"�����޸�";
		}
		document.form4.action="f8026_submit_mod.jsp"; //query bebore modify
		document.form4.submit();
		document.form4.bSubmit4.disabled=true;
	}
		
	onload=function() 
	{
		 self.status="";
	}
	
	function doProcess(packet)
	{
		self.status="";
		
		var role_code = packet.data.findValueByName("role_code");//���
		var retType = packet.data.findValueByName("retType");
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");
		
		if(retType=="queryrole")
		{
			if(errCode == 0)
			{
				var role_code = packet.data.findValueByName("role_code");
				document.form1.role_code.value=StrAdd(1,role_code,1);
				document.form1.query_role.disabled=true;		
			}
			else
			{
				rdShowMessageDialog( packet.data.findValueByName("errCode") + "[" +  packet.data.findValueByName("errMsg") + "]" ,0);
			}
		}
		else
		{
			if ( packet.data.findValueByName("errCode")==0)
			{
				if(role_code!="")
				{
					document.form1.role_code.value=role_code;
					document.form1.bSubmit.disabled=false;
				}
			}
			else
			{
	    		rdShowMessageDialog( packet.data.findValueByName("errCode") + "[" +  packet.data.findValueByName("errMsg") + "]" ,0);
			}
		}
	}
	
	function queryrole()
	{
		var myPacket = new AJAXPacket("f8026_RPC.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("role_code_parter",form1.role_code_parter.value);
		myPacket.data.add("retType","queryrole");
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}
	function StrAdd(AddType, SrcStr, Value)
	{
		//AddType 0ֵ��1�� 1:ģ��1
		var BaseStr ="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
		//var BaseStr ="0123456789";
		var S = "";
		var CurPos = 0, PrePos = 0, SrcLen=0,BaseLen=0, Index=0;
		var isCarry = 0;
		
		SrcLen= SrcStr.length;
		BaseLen=BaseStr.length;
		isCarry = Value % BaseLen;
		for(  CurPos = SrcLen - 1; CurPos >= 0; CurPos --)
		{
			if (isCarry != 0)
			{
				Index = BaseStr.indexOf(SrcStr.charAt(CurPos)) + isCarry;
				if (Index < -1)
				{
					return "";
				}
				if (Index > BaseLen - 1)
				{
					isCarry = 1;
					S = BaseStr.charAt(Index - BaseLen) + S;
				}
				else
				{
					isCarry = 0;
					S = SrcStr.substring(0, CurPos) + BaseStr.charAt(Index) + S;
					break;
				}
				if (CurPos == 0 && AddType == 0) S = BaseStr.charAt(0) + S;
			}
			else
			{
				break;
			}
		}
		return S;
	}

	function selectroleAdd()//add ��ѯ��ɫ
	{
	
			var path = "roletree.jsp?formFlag=form1";
  		window.open(path,'_blank','height=600,width=300,scrollbars=yes');
			document.form1.query_role.disabled=false;
	}
	
	function selectrole()
	{
		//mod select role
		
		if(document.form4.role_code.value=="")
		{
			var path = "roletree.jsp?formFlag=form4";
  			window.open(path,'_blank','height=600,width=300,scrollbars=yes');
		}
		else
		{
			var role_code=document.form4.role_code.value;
			window.open("f8026_select_role.jsp?role_code="+role_code,"","height=500,width=400,scrollbars=yes");
		}
	}

	function selectrole1()
	{

		
		if(document.form3.role_code.value=="")
		{
			var path = "roletree.jsp?formFlag=form3";
  			window.open(path,'_blank','height=600,width=300,scrollbars=yes');
		}
		else
		{
			var role_code=document.form3.role_code.value;
			window.open("f8026_select_role1.jsp?role_code="+role_code,"","height=500,width=400,scrollbars=yes");
		}
	}
	
	function selectnode(node)//query node
	{
		var path = "<%=request.getContextPath()%>/npage/common/grouptree.jsp?grouptype=form1";
	    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	}
	function selectnode1(node)//query node
	{
		var path = "<%=request.getContextPath()%>/npage/common/grouptree.jsp?grouptype=form4";
	    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	}
		
	
	function rolerelationmsg()//role_relationmsg1
	{
		if(document.form3.role_code.value!="")
		{	        
		    var url = "popedomtree.jsp?roleCode="+document.form3.role_code.value+"&roleName="+document.form3.role_name.value;
			window.open(url,'','height=600,width=300,left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
		}
		else
		{
			rdShowMessageDialog("���Ƚ��н�ɫ����Ĳ�ѯ��",0);
		}
	}
	
	function showtbs1()
	{
		showtbs1_view();
		resetAdd();
		getBeforePrompt("8026");
		op_code="8026";
	}
	
	function showtbs3()
	{
		showtbs3_view();
		resetMod();
		getBeforePrompt("8065");
		op_code="8065";
	}
	
	function showtbs4()
	{
		showtbs4_view();
		resetQry();
		getBeforePrompt("8026");
		op_code="8065";
	}		
		
	function showtbs1_view()
	{	
		tbs1.style.display="";
		tbs3.style.display="none";
		tbs4.style.display="none";
		document.all.font1.color='222222';
		document.all.font3.color='999999';
		document.all.font4.color='999999';
		document.all.font1.parentNode.style.background = "999999";
		document.all.font1.parentNode.parentNode.style.background = "999999";
		document.all.font3.parentNode.style.background = "";
		document.all.font3.parentNode.parentNode.style.background = "";
		document.all.font4.parentNode.style.background = "";
		document.all.font4.parentNode.parentNode.style.background = "";
	}

	function showtbs3_view()
	{	
		tbs1.style.display="none";
		tbs3.style.display="";
		tbs4.style.display="none";
		document.all.font1.color='999999';
		document.all.font3.color='222222';
		document.all.font4.color='999999';
		document.all.font1.parentNode.style.background = "";
		document.all.font1.parentNode.parentNode.style.background = "";
		document.all.font3.parentNode.style.background = "999999";
		document.all.font3.parentNode.parentNode.style.background = "999999";
		document.all.font4.parentNode.style.background = "";
		document.all.font4.parentNode.parentNode.style.background = "";
	}
	function showtbs4_view()
	{
		tbs1.style.display="none";
		tbs3.style.display="none";
		tbs4.style.display="";
		document.all.font1.color='999999';
		document.all.font3.color='999999';
		document.all.font4.color='222222';
		document.all.font1.parentNode.style.background = "";
		document.all.font1.parentNode.parentNode.style.background = "";
		document.all.font3.parentNode.style.background = "";
		document.all.font3.parentNode.parentNode.style.background = "";
		document.all.font4.parentNode.style.background = "999999";
		document.all.font4.parentNode.parentNode.style.background = "999999";
	}
	
	//�������ӽ���
	function resetAdd() 
	{
		document.form1.reset();
		document.form1.query_role_parter.disabled=false;
		document.form1.query_role.disabled=true;
	}
	
	//�����޸Ľ���
	function resetMod() 
	{
		document.form4.reset();
		document.form4.query_role.disabled=false;
		document.form4.bSubmit4.disabled=true;
		document.form4.role_code.readOnly=false;
		document.form4.role_name.readOnly=false;
	}
	
	//���ò�ѯ����
	function resetQry()
	{
		document.form3.reset();
		document.form3.query_role.disabled=false;
		document.form3.role_code.readOnly=false;
		document.form3.role_relationmsg.disabled=true;
		//document.form3.role_name.readOnly=false;
	}
	
	function clearAdd()
	{
		document.form1.role_code.value="";
		document.form1.role_name.value="";
		document.form1.role_describe.value="";
		document.form1.use_flag.value="Y";
		document.form1.op_note.value="";
		document.form1.query_role.disabled=false;
	}
	function chgUseFlag()
	{
		if(document.form4.use_flag.value=="N")
		{
			rdShowMessageDialog("ѡ��񣬴˽�ɫ�������¼���ɫ��ʧЧ��",0);
			return;
		}
	}
	function getBeforePrompt(opCode)
	{
		var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","���Ժ�...");
		packet.data.add("opCode" ,opCode);
	  core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//�첽
		packet =null;
	}
	
	function doGetBeforePrompt(data)
	{
		$('#wait').hide();
		$('#beforePrompt').html(data);
	}
	
	function getAfterPrompt(opCode)
	{
		var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","���Ժ�...");
		packet.data.add("opCode" ,opCode);
	  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//ͬ��
		packet =null;
	}
	
	function doGetAfterPrompt(packet)
	{
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retCode=="000000"){
	    	promtFrame(retMsg);
	    }
	}
function getBefore(){
	var op_code="<%=opCode%>";
	if(op_code=="8065"){
		showtbs3();
		getBeforePrompt(op_code)
	}else{
		showtbs1();
		getBeforePrompt(op_code)
	}
}

$(document).ready(function (){
	var opCode = "<%=opCode%>";
	if("m477"==opCode){
		//ֻչʾ��ѯ����
		$("#tabhead2").parent().parent().hide();
		showtbs4();
	}
});
</script>

<body onload="getBefore();">
	<%@ include file="/npage/include/header.jsp" %> 
		<form name="form1" method="post" action="">
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<input type="hidden" name="opName" value="<%=opName%>">                        


	<div class="title">
		<div id="title_zi">��ɫ����</div>
	</div>



<TABLE  cellSpacing=0>
	<tr>
		<TD nowrap><a style=background="999999" id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs1()" value="1">&nbsp;&nbsp;<font id="font1" color='222222'>����&nbsp;&nbsp;</font></a></TD>
		<TD nowrap><a id="tabhead1" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs3()" value="1">&nbsp;&nbsp;<font id="font3" >�޸�&nbsp;&nbsp;</font></a></TD>
		<TD nowrap><a id="tabhead2" style="CURSOR: hand; TEXT-DECORATION: none" class="tabnodisp" href="javascript:onclick=showtbs4()" value="1">&nbsp;&nbsp;<font id="font4" >��ѯ&nbsp;&nbsp;</font></a></TD>
	</tr>
</table>
		
	<!--add-->
   <div id=tbs1 style=display="">
		<TABLE cellspacing="0" >

  	<input type="hidden" name="ip_Addr" id="ip_Addr" value="<%=ip_Addr%>">
		<input type="hidden" name="op_code"  value="8026">
		<input type="hidden" name="NoPass"   value="<%=nopass%>">
    <TBODY>
    	<TR >          			
			    <TD  height=20 width="15%" class="blue">�ϼ���ɫ</TD>
	        <TD  height=20 width="85%">
	      			<input name="role_code_parter"  type=hidden >
	      			<input name="role_name_parter"  v_must=1 v_minlength=1 v_maxlength=100 v_name="�ϼ���ɫ" readonly Class="InputGrey">
	            <input  type="button" name="query_role_parter" onclick="selectroleAdd()" value="��ѯ" class="b_text">
	            <font class="orange">*</font>
	        </TD>
      </TR>
			 <TR >          			
			    <TD  height=20 width="15%" class="blue">��ɫ����</TD>
	        <TD  height=20 width="85%">
		      			<select name="roleType_code" onChange="clearAdd()" >
		           	<%
				for(int i=0;i < retListString1.length;i ++)
				{
			%>
              		<option value='<%=retListString1[i][0]%>'><%=retListString1[i][1]%></option>
		<%
				}
		%>
		           	</select>	
	            <font class="orange">*</font>
	        </TD>
      </TR>
      <TR> 			
			    <TD  height = 20  class="blue">��ɫ����</TD>
	        <TD  colspan="3" height = 20>
	          	<input type=text  v_type="string" readonly v_must=1 v_minlength=1 v_maxlength=100 v_name="��ɫ����" Class="InputGrey" name="role_code" maxlength=100>
							<input  type="button" class="b_text" name="query_role" onclick="queryrole()" value="��ȡ" disabled >
							<font class="orange">*</font>
	        </TD> 			
	     </TR>
	     <TR >          			
			    <TD height = 20  class="blue">��ɫ����</TD>
	        <TD colspan="3" height = 20 >
	           	<input type=text  v_type="string"  v_must=1 v_minlength=0 v_maxlength=50 v_name="��ɫ����"  name=role_name maxlength=50>
	            <font class="orange">*</font>
	        </TD>
       </TR>

	     <TR >          			
			    <TD  height = 20  class="blue">��ɫ����</TD>
	        <TD colspan="3" height = 20>
	           	<input type=text  v_type="string"  v_must=1 v_minlength=0 v_maxlength=255 v_name="��ɫ����"  name=role_describe maxlength=255 size="60">
	     	      <font class="orange">*</font>
	        </TD>
       </TR>
       
       <TR > 
					<TD  height = 20  class="blue">�Ƿ�����</TD>
		      <TD height = 20 colspan="3"  width=35%>
              <select name="use_flag">
					 			<option value="Y">��</option>
		       			<option value="N">��</option>
              </select>
       		</TD> 
       </TR>

	    <TR  id="line_1">
	        <TD class="blue">��ע</TD>
	        <TD colspan="10"><input type=text  v_type="string" v_maxlength=60 v_name="��ע"  name=op_note maxlength=60 size=60 readonly class="InputGrey"></TD>
      </TR>

    </TBODY>
    </TABLE> 
    
		<TABLE cellspacing="0"  >
			<tr> 
				<td align = center height="30" id="footer">		
						<input  type="button" name="bSubmit" onclick="if(check(form1)) fsubmit()" value="����" class="b_foot">&nbsp;
						<input name="resetAddBtn" type="button"  value="����" onclick="resetAdd()" class="b_foot">&nbsp;	
						<input  type="button" name="Return" onclick="removeCurrentTab()" value="�ر�" class="b_foot">
				</td>
			</tr>
		</form>
		</table>
   </div>

	<!--query before modify-->	
	<div id=tbs3 style=display="none">
		<TABLE cellspacing="0"  >
		<form name="form4" method="post" action="">
		<input type="hidden" name="loginName" id="loginName" value="<%=loginName%>">
		<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
		<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
		<input type="hidden" name="ip_Addr" id="ip_Addr" value="<%=ip_Addr%>">
		<input type="hidden" name="op_code"  value="8026">
		<input type="hidden" name="NoPass"   value="<%=nopass%>">
		<input type=hidden name=create_login value="<%=loginNo%>" >
		<input type=hidden name=create_date value="<%=sysdate%>" >
		<input type="hidden" name="opCode" value="<%=opCode%>">
		<input type="hidden" name="opName" value="<%=opName%>">
		<TBODY>
		<TR  > 			
			<TD  height = 20 class="blue">��ɫ����</TD>
			<TD  colspan="3" height = 20>
		 		<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=100 v_name="��ɫ����"  name=role_code maxlength=100 onkeydown="if(event.keyCode==13)selectrole()" >
				<input  type="button" class="b_text" name="query_role" onclick="selectrole()" value="��ѯ">
				<font class="orange">*</font>			
			</TD>
		</TR>
		<TR >
			<TD  height = 20 width="15%" class="blue">��ɫ����</TD>
			<TD  height = 20 width="85%">
				<input type="hidden" name="roleType_codeIn" >
				<select name="roleType_code" disabled >
					<%
						for(int i=0;i < retListString1.length;i ++){
					%>
					<option value='<%=retListString1[i][0]%>'><%=retListString1[i][1]%></option>
					<%
					}
					%>
					</select>	
					<font class="orange">*</font>
			</TD>
       		</TD> 
		</TR>
		<TR >          			
			<TD height = 20  class="blue">��ɫ����</TD>
			<TD colspan="3" height = 20 >
				<input type=text  v_type="string"  v_must=1 v_minlength=0 v_maxlength=50 v_name="��ɫ����"  name=role_name maxlength=50>
				<font class="orange">*</font>
			</TD>
		</TR>

		<TR >          			
			<TD  height = 20  class="blue">��ɫ����</TD>
			<TD colspan="3" height = 20>
				<input type=text  v_type="string"  v_must=1 v_minlength=0 v_maxlength=255 v_name="��ɫ����"  name=role_describe maxlength=255 size="60">
				<font class="orange">*</font>
			</TD>
		</TR>
		<TR > 
			<TD  height = 20  class="blue">�Ƿ�����</TD>
			<TD colspan="3" width=35% height = 20>
				<select name="use_flag" onChange="chgUseFlag()">
					<option value="Y">��</option>
					<option value="N">��</option>
				</select>
			</TD> 
		</TR>
	        <TR  id="line_1">
	              <TD class="blue">��ע</TD>
	              <TD colspan="10"><input type=text  v_type="string" v_maxlength=60 v_name="��ע"  name=op_note maxlength=60 size=60 readonly class="InputGrey"></TD>
          </TR>

          </TBODY>
        </TABLE>
		<TABLE  cellspacing="0">
			<tr> 
				<td align = center height="30" id="footer">		
					<input  type="button" name="bSubmit4" onclick="if(check(form4)) fsubmit4()" value="�޸�" class="b_foot">&nbsp;
					<input name="resetModBtn" type="button"  value="����" onclick="resetMod()" class="b_foot">&nbsp;	
					<input  type="button" name="Return" onclick="removeCurrentTab()" value="�ر�" class="b_foot">
				</td>
			</tr>
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<input type="hidden" name="opName" value="<%=opName%>">
		</form>
		</table>
		
  </div>

	<!--query list -->
	<div id=tbs4 style=display="none">
		<TABLE  cellspacing="0">
			<form name="form3" method="post" action="">
				<TBODY>
				<TR  > 			
					<TD  height = 20 class="blue">��ɫ����</TD>
					<TD  colspan="3" height = 20>
						<input type=text v_type="string"  v_must=1 v_minlength=1 v_maxlength=100 v_name="��ɫ����"  name=role_code maxlength=100 onkeydown="if(event.keyCode==13)selectrole1()" >
						<input  type="button" class="b_text" name="query_role" onclick="selectrole1()" value="��ѯ">
						<input  type="button" name="role_relationmsg" onclick="rolerelationmsg()" value="��ɫȨ�޹�ϵ��Ϣ" disabled class="b_text">	
					</TD> 			
				</TR>
				
				<TR >
			 		<TD height = 20 class="blue">��ɫ����</TD>
					<TD colspan="3" height = 20 >
						<input type=text  readonly Class="InputGrey" v_type="string"  v_must=1 v_minlength=0 v_maxlength=50 v_name="��ɫ����"  name=role_name maxlength=50>
					</TD>
				</TR>

				<TR >
					<TD  height = 20 class="blue">��ɫ����</TD>
					<TD colspan="3" height = 20>
						<input type=text  readonly Class="InputGrey" v_type="string"  v_must=1 v_minlength=0 v_maxlength=255 v_name="��ɫ����"  name=role_describe maxlength=255 size="60">
					</TD>
				</TR>
				<TR >   
					<TD  height = 20 class="blue">�Ƿ�����</TD>
					<TD height = 20>
						<select name="use_flag" disabled>
							<option value="Y">��</option>
							<option value="N">��</option>
						</select>
					</TD> 
					<TD  height = 20 >&nbsp;</TD>
					<TD  height = 20 >&nbsp;</TD>
				</TR>
				<TR >
					<TD  height = 20 class="blue">��ɫ����</TD>
					<TD  height = 20>
						<input type="hidden" name="roleType_codeIn" >
						<select name="roleType_code" disabled>
					<%
						for(int i=0;i < retListString1.length;i ++)
						{
					%>
							<option value='<%=retListString1[i][0]%>'><%=retListString1[i][1]%></option>
					<%
						}
					%>
						</select>	
					</TD>
					<TD  height = 20 >&nbsp;</TD>
					<TD  height = 20 >&nbsp;</TD>
				</TR>
				<TR >          			
					<TD  height = 20 class="blue">��������</TD>
					<TD  height = 20>
					 	<input type=text  readonly Class="InputGrey" v_type="string"  v_must=1 v_minlength=0 v_maxlength=6 v_name="��������"  name=create_login maxlength=6>
					</TD>
					<TD  height = 20 class="blue">����ʱ��</TD>
					<TD  height = 20>
						<input type=text  readonly Class="InputGrey" v_type="date"  v_must=1 v_minlength=0 v_maxlength=17 v_name="����ʱ��"  name=create_date maxlength=17>
					</TD>
				</TR>
				<TR >          			
					<TD  height = 20 class="blue">����������</TD>
					<TD  height = 20>
						<input type=text  readonly Class="InputGrey" v_type="string"  v_must=1 v_minlength=0 v_maxlength=6 v_name="����������"  name=create_login_name maxlength=6>
					</TD>
					<TD  height = 20 class="blue">��������֯�ڵ�</TD>
					<TD  height = 20>
						<input type=text  readonly Class="InputGrey" v_type="date"  v_must=1 v_minlength=0 v_maxlength=17 v_name="��������֯�ڵ�"  name=create_login_GrpName maxlength=30 size=30>
					</TD>
				</TR>
				<TR  id="line_1">
					<TD class="blue">��ע</TD>
					<TD colspan="10">
						<input type=text readonly Class="InputGrey"  v_type="string"   v_minlength=1 v_maxlength=60   name=op_note maxlength=60 size=60>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<TABLE  cellspacing="0">
			<tr>
				<td align = center height="30" id="footer">	
					<input name="" type="reset" onclick="resetQry()"   value="����" class="b_foot">&nbsp;
					<input  type="button" name="Return" onclick="removeCurrentTab()" class="b_foot" value="�ر�">
				</td>
			</tr>
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<input type="hidden" name="opName" value="<%=opName%>">
		</form>
		
	</table>
	</div>
	<div id="relationArea" style="display:none"></div>
				<div id="wait" style="display:none">
				<img  src="/nresources/default/images/blue-loading.gif" />
			</div>
			<div id="beforePrompt"></div>
		</DIV>             
</DIV>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</body>
</html>

<script>
	showDiv();
</script>