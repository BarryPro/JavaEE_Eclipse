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
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="zgb5";
	String opName="��Ԥ���(��ʵ��)";
	String phoneno = (String)request.getParameter("phoneno");
	String contractno=request.getParameter("contractno");
	String busy_type = "2";
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaa busy_type is "+busy_type);
	String orgcode = (String)session.getAttribute("orgCode");
	String regionCode= (String)session.getAttribute("regCode");
	String workname = (String)session.getAttribute("workName");
	String workno = (String)session.getAttribute("workNo");
//    ScallSvrViewBean viewBean = new ScallSvrViewBean();
//    CallRemoteResultValue  value1 = null;
	//xl add for hanfeng PB�Ĳ����԰���
	String s_sm_code="";
	String selectValue = request.getParameter("selectValue");
	String sim_vlaue = request.getParameter("sim_vlaue");
	String fphm = request.getParameter("fphm");
	String fpdm = request.getParameter("fpdm");
	String s_content ="";
	if(selectValue=="2" ||selectValue.equals("2"))
	{
		s_content =sim_vlaue;
	}
	else
	{
		s_content = fphm+","+fpdm;
	}
	String inParas_sm[] = new String[6];
	if(busy_type=="1" ||busy_type.equals("1"))
	{
		inParas_sm[0]="select sm_code from dcustmsg where phone_no=:s_no ";
		inParas_sm[1]="s_no="+phoneno;
	}
	else
	{
		inParas_sm[0]="select sm_code from dcustmsgdead where phone_no=:s_no and contract_no=:s_con_no";
		inParas_sm[1]="s_no="+phoneno+",s_con_no="+contractno;
	}
	
	%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" outnum="1">
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

	// xl add for ȫҵ������
	String reason1 = request.getParameter("reason1");
	String reason2_txt = request.getParameter("reason2_txt");

    String[] inParas1 = new String[2];
//	String[][] result1  = null ;
	String count_num="0";
	String contract_num="0";
 
	inParas1[0] = "select to_char(nvl(count(*),0)) from dConShort where contract_no = '"+ contractno +"'";
	inParas1[1] = "contractno="+contractno;
//		value1 = viewBean.callService("0", null, "sPubSelect", "1",inParas1);
%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/> 
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
<%	
		
//		System.out.println("tempArr================"+tempArr[0][0]);
//        result1 = value1.getData();
//       System.out.println("result1================"+result1[0][0]);
		if (result1.length == 1) {
		   count_num = result1[0][0];
		}
		if(count_num.equals("0")) {
			inParas1[0] = "select to_char(nvl(count(*),0)) from dconusermsg where contract_no = '"+ contractno +"'";
//			value1 = viewBean.callService("0", null, "sPubSelect", "1", inParas1);
%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/> 
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
<%				
//			result1 = value1.getData();
			if (result1.length == 1) {
			  contract_num = result1[0][0];
			}
		}

	//������� begin
	String sqlStr = "";
	String id_iccid="";
	String id_address="";
	String sm_name="";
	String back_cust="";
	sqlStr = "select c.id_iccid,c.id_address ,d.sm_name ,a.bank_cust from dconmsg a,dcustmsg b,dcustdoc c ,ssmcode d where  a.contract_no ="+contractno +" and a.con_cust_id=b.cust_id  and b.cust_id=c.cust_id and c.region_code=d.region_code and b.sm_code=d.sm_code   ";
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

	//end �������

		 String[] inParas = new String[4];
         inParas[0] = contractno;
         inParas[1] = orgcode;
         inParas[2] = busy_type;
         inParas[3] = phoneno;
 
//    CallRemoteResultValue  value  = viewBean.callService("1",orgcode.substring(0,2),  "s1362Init", "7" ,  inParas) ;
%>  
	<wtc:service name="s1362Init" routerKey="region" routerValue="<%=regionCode%>" outnum="7" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
