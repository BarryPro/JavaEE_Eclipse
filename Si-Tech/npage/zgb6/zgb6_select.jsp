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
<%@ page import="com.sitech.boss.s1310.wrapper.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<%
	//xl add for order
	String phone2 = request.getParameter("phone2");
	if(phone2==null ||phone2.equals(null))
	{
		phone2="";
	}
	//end
	String id_no =  request.getParameter("id_no");
	// xl add for ȫҵ������
	String reason1 = request.getParameter("reason1");
	String reason2_txt = request.getParameter("reason2_txt");
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA reason1 is "+reason1+" reason2_txt is "+reason2_txt);
	String opCode="zgb6";
	String opName="�˻�ת��(ʵ����)";
	String phoneno = (String)request.getParameter("phoneno");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String busy_type = "2";
	String contractno=request.getParameter("contractno");
	String accountpassword=request.getParameter("user_passwd");

	accountpassword = Encrypt.encrypt(accountpassword);
	//System.out.println("R1364.accountpassword="+accountpassword);
	if (accountpassword == null) {
		//  accountpassword = "0";
		accountpassword = "L";
		//System.out.println("R1364.accountpassword="+accountpassword);
	}
	//xl add for hanfeng PB�Ĳ����԰���
	String s_sm_code="";
	String inParas_sm[] = new String[6];
	if(busy_type=="1" ||busy_type.equals("1"))
	{
		inParas_sm[0]="select sm_code from dcustmsg where phone_no=:s_no ";
		inParas_sm[1]="s_no="+phoneno;
	}
	else
	{
		inParas_sm[0]="select sm_code from dcustmsgdead where phone_no=:s_no and contract_no=:s_con_no  ";
		inParas_sm[1]="s_no="+phoneno+",s_con_no="+contractno;
	}
	
	%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=orgCode.substring(0,2)%>" outnum="1">
    	<wtc:param value="<%=inParas_sm[0]%>"/>
        <wtc:param value="<%=inParas_sm[1]%>"/>
   </wtc:service>
    <wtc:array id="result_pp" scope="end" />
	<%
	if(result_pp!=null&&result_pp.length>0)
	{
		s_sm_code=result_pp[0][0];
	}
	//end of ���� ������
	String selectValue = request.getParameter("selectValue");
	String sj_name = request.getParameter("sj_name"); 
	String je_name = request.getParameter("je_name");
	String fphm = request.getParameter("fphm");
	String fpdm = request.getParameter("fpdm");
	String sim_vlaue = request.getParameter("sim_vlaue");
	String s_content ="";
	if(selectValue=="2" ||selectValue.equals("2"))
	{
		s_content =sim_vlaue;
	}
	else
	{
		s_content = fphm+","+fpdm;
	}
%>
	<wtc:service name="s1364Init" routerKey="region" routerValue="<%=regionCode%>" outnum="9" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=contractno%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=orgCode%>"/>
		<wtc:param value="<%=busy_type%>"/>
		<wtc:param value="<%=id_no%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
	<wtc:array id="result2" start="5" length="4" scope="end"/>
<%
	System.out.println("result ==="+result.length);
	for(int k=0;k<result.length; k++){
		System.out.println("====="+k+"===="+result[k]);
	}
	System.out.println("result2==="+result2.length);
//	String [][] result = new String[][]{};
//	String [][] result2 = new String[][]{};
//	result = (String[][])arlist.get(0);
	String return_code =result[0][0];
	String return_message = result[0][1];
	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));

	if (!return_code.equals("000000")) {
	%>
	<script language="JavaScript">
		rdShowMessageDialog("��ѯ����<br>������룺'<%=return_code%>'��<br>������Ϣ��'<%=return_message%>'��",0);
		window.location.href="zgb6_1.jsp";
	</script>
	<%}
	String return_money = result[0][2];
	String cust_name =result[0][3];
	String cur_owe =result[0][4];
	return_money=return_money.trim();
	cust_name=cust_name.trim();
	cur_owe=cur_owe.trim();
//	result2 = (String[][])arlist.get(1);
	if (result2.length==0)
	{%>
	<script language="JavaScript">
		rdShowMessageDialog("��ѯ�����޽������111111��",0);
		window.location.href="zgb6_1.jsp";
	</script>
	<%}
