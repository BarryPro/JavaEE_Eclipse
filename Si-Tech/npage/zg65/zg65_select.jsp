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
	String phoneno = (String)request.getParameter("phoneNo");
	String contractno=request.getParameter("contractno");
	String busy_type = request.getParameter("busy_type");
	String orgcode = (String)session.getAttribute("orgCode");
	String regionCode= (String)session.getAttribute("regCode");
//    ScallSvrViewBean viewBean = new ScallSvrViewBean();
//    CallRemoteResultValue  value1 = null;
    String[] inParas1 = new String[2];
//	String[][] result1  = null ;
	String count_num="0";
	String contract_num="0";

	//xl add �ʷ���Ϣ��ѯ begin
	String s_zt="";//״̬
	String s_zf="";//�ʷ�
	String s_ym="";//���»��ǰ���
	String[] inParas_zf =new String[2];
	inParas_zf[0]="SELECT case WHEN a.eff_date>sysdate then 'o' else 'n' end,to_char(round(c.offer_attr_value,2)),'m' from  product_offer_instance a, product_offer b,product_offer_attr c where a.serv_id=(select id_no from dcustmsg where phone_no = :s_no)  and a.offer_id = b.offer_id  and a.offer_id = c.offer_id  and b.offer_attr_type = 'YnKD'  and b.offer_type=10 and c.offer_attr_seq=50001 and a.exp_date>sysdate union SELECT case WHEN a.eff_date > sysdate then 'o' else 'n' end,to_char(round(to_char(to_number(c.offer_attr_value)/to_number(d.offer_attr_value)),2)),'y' from product_offer_instance a,product_offer b,product_offer_attr c,product_offer_attr d where a.serv_id=(select id_no from dcustmsg where phone_no = :s_no) and a.offer_id=b.offer_id and a.offer_id=c.offer_id and b.offer_attr_type='YnKB' and b.offer_type = 10 and c.offer_attr_seq=5070 and a.exp_date>sysdate and d.offer_attr_seq=5080 and d.offer_id=c.offer_id";
	inParas_zf[1]="s_no="+phoneno+",s_no="+phoneno;

	%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneno%>"  retcode="retCode_zf" retmsg="retMsg_zf" outnum="3">
		<wtc:param value="<%=inParas_zf[0]%>"/>
		<wtc:param value="<%=inParas_zf[1]%>"/>
	</wtc:service>
	<wtc:array id="ret_val_zf" scope="end" />
	<%
		//ȡlength���� ���length>1 ��˵���е�ǰ��ԤԼ���ʷ� ȡԤԼ�ʷ�
		//length=1 ֻ�е�ǰ
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ret_val_zf.length is "+ret_val_zf.length);
		if(ret_val_zf.length>0)
		{
			System.out.println("11111111111111111111");
			if(ret_val_zf.length>1)
			{
				System.out.println("33333333333333333");
				//��ô�ж�ȡ����ǰorԤԼ? ȡs_zt=o�� ��ʾԤԼ
				for(int i =0;i<ret_val_zf.length;i++)
				{
					System.out.println("fffffffaaaaaaaaaaaaaaaaaa ret_val_zf[i][0] is "+ret_val_zf[i][0]);
					if(ret_val_zf[i][0]=="o" ||ret_val_zf[i][0].equals("o"))
					{
						s_zt=ret_val_zf[i][0];
						s_zf=ret_val_zf[i][1];
						s_ym=ret_val_zf[i][2];
						System.out.println("5555555555555555555");
						//break;
					}
					else
					{
						System.out.println("6666666666666666666666666");
						%>
							<script language="javascript">
								//rdShowMessageDialog("�û����ڶ�����ԤԼ�ʷ�!");
								//history.go(-1);
								//alert("test ret_val_zf[i][0] is "+"<%=ret_val_zf[i][0]%>");
							</script>
						<%
					}
				}
			}
			else
			{
				System.out.println("44444444444444444444");
				s_zt=ret_val_zf[0][0];
				s_zf=ret_val_zf[0][1];
				s_ym=ret_val_zf[0][2];
			}
			//xl add for ���겻���ʷ�
			if(s_ym=="y" ||s_ym.equals("y"))
			{
				s_zf="0";
			}
		}
		else
		{
			System.out.println("222222222222222222");
			s_zt="0";
			s_zf="0";
			s_ym="0";
		}
		System.out.println("fffffffffffffffffffffffff final test s_zt is "+s_zt+" and s_zf is "+s_zf+" and s_ym is "+s_ym);
		String[] inParas_diff_date =new String[2];
		inParas_diff_date[0]="select to_char(round(to_number(TO_DATE(substr(acc_day,0,8),'yyyymmdd')-TO_DATE(substr(end_time,0,8),'yyyymmdd')))) ,substr(acc_day,0,8),substr(end_time,0,8) from ttkd_account_msg where trim(Phone_no)=:s_no";
		inParas_diff_date[1]="s_no="+phoneno;
		//inParas_diff_date[1]="s_no=20904523315";
	%>
	<wtc:service name="TlsPubSelBoss"  outnum="3" >
		<wtc:param value="<%=inParas_diff_date[0]%>"/>
		<wtc:param value="<%=inParas_diff_date[1]%>"/> 
	</wtc:service>
	<wtc:array id="result_diff_date" scope="end"/>
	
