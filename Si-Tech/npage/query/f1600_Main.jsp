<%
/********************
 version v2.0
������: si-tech
*
*create by lipf 20120322
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "e729";
	String opName = "�����Ϣ��ѯ";
	
	String inStr  = request.getParameter("parStr");//�õ��������
	int pos = inStr.indexOf("|");
	String phoneNo  = inStr.substring(0,pos);//�ֻ�����
	String idNo  = inStr.substring(12,inStr.length());//ID��
	

	String workNoAccountType = (String)session.getAttribute("accountType"); 		//wanghfa ��� Ϊ�ж��Ƿ�Ϊ�ͷ�����
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String powerName = (String)session.getAttribute("powerRight");
	String deptCode = (String)session.getAttribute("orgCode");;
	String ip_Addr = "172.16.23.13";
	String regionCode = deptCode.substring(0,2);
	//add by lipf for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");

	/* ningtn@20100707 �޸�ҳ��������ʾ��ʽ start */
	String custNameStr 			 = "";
	String custAddressStr 		 = "";
	String idIccidStr 			 = "";
	String idAddressStr 		 = "";
	String contactPersonStr      = "";
	String contactPhoneStr       = "";
	String contactAddressStr     = "";
	String contactPostStr        = "";
	String contactAddress1Str    = "";
	String contactMailaddressStr = "";
	String contactFaxStr         = "";
	

	
%>
	<!--update by lipf 20120717 ����ӹ�begin-->
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sLoginAccept"/>
	
	<wtc:service name="s1500Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="10">
	<wtc:param value="<%=sLoginAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="e729"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=idNo%>"/>
	</wtc:service>
	<wtc:array id="mainQryArr" scope="end"/>	
	<!--update by lipf 20120717 ����ӹ�end-->
<%
	System.out.println("lipf   f1600_Main.jsp  ======= ->sLoginAccept->       "+sLoginAccept+" ====== ->phoneNo->       "+phoneNo+" ======= ->idNo->       "+idNo+" ======== ->retCode1->       "+retCode1);
 String retCodeForCntt = retCode1;
 String loginAccept =""; 
 String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo;
 System.out.println("url="+url);
%>
<jsp:include page="<%=url%>" flush="true" />
<%
	if(!retCode1.equals("000000")){
%>
	<script language="javascript">
		rdShowMessageDialog("����δ�ܳɹ�,�������<%=retCode1%><br>������Ϣ<%=retMsg1%>!");
		parent.removeTab("<%=opCode%>");
	</script>
<%
		return;
	}else if(mainQryArr==null||mainQryArr.length==0){
%>
	<script language="javascript">
		rdShowMessageDialog("��ѯ���Ϊ��,�޴�������Ϣ���������!");
		parent.removeTab("<%=opCode%>");
	</script>
<%
		return;
	}
	
	//ѭ��ȡֵ,�������������list��
	ArrayList arlist = new ArrayList();
	StringTokenizer resToken = null;
  for(int i = 0; i<mainQryArr.length; i++){
  	for(int j=0;j<mainQryArr[i].length;j++){
  		String value;
      for(resToken = new StringTokenizer(mainQryArr[i][j], "|"); resToken.hasMoreElements(); arlist.add(value)){
          value = (String)resToken.nextElement();
      }
  	}
  }
	/* ningtn ��ͨ�˺� ��ʽ����*/
	String broadStyle = "none;";
	String simStyle = "block;";
	if("GH".equals((String)arlist.get(65))
	 ||"kd".equals((String)arlist.get(65))
	 ||"CT".equals((String)arlist.get(65))){
	 broadStyle = "block";
	 simStyle = "none";
	}
	//�����￪ʼȡֵ��
	String return_code = (String)arlist.get(0);
	String return_message =(String)arlist.get(1);
	
	String sql="select trim(phone_no) from wPrepayPhoneSaleOpr where second_id=to_number('"+idNo+"') and op_code='8042' and back_flag='0'";
%>
	<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="mainPhoneArr" scope="end" />
