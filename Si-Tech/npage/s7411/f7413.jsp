<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "7413";
	String opName = "����100ҵ����˶�";

	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String[][] agentInfo = (String[][])arr.get(2);
	String[][] pass = (String[][])arr.get(4);
	String ip_Addr = agentInfo[0][2];
	String workno = baseInfo[0][2];
	String workname = baseInfo[0][3];
	String org_code = baseInfo[0][16];
	String nopass  = pass[0][0];
	String Department = baseInfo[0][16];
	String regionCode = Department.substring(0,2);
	String districtCode = Department.substring(2,4);

	String sqlStr = "";

	//ȡ����ʡ�ݴ��� -- Ϊ�������ӣ�ɽ������ʹ��session
	sqlStr = "select agent_prov_code FROM sProvinceCode where run_flag='Y'";
%>   
<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result2" scope="end"/>
<%
	String ProvinceRun = "";
	if (result2.length != 0) 
	{
		ProvinceRun = result2[0][0];
	}

	//	ȡ���������GROUP_ID
	String GroupId = "";
	String OrgId = "";
	if(ProvinceRun.equals("20"))  //����
	{	
		sqlStr = "select group_id,'unknown' FROM dLoginMsg where login_no='"+workno+"'";
%>   
<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end"/>
<%
	if ( result1.length != 0) 
	{
		GroupId = result1[0][0];
		OrgId = result1[0][1];
	}
	}
	else
	{
		GroupId = baseInfo[0][21];
		OrgId = baseInfo[0][23];
	}
%>

<HEAD>
<title><%=opName%></title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<SCRIPT type=text/javascript>

core.loadUnit("debug");
core.loadUnit("rpccore");
onload=function(){
    core.rpc.onreceive = doProcess;
}

function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    self.status="";
	if(retType == "checkbackfee")
	{
		if(retCode=="000000")
		{
			var backprepay = packet.data.findValueByName("backprepay");
			var nobackprepay = packet.data.findValueByName("nobackprepay");
			if(backprepay == ".00"){
				backprepay = "0.00";
			}
			if(nobackprepay == ".00"){
				nobackprepay = "0.00";
			}
			document.frm.grpbackprepay.value = backprepay;
			document.frm.grpnobackprepay.value = nobackprepay;
		}
		else
		{
            rdShowMessageDialog("��ѯ����Ԥ�����");
            return false;
		}
	}
    //---------------------------------------
    if(retType == "GrpCustInfo") //�û������û�����ʱ�ͻ���Ϣ��ѯ
    {
        var retname = packet.data.findValueByName("retname");
        if(retCode=="000000")
        {
            document.frm.cust_name.value = retname;
			document.frm.unit_id.focus();
        }
        else
        {
            retMessage = retMessage + "[errorCode1��" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
            return false;
        }
     }
	 if(retType == "getSysAccept")
     {
        if(retCode == "000000")
        {
          	var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.login_accept.value=sysAccept;
					
			document.frm.sure.disabled = true;
	    	page = "f7413Cfm.jsp";
	    	frm.action=page;
	    	frm.method="post";
	    	frm.submit();
        }else{
          	rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��");
			return false;
        }
    }
     //---------------------------------------
     if(retType == "checkPwd") //���ſͻ�����У��
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
	        	frm.custPwd.value = "";
	        	frm.custPwd.focus();
    	    	return false;
            }
            else
            {
                rdShowMessageDialog("�ͻ�����У��ɹ���",2);
                document.frm.sysnote.value = "����100ҵ����˶�";
                document.frm.tonote.value = "����100ҵ����˶�";
                document.frm.sure.disabled = false;
            }
        }
        else
        {
            rdShowMessageDialog("�ͻ�����У�����������У�飡");
    		return false;
        }
     }
}