//	ArrayList retArray = new ArrayList();
//	String[][] result3 = new String[][]{};
//	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String sqlStr = "";
	String id_iccid="";
	String id_address="";
	String sm_name="";
	String back_cust="";
	sqlStr = "select c.id_iccid,c.id_address ,d.sm_name ,a.bank_cust from dconmsg a,dcustmsg b,dcustdoc c ,ssmcode d where  a.contract_no ="+contractno +" and a.con_cust_id=b.cust_id  and b.cust_id=c.cust_id and c.region_code=d.region_code and b.sm_code=d.sm_code   ";
//	retArray = callView.sPubSelect("4",sqlStr);

%>
	<wtc:pubselect name="TlsPubSelBoss"  routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode1" retmsg="retMsg1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result3" scope="end" />
<%
//	result3  = (String[][])retArray.get(0);
	if(result3.length>0){
		id_iccid= result3[0][0];
		id_address= result3[0][1];
		sm_name= result3[0][2];
		back_cust= result3[0][3];
	}
	/****�õ���ӡ��ˮ****/
	String printAccept="";
	printAccept = getMaxAccept();
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>������BOSS-�ʻ�ת��</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
<!--
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
function form_load()
{
form.phoneno2.focus();
}
function docheck(sm_code)
{
  // alert(sm_code);
   if(sm_code=="PB")
   {
		rdShowMessageDialog("���������벻�������!");
		return false;
   }
   else
   {
	   getAfterPrompt();
	   var v_fee = document.form.return_money.value;
	   var pay_message="ת�ʽ���С��0!";
	   var null_message="ת�ʽ���Ϊ��!";
	   var NaN_message="ת�ʽ��ӦΪ������!";
	   var larger_message="ת�ʽ��ܴ����ʻ�ʣ����!";
	   var pos;

	   if(v_fee == null || v_fee == "")
	   {
			rdShowMessageDialog(null_message);
			document.form.return_money.select();
			return false;
	   }
	   if(v_fee><%=return_money%>)
	   {
			rdShowMessageDialog(larger_message);
			document.form.return_money.select();
			return false;
	   }
	   if(parseFloat(v_fee) <= 0)
	   {
			rdShowMessageDialog(pay_message);
			document.form.return_money.select();
			return false;
	   }
	   if(isNaN(parseFloat(v_fee)))
	   {
			rdShowMessageDialog(NaN_message);
			document.form.return_money.select();
			return false;
	   }
	   if(v_fee>9999999999.99)
	   {
			rdShowMessageDialog("ת�ʽ��ܴ���9999999999.99");
			document.form.return_money.select();
			return false;
	   }
	   pos=v_fee.indexOf(".");
	   if(pos!=-1)
	   {
			if(pos>10)
			{
				rdShowMessageDialog("ת�ʽ��С����ǰ���ܴ���10λ��");
				document.form.return_money.select();
				return false;
			}
			if(v_fee.length-pos>3)
			{
				rdShowMessageDialog("ת�ʽ��С������ܴ���2λ��");
				document.form.return_money.select();
				return false;
			}
	   }
	   else
	   {
			if(v_fee.length>10)
			{
				rdShowMessageDialog("ת�ʽ��С����ǰ���ܴ���10λ��");
				document.form.return_money.select();
				return false;
			}
	   }

		if(form.contractno2.value.length<5&&( form.phoneno2.value.length<11 || isNumberString(form.phoneno2.value,"1234567890")!=1)) {
			rdShowMessageDialog("������������,����Ϊ11λ����,��ֱ�������ʺ� !!")
			document.form.phoneno2.focus();
			return false;
		}
		/*20090422 liyan modify �Ŷθ���
		else if (form.contractno2.value.length<5&&(parseInt(form.phoneno2.value.substring(0,3),10)<134 || 158>parseInt(form.phoneno.value.substring(0,3),10)>139||parseInt(form.phoneno.value.substring(0,3),10)>159)){
			rdShowMessageDialog("������134-139����158,159��ͷ�ķ������,��ֱ�������ʺ� !!")
			document.form.phoneno2.focus();
			return false;
		}*/

		else if (!checkPhone(form.phoneno2.value) && form.contractno2.value.length<5)
		{
			rdShowMessageDialog("<%=PhoneHeadErrMsg%>,��ֱ�������ʺ� !");
			return false;
		}

		else if (form.contractno2.value==""){
			rdShowMessageDialog("��������ѯ�ʻ����� !!")
			document.form.contractno2.focus();
			return false;
		}
		else if (form.contractno.value==form.contractno2.value)
	   {
			rdShowMessageDialog("ת���ʻ�������ԭ�ʻ�����һ�£�");
			document.form.contractno2.select();
			return false;
		}

		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");

		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
			{
				  form.action="zgb6_2.jsp?reason1=<%=reason1%>&reason2_txt=<%=reason2_txt%>";
				  form.submit();
			}

			if(ret=="remark")
			{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
				 {
					   form.action="zgb6_2.jsp?reason1=<%=reason1%>&reason2_txt=<%=reason2_txt%>";
					   
					   form.submit();
				}
			}

		}
		else
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
			{
				 form.action="zgb6_2.jsp?reason1=<%=reason1%>&reason2_txt=<%=reason2_txt%>";
				// alert("<%=reason1%> is "+<%=reason1%>+"<%=reason2_txt%> is "+<%=reason2_txt%>);
				 form.submit();
			}
		}

		document.form.sure.disabled=true;
		document.form.clear.disabled=true;
		document.form.reset.disabled=true;
   }	
   


}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  //��ʾ��ӡ�Ի���
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

	var pType="subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =<%=printAccept%>;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode="zgb6" ;                   			 		//��������
	var phoneNo="<%=phoneno%>";                  	 		//�ͻ��绰

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfn;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode=<%=opCode%>&sysAccept="+sysAccept+
	//	"&opCode=1364&sysAccept="+sysAccept+
		"&phoneNo="+document.form.phoneno.value+
		"&submitCfm="+submitCfn+"&pType="+
		pType+"&billType="+billType+ "&printInfo=" + printStr;

	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{
    var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����

    var a ="<%=return_money%>";
	var b = document.form.return_money.value;
	var c=a-b;

    cust_info+="�ֻ����룺"+document.form.phoneno.value+"|";
    cust_info+="�ͻ�������"+"<%=cust_name%>"+"|";
    cust_info+="֤�����룺"+"<%=id_iccid%>"+"|";
    cust_info+="�ͻ���ַ��"+"<%=id_address%>"+"|";

    opr_info+="�û�Ʒ�ƣ�"+"<%=sm_name%>"+"  ����ҵ���ʻ�ת��"+"  ������ˮ��"+"<%=printAccept%>"+"|";
    opr_info+="�ʻ����ƣ�"+"<%=back_cust%>"+"    �ʻ����룺"+document.form.contractno.value+"  ת�ʽ�"+document.form.return_money.value+"|";
    opr_info+="ת����룺"+document.form.phoneno2.value+"  ת���ʺţ�"+document.form.contractno2.value+"  ת����"+c+"|";
    opr_info+='<%=workno%>   <%=workname%>'+"|";
    opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    retInfo+=""+"|";
    retInfo+=""+"|";
    retInfo+=""+"|";
	retInfo+=""+"|";
    retInfo+=""+"|";
	retInfo+=""+"|";

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}

