<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<!--baixf add �ڽ�����������Bossϵͳ�и��ֻ������Ӧ����������Ϣ������Ƚϡ�     -->
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.config.INIT_DATA"%>


<script type="text/javascript" src="date.js"></script>

<%
		String opCode = "3216";
		String opName = "��ѯ���ų�Ա��Ϣ";

		ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfoSession = (String[][])arrSession.get(0);
		String[][] otherInfoSession = (String[][])arrSession.get(2);
        String loginNo =(String)session.getAttribute("workNo");
        String loginName = (String)session.getAttribute("workName");
        String orgCode = (String)session.getAttribute("orgCode");
        String ip_Addr = (String)session.getAttribute("ipAddr");
 		String regionCode = (String)session.getAttribute("regCode");
		String regionName = otherInfoSession[0][5];

		String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
		String GroupId = baseInfoSession[0][21];
		String ProvinceRun = baseInfoSession[0][22];
		String OrgId = baseInfoSession[0][23];

		int recordNum = 0;
		String tok = "~";
		ArrayList retArray = new ArrayList();
		String[][] result = new String[][]{};


	     String vpmnCodeBossMsg ="";  //���������
	     String shortNoBossMsg  ="";   //�̺�
	     String phoneNoBossMsg  =request.getParameter("ISDNNO");   //��ʵ����
	     String custNameBossMsg ="";  //�û�����
	     String unitIdBossMsg   ="";    //��ʵ�����������ű��
	     String unitNameBossMsg ="";  //��ʵ����������������


	     //String sqlBossMsg="select a.group_no,a.short_no,a.phone_no,b.cust_name ,d.unit_id,d.unit_name "
	     //                 +" from dvpmnusrmsg a,dcustdoc b ,dcustmsg c,dgrpcustmsg d "
 	     //		         +" where c.cust_id=b.cust_id and a.id_no=c.id_no and "
 	     //		         +" a.cust_id=d.cust_id and  a.phone_no='"+phoneNoBossMsg.trim()+"'";

         //retArrayBossMsg = coBossMsg.sPubSelect("6",sqlBossMsg);
	     //retStrBossMsg=(String[][])retArrayBossMsg.get(0);
	     String qryType = request.getParameter("qryType");
	     String noType = request.getParameter("noType");
	     String GRPID = request.getParameter("GRPID");
	     String ISDNNO = request.getParameter("ISDNNO");
	     String shortNo = request.getParameter("PHONENO");	//yuanqs add 2011/6/24 16:09:05
	     String curpkgtypeMsg = "";		//�����ײ�	yuanqs add 2011/6/24 16:26:11
	     String curpkgtypeNameMsg = "";	//�����ײ����� yuanqs add 2011/6/24 16:26:16
		 String nextpkgtypeMsg = "";	//�����ײ�	yuanqs add 2011/6/24 16:26:19
		 String nextpkgtypeNameMsg = "";//�����ײ�����	yuanqs add 2011/6/24 16:26:24
		 String CUSTMANAGER = "";//�ͻ��������� diling add@2012/5/4 18:11:18
		 String CUSTMANAGERNO = "";//�ͻ������� diling add@2012/5/4 18:11:18
		 String UNITTYPE = "";//������� diling add@2012/5/4 18:11:18
		 /* yuanqs add <wtc:param value="<%=shortNo%>" /> */
  %>
	<wtc:service name="s3216AllEXC" routerKey="region" routerValue="<%=regionCode%>"  retcode="code" retmsg="msg" outnum="13">
		<wtc:param value="3216" />
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=qryType%>" />
		<wtc:param value="<%=noType%>" />
		<wtc:param value="<%=GRPID%>" />
		<wtc:param value="<%=ISDNNO%>" />
		<wtc:param value="<%=shortNo%>" />
	</wtc:service>
	<wtc:array id="retStrBossMsg" scope="end" />
  <%
  System.out.println("%%%%%%%%%%%%%%%%%%%%==="+code);
        System.out.println("%%%%%%%%%%%%%%%%%%%%==="+msg);
	     if(retStrBossMsg==null ||retStrBossMsg.length==0) {
	          phoneNoBossMsg="";
	     }
	     else {
	          vpmnCodeBossMsg =retStrBossMsg[0][0];
	          shortNoBossMsg  =retStrBossMsg[0][1];
	          phoneNoBossMsg  =retStrBossMsg[0][2];
	          custNameBossMsg =retStrBossMsg[0][3];
	          unitIdBossMsg   =retStrBossMsg[0][4];
	          unitNameBossMsg =retStrBossMsg[0][5];

			  curpkgtypeMsg = retStrBossMsg[0][6];
			  curpkgtypeNameMsg = retStrBossMsg[0][7];
			  nextpkgtypeMsg = retStrBossMsg[0][8];
			  nextpkgtypeNameMsg = retStrBossMsg[0][9];
			  
        CUSTMANAGER = retStrBossMsg[0][11];
        CUSTMANAGERNO = retStrBossMsg[0][12];
        UNITTYPE = retStrBossMsg[0][10];

	      }
		System.out.println("vpmnCodeBossMsg = "+vpmnCodeBossMsg);
		System.out.println("shortNoBossMsg = "+shortNoBossMsg);
		System.out.println("phoneNoBossMsg = "+phoneNoBossMsg);
		System.out.println("custNameBossMsg = "+custNameBossMsg);
		System.out.println("unitIdBossMsg = "+unitIdBossMsg);
		System.out.println("unitNameBossMsg = "+unitNameBossMsg);
		System.out.println("curpkgtypeMsg = "+curpkgtypeMsg);
		System.out.println("curpkgtypeNameMsg = "+curpkgtypeNameMsg);
		System.out.println("nextpkgtypeMsg = "+nextpkgtypeMsg);
		System.out.println("nextpkgtypeNameMsg = "+nextpkgtypeNameMsg);