<%
	String mainPhone="";
	if(mainPhoneArr.length>0){
		mainPhone=mainPhoneArr[0][0];
	}else{
		mainPhone="��";
	}
	
	
	if (!return_code.equals("000000")){
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=return_message%><br>������� :<%=return_code%>");
	history.go(-1);
</script>
<%	
	}else{
	String userInfo1 = (String)arlist.get(29);
	String highmsg=(String)arlist.get(30);
	String ss="�и߶��û�";
	int spos=highmsg.indexOf(ss,0);
%>
<script>
	if(<%=spos%>>=0){rdShowMessageDialog("���û����и߶��û���");}
	var userInfo = "<%= userInfo1 %>" ;
	
	var userType = oneTok(userInfo,"~",1);
	var stopFlag = oneTok(userInfo,"~",2);
	var stopDesc = "";
	if ( stopFlag == "N" )
		stopDesc = "��ͣ�û�";
	else
		stopDesc = "����ͣ�û�";
		
</script>
<%
}
%>
<%
/* ningtn@20100707 �޸�ҳ��������ʾ��ʽ start */
	if("1".equals(request.getParameter("passFlag"))) {
		custNameStr 		  = "";
		custAddressStr 		  = "";
		idIccidStr 			  = "";
		idAddressStr 		  = "";
		contactPersonStr      = "";
		contactPhoneStr       = "";
		contactAddressStr     = "";
		contactPostStr        = "";
		contactAddress1Str    = "";
		contactMailaddressStr = "";
		contactFaxStr         = "";
	}else{
		custNameStr 		  = (String)arlist.get(3);
		custAddressStr 		  = (String)arlist.get(9);
		idIccidStr 			  = (String)arlist.get(11);
		idAddressStr 		  = (String)arlist.get(12);
		contactPersonStr      = (String)arlist.get(14);
		contactPhoneStr       = (String)arlist.get(15);
		contactAddressStr     = (String)arlist.get(16);
		contactPostStr        = (String)arlist.get(17);
		contactAddress1Str    = (String)arlist.get(18);
		contactMailaddressStr = (String)arlist.get(20);
		contactFaxStr         = (String)arlist.get(19);
	}
/* ningtn@20100707 �޸�ҳ��������ʾ��ʽ end */
%>

<script>
	x = screen.availWidth;
	y = screen.availHeight;
	window.innerWidth = x;
	window.innerHeight = y;
</script>

<%--add by zhanghonga@20090107,�汾�ϲ�ʱ���ӵ���������--%>
<%
	String fee_return_code = "";//s1500_fee����retCode
	String fee_return_msg = "";//s1500_fee����retMsg
	String show_fee = ""; //��ǰԤ��;
	String prepayFee = "";//��ǰ�ɻ���Ԥ��
	String nobillpay = ""; //δ���˻���
	String now_prepayFee = "";//��ǰ����Ԥ��
	
	//liuxmc add 20100907 begin
	String zx_yc_fee = "";//ר��Ԥ�����
	String pt_yc_fee = "";//��ͨԤ�����
	//liuxmc add 20100907 end
%>
	<wtc:service name="s1500_feeVW" routerKey="region" routerValue="<%=regionCode%>" retcode="feeRetCode" retmsg="feeRetMsg" outnum="8">
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=idNo%>"/>
	</wtc:service>
	<wtc:array id="s1500FeeArr" scope="end"/>
<%
	//��Ϊ���񷵻ص�retCode���淶,������ֻ��һ��"0",���������Ƚ���
	if(Integer.parseInt(feeRetCode)==0){
		if(s1500FeeArr.length>0){
			fee_return_code = s1500FeeArr[0][0];
			fee_return_msg = s1500FeeArr[0][1];
			show_fee = s1500FeeArr[0][2]; //��ǰԤ��;
			prepayFee = s1500FeeArr[0][3];//��ǰ�ɻ���Ԥ��
			nobillpay = s1500FeeArr[0][4]; //δ���˻���
			now_prepayFee = s1500FeeArr[0][5];//��ǰ����Ԥ��
			
			//liuxmc add 20100907 begin
			zx_yc_fee=s1500FeeArr[0][6];
			pt_yc_fee=s1500FeeArr[0][7];
			/* ningtn */
			if(zx_yc_fee == null){
				zx_yc_fee = "";
			}
			if(pt_yc_fee == null){
				pt_yc_fee = "";
			}
			//liuxmc add 20100907 end
		}
	}