function getcount()
{
	if( form.phoneno2.value.length<11 || isNumberString(form.phoneno2.value,"1234567890")!=1 ) {
		rdShowMessageDialog("������������,����Ϊ11λ���� !!")
		document.form.phoneno2.focus();
		return false;
	}
	/*20090422 liyan modify �Ŷθ���
	else if (parseInt(form.phoneno2.value.substring(0,3),10)<134 || 158>parseInt(form.phoneno.value.substring(0,3),10)>139||parseInt(form.phoneno.value.substring(0,3),10)>159){
		rdShowMessageDialog("������134-139����158,159��ͷ�ķ������ !!")
		document.form.phoneno2.focus();
		return false;
	}
	*/
	if (!checkPhone(form.phoneno2.value))
	{
		rdShowMessageDialog("<%=PhoneHeadErrMsg%>");
		return false;
	}
	else {
		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		var str=window.showModalDialog('getCount.jsp?phoneNo='+document.form.phoneno2.value,"",prop);

		if( typeof(str) != "undefined" ){
			if (parseInt(str)==0){
		   		rdShowMessageDialog("û���ҵ���Ӧ���ʺţ�",0);
		   		document.form.phoneno2.focus();
		   		return false;
		   	}
	   		else {
		   		document.form.contractno2.value=str;
		   		document.form.return_money.focus();
		   		return true;
		   	}
			return true;
		}
	}
}