//           String [][] result  = value.getData();

	   	  String return_code =result[0][0];
		  String return_message = result[0][1];
 
 if ( return_code.equals("000000")) 
{
	String return_money = result[0][2].trim();
	String unbill_total =result[0][3].trim();
	String prepay_fee =result[0][4].trim();
	String cust_name =result[0][5].trim();
	String interest = result[0][6].trim();
 %>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript" src="/npage/s1300/common_1300.js"></script>
 
<script language="JavaScript">
<!--

function form_load()
{
��form.nopay_money.focus();
}
function conShort()
{
	rdShowMessageDialog("���ʻ�����û�������˷Ѷ��Ž��պ��룬�����ýɡ��˷Ѷ��Ž��պ��룡");
	window.open("<%=request.getContextPath()%>/page/s1211/f1771.jsp?contractNo="+document.all.contractno.value,"","width=1000,height=600");
}
function docheck(sm_code)
{
   //alert("sm_code is "+sm_code+",test");
   //��ť�û�
	document.form.sure.disabled=true;
	document.form.reset.disabled=true;
   
	   getAfterPrompt();
	   var v_fee = document.form.nopay_money.value;  
	   var pay_message="�˷ѽ���С��0!"; 
	   var null_message="�˷ѽ���Ϊ��!"; 
	   var NaN_message="�˷ѽ��ӦΪ������!";
	   var larger_message="�˷ѽ��ܴ��ڿ��˽��!";
	   var pos;
	   if(document.form.count_num.value ==0 && document.form.contract_num.value ==0 || document.form.contract_num.value >=2){
			conShort();
	   }
		var	prtFlag = rdShowConfirmDialog("�Ƿ�ȷ���˷ѣ�");
		if (prtFlag !=1)
			return false;

	   if(v_fee == null || v_fee == "") 
	   {        
			rdShowMessageDialog(null_message); 
			document.form.nopay_money.value=<%=return_money%>; 
			document.form.nopay_money.select(); 
			return false; 
	   } 
	 
	   if(v_fee><%=return_money%>) 
	   {        
			rdShowMessageDialog(larger_message); 
			document.form.nopay_money.value=<%=return_money%>; 
			document.form.nopay_money.select(); 
			return false; 
	   } 
	   if(parseFloat(v_fee) == 0) 
	   {        
			rdShowMessageDialog(pay_message); 
			document.form.nopay_money.value=<%=return_money%>; 

			document.form.nopay_money.select(); 
			return false; 
	   }        
	   if(isNaN(parseFloat(v_fee)))   
	   {        
			rdShowMessageDialog(NaN_message); 
			document.form.nopay_money.value=<%=return_money%>; 
			document.form.nopay_money.select(); 
			return false; 
	   }
	   if(v_fee>9999999999.99)
	   {
			rdShowMessageDialog("�˷ѽ��ܴ���9999999999.99");
			document.form.nopay_money.value=<%=return_money%>; 

			document.form.nopay_money.select(); 
			return false;
	   }
	  
	   var  tmp_fee = v_fee.toString().replace(/\$|\,/g,'');
		if(isNaN(tmp_fee))
		{
			rdShowMessageDialog("�˷ѽ��ĸ�ʽ���ԣ�");
			document.form.nopay_money.value=<%=return_money%>; 
			document.form.nopay_money.select(); 
			return false;
		}

	   
	   pos=v_fee.indexOf(".");
	   if(pos!=-1)
	   {
			if(v_fee.length-pos>3)
			{
				rdShowMessageDialog("�˷ѽ��С������ܴ���2λ��");
			   document.form.nopay_money.value=<%=return_money%>; 

				document.form.nopay_money.select(); 
				return false;
			}
	   }
		//begin ���
		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");

		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
			{
				  form.action="zgb5_2.jsp?reason1=<%=reason1%>&reason2_txt=<%=reason2_txt%>";
				  form.submit();
			}

			if(ret=="remark")
			{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
				 {
					   form.action="zgb5_2.jsp?reason1=<%=reason1%>&reason2_txt=<%=reason2_txt%>";
					   
					   form.submit();
				}
			}

		}
		else
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
			{
				 document.form.action="zgb5_2.jsp?reason1=<%=reason1%>&reason2_txt=<%=reason2_txt%>";
				// alert("<%=reason1%> is "+<%=reason1%>+"<%=reason2_txt%> is "+<%=reason2_txt%>);
				 document.form.submit();
			}
		}
		//end ���
	 
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
	var opCode="zgb5" ;                   			 		//��������
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
	var b = document.form.nopay_money.value;
	var c=a-b;

    cust_info+="�ֻ����룺"+document.form.phoneno.value+"|";
    cust_info+="�ͻ�������"+"<%=cust_name%>"+"|";
    cust_info+="֤�����룺"+"<%=id_iccid%>"+"|";
    cust_info+="�ͻ���ַ��"+"<%=id_address%>"+"|";

    opr_info+="�û�Ʒ�ƣ�"+"<%=sm_name%>"+"  ����ҵ����Ԥ���"+"  ������ˮ��"+"<%=printAccept%>"+"|";
    opr_info+="�ʻ����ƣ�"+"<%=back_cust%>"+"    �ʻ����룺"+document.form.contractno.value+"  ��Ԥ����"+document.form.nopay_money.value+"|";
    //opr_info+="ת����룺"+document.form.phoneno2.value+"  ת���ʺţ�"+document.form.contractno2.value+"  ת����"+c+"|";
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
 function showSelWindow() {
	var h=500;
	var w=500;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	var returnValue=window.showModalDialog('getPreAcount.jsp?contractno=<%=contractno%>',"",prop);
    
	if(typeof(returnValue) != "undefined") {   
	    rdShowMessageDialog(returnValue);	   
	}
 }
