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

<%
	String opCode=(String)request.getParameter("opCode");
	String opName=(String)request.getParameter("opName");
	String phoneno = (String)request.getParameter("phoneno");
	String contractno=request.getParameter("contractno");
	String busy_type = request.getParameter("busy_type");
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaa busy_type is "+busy_type);
	String orgcode = (String)session.getAttribute("orgCode");
	String regionCode= (String)session.getAttribute("regCode");
//    ScallSvrViewBean viewBean = new ScallSvrViewBean();
//    CallRemoteResultValue  value1 = null;
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
	
	//xl add for sunqy ���ӷ�Ʊbegin
	int i_count=0;
	String inParas_1362[] = new String[2];
	inParas_1362[0]="select to_char(count(*)) from dinvreturns a,dinvoicebyym b  where a.contract_no=:contract_no  and a.user_no=b.phone_no and a.invoice_ym=b.invoice_ym  and b.chg_flag='1' and b.tax_invoice_number is not null ";
	inParas_1362[1]="contract_no="+contractno;
	//end of ���ӷ�Ʊ��
	%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=orgcode.substring(0,2)%>" outnum="1">
    	<wtc:param value="<%=inParas_1362[0]%>"/>
        <wtc:param value="<%=inParas_1362[1]%>"/>
   </wtc:service>
    <wtc:array id="result_1362" scope="end" />
	<%
	if(result_1362!=null&&result_1362.length>0)
	{
		i_count=Integer.parseInt(result_1362[0][0]);
	}
	System.out.println("ffffffffffffffffffffffffffff test   i_count is "+i_count);
	if(i_count>0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("�ú����ѿ�����ֵ˰ר�÷�Ʊ,�轫���ߵ�רƱ���(zg24)������(zg27)�ſ��Խ����˷Ѳ���!");
				//return false;
				history.go(-1);
			</script>
		<%
	}
	else
	{
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

	//ScallSvrViewBean viewBean = new ScallSvrViewBean();

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
	//document.form.sure.disabled=true;
	//document.form.reset.disabled=true;
   
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
		
		document.form.action="s1362_2.jsp?reason1=<%=reason1%>&reason2_txt=<%=reason2_txt%>";
		document.form.submit();
		
		 
 
   	
   
 
	
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
function tzz()//��ӡֽ�ʷ�Ʊ
{
	//alert("zz");
	document.all.cfm.style.display="none";
	document.all.cfmdz.style.display="block";
	document.all.zz_flag.value="1";
}
function tdz()//��ӡ���ӷ�Ʊ
{
	//alert("dz");
	document.all.cfm.style.display="none";
	document.all.cfmdz.style.display="block";
	document.all.zz_flag.value="e";
}
function zz1()
{
	document.all.cfm.style.display="none";
	document.all.cfmdz.style.display="block";
	document.all.zz_flag.value="2";
}
function inits()
{
	document.all.cfm.style.display="none";
	document.all.cfmdz.style.display="none";
}
function doqry()
{
	//alert("1");
	var dzhm = document.all.dzhm.value;
	var dzdm = document.all.dzdm.value;
	var kyny = document.all.kyny.value;
	var phone_no = "<%=phoneno%>";
	var fp_flag = document.all.zz_flag.value;
	if(fp_flag=="2")
	{
		//�����߼�
		var hm_length = dzhm.length;
		var dm_length = dzdm.length;
		//alert("1 dzhm is "+hm_length+" and dm_length is "+dm_length);
		if(hm_length>8 || dm_length>12)
		{
			rdShowMessageDialog("��Ʊ���벻�ܳ���8���ַ�,��Ʊ���벻�ܳ���12���ַ�!");
			return false;
		}
		else
		{
			document.getElementById("s_accept").value="";
			document.all.s_money.value=document.all.nopay_money.value;
			docheck('<%=s_sm_code%>');
		}
	}
	else
	{
		if(dzhm=="" ||dzdm=="" ||kyny=="")
		{
			rdShowMessageDialog("�����뷢Ʊ���롢��Ʊ����ͷ�Ʊ��������!");
			return false;
		}
		else
		{
			var pactket2 = new AJAXPacket("sget_fp.jsp","���ڽ��з�ƱԤռȡ�������Ժ�......");
			pactket2.data.add("dzhm",dzhm);
			pactket2.data.add("dzdm",dzdm);
			pactket2.data.add("kyny",kyny);
			pactket2.data.add("phone_no",phone_no);
			pactket2.data.add("fp_flag",fp_flag);
			core.ajax.sendPacket(pactket2,fpGet);
		}
	}

	
}
function doqryzz()
{
	//alert("2");
	var zzhm = document.all.dzhm.value;
	var zzdm = document.all.dzdm.value;
	var zzkyny = document.all.zzkyny.value;
	var phone_no = "<%=phoneno%>";

	if(zzhm=="" ||zzdm=="" ||zzkyny=="")
	{
		rdShowMessageDialog("������ֽ�ʷ�Ʊ���롢ֽ�ʷ�Ʊ�����ֽ�ʷ�Ʊ��������!");
		return false;
	}
	else
	{
		var pactket2 = new AJAXPacket("sget_fp.jsp","���ڽ��з�ƱԤռȡ�������Ժ�......");
		pactket2.data.add("dzhm",zzhm);
		pactket2.data.add("dzdm",zzdm);
		pactket2.data.add("kyny",zzkyny);
		pactket2.data.add("phone_no",phone_no);
		pactket2.data.add("fp_flag","z");
		core.ajax.sendPacket(pactket2,fpGet);
	}
}
function fpGet(packet)
{
	var s_flag = packet.data.findValueByName("s_flag");
	var s_money = packet.data.findValueByName("s_money");
	var s_accept = packet.data.findValueByName("s_accept");
	document.getElementById("s_accept").value=s_accept;
	//alert("s_flag is "+s_flag+" and s_money is "+s_money+" and s_accept is "+s_accept);
	var tfje = document.all.nopay_money.value;
	document.all.s_money.value=s_money;
	//alert("s_money is "+s_money+" and tfje is "+tfje);
	if(s_flag=="1")
	{
		rdShowMessageDialog("��Ʊ��Ϣ��ѯʧ��!");
		return false;
	}
	else
	{
		if(parseFloat(s_money)<parseFloat(tfje))
		{
			rdShowMessageDialog("��Ʊ�˷ѽ��"+s_money+"С���˷ѽ��"+tfje+",�����������˷ѽ��!");
			return false;
		}
		else
		{
			docheck('<%=s_sm_code%>');
		}
	}
}
</script>
</HEAD>
<BODY onload="inits()">
<FORM action="" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" id="s_accept" name="saccept">
<input type="hidden" name="busy_type"  value="<%=busy_type%>">
<input type="hidden" name="count_num"  value="<%=count_num%>">
<input type="hidden" name="contract_num"  value="<%=contract_num%>">
<input type="hidden" name="opCode"  value="<%=opCode%>">
<input type="hidden" name="opName"  value="<%=opName%>">
<input type="hidden" name="zz_flag"><!--1=ֽ�� e=���� 2=��У���-->
<input type="hidden" name="s_money"><!--1=ֽ�� e=����-->
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
			<input class="button" name=nopay_money value="<%=return_money%>" onKeyPress="return isKeyNumberdot(1)">
		</td>
	</tr>
	<tr> 
		<td align=center id="footer" colspan="4">
		��ѡ��ԭ��Ʊ���ͣ�
			<input type="radio" name="opFlag" value="0" onclick="tzz()"  >ֽ�ʷ�Ʊ(У�鷢Ʊ����)
			&nbsp;
			&nbsp;
			<input type="radio" name="opFlag" value="1" onclick="zz1()"  >ֽ�ʷ�Ʊ(��У�鷢Ʊ����)
			
			&nbsp;
			&nbsp;
			<input type="radio" name="opFlag" value="1" onclick="tdz()"  >���ӷ�Ʊ
			<!--
			<input class="b_foot" name=sure type=button value=ȷ�� onclick="docheck('<%=s_sm_code%>')">
			&nbsp;
			<input class="b_foot" name=reset type=reset value=���� onClick="history.go(-1)">
			&nbsp;
			-->
			&nbsp;
			&nbsp;
			
			
	</tr>
	<tr>
	<td colspan=4>��ע�� 
ֽ�ʷ�Ʊ(���鷢Ʊ����):��ԭҵ���ӡ����ֽ�ʷ�Ʊ����ҵ�����ӡ���ӷ�Ʊʱѡ��
 </td>
	</tr>
	<tr>
	<td colspan=4>ֽ�ʷ�Ʊ(�����鷢Ʊ����):��ԭҵ���ӡ����ֽ�ʷ�Ʊ�����޷��ṩֽ�ʷ�Ʊ�����ԭҵ����ͨ�������ɷѻ��ɷѣ���ҵ�����ӡֽ�ʷ�Ʊʱѡ���籾��ҵ�����ӡ���ӷ�Ʊʱ����ѡ��
 </td>
	</tr>
	<tr>
	<td colspan=4>���ӷ�Ʊ:��ԭҵ���ӡ���ǵ��ӷ�Ʊ����ҵ��ֻ��ѡ����ӷ�Ʊ��
</td>

	 
	</tr>
	<!--
	<tr id="cfm">
		<td align=center id="footer" colspan="4"> 
		<input class="b_foot" name=sure type=button value=ȷ�� onclick="docheck('<%=s_sm_code%>')">
			&nbsp;
		<input class="b_foot" name=reset type=reset value=���� onClick="history.go(-1)">
			&nbsp;
		</td>
	</tr>
	-->
	 <tr id="cfm">
		 
	</tr>
	<!--���ӵ� ��ѯ���ӷ�Ʊ���� ���� ���µ�-->
	<tr id="cfmdz">
		<td > 
			 ��Ʊ����:<input type="text" name="dzhm">
		</td>
		<td > 
			 ��Ʊ����:<input type="text" name="dzdm">
		</td>
		<td > 
			 ��Ʊ��������:<input type="text" name="kyny" maxlength="6">(��:201704)
		</td>
		<td  > 
			<input type="button" name="qry" value="��ѯ" onclick="doqry()">
		</td>
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
			window.location.href="s1362.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	 </script>
<%
	}
	}


	
%>