//-->
</script>
</HEAD>
<BODY>
<FORM action="zgb6_2.jsp" method=post name=form>
<input type="hidden" name="busy_type"  value="<%=busy_type%>">
<input type="hidden" name="printAccept"  value="<%=printAccept%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�˻���Ϣ</div>
	</div>
<table cellspacing="0">
	<tr>
		<th>�û����ͣ�</th>
		<th>
		<%if (busy_type.equals("1")) {%>
		�����û� <%} else {%>
		�����û� <%}%></th>
		<th>���ţ�</th>
		<th><%=orgCode%></th>
	</tr>
	<tr>
		<td class="blue">�������</td>
		<td class="blue">
			<input type="text" name="phoneno" maxlength="11" class="InputGrey" readonly value="<%=phoneno%>">
		</td>
		<td class="blue">�ʻ�����</td>
		<td width="39%">
			<input type="text" class="InputGrey" readonly name="contractno" value="<%=contractno%>">
		</td>
	</tr>
	<tr>
		<td class="blue">�ʻ�����</td>
		<td>
			<input type="password" readonly name="accountpassword" class="InputGrey" value="�뿴���밡��:)">
		</td>
		<td class="blue">�û�����</td>
		<td>
			<input type="text" readonly name="contractno3" class="InputGrey" value="<%=cust_name%>">
		</td>
	</tr>
	<tr>
		<td class="blue">δ��Ƿ��</td>
		<td colspan="3">
			<input type="text" name="cur_owe" maxlength="11" class="InputGrey" readonly value="<%=cur_owe%>">
		</td>
    </tr>
	<input type="hidden" name="s_content" value="<%=s_content%>">
		<input type="hidden" name="selectValue" value="<%=selectValue%>">
</table>
</div>

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">Ԥ����ϸ</div>
</div>

<table cellspacing=0>
	<tr>
		<th>
			<div align="center">Ԥ������</div>
		</th>
		<th>
			<div align="center">Ԥ����</div>
		</th>
		<th>
			<div align="center">˳��</div>
		</th>
		<th>
			<div align="center">�Ƿ����</div>
		</th>
	</tr>
	<%
		for(int y=0;y<result2.length;y++){
		String tdClass = ((y%2)==1)?"Grey":"";
	%>
	<%
	for(int j=0;j<result2[0].length;j++){
	%>
	<td height="25" class="<%=tdClass%>"><div align="center"><%= result2[y][j]%></div></td>
	<%	}
	%>
	</tr>
	<%
	}
	%>

</table>
</div>

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">ת����ϸ</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">ת�����</td>
		<td>
			<input type="text" name="phoneno2" maxlength="11" class="button" onkeydown="if(event.keyCode==13)getcount()" onKeyPress="return isKeyNumberdot(0)" value="<%=phone2%>">
			<input class="b_text" name=sure22 type=button value=��ѯ�ʺ� onClick="getcount();">
		</td>
		<td class="blue">ת���ʻ�</td>
		<td>
			<input type="text" name="contractno2" class="InputGrey" onKeyPress="return isKeyNumberdot(0)" onkeydown="if(event.keyCode==13)document.form.return_money.focus()" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">��ת����</td>
		<td>
			<input class="InputGrey" readonly name=remark2 value="<%=return_money%>">
		</td>
		<td class="blue">ת����</td>
		<td>
			<input class="InputGrey" name=return_money value="<%=return_money%>" readonly>
		</td>
	</tr>
	<tr>
		<td align=center id="footer" colspan="4">
		<input class="b_foot" name=sure type=button value=ȷ�� onclick="docheck('<%=s_sm_code%>')">
		&nbsp;
		<input class="b_foot" name=clear type=reset value=���>
		&nbsp;
		<input class="b_foot" name=reset type=reset value=���� onClick="history.go(-1)">
		&nbsp; </td>
	</tr>
</table>

	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