<%
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaffffffffffffffffffff result_diff_date is "+result_diff_date.length);
	if(result_diff_date.length==0)
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("��ѯ�û�������Ϣ����!");
				history.go(-1);
			</script>
		<%
	}
	else
	{
	String phoneno_out=request.getParameter("phoneno"); 
    System.out.println("QQQQQQQQQQQQQQQQQQQQQQQQQQQQaaaaaaaaaaaaaaaaaaaaaaa test service=s1362Init��  opCode is "+opCode+" and contractno is "+contractno+" and phoneno is  "+phoneno+" and phoneno_out is "+phoneno_out);
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
		<wtc:param value="zg65"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
//           String [][] result  = value.getData();

	   	  String return_code =result[0][0];
		  String return_message = result[0][1];
 
 if ( return_code.equals("000000")) 
{
	String return_money = result[0][2].trim();
	//���˽����Ҫ��ȥ�ʷ� ���ж�
	/**/
	System.out.println("cccccccccccccccccccccccccccc ����ȡ���� ���˽��="+return_money);
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
function docheck()
{
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
   //�˷ѽ��ܴ���max_money �����߼�������� ��ô�˲����� ����?
   //Ӧ�����˷ѽ�� nopay_money �� ���˽�� ktje ���Ƚ�
   //rdShowMessageDialog("document.all.nopay_money.value is "+document.all.nopay_money.value+" and document.all.max_money.value is "+document.all.max_money.value);
   if(parseFloat(document.all.nopay_money.value)>parseFloat(document.all.max_money.value))
   {
	   rdShowMessageDialog("�˷ѽ���Ѵ��ڿ��˷�����");
	   return false;
   }
   document.form.sure.disabled=true;
   document.form.reset.disabled=true;
   document.form.action="s1362_2.jsp";
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
 	//��������֮��
function getDays(strDateStart,strDateEnd){
   var strSeparator = "-"; //���ڷָ���
   var oDate1;
   var oDate2;
   var iDays;
   //oDate1= strDateStart.split(strSeparator);
   //oDate2= strDateEnd.split(strSeparator);
   oDate1= strDateStart;
   oDate2= strDateEnd;
    var strDateS = new Date(oDate1.substr(0,4), oDate1.substr(4,2)-1, oDate1.substr(6,2));
    var strDateE = new Date(oDate2.substr(0,4), oDate2.substr(4,2)-1, oDate2.substr(6,2));
   //alert("strDateS is "+strDateS+" and strDateE is "+strDateE);
   iDays = parseInt(Math.abs(strDateS - strDateE ) / 1000 / 60 / 60 /24)//�����ĺ�����ת��Ϊ���� 
   //alert(iDays);
   return iDays ;
   
}
	function inits()
	{
	   //xl add for ����ж� begin pre-�ʷѵ�Ǯ ������ȡһ�� ���ڰ���ȡȫ��
	   /*var sDate1=document.all.kssj.value.substr(0,8) ;
	   var sDate2=document.all.jssj.value.substr(0,8) ;
	   var i_days=getDays(sDate1,  sDate2);

	   nopay_money �����������ֵ
	   */
 
	   var i_days="<%=result_diff_date[0][0]%>";
	   //alert("i_days is "+i_days);
	   if(i_days>15)//ȡ����
	   {
			document.form.sfby.value="��";
			var value1=document.form.nopay_money.value-document.form.yhzf.value;
			document.form.ktje.value=value1.toFixed(2);
			document.form.nopay_money.value=document.form.ktje.value;
	   }
	   else
	   {
		   document.form.sfby.value="��";
		   var value1=document.form.nopay_money.value-document.form.yhzf.value/2;
		   document.form.ktje.value=value1.toFixed(2);
		   document.form.nopay_money.value=document.form.ktje.value;
	   }
	   //���<0 ȡ��0
	   if(document.form.nopay_money.value<0)
	   {
		   document.form.nopay_money.value=0;
		   document.form.max_money.value =0;
	   } 	
	   document.form.max_money.value= document.form.nopay_money.value;
	   //xl add for ����ж� end 
	}
//-->
</script>
</HEAD>
<BODY onload="inits()">
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
			<input type="text" name="ktje" value="<%=return_money%>" class="InputGrey" readOnly>
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
		<td class="blue"> �û��ʷ� </td>
		<td >
			<input type="text" name="yhzf" value="<%=s_zf%>" class="InputGrey" readOnly>
		</td>
		<td></td> 
		<td></td> 
	</tr>
	<tr> 
		<td class="blue">������</td>
		<td> 
		 
			<input type="text" name="dqr" value="<%=result_diff_date[0][1]%>" class="InputGrey" readOnly>
		</td>
		<td class="blue">ʧЧʱ��</td>
		<td> 
		    <input type="text" name="sxsj" value="<%=result_diff_date[0][2]%>" class="InputGrey" readOnly>
			 
		</td>
	</tr>
	
	<tr> 
		<td class="blue">���ڲ� </td>
		<td> 
			<input type="text" name="sjc" value="<%=result_diff_date[0][0]%>" class="InputGrey" readOnly>
		</td>
		<td class="blue">�Ƿ�ȡ����</td>
		<td> 
			<input type="text" name="sfby"  class="InputGrey" readOnly>
		</td>
	</tr>

	<tr> 
		<td class="blue">�˷ѽ��</td>
		<td colspan="3"> 
			<input class="button" name=nopay_money value="<%=return_money%>" onKeyPress="return isKeyNumberdot(1)">
		</td>
		<input type="hidden" name=max_money  >
	</tr>
	<tr> <input type="hidden" name="phoneno_out" value="<%=phoneno_out%>">
		<td align=center id="footer" colspan="4"> 
			<!--
			<input class="button" name=predetail type=button value=Ԥ����ϸ onclick="showSelWindow()">
			&nbsp;
			-->
			<input class="b_foot" name=sure type=button value=ȷ�� onclick="docheck()">
			&nbsp;
			<input class="b_foot" name=reset type=reset value=���� onClick="history.go(-1)">
			&nbsp;				  
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
			window.location.href="zg65_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	 </script>
<%
	}
 
	}
	
%>