//���ù������棬���м��ſͻ�ѡ��
function getInfo_Cust()
{
    var pageTitle = "���ſͻ�ѡ��";
    var fieldName = "���֤��|���ſͻ�ID|���ſͻ�����|�����û�ID|�����û���� |�����û�����|ҵ�������|ҵ�������|����ID|�����ʻ�|Ʒ������";
    var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "11|0|1|2|3|4|5|6|7|8|9|10|";
    var retToField = "iccid|cust_id|cust_name|grp_id|user_no|grp_name|product_code|product_name|unit_id|account_id|sm_name|";
    var cust_id = document.frm.cust_id.value;
    if(document.frm.iccid.value == "" &&
       	document.frm.cust_id.value == "" &&
       	document.frm.unit_id.value == "" &&
       	document.frm.user_no.value == "")
    {
        rdShowMessageDialog("���������֤�š����ſͻ�ID������ID�����û���Ž��в�ѯ��",0);
        document.frm.iccid.focus();
        return false;
    }

    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
      	rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
      	rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(document.frm.user_no.value == "0")
    {
    	frm.user_no.value = "";
        rdShowMessageDialog("�����û���Ų���Ϊ0��",0);
    	return false;
    }

    PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s7411/fpubgrpusr_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;
    path = path + "&user_no=" + document.all.user_no.value;
    path = path + "&op_code=" + document.all.op_code.value;
    path = path + "&run_code=" + document.all.run_code.value;
    path = path + "&regionCode=" + document.all.region_code.value;

    retInfo = window.open(path,"newwindow","height=450, width=1000,top=50,left=100,scrollbars=yes, resizable=yes,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
  	var retToField = "iccid|cust_id|cust_name|grp_id|user_no|grp_name|product_code|product_name|unit_id|account_id|sm_name|";
  	if(retInfo ==undefined)
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
    /**��RPC������Ԥ��**/
    var rpc_account_id= document.all.account_id.value;
    var checkbackfee_Packet = new RPCPacket("/npage/s3096/backfee.jsp","���ڲ�ѯԤ��,���Ժ�......");
    checkbackfee_Packet.data.add("retType","checkbackfee");
    checkbackfee_Packet.data.add("account_id",rpc_account_id);
	core.rpc.sendPacket(checkbackfee_Packet);
	delete(checkbackfee_Packet);
}

function check_HidPwd()
{
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    if(cust_id == ""){
    	rdShowMessageDialog("���Ƚ��в�ѯ������");
    	return false;
    }
    var checkPwd_Packet = new RPCPacket("/npage/s3096/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",cust_id);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.rpc.sendPacket(checkPwd_Packet);
	delete(checkPwd_Packet);
}

function getSysAccept()
{
	var getSysAccept_Packet = new RPCPacket("/npage/s3096/pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.rpc.sendPacket(getSysAccept_Packet);
	delete(getSysAccept_Packet);
}

function refMain(){

    var checkFlag; //ע��javascript��JSP�ж���ı���Ҳ������ͬ,���������ҳ����.
    //˵�������ֳ�����,һ���������Ƿ��ǿ�,��һ���������Ƿ�Ϸ�.
    if(check(frm))
    {
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("�����û����ƣ�"+document.frm.grp_name.value+",��������!!");
            document.frm.grp_name.select();
            return false;
        }
        if(  document.frm.grp_id.value == "" ){
            rdShowMessageDialog("ҵ�����ƷID��������!!");
            document.frm.grp_id.select();
            return false;
        }
		getSysAccept();
    }
}

</script>
</HEAD>
<BODY>
<FORM action="" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>
 	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
    <TABLE cellSpacing="0">         	
      	<TR>
      	  	<TD width="15%" class="blue">
      	    	���֤��
      	  	</TD>
      	  	<TD width="35%">
      	      	<input name=iccid class="button" id="iccid" maxlength="18" v_type="string" v_must=1 v_name="���֤��" index="1">
      	      	<input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor��hand" value=��ѯ>
      	      	<font class="orange">*</font>
      	  	</TD>
      	  	<TD  width="15%" class="blue">
      	  		���ſͻ�ID
      	 	</TD>
      	  	<TD width="35%">
      	    	<input class="button" type="text" name="cust_id" maxlength="18" v_type="0_9" v_must=1 v_name="�ͻ�ID" index="2">
      	    	<font class="orange">*</font>
      	  	</TD>
      	</TR>
      	<TR>
      	  	<TD class="blue">
      	     	����ID
      	  	</TD>
      	  	<TD>
	  	  		<input name=unit_id class="button" id="unit_id"  maxlength="10" v_type="0_9" v_must=1 v_name="����ID" index="3">
      	  		<font class="orange">*</font>
      	  	</TD>
      	  	<TD class="blue">
      	  		�����û����
      	  	</TD>
      	  	<TD>
      	    	<input class="button" name="user_no" size="20" v_must=1 v_type=string v_name="�����û����" index="4">
      	    	<font class="orange">*</font>
      	  	</TD>
      	</TR>
      	<TR>
      	  	<TD class="blue">
      	  		���ſͻ�����
      	  	</TD>
      	  	<TD COLSPAN="3">
      	    	<input class="button" name="cust_name" size="20" readonly v_must=1 v_type=string v_name="�ͻ�����" index="4">
      	    	<font class="orange">*</font>
      	  	</TD>
      	</TR>
      	<TR>
      	  	<TD class="blue">�����û�ID</TD>
      	  	<TD>
      	    	<input name="grp_id" type="text" class="button" size="20" maxlength="12" readonly v_type="0_9" v_must=1 index="3">
      	    	<font class="orange">*</font>
      	  	</TD>
      	  	<TD class="blue">�����û�����</TD>
      	  	<TD>
      	    	<input name="grp_name" type="text" class="button" size="20" maxlength="60" readonly v_must=1 v_maxlength=60 v_type="string" v_name="�����û�����" index="4">
      	  		<font class="orange">*</font>
      	  	</TD>
      	</TR>
      	<TR>
      	  	<TD class="blue">ҵ��������ʻ�</TD>
      	  	<TD>
      	    	<input name="account_id" type="text" class="button" size="20" maxlength="12" readonly v_type="0_9" v_must=1 v_name="���Ÿ����ʻ�" index="5">
      	    	<font class="orange">*</font>
      	  	</TD>
      	  	<TD class="blue">ҵ�������</TD>
      	  	<TD>
      	    	<input class="button" type="text" name="product_name" size="20" readonly v_must=1 v_type="string" v_name="��������Ʒ��" index="6"> 
      	    	<font class="orange">*</font>
      	  	</TD>
      	</TR>      	
      	
      	<TR>
      	  	<TD class="blue">����Ԥ��</TD>
      	  	<TD>
      	    	<input name="grpbackprepay" type="text" class="button" size="20" readonly v_name="����Ԥ��">
      	  	</TD>
      	  	<TD class="blue">������Ԥ��</TD>
      	  	<TD>
      	    	<input name="grpnobackprepay" type="text" class="button" size="20" readonly v_name="������Ԥ��">
      	  	</TD>
      	</TR>

      	<TR>
      	   	<TD class="blue">���ſͻ�����</TD>
      	  	<TD COLSPAN="3">
      	  	<%if(!ProvinceRun.equals("20"))  //���Ǽ���
			 	{
			%>       
      	    <jsp:include page="/page/common/pwd_1.jsp">
      	    <jsp:param name="width1" value="15%"  />
	  	    <jsp:param name="width2" value="35%"  />
	  	    <jsp:param name="pname" value="custPwd"  />
	  	    <jsp:param name="pwd" value=""  />
 	  	    </jsp:include>
 	  	      
 	  	 	<%}else{%>
 	  	     	<input name=custPwd type="password" class="button" id="custPwd" size="14" maxlength="6" v_must=1>
     		<%  } %>
     			<input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=У��>
      	      	<font class="orange">*</font>
      	  	</TD>
      	</TR>
      	<TR>
      	    <TD class="blue">ϵͳ��ע</TD>
      	    <TD  colspan="3">
      	     	<input class="button" name="sysnote" size="60" readonly>
      	    </TD>
      	</TR>
      	<TR>
      	    <TD class="blue">�û���ע</TD>
      	    <TD colspan="3">
      	    	<input class="button" name="tonote" size="60">
      	    </TD>
      	</TR>
      	<TR>
      	    <TD colspan="4" align=center id="footer">
      	    	<input class="b_foot" name="sure"  type=button value="ȷ��"  onclick="refMain()" disabled>
      	    	<input class="b_foot" name="reset1"  onClick="" type=reset value="���" >
      	    	<input class="b_foot" name="close"  onClick="parent._exttabref.removeTab('<%=opCode%>')" type=button value="�ر�">
      	    </TD>
			<input class="button" type="hidden" name="sm_name"  value="">
      	</TR>
    </TABLE>
<%@ include file="/npage/include/footer.jsp" %> 
<input type="hidden" name="product_code" value="">
<input type="hidden" name="product_level"  value="1">
<input type="hidden" name="op_type" value="1">
<input type="hidden" name="grp_no" value="0">
<input type="hidden" name="tfFlag" value="n">
<input type="hidden" name="chgpkg_day"   value="">
<input type="hidden" name="TCustId"  value="">
<input type="hidden" name="unit_name"  value="">
<input type="hidden" name="login_accept"  value="0"> <!-- ������ˮ�� -->
<input type="hidden" name="op_code"  value="<%=opCode%>">
<input type="hidden" name="OrgCode"  value="<%=org_code%>">
<input type="hidden" name="region_code"  value="<%=regionCode%>">
<input type="hidden" name="district_code"  value="<%=districtCode%>">
<input type="hidden" name="WorkNo"   value="<%=workno%>">
<input type="hidden" name="NoPass"   value="<%=nopass%>">
<input type="hidden" name="ip_Addr"  value=<%=ip_Addr%>>
<input type="hidden" name="run_code"  value="A">   
</FORM>
</BODY>
</HTML>