%>

<%
	int valid = 1;  //0:��ȷ��1��ϵͳ����2��ҵ�����

	String[] retInfos = null;

	String[] ParamsIn = new String[8];
	String op_code = request.getParameter("opCode");
	String no_type = request.getParameter("noType");
	String inOrgCode = request.getParameter("orgCode");	 /* ��������   */
	String iRegion_Code = inOrgCode.substring(0,2);

	ParamsIn[0] = request.getParameter("loginNo");  /* ��������   */
	ParamsIn[1] = request.getParameter("orgCode");  /* ��������   */
	ParamsIn[2] = request.getParameter("opCode");   /* ��������   */
	ParamsIn[3] = request.getParameter("opNote");   /* ������ע   */
	ParamsIn[4] = request.getParameter("GRPID");	/* ���ź� 	*/
	ParamsIn[5] = request.getParameter("PHONENO");  /* �̺��� 	*/
	ParamsIn[6] = request.getParameter("ISDNNO");   /* ��ʵ����   */
	ParamsIn[7] = request.getParameter("qryType");  /* ��ѯ����   */

	for(int i=0; i<ParamsIn.length; i++){
		if( ParamsIn[i] == null ){
			ParamsIn[i] = "";
		}
		System.out.println("["+i+"]="+ParamsIn[i]);
	}

	//al = s3210.get_s3216( op_code,input_paras );
	//retArray = callView.callFXService("s3216Cfm", ParamsIn, "3", "region", iRegion_Code);
  %>
	<wtc:service name="s3216Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="errorCode" retmsg="errorMsg" outnum="3">
		<wtc:param value="<%=ParamsIn[0]%>" />
		<wtc:param value="<%=ParamsIn[1]%>" />
		<wtc:param value="<%=ParamsIn[2]%>" />
		<wtc:param value="<%=ParamsIn[3]%>" />
		<wtc:param value="<%=ParamsIn[4]%>" />
		<wtc:param value="<%=ParamsIn[5]%>" />
		<wtc:param value="<%=ParamsIn[6]%>" />
		<wtc:param value="<%=ParamsIn[7]%>" />
	</wtc:service>
	<wtc:array id="callData" start="2" length="1" scope="end" />
  <%
	if( callData == null ){
		valid = 1;
	}else{
		if( !errorCode.equals("000000")){
			valid = 2;
		}
		else
		{
			valid = 0;
			retInfos = callData[0][0].split(tok, 63);
			for(int i = 0; i < retInfos.length; i ++)
			{
				System.out.println("retInfos[" + i + "]=[" + retInfos[i] + "];");
			}
			if( retInfos.length != 63 )
			{
				valid = 2;
				errorCode="444444";
				errorMsg="�������ȷ!!";
			}

		}
	}