//-->
</script>
</HEAD>
<BODY>
<FORM action="" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="busy_type"  value="<%=busy_type%>">
<input type="hidden" name="count_num"  value="<%=count_num%>">
<input type="hidden" name="contract_num"  value="<%=contract_num%>">
<input type="hidden" name="opCode"  value="<%=opCode%>">
<input type="hidden" name="opName"  value="<%=opName%>">
<table cellspacing="0">
	<tr> 
		<th class="blue">�������</th>
		<th> 
			<input type="text" name="phoneno" maxlength="11" value="<%=phoneno%>" class="InputGrey" readOnly>
		</th>
		<th colspan="4">���ţ�<%=orgcode%></th>
	</tr>
	<tr> 
		<td class="blue">�ʻ�����</td>
		<td> 
			<input type="text" name="contractno" value="<%=contractno%>" class="InputGrey" readOnly>
		</td>
		<td class="blue">�û�����</td>
		<td>
			<input type="text" name="cust_name" value="<%=cust_name%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td class="blue"> ����Ԥ���� </td>
		<td> 
			<input type="text" name="prepay_fee" value="<%=prepay_fee%>" class="InputGrey" readOnly>
		</td>
		<td class="blue">��Ƿ��</td>
		<td> 
			<input type="text" name="unbill_total" value="<%=unbill_total%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td class="blue"> ���˽�� </td>
		<td> 
			<input type="text" name="textfield" value="<%=return_money%>" class="InputGrey" readOnly>
		</td>
			<% if (busy_type.equals("1")) {%>
		<td colspan="2">
			<input type="hidden" name="interest" value="<%=interest%>" class="InputGrey" readOnly>
		</td>
			<%} else {%>
		<td class="blue">��Ϣ</td>
		<td> 
			<input type="text" name="interest" value="<%=interest%>" class="InputGrey" readOnly>
		</td>
			<%}%>
	</tr>
	<tr> 
		<td class="blue">�˷ѽ��</td>
		<td colspan="3"> 
			<input text name=nopay_money value="<%=return_money%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr> 
		<td align=center id="footer" colspan="4"> 
			<!--
			<input class="button" name=predetail type=button value=Ԥ����ϸ onclick="showSelWindow()">
			&nbsp;
			-->
			<input class="b_foot" name=sure type=button value=ȷ�� onclick="docheck('<%=s_sm_code%>')">
			&nbsp;
			<input class="b_foot" name=reset type=reset value=���� onClick="history.go(-1)">
			&nbsp;				  
		</td>
		<input type="hidden" name="s_content" value="<%=s_content%>">
		<input type="hidden" name="selectValue" value="<%=selectValue%>">
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%}
else
{
%>
	 <script language="JavaScript">
			rdShowMessageDialog("��ѯ����!<br>������룺'<%=return_code%>'��������Ϣ��'<%=return_message%>'��",0);
			window.location.href="zgb5_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	 </script>
<%
	}
%>