%>
<%--add by zhanghonga@20090107,�汾�ϲ�ʱ���ӵ��������ݵ��������--%>

<HTML>
	<HEAD>
	<TITLE>�����Ϣ��ѯ</TITLE>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	
	</HEAD>
<script language=javascript>
	var a=1;
function init(){
	document.all.attrCode.value = userType;
	document.all.stop.value = stopDesc;

	if (<%=request.getParameter("passFlag")%> == "1") {
		rdShowMessageDialog("���벻��ȷ��ֻ����ʾ������Ϣ��");
	}
}

</script>
<body onLoad="init()">
  <form name="form1" method="post" action="">
  	<%@ include file="/npage/include/header.jsp" %>
  	<div id="Operation_Table">	
  		<div class="title">
				<div id="title_zi">�ͻ���Ϣ</div>
			</div>
		  <table id=tb1 cellspacing="0">
		    <tr> 
		      <td class="blue">�ͻ���ʶ</td>
		      <td> 
		        <input name=custId  class="InputGrey" maxlength="20" readonly value="<%=(String)arlist.get(2)%>">
		      </td>
		      <td class="blue">�ͻ�����</td>
		      <td> 
		        <input name=custName class="InputGrey" readonly value="<%=custNameStr%>" >
		        </td>
		      <td class="blue">�����ص�</td>
		      <td> 
		        <input name=regionCode class="InputGrey" readonly value="<%=(String)arlist.get(4)%>">
		      </td>
		      <td class="blue">�ͻ�״̬</td>
		      <td class="blue"> 
		        <input name=custStatus class="InputGrey" readonly value="<%=(String)arlist.get(5)%>">
		      </td>
		    </tr>
		    <tr> 
		      <td class="blue">״̬ʱ��</td>
		      <td> 
		        <input name=runTime class="InputGrey" readonly value="<%=(String)arlist.get(6)%>">
		        </td>
		      <td class="blue">�ͻ�����</td>
		      <td> 
		        <input name=ownerGrade class="InputGrey" readonly value="<%=(String)arlist.get(7)%>" >
		        </td>
		      <td class="blue">�ͻ����</td>
		      <td> 
		        <input name=ownerType class="InputGrey" readonly value="<%=(String)arlist.get(8)%>">
		        </td>
		      <td class="blue">�ͻ���ַ</td>
		      <td> 
		        <input name=custAddress class="InputGrey" readonly value="<%=custAddressStr%>">
		      </td>
		    </tr>
		    <tr> 
		      <td class="blue">֤������</td>
		      <td> 
		        <input name=idType class="InputGrey" readonly value="<%=(String)arlist.get(10)%>">
		        </td>
		      <td class="blue">֤������</td>
		      <td> 
		        <input name=idIccid class="InputGrey" readonly value="<%=idIccidStr%>">
		      </td>
		      <td class="blue">֤����ַ</td>
		      <td> 
		        <input name=idAddress class="InputGrey" readonly value="<%=idAddressStr%>">
		      </td>
		      <td class="blue">֤����Ч��</td>
		      <td> 
		        <input name=idValiddate class="InputGrey" readonly value="<%=(String)arlist.get(13)%>">
		      </td>
		    </tr>
		    <tr> 
		      <td class="blue">��ϵ��</td>
		      <td> 
		        <input name=contactPerson class="InputGrey" readonly value="<%=contactPersonStr%>">
		        </td>
		      <td class="blue">��ϵ�绰</td>
		      <td> 
		        <input name=contactPhone class="InputGrey" readonly value="<%=contactPhoneStr%>">
		        </td>
		      <td class="blue">��ϵ��ַ</td>
		      <td> 
		        <input name=contactAddress class="InputGrey" readonly value="<%=contactAddressStr%>" >
		      </td>
		      <td class="blue">��������</td>
		      <td class="blue"> 
		        <input name=contactPost class="InputGrey" readonly value="<%=contactPostStr%>">
		      </td>
		    </tr>
		    <tr> 
		      <td class="blue">ͨѶ��ַ</td>
		      <td> 
		        <input name=contactAddress1 class="InputGrey" readonly value="<%=contactAddress1Str%>" >
		        </td>
		      <td class="blue">��ϵ�˴���</td>
		      <td> 
		        <input name=contactFax class="InputGrey" readonly value="<%=contactFaxStr%>" >
		      </td>
		      <td class="blue">��������</td>
		      <td class="blue"> 
		        <input name=contactMailaddress class="InputGrey" readonly value="<%=contactMailaddressStr%>">
		      </td>
		      <td class="blue">����������ʶ</td>
		      <td> 
		        <input name=contact_emaill class="InputGrey" readonly value="<%=(String)arlist.get(21)%>">
		      </td>
		    </tr>
		    <tr> 
		      <td class="blue">����ʱ��</td>
		      <td> 
		        <input name=create_time class="InputGrey" readonly value="<%=(String)arlist.get(22)%>">
		      </td>
		      <td class="blue">����ʱ��</td>
		      <td> 
		        <input name=close_time class="InputGrey" readonly value="<%=(String)arlist.get(23)%>">
		      </td>
		      <td class="blue">�ϼ��ͻ�ID</td>
		      <td> 
		        <input name=parent_id class="InputGrey" readonly value="<%=(String)arlist.get(24)%>">
		      </td>
		      <td class="blue">Ԥ�滻�ֻ����ѹ���������</td>
		      <td>
		      	<input name=parent_id class="InputGrey" readonly value="<%=mainPhone%>">
		     	</td>
		    </tr>
		  </table>
	  </div>
  
		<div id="Operation_Table">	
	  	<div class="title">
			  <div id="title_zi">�û���Ϣ</div>
			</div>
			<table id=tb2 cellspacing="0">
				<tr> 
				  <td class="blue" nowrap>�������</td>
				  <td> 
				    <input name="phone_no"   maxlength="20" class="InputGrey" readonly value="<%=phoneNo%>">
				  </td>
				  <td class="blue" nowrap>ҵ��Ʒ��</td>
				  <td> 
				    <input name="smCode"  class="InputGrey" readonly value="<%=(String)arlist.get(26)%>">
				  </td>
				  <td class="blue" nowrap>��������</td>
				  <td> 
				    <input name=serviceType  class="InputGrey" readonly value="<%=(String)arlist.get(27)%>">
				  </td>
				  <td class="blue" nowrap>����ʱ��</td>
				  <td> 
				    <input name=openTime  class="InputGrey" readonly value="<%=(String)arlist.get(28)%>">
				  </td>
				</tr>
				<tr> 
				  <td class="blue">�û�����</td>
				  <td> 
				    <input name=attrCode   class="InputGrey" readonly value=userType>
				  </td>
				  <td class="blue">��ͻ���־</td>
				  <td> 
				    <input name=creditCode class="InputGrey" readonly value="<%=(String)arlist.get(30)%>">
				    </td>
				  <td class="blue">���ö�</td>
				  <td> 
				    <input name=creditValue class="InputGrey" readonly value="<%=(String)arlist.get(31)%>">
				  </td>
				  <td class="blue" nowrap>������״̬</td>
				  <td> 
				    <input name=runName1 class="InputGrey" readonly value="<%=(String)arlist.get(32)%>">
				  </td>
				</tr>
				<tr> 
				  <td class="blue">��ǰ״̬</td>
				  <td> 
				    <input name=runName2 class="InputGrey" readonly value="<%=(String)arlist.get(33)%>">
				  </td>
				  <td class="blue">״̬�޸�ʱ��</td>
				  <td> 
				    <input name=runTime class="InputGrey" readonly value="<%=(String)arlist.get(34)%>">
				  </td>
				  <td class="blue">����ʱ��</td>
				  <td> 
				    <input name=billDate class="InputGrey" readonly value="<%=(String)arlist.get(35)%>">
				  </td>
				  <td class="blue">��������</td>
				  <td> 
				    <input name=billUnit class="InputGrey" readonly value="<%=(String)arlist.get(36)%>">
				  </td>
				</tr>
				<tr> 
				  <td class="blue">�ײ�����</td>
				  <td> 
				    <input name=idAddress1 class="InputGrey" readonly value="<%=(String)arlist.get(37)%>">
				    </td>
				  <td class="blue">�����ײ�</td>
				  <td> 
				    <input name=idValiddate class="InputGrey" readonly value="<%=(String)arlist.get(38)%>">
				    </td>
				  <td class="blue">�ײ���ʼʱ��</td>
				  <td> 
				    <input name=contactPerson1 class="InputGrey" readonly value="<%=(String)arlist.get(39)%>">
				    </td>
				  <td class="blue">��Чʱ��</td>
				  <td> 
				    <input name=contactPhone1 class="InputGrey" readonly value="<%=(String)arlist.get(40)%>">
				    </td>
				</tr>
				<tr> 
				  <td class="blue" style="display:<%=simStyle%>">SIM����</td>
				  <td  style="display:<%=simStyle%>"> 
				    <input name=simNo class="InputGrey" readonly value="<%=(String)arlist.get(41)%>">
				    </td>
				  <td class="blue"  style="display:<%=simStyle%>">IMSI��</td>
				  <td  style="display:<%=simStyle%>"> 
				    <input name=imsiNo class="InputGrey" readonly value="<%=(String)arlist.get(42)%>">
				    </td>
				  <td class="blue">��ͣ��־</td>
				  <td> 
				    <input name="stop" class="InputGrey" readonly>&nbsp;
				  </td>
				  <td class="blue"  style="display:<%=broadStyle%>">��ͨ����˺�</td>
				  <td  style="display:<%=broadStyle%>">
				  	<input name="broadNo" class="InputGrey" readonly value="<%=(String)arlist.get(63)%>">
				  </td>
				  <td class="blue"  style="display:<%=broadStyle%>">���ŷ־�</td>
			    <td  style="display:<%=broadStyle%>">
			    	<input name="dianxinfj" class="InputGrey" readonly value="<%=(String)arlist.get(66)%>">
			    </td>
				</tr>
				<tr>
				  <th colspan="5" class="blue"><span style="padding-left:250px;">�ط���ϸ�б�</span></th>
				  <th colspan="3" class="blue"><span style="padding-left:90px;">�û�ҵ�������б�</span></th>
				</tr>
				<tr>
					<td colspan="5">
						<textarea name="textarea" rows=6 cols='' readonly style="width:98%"><%=(String)arlist.get(43)%><%=(String)arlist.get(44)%><%=(String)arlist.get(45)%></textarea>
					</td>
					<td colspan="3">
						<textarea name="textarea2" rows=6 cols='' readonly style="width:95%"><%=(String)arlist.get(60)%></textarea>
					</td>
				</tr>
			</table>
		</DIV>
	
	
	<!-- ��title -->
		<DIV id="Operation_Table">
			<div class="title">
				<div id="title_zi">�ʻ���Ϣ</div>		
			</div>
		  <table id=tb3 cellspacing="0">
		    <tr> 
		      <td class="blue">�ʻ���</td>
		      <td> 
		        <input name=contractNo class="InputGrey" readonly value="<%=(String)arlist.get(46)%>">
		        </td>
		      <td class="blue">�ʻ�����</td>
		      <td> 
		        <input name=bankCust class="InputGrey" readonly value="<%=(String)arlist.get(47)%>">
		      </td>
		      <td class="blue">�ʻ���ͷ</td>
		      <td> 
		        <input name=oddment class="InputGrey" readonly value="<%=(String)arlist.get(48)%>">
		      </td>
		      <td class="blue">Ԥ��ʱ��</td>
		      <td> 
		        <input name=prepayTime class="InputGrey" readonly value="<%=(String)arlist.get(50)%>">
		      </td>
		    </tr>
		    <tr>
		      <td class="blue">�ʺ�����</td>
		      <td> 
		        <input name=accountType class="InputGrey" readonly value="<%=(String)arlist.get(51)%>">
		      </td>
		      <td class="blue">Ƿ�ѱ�־</td>
		      <td> 
		        <input name=status class="InputGrey" readonly value="<%=(String)arlist.get(52)%>">
		      </td>
		      <td class="blue">״̬�ı�ʱ��</td>
		      <td> 
		        <input name=statusTime class="InputGrey" readonly value="<%=(String)arlist.get(53)%>">
		      </td>
		      <td class="blue">�ʼı�־</td>
		      <td> 
		        <input name=postFlag class="InputGrey" readonly value="<%=(String)arlist.get(54)%>">
		      </td>
		    </tr>
		    <tr> 
		      <td class="blue">Ѻ ��</td>
		      <td> 
		        <input name=deposit class="InputGrey" readonly value="<%=(String)arlist.get(55)%>">
		      </td>
		      <td class="blue">��СǷ������</td>
		      <td> 
		        <input name=minYM class="InputGrey" readonly value="<%=(String)arlist.get(56)%>">
		      </td>
		      <td class="blue">�ʻ�������</td>
		      <td> 
		        <input name=accountLimit class="InputGrey" readonly value="<%=(String)arlist.get(58)%>">
		      </td>
		      <td class="blue">���ʽ</td>
		      <td> 
		        <input name=payCode class="InputGrey" readonly value="<%=(String)arlist.get(59)%>">
		      </td>
		    </tr>
		    <tr>
		      <td class="blue">��ǰԤ��</td>
		      <td>
		    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=show_fee.trim()%>" >
		      </td>
			  <td class="blue">��ǰ�ɻ���Ԥ��</td>
		      <td>
		    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=prepayFee.trim()%>" >
		      </td>
			  <td class="blue">δ���ʻ���</td>
		      <td>
		    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=nobillpay.trim()%>" >
		      </td>
		      <td class="blue">��ǰ����Ԥ��</td>
		      <td>
		    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=now_prepayFee.trim()%>" >
		      </td>
		    </tr>
		    
		    <!-- liuxmc add 20100907 begin-->
		    <tr>
		      <td class="blue">��ǰ����ר�����</td>
		      <td>
		    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=zx_yc_fee.trim()%>" >
		      </td>
			  <td class="blue">��ǰ������ͨ���</td>
		      <td>
		    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="<%=pt_yc_fee.trim()%>" >
		      </td>
			  <td class="blue"></td>
		      <td>
		    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="" >
		      </td>
		      <td class="blue"></td>
		      <td>
		    	<input name=prepay_fee class="InputGrey" style="color:red" readonly value="" >
		      </td>
		    </tr>
		    <!--liuxmc add 20100907 end-->
		  </table>
	  </DIV>
	
		<DIV id="Operation_Table">
			<div class="title">
				<div id="title_zi">�ʻ���Ϣ</div>		
			</div>
		  <table id=tb4 cellspacing="0">
		    <tr> 
		      <td colspan="2"> 
		        <a href="f1600_wPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�ɷѼ�¼��ѯ</font></a> 
		       </td>
		      <td colspan="2"> 
		        <a href="f1600_publicValidate.jsp?broadPhone=<%=(String)arlist.get(63)%>&activePhone=<%=phoneNo%>&changType=1&opCode=e729&opName=����û���������&oprationType=change&idNo=<%=idNo%>"><font color="#3366CC">����û���������</font></a> 
		      </td>
		      <td colspan="2"> 
		        <a href="f1600_sBindPortCfm.jsp?iAccount=<%=(String)arlist.get(63)%>&iPhoneNo=<%=phoneNo%>&iOpCode=e729"><font color="#3366CC">�˿ڳ�ʼ��</font></a> 
		      </td>
		    </tr>
		    <tr> 
		      <td colspan="2"> 
		        <a href="f1600_sOnLineQry.jsp?iAccount=<%=(String)arlist.get(63)%>&iPhoneNo=<%=phoneNo%>&iOpCode=e729&opName=�����û���ѯ"><font color="#3366CC">�����û���ѯ</font></a> 
		      </td>
		      <td colspan="2"> 
		        <a href="f1600_sAccessLogQry_main.jsp?iAccount=<%=(String)arlist.get(63)%>&iPhoneNo=<%=phoneNo%>&opCode=e729&opName=��֤ʧ����Ϣ��ѯ"><font color="#3366CC">��֤ʧ����Ϣ��ѯ</font></a> 
		      </td>
		    </tr>
		  </table>
		</DIV>
  
	  <table>
	    <tr> 
    	  <td id="footer">
				<%
				if(!"2".equals(workNoAccountType)){
				%>
								<input class="b_foot" name=back onClick="location='f1600_1.jsp'" type=button value="  ��  ��  ">
				<%
				}
				%>
	        <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value="  ��  ��  ">
       </td>
	  	</tr>
	  </table>
  <%@ include file="/npage/include/footer.jsp" %>
  </form>
</BODY>

</HTML>
<!--***********************************************************************-->