%>

<%if( valid != 0 ){
	response.sendRedirect("smapError.jsp?ReqPageName=f3216&errCode="+errorCode+"&errMsg="+errorMsg);
%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<br>�������:"+"<%=errorCode%></br>"+"������Ϣ:"+"<%=errorMsg%>");
	history.go(-1);

//-->
</script>
<%}%>


<head>
<title>��ѯ:ȫ����Ϣ</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">


<script language="JavaScript">
	function fillSelectUseValue_noArr(fillObject,indValue)
	{
			for(var i=0;i<document.all(fillObject).options.length;i++){
				if(document.all(fillObject).options[i].value == indValue){
					document.all(fillObject).options[i].selected = true;
					break;
				}
			}
	}
	function init()
	{
		with(document.frm)
		{
			//������Ϣ������
			GRPID.value = "<%=retInfos[0]%>";
			PHONENO.value = "<%=retInfos[1]%>";
			ISDNNO.value = "<%=retInfos[2]%>";

			USERNAME.value = "<%=retInfos[3]%>";
			IDCARD.value = "<%=retInfos[4]%>";
			DEPT.value = "<%=retInfos[5]%>";
			PCOMMENT.value ="<%=retInfos[6]%>";

			//CLOSENO1.value = "<%=retInfos[7]%>";
			//CLOSENO2.value = "<%=retInfos[8]%>";
			//CLOSENO3.value = "<%=retInfos[9]%>";
			//CLOSENO4.value = "<%=retInfos[10]%>";
			//CLOSENO5.value = "<%=retInfos[11]%>";
			//inuserFlag.value="";
			fillSelectUseValue_noArr("LOCKFLAG","<%=retInfos[12]%>" );

			FLAGS.value =  "<%=retInfos[13]%>";
			var statusDB =  "<%=retInfos[14]%>";
			if(  statusDB.length >=3 )
			{
				fillSelectUseValue_noArr("STATUS1",statusDB.substring(0,1) );
				fillSelectUseValue_noArr("STATUS2",statusDB.substring(1,2) );
				fillSelectUseValue_noArr("STATUS3",statusDB.substring(2,3) );
			}

			fillSelectUseValue_noArr("USERTYPE","<%=retInfos[15].trim()%>");

			MAXOUTNUM.value = "<%=retInfos[16]%>";
			CUROUTNUM.value = "<%=retInfos[17]%>";
			OUTGRP.value = "<%=retInfos[18]%>";

			var feeflagDB = "<%=retInfos[19]%>";
			if( feeflagDB.length >=4 )
			{
				fillSelectUseValue_noArr("FEEFLAG1",feeflagDB.substring(0,1) );
				fillSelectUseValue_noArr("FEEFLAG2",feeflagDB.substring(1,2) );
				fillSelectUseValue_noArr("FEEFLAG3",feeflagDB.substring(2,3) );
				fillSelectUseValue_noArr("FEEFLAG4",feeflagDB.substring(3,4) );
			}

			LMTFEE.value = "<%=retInfos[20]%>";

			//yuanqs add 2011/6/24 16:44:37 �޸ĸ�ֵ����
			CURPKG.value ="<%=curpkgtypeMsg%>";
			CPKGNAME.value = "<%=curpkgtypeNameMsg%>";
			NEXTPKG.value ="<%=nextpkgtypeMsg%>";
			NPKGNAME.value ="<%=nextpkgtypeNameMsg%>";

			fillSelectUseValue_noArr("ISDNTYPE","<%=retInfos[27].trim()%>" );

			STARTTIME.value = "<%=retInfos[28]%>";
			fillSelectUseValue_noArr("CURFEETYPE", "<%=retInfos[23]%>" );
			fillSelectUseValue_noArr("FEETYPE","<%=retInfos[24]%>" );

			//������Ϣ������
			MONTHNOW.value = "<%=retInfos[31]%>";
			TOTALFEE.value = "<%=retInfos[32]%>";
			OVERDUE.value = "<%=retInfos[33]%>";
			FEE1.value = "<%=retInfos[34]%>";
			FEE2.value ="<%=retInfos[35]%>";
			FEE3.value ="<%=retInfos[36]%>";
			FEE4.value = "<%=retInfos[37]%>";
			DURAT1.value = "<%=retInfos[39]%>";
			DURAT2.value = "<%=retInfos[40]%>";
			DURAT3.value = "<%=retInfos[41]%>";
			DURAT4.value = "<%=retInfos[42]%>";
			DURAT5.value = "<%=retInfos[43]%>";
			PTOTALFEE.value = "<%=retInfos[44]%>";
			POVERDUE.value = "<%=retInfos[45]%>";
			PFEE1.value = "<%=retInfos[46]%>";
			PFEE2.value = "<%=retInfos[47]%>";
			PFEE3.value = "<%=retInfos[48]%>";
			PFEE4.value = "<%=retInfos[49]%>";
			PFEE5.value = "<%=retInfos[50]%>";
			PFEE6.value = "<%=retInfos[51]%>";
			PKGDAY.value = "<%=retInfos[52]%>";
			PAYDAY.value = "<%=retInfos[53]%>";
			RENTTIME1.value = "<%=retInfos[54]%>";
			RENTTIME2.value = "<%=retInfos[55]%>";
			RENTFEE1.value = "<%=retInfos[56]%>";
			RENTFEE2.value = "<%=retInfos[57]%>";

			$("#STATUS1").find("option:not(:selected)").remove();
			$("#STATUS2").find("option:not(:selected)").remove();
			$("#STATUS3").find("option:not(:selected)").remove();
			$("#USERTYPE").find("option:not(:selected)").remove();
			$("#FEEFLAG1").find("option:not(:selected)").remove();
			$("#FEEFLAG2").find("option:not(:selected)").remove();
			$("#FEEFLAG3").find("option:not(:selected)").remove();
			$("#FEEFLAG4").find("option:not(:selected)").remove();

			//boss����������Ϣ
			jvpmnCodeBossMsg.value="<%=vpmnCodeBossMsg%>";
			jshortNoBossMsg .value="<%=shortNoBossMsg %>";
			jphoneNoBossMsg .value="<%=phoneNoBossMsg %>";
			jcustNameBossMsg.value="<%=custNameBossMsg%>";
			junitIdBossMsg  .value="<%=unitIdBossMsg  %>";
	    junitNameBossMsg.value="<%=unitNameBossMsg%>";
	    	//wangleic add ��¼BOSS������
	    	if(jvpmnCodeBossMsg.value.trim()==""&&jshortNoBossMsg.value =="")
			{
				RepairBOSS.disabled = false;
			}
		}
}
  function deleteZNW()
  {
  	//ֻ��boss��û�����ݵ�����¿���ɾ������������
  	if(document.frm.jvpmnCodeBossMsg.value.trim()!=""||document.frm.jshortNoBossMsg.value!="")
  	{
  		rdShowMessageDialog("boss���г�Ա��Ϣ����ɾ����������",0)
  	}
  	else
  		{
  			var patherr="f3216_delete.jsp";
            patherr= patherr + "?phoneNo=" +document.frm.ISDNNO.value;
            patherr = patherr +"&grounNo=" + document.frm.GRPID.value;
       		window.open(patherr);
        	history.go(-1);
  		}

  }
  //wangleic ��¼BOSS����
  function repairBOSS()
  {
  	//ֻ��boss��û�����ݵ�����¿��Բ�¼BOSS������
  	if(document.frm.jvpmnCodeBossMsg.value.trim()!=""||document.frm.jshortNoBossMsg.value!="")
  	{
  		rdShowMessageDialog("boss���г�Ա��Ϣ���ܲ�¼BOSS�����ݣ�",0)
  	}
  	else
  		{
  			frm.action="f3216_repair1.jsp";
        	frm.method="post";
        	frm.submit();
  		}

  }
	function call_FLAGS()
	{

	   var h=480;
	   var w=750;
	   var t=screen.availHeight/2-h/2;
	   var l=screen.availWidth/2-w/2;
	   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

	   var str=window.showModalDialog('user_flags.jsp?flags='+document.frm.FLAGS.value,"",prop);


		return true;

	}

//-->
</script>

</head>

<body onLoad="init()" >
<form name="frm" method="post" action="">
<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">��ѯ:ȫ����Ϣ</div>
	</div>


		<table cellspacing="0">
		  <tr >
			<td class="blue">���ź�</td>
			<td><input name="GRPID" type="text" class="button" id="GRPID" readonly></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr >
			<td class="blue">�̺�</td>
			<td width="36%"><input name="qryNo" type="text" class="button" id="PHONENO" readonly></td>
			<td class="blue">��ʵ����</td>
			<td><input name="ISDNNO" type="text" class="button" id="ISDNNO"  readonly></td>
		  </tr>
		  <tr >
			<td class="blue">�û�����</td>
			<td ><input name="USERNAME" type="text" class="button" id="USERNAME" maxlength="18" readonly></td>
			<td class="blue">֤������</td>
			<td><input name="IDCARD" type="text" class="button" id="IDCARD" maxlength="36" readonly></td>
		  </tr>
		  <tr >
			<td  class="blue">�û�����</td>
			<td width="36%"><input name="DEPT" type="text" class="button" id="DEPT" maxlength="36" readonly>
			</td>
			<td  class="blue">������Ϣ</td>
			<td width="34%"><input name="PCOMMENT" type="text" class="button" id="PCOMMENT2" maxlength="36" readonly></td>
		  </tr>
		  <!--<tr >
			<td  class="blue" >�պ�Ⱥ��1</td>
			<td width="36%" ><input name="CLOSENO1" type="text" class="button" id="CLOSENO1" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="�պ�Ⱥ��1">
			</td>
			<td>�պ�Ⱥ��2</td>
			<td ><input name="CLOSENO2" type="text" class="button" id="CLOSENO2" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="�պ�Ⱥ��2">
			</td>
		  </tr>
		  <tr >
			<td  class="blue">�պ�Ⱥ��3:</td>
			<td width="36%"><input name="CLOSENO3" type="text" class="button" id="CLOSENO3" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="�պ�Ⱥ��3">
			</td>
			<td  class="blue">�պ�Ⱥ��4</td>
			<td><input name="CLOSENO4" type="text" class="button" id="CLOSENO4" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="�պ�Ⱥ��4">
			</td>
		  </tr>
		  <tr >
			<td  class="blue" >�պ�Ⱥ��5</td>
			<td width="36%" ><input name="CLOSENO5" type="text" class="button" id="CLOSENO5" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="�պ�Ⱥ��5">
			</td>
			<td>&nbsp;</td>
			<td >&nbsp;</td>
		  </tr>-->
		  <tr >
			<td  class="blue" >�û�������־</td>
			<td ><select name="LOCKFLAG" class="button" id="LOCKFLAG">
				<option value="00" selected>00--&gt;ȥ����</option>
				<option value="10">10--&gt;����</option>
			  </select></td>
			<td class="blue">�û�����Ȩ�޼�</td>
			<td><input name="FLAGS" type="text"  class="button" id="FLAGS" size="36" maxlength="36" readonly>
			<input name="updateFlags" type="button" class="button" id="updateFlags" value="��ϸ��Ϣ" onClick="call_FLAGS()">
			</td>
		  </tr>
		  <tr >
			<td colspan="4"  class="blue">״̬������</td>
		  </tr>
		  <tr >
			<td colspan="4" >
				<table>
				<tr>
				  <td  class="blue">���˸��ѷ�����־</td>
				  <td><select name="STATUS1" id="STATUS1">
					  <option value="0">0--&gt;δ����</option>
					  <option value="1">1--&gt;�ѷ���</option>
					</select></td>
				  <td class="blue">��������</td>
				  <td><select name="STATUS2" id="STATUS2">
					  <option value="0">0--&gt;δ��������</option>
					  <option value="1">1--&gt;��ͨ��</option>
					  <option value="2">2--&gt;Ӣ��</option>
					  <option value="3">3--&gt;�ط���</option>
					</select></td>
				  <td class="blue">���к�����ʾ��ʽ</td>
				  <td><select name="STATUS3" id="STATUS3">
					  <option value="1">1--&gt;��ʾ�̺�</option>
					  <option value="2">2--&gt;��ʾ��ʵ����</option>
					  <option value="3">3--&gt;PBX������ʾ��ʵ����</option>
					  <option value="4">4--&gt;����������ʾ�̺�</option>
					</select></td>
				</tr>
			  </table></td>
		  </tr>
		  <tr >
			<td  class="blue">�û�����</td>
			<td><select name="USERTYPE" id="USERTYPE">
				<option value="0" selected>0--&gt;��ͨ�û�</option>
				<option value="1">1--&gt;����Ա</option>
				<option value="2">2--&gt;����Ա</option>
				<option value="3">3--&gt;����Ա+����Ա</option>
			  </select></td>
			<td>���������</td>
			<td><input name="OUTGRP" type="text" class="button" id="OUTGRP" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="���������">
			</td>
		  </tr>
		  <tr >
			<td  class="blue" >������������</td>
			<td ><input name="MAXOUTNUM" type="text" class="button" id="MAXOUTNUM" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="������������">
			</td>
			<td>��ǰ���������</td>
			<td><input name="CUROUTNUM" type="text" class="button" id="CUROUTNUM"></td>
		  </tr>
		  <tr >
			<td colspan="4">�����޶��־</td>
		  </tr>
		  <tr >
			<td colspan="4" >
				<table >
				<tr>
				  <td  class="blue">����</td>
				  <td><select name="FEEFLAG1" id="FEEFLAG1">
					  <option value="0" selected>0--&gt;���Ÿ������޶�</option>
					  <option value="1">1--&gt;���˸��Ѳ��޶�</option>
					</select></td>
				  <td  class="blue">����</td>
				  <td><select name="FEEFLAG2" id="FEEFLAG2">
					  <option value="0">0--&gt;���Ÿ������޶�</option>
					  <option value="1" selected>1--&gt;���˸��Ѳ��޶�</option>
					</select></td>
				  <td  class="blue">��������</td>
				  <td><select name="FEEFLAG3" id="FEEFLAG3">
					  <option value="0">0--&gt;���Ÿ������޶�</option>
					  <option value="1" selected>1--&gt;���˸��Ѳ��޶�</option>
					</select></td>
				  <td class="blue">���������</td>
				  <td><select name="FEEFLAG4" id="FEEFLAG4">
					  <option value="0">0--&gt;���Ÿ������޶�</option>
					  <option value="1" selected>1--&gt;���˸��Ѳ��޶�</option>
					</select></td>
				</tr>
			  </table></td>
		  </tr>
		  <tr >
			<td  class="blue">�·����޶�</td>
			<td><input name="LMTFEE" type="text" class="button" id="LMTFEE" maxlength="8" v_must=1 v_type=0_9 v_minlength=1   v_name="�·����޶�" readonly>
			</td>
			<td>&nbsp;</td>
			<td>&nbsp; </td>
		  </tr>
		  <tr  id="SHOWADD3">
			<td  class="blue" >�����ʷ��ײ�����</td>
			<td ><input name="CURPKG" type="text" class="button" id="CURPKG" readonly>
			</td>
			<td>�����ʷ��ײ�����</td>
			<td><input name="CPKGNAME" type="text" class="button" id="CPKGNAME"></td>
		  </tr>
		  <tr >
			<td  class="blue">�����ʷ��ײ�����</td>
			<td ><input name="NEXTPKG" type="text" class="button" id="NEXTPKG2" readonly>
			</td>
			<td  class="blue">�����ʷ��ײ�����</td>
			<td ><input name="NPKGNAME" type="text" class="button" id="NPKGNAME"></td>
		  </tr>
		  <tr >
			<td class="blue">�绰����</td>
			<td><select name="ISDNTYPE" id="ISDNTYPE">
				<option value="1">1--&gt;�̶��绰</option>
				<option value="2">2--&gt;�ƶ�PPS</option>
				<option value="3">3--&gt;ȫ��ͨPPS</option>
				<option value="4">4--&gt;ȫ��ͨ��ͨ�ʻ�</option>
				<option value="5">5--&gt;��ͨPPS</option>
				<option value="6">6-&gt;��ͨ��ͨ�ʻ�</option>
				<option value="7">7--&gt;��ͨCDMA </option>
				<option value="8">8--&gt;PBX</option>
				<option value="9">9--&gt;Ѱ����</option>
				<option value="10">10--&gt;��ͨCDMA PPC�û�</option>
			  </select></td>
			<td class="blue">����ʱ��</td>
			<td><input name="STARTTIME" type="text" class="button" id="STARTTIME"></td>
		  </tr>
		  <tr >
			<td class="blue">�����û�Ʒ��</td>
			<td ><select name="CURFEETYPE" id="CURFEETYPE">
				<option value="0">0--&gt;û��Ʒ��</option>
				<option value="1">1--&gt;ȫ��ͨ</option>
				<option value="2">2--&gt;��������</option>
				<option value="3">3--&gt;Ʒ��3</option>
				<option value="4">4--&gt;Ʒ��4 </option>
				<option value="5">5--&gt;Ʒ��5</option>
			  </select></td>
			<td  class="blue">�����û�Ʒ��</td>
			<td ><select name="FEETYPE" id="FEETYPE">
				<option value="0">0--&gt;û��Ʒ��</option>
				<option value="1">1--&gt;ȫ��ͨ</option>
				<option value="2">2--&gt;��������</option>
				<option value="3">3--&gt;Ʒ��3</option>
				<option value="4">4--&gt;Ʒ��4 </option>
				<option value="5">5--&gt;Ʒ��5</option>
			  </select></td>
		  </tr>
		  <%/*add �����ͻ��������ţ�������� by diling for �������Ӽ��ſͻ�ҵ���������ĺ���BOSS���ֵ�һ����@2012/5/3*/
      %>
      <tr >
			<td colspan="4" >
				<table>
				<tr>
				  <td  class="blue">�ͻ���������</td>
				  <td>
					  <input id="CUSTMANAGER" name="CUSTMANAGER" type="text" class="button" value="<%=CUSTMANAGER%>" readonly />
					</td>
				  <td class="blue">�ͻ�������</td>
				  <td>
					  <input id="CUSTMANAGERNO" name="CUSTMANAGERNO" type="text" class="button" value="<%=CUSTMANAGERNO%>" readonly />
					</td>
				  <td class="blue">�������</td>
				  <td>
					  <input id="UNITTYPE" name="UNITTYPE" type="text" class="button" value="<%=UNITTYPE%>" readonly />
					</td>
				</tr>
			  </table></td>
		  </tr>
      
		  <tr bgcolor="649ECC">
			<td colspan="4" class="blue">������Ϣ</td>
		  </tr>
		  <tr >
			<td class="blue">��������</td>
			<td><input name="Monthnow" type="text" class="button" id="MONTHNOW" readonly></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr >
			<td  class="blue">���Ÿ����ܷ���</td>
			<td><input name="Totalfee" type="text" class="button" id="TOTALFEE" readonly></td>
			<td class="blue">���Ÿ���Ƿ���ܶ�</td>
			<td><input name="OVERDUE" type="text" class="button" id="OVERDUE" readonly></td>
		  </tr>
		  <tr >
			<td class="blue">�������ں����ܷ���</td>
			<td ><input name="Fee1" type="text" class="button" id="FEE1" readonly></td>
			<td class="blue">������������ܷ���</td>
			<td><input name="Fee2" type="text" class="button" id="FEE2" readonly></td>
		  </tr>
		  <tr >
			<td  class="blue">�����������������ܷ���</td>
			<td ><input name="FEE3" type="text" class="button" id="FEE3" readonly></td>
			<td  class="blue">������������ܷ���</td>
			<td><input name="FEE4" type="text" class="button" id="FEE4" readonly></td>
		  </tr>
		  <tr >
			<td  class="blue">���ں�����ʱ��</td>
			<td><input name="DURAT1" type="text" class="button" id="DURAT1" readonly></td>
			<td class="blue">�����л�����ʱ��</td>
			<td><input name="DURAT2" type="text" class="button" id="DURAT2" readonly></td>
		  </tr>
		  <tr >
			<td class="blue">���ⳤ;����ʱ��</td>
			<td><input name="DURAT3" type="text" class="button" id="DURAT3" readonly></td>
			<td class="blue">��������������ʱ��</td>
			<td><input name="DURAT4" type="text" class="button" id="DURAT4" readonly></td>
		  </tr>
		  <tr >
			<td class="blue">���������ʱ��</td>
			<td><input name="DURAT5" type="text" class="button" id="DURAT5" readonly></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr >
			<td class="blue">�����Żݺ����ܷ���</td>
			<td><input name="PTOTALFEE" type="text" class="button" id="PTOTALFEE" readonly></td>
			<td class="blue">����Ƿ���ܶ�</td>
			<td><input name="POVERDUE" type="text" class="button" id="POVERDUE" readonly></td>
		  </tr>
		  <tr >
			<td class="blue">�������ں����ܷ���</td>
			<td><input name="PFEE1" type="text" class="button" id="PFEE1" readonly></td>
			<td class="blue">������������ܷ���</td>
			<td><input name="PFEE2" type="text" class="button" id="PFEE2" readonly></td>
		  </tr>
		  <tr >
			<td class="blue">�����������������ܷ���</td>
			<td><input name="PFEE3" type="text" class="button" id="PFEE3" readonly></td>
			<td class="blue">������������ܷ���</td>
			<td><input name="PFEE4" type="text" class="button" id="PFEE4" readonly></td>
		  </tr>
		  <tr >
			<td class="blue">�ײ��û����ں����л��ܷ���</td>
			<td><input name="PFEE5" type="text" class="button" id="PFEE5" readonly></td>
			<td class="blue">���һ��ͨ������</td>
			<td><input name="PFEE6" type="text" class="button" id="PFEE6" readonly></td>
		  </tr>
		  <tr >
			<td class="blue">�ʷ��ײ���Ч����</td>
			<td><input name="PKGDAY" type="text" class="button" id="PKGDAY" readonly></td>
			<td class="blue">���һ�ν���������</td>
			<td><input name="PAYDAY" type="text" class="button" id="PAYDAY" readonly></td>
		  </tr>
		  <tr >
			<td class="blue">��������ʣ�����ʱ��</td>
			<td><input name="RENTTIME1" type="text" class="button" id="RENTTIME1" readonly></td>
			<td class="blue">��������ʣ�����ʱ��2</td>
			<td><input name="RENTTIME2" type="text" class="button" id="RENTTIME2" readonly></td>
		  </tr>
		  <tr >
			<td class="blue">��������ʣ����ѽ��1</td>
			<td><input name="RENTFEE1" type="text" class="button" id="RENTFEE1" readonly></td>
			<td class="blue">��������ʣ����ѽ��2</td>
			<td><input name="RENTFEE2" type="text" class="button" id="RENTFEE2" readonly></td>
		  </tr>

		 <tr>
			<td  class="blue" colspan="4">Boss����������Ϣ</td>
		  </tr>
		 <tr >
			<td class="blue">���������</td>
			<td><input name="jvpmnCodeBossMsg" type="text" class="button" id="jvpmnCodeBossMsg" readonly></td>
			<td class="blue">���ڶ̺�</td>
			<td><input name="jshortNoBossMsg" type="text" class="button" id="jshortNoBossMsg" readonly></td>
		  </tr>
		  <tr >
		   <td class="blue">��ʵ����</td>
		   <td><input name="jphoneNoBossMsg" type="text" class="button" id="jphoneNoBossMsg" readonly></td>
		   <td class="blue">�û�����</td>
		   <td><input name="jcustNameBossMsg" type="text" class="button" id="jcustNameBossMsg" readonly></td>
		  </tr>
		  <tr >
		   <td class="blue">�����������ű��</td>
		   <td><input name="junitIdBossMsg" type="text" class="button" id="junitIdBossMsg" readonly></td>
		   <td class="blue">����������������</td>
		   <td ><input name="junitNameBossMsg" type="text" class="button" id="junitNameBossMsg" ></td>
		  </tr>
		  <tr >
			<td colspan="4" id="footer"> <div align="center"> &nbsp; &nbsp; &nbsp;
				<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="����">
				<input name="DeleteZNW" onClick="deleteZNW()" type="button" class="b_foot" value="ɾ��������">
				<input name="RepairBOSS" onClick="repairBOSS()" type="button" class="b_foot" value="��¼BOSS������" disabled >
				&nbsp; </div></td>
		  </tr>
		</table>


	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
	<input type="hidden" name="loginName" id="loginName" value="">
	<input type="hidden" name="opCode" id="opCode" value="">
	<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">
	<input type="hidden" name="org_id"  value="<%=OrgId%>">
	<input type="hidden" name="group_id"  value="<%=GroupId%>">
			<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

