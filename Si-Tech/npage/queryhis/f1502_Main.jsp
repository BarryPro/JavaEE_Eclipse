<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-13 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "1502";
	String opName = "�ۺ���Ϣ��ʷ��ѯ";
	
	String inStr  = request.getParameter("parStr");//�õ��������
	int pos = inStr.indexOf("|");
	String phoneNo  = inStr.substring(0,pos);//�ֻ�����
	String idNo  = inStr.substring(12,inStr.length());//ID��
	

	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String powerName = (String)session.getAttribute("powerRight");
	String deptCode = (String)session.getAttribute("orgCode");;
	String ip_Addr = "172.16.23.13";
	String regionCode = deptCode.substring(0,2);

  String password = (String)session.getAttribute("password"); //diling add for ��ȫ�ӹ�
	
/**
	ArrayList arlist = new ArrayList();
	try
	{	//System.out.println("--------------5555555-------------");
		s1500View viewBean = new s1500View();//ʵ����viewBean
		arlist = viewBean.view_s1500Qry(phoneNo,idNo); 
		//System.out.println("--------------5555555-------------");
	}
	catch(Exception e)
	{
		//System.out.println("����EJB����ʧ�ܣ�");
	}
	**/
	
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

	<wtc:service name="s1500Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=idNo%>"/>
	
	</wtc:service>
	<wtc:array id="mainQryArr" scope="end"/>	
<%
 System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
 String retCodeForCntt = retCode1;
 String loginAccept =""; 
 String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo;
 System.out.println("url="+url);
 System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");    
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
%>

<%
	//System.out.println("###########################zhanghonga->feeRetCode->"+feeRetCode);
	
	//��Ϊ���񷵻ص�retCode���淶,������ֻ��һ��"0",���������Ƚ���
	/*if(Integer.parseInt(feeRetCode)==0){
		if(s1500FeeArr.length>0){
			fee_return_code = s1500FeeArr[0][0];
			fee_return_msg = s1500FeeArr[0][1];
			show_fee = s1500FeeArr[0][2]; //��ǰԤ��;
			prepayFee = s1500FeeArr[0][3];//��ǰ�ɻ���Ԥ��
			nobillpay = s1500FeeArr[0][4]; //δ���˻���
			now_prepayFee = s1500FeeArr[0][5];//��ǰ����Ԥ��
		}
	}*/
%>
<%--add by zhanghonga@20090107,�汾�ϲ�ʱ���ӵ��������ݵ��������--%>

<HTML>
	<HEAD>
	<TITLE>�ۺ���Ϣ��ѯ</TITLE>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	
	<!---add by zhanghonga@20081225(ʥ����),Ӧ�û�Ҫ��,�޸�&���"������Ϣ"����ʽ,û�ŵ�����css��,��Ϊֻ��1500�õ�����ʽ--->
	<style>
	/*ȫ�ֵ����˵�����*/
	#nav{
		list-style-type:none;
		padding:0px;
		margin-top: 2px;
		margin-right: 60px;
		margin-bottom: 0px;
		margin-left: 0px;
		float: right;
		line-height: 12px;
	 }
	 
	#nav dl {
		width: 68px;
		margin: 0;
		float: left;
		background-image: url(../../nresources/default/images/button_other.gif);
		background-repeat: no-repeat;
		height: 21px;
		padding-top: 4px;
		padding-right: 0;
		padding-bottom: 0;
		padding-left: 0px;
		color: #439337;
	}
	
	#nav dt {
		margin:0;
		padding-top: 0;
		padding-right: 0;
		padding-bottom: 0;
		padding-left: 0px;
		text-align: center;
	}

	#nav a{
		position:relative;
		text-decoration: none;
	}

	#nav a:hover{
		color: #FF9933;
		font-size: 12px;
		font-weight: normal;
		text-decoration: none;
	} 
 
	.showmenu_shadow{
		background:#e9e8e8;
		width:160px;
		position:absolute;
		z-index:500;
		display:none;
		text-align:left;
		right:0px;
	    filter: alpha(opacity=86);
	    -moz-opacity: .86;
	    margin-top:-8px;
	    font-size:12px;
		font-family:Tahoma,Arial, Helvetica, sans-serif;
	}
	.showmenu_shadow a,
	.showmenu_shadow a:link,
	.showmenu_shadow a:visited{
	 	display:block;
		padding:2px 0 0 5px;
		color:#289312;
		font-weight:bold;
		border-bottom:1px solid #addc61;
		height:22px;
		text-decoration:none;
	}	
	.showmenu_shadow a:hover{
		color:#cc0000;
		background:#FFFFFF;
		border-bottom:1px solid #999999;
	}
	.showmenu_shadow .showmenuBody{/*���ݲ�*/
		z-index:100;
		border:solid 1px #999;
		position:relative;
		background:#dff6b3;
		margin:0 2px 2px 0;
		padding-left:3px;
		padding-right:3px;
	}
	</style>
	<!---add by zhanghonga@20081225(ʥ����)�����ʽ����--->

	<!---add by zhanghonga@20081225(ʥ����):��δ���ʹ��jquery��д,����������ʽ,���ɲ˵�Ч��;--->
	<!---�����ʹ�ô˲˵�,ɾ����δ��뼴��,�����������ݹ����κβ���Ӱ��--->
	<script language="javascript">
		<!--
	    var showmua = false;
	    function showmenu(a, b) {
	        //ǿ��hide()
	        for (i = 1; i <= 4; i++) {
	            var el = $('#mc' + i);
	            hid(el)
	        }
	        showmua = true;
	        var e = $('#' + a);
	        if (e.css("display") == "none") {
	            e.fadeIn('normal')
	        }
	        ;
	        if (b) {//Ĭ�ϲ�����b����
	            var mc_left = document.getElementById(b).offsetLeft;
	            e.css("left", mc_left);
	        }
	    }
	    function hidemenu(a) {
	        showmua = false
	        setTimeout('hid("' + a + '")', 1)
	        //hid(a)
	    }
	    function hid(a) {
	        var e = $('#' + a)
	        if (e.css("display") == "block" && showmua == false) {
	            e.fadeOut('normal')
	        }
	        showmua = true;
	    }
	    //-->
	</script>
	<!---add by zhanghonga@20081225(ʥ����):Ϊ�˵���ʽ�����js�ű�����--->

	</HEAD>
<script language=javascript>
function init(){
	document.all.attrCode.value = userType;
	document.all.stop.value = stopDesc;
	if (<%=request.getParameter("passFlag")%> == "1") {
		document.all.form1.custName.value="";
		document.all.form1.custName.value="";
		document.all.form1.custAddress.value="";
		document.all.form1.idIccid.value="";
		document.all.form1.idAddress.value="";
		document.all.form1.contactPerson.value="";
		document.all.form1.contactPhone.value="";
		document.all.form1.contactAddress.value="";
		document.all.form1.contactPost.value="";
		document.all.form1.contactAddress1.value="";
		document.all.form1.contactMailaddress.value="";
		document.all.form1.contactFax.value="";
		rdShowMessageDialog("���벻��ȷ��ֻ����ʾ������Ϣ��");
	} 
}


function  actionchk()
{
   var smCode = document.form1.smCode.value;
   if(smCode=="���еش�" || smCode=="dn")
	{
		document.form1.action="f1500_dnMarkMsg.jsp?idNo=<%=idNo%>&custName=<%=(String)arlist.get(3)%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>";
		document.form1.submit();
	}else{
		document.form1.action="f1500_dMarkMsg.jsp?idNo=<%=idNo%>&custName=<%=(String)arlist.get(3)%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>";
		document.form1.submit();
	}
	
	}
</script>
<body onLoad="init()">
  <form name="form1" method="post" action="">
  	<%@ include file="/npage/include/header.jsp" %>
  	
  		<div class="title">
			<div id="title_zi">�ͻ���Ϣ</div>
	  		<div id="nav">
				<dl>
		  			<dt>
						<a href="#" id="mh1" onmouseover="showmenu('mc1','mh1')" onmouseout="hidemenu('mc1')">������Ϣ</a>
					</dt>
				</dl>
			</div>
		</div>
		<div class="showmenu_shadow" id="mc1" onmouseover="showmenu('mc1')" onmouseout="hidemenu('mc1')">
			<!--div class="showmenuBody">
			  <a href="f1502_custuser.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�ͻ�-�û���Ӧ��ϵ</font></a>
			  <a href="f1502_custcon.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�ͻ�-�ʻ���Ӧ��ϵ</font></a> 
			  <a href="f1502_custuserh.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�ͻ�-�û���Ӧ��ϵ��ʷ</font></a> 
			  <a href="f1502_custhis01.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�ͻ���ʷ��¼</font></a> 
			  <a href="f1502_dCustDocInAdd.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�ͻ�������Ϣ</font></a> 
			  <a href="fGetUserFavMsg.jsp?idNo=<%=idNo%>&openTime=<%=(String)arlist.get(28)%>&custName=<%=(String)arlist.get(3)%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">�Ż���Ϣ��ѯ</font></a>
			  <a href="f1502_CustManage.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>&custName=<%=(String)arlist.get(3)%>"> <font color="#3366CC"> �ͻ�������Ϣ</font></a> 
			  <a href="f1502_RoamInfo.jsp?idNo=<%=idNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">�߽�����Ͷ����Ϣ</font></a></dd> 
			  <a href="f1502_sPubCustBillDet1.jsp?idNo=<%=idNo%>"><font color="#3366CC">��ϸ�ʷ���Ϣ</font></a></dd> 
			  <a href="f1534_1.jsp?phoneNo=<%=phoneNo%>"><font color="#3366CC">�û������ʷ��Żݲ�ѯ</font></a></dd> 
			</div-->
				<div class="showmenuBody">
				  <a href="../queryhis/f1502_custhis01.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�ͻ���ʷ��¼</font></a> 
				</div>			
			<div class="showmenu_shadow" id="mca" onmouseover="showmenu('mca')" onmouseout="hidemenu('mca')">
				<div class="showmenuBody">
				  <a href="../queryhis/f1502_custhis01.jsp?custId=<%=(String)arlist.get(2)%>&custName=<%=(String)arlist.get(3)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�ͻ���ʷ��¼</font></a> 
				</div>
			</div> 				
		</div> 
  <table id=tb1 cellspacing="0">
    <tr> 
      <td class="blue">�ͻ���ʶ</td>
      <td> 
        <input name=custId  class="InputGrey" maxlength="20" readonly value="<%=(String)arlist.get(2)%>">
      </td>
      <td class="blue">�ͻ�����</td>
      <td> 
        <input name=custName class="InputGrey" readonly value="<%=(String)arlist.get(3)%>">
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
        <input name=ownerGrade class="InputGrey" readonly value="<%=(String)arlist.get(7)%>">
        </td>
      <td class="blue">�ͻ����</td>
      <td> 
        <input name=ownerType class="InputGrey" readonly value="<%=(String)arlist.get(8)%>">
        </td>
      <td class="blue">�ͻ���ַ</td>
      <td> 
        <input name=custAddress class="InputGrey" readonly value="<%=(String)arlist.get(9)%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">֤������</td>
      <td> 
        <input name=idType class="InputGrey" readonly value="<%=(String)arlist.get(10)%>">
        </td>
      <td class="blue">֤������</td>
      <td> 
        <input name=idIccid class="InputGrey" readonly value="<%=(String)arlist.get(11)%>">
      </td>
      <td class="blue">֤����ַ</td>
      <td> 
        <input name=idAddress class="InputGrey" readonly value="<%=(String)arlist.get(12)%>">
      </td>
      <td class="blue">֤����Ч��</td>
      <td> 
        <input name=idValiddate class="InputGrey" readonly value="<%=(String)arlist.get(13)%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">��ϵ��</td>
      <td> 
        <input name=contactPerson class="InputGrey" readonly value="<%=(String)arlist.get(14)%>">
        </td>
      <td class="blue">��ϵ�绰</td>
      <td> 
        <input name=contactPhone class="InputGrey" readonly value="<%=(String)arlist.get(15)%>">
        </td>
      <td class="blue">��ϵ��ַ</td>
      <td> 
        <input name=contactAddress class="InputGrey" readonly value="<%=(String)arlist.get(16)%>" >
      </td>
      <td class="blue">��������</td>
      <td class="blue"> 
        <input name=contactPost class="InputGrey" readonly value="<%=(String)arlist.get(17)%>">
      </td>
    </tr>
    <tr> 
      <td class="blue">ͨѶ��ַ</td>
      <td> 
        <input name=contactAddress1 class="InputGrey" readonly value="<%=(String)arlist.get(18)%>" >
        </td>
      <td class="blue">��ϵ�˴���</td>
      <td> 
        <input name=contactFax class="InputGrey" readonly value="<%=(String)arlist.get(19)%>" >
      </td>
      <td class="blue">��������</td>
      <td class="blue"> 
        <input name=contactMailaddress class="InputGrey" readonly value="<%=(String)arlist.get(20)%>">
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
			<div id="nav">
				<dl>
		  			<dt>
						<a href="#" id="mh2" onmouseover="showmenu('mc2','mh2')" onmouseout="hidemenu('mc2')">������Ϣ</a>
					</dt>
				</dl>
			</div>
		</div>
		<div class="showmenu_shadow" id="mc2" onmouseover="showmenu('mc2')" onmouseout="hidemenu('mc2')">
			<!--div class="showmenuBody">
			  <a href="f1502_uConQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&busy_type=1&count=<%=(String)arlist.get(46)%>"><font color="#3366CC">�û��ʵ�</font></a>
			  <a href="f1502_dBillCustDetail.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">��ϸ�Ż���Ϣ</font></a> 
			  <a href="f1502_wChgQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�����¼</font></a> 
			  <a href="f1502_dCustSimHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">������¼</font></a> 
			  <a href="f1502_dCustMsgHis01.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�û���ʷ</font></a> 
			  <a href="f1502_dAssuMsg.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">����������Ϣ</font></a> 
			  <a href="assuNote.jsp?id_no=<%=idNo%>"><font color="#3366CC">�û�ҵ��ע</font></a> 
			  <a href="f1502_dCustInnet.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">������Ϣ</font></a> 
			  <a href="f1502_wPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�û�������Ϣ</font></a> 
			  <a href="f1502_dCustFuncHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC"> �ط������ϸ</font></a> 
			  <a href='javascript:actionchk()'><font color="#3366CC">�û�����</font></a> 
			  <a href="f1550_dConUserMsg.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC">�û�-�ʻ���Ӧ��ϵ</font></a> 
			  <a href="f1502_sPubCustColorRing.jsp?phoneNo=<%=phoneNo%>"><font color="#3366CC">������Ϣ��ѯ</font></a> 
			</div-->
				<div class="showmenuBody">
				  <a href="../queryhis/f1502_wChgQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�����¼</font></a> 
				  <a href="../queryhis/f1502_dCustSimHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">������¼</font></a> 
				  <a href="../queryhis/f1502_dCustMsgHis01.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�û���ʷ</font></a> 
				  <a href="../queryhis/f1502_wPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�û�������Ϣ</font></a> 
				  <a href="../queryhis/f1502_dCustFuncHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC"> �ط������ϸ</font></a> 
				</div>
			<div class="showmenu_shadow" id="mcb" onmouseover="showmenu('mcb')" onmouseout="hidemenu('mcb')">
				<div class="showmenuBody">
				  <a href="../queryhis/f1502_wChgQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�����¼</font></a> 
				  <a href="../queryhis/f1502_dCustSimHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">������¼</font></a> 
				  <a href="../queryhis/f1502_dCustMsgHis01.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�û���ʷ</font></a> 
				  <a href="../queryhis/f1502_wPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�û�������Ϣ</font></a> 
				  <a href="../queryhis/f1502_dCustFuncHis.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&workNo=<%=workNo%>&workName=<%=workName%>"><font color="#3366CC"> �ط������ϸ</font></a> 
				</div>
			</div>			
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
    <td class="blue">SIM����</td>
    <td> 
      <input name=simNo class="InputGrey" readonly value="<%=(String)arlist.get(41)%>">
      </td>
    <td class="blue">IMSI��</td>
    <td> 
      <input name=imsiNo class="InputGrey" readonly value="<%=(String)arlist.get(42)%>">
      </td>
    <td class="blue">��ͣ��־</td>
    <td> 
      <input name="stop" class="InputGrey" readonly>&nbsp;
    </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
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
			<!--div id="title_zi">�ʻ���Ϣ</div>
			<div id="nav">
				<dl>
		  			<dt>
						<a href="#" id="mh3" onmouseover="showmenu('mc3','mh3')" onmouseout="hidemenu('mc3')">������Ϣ</a>
					</dt>
				</dl>
			</div-->
		</div>
		<div class="showmenu_shadow" id="mc3" onmouseover="showmenu('mc3')" onmouseout="hidemenu('mc3')">
			<div class="showmenuBody">
	  		  <a href="f1502_dConUserMsg.jsp?idNo=<%=idNo%>&contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">���Ѽƻ���Ϣ</font></a> 
			  <a href="f1502_cConQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&busy_type=2&count=<%=(String)arlist.get(46)%>"><font color="#3366CC">�ʻ��ʵ�</font></a> 
			  <a href="f1502_dConMsg.jsp?idNo=<%=idNo%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�����ʺ���Ϣ</font></a> 
			  <a href="f1502_wConPayQry.jsp?idNo=<%=idNo%>&phoneNo=<%=phoneNo%>&contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(45)%>&beginTime=0&endTime=0&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�ʻ�������Ϣ</font></a>
			  <a href="f1502_dConMsgHis01.jsp?contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�ʻ���ʷ��¼</font></a> 
			  <a href="f1502_dConMsgPre.jsp?contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">Ԥ�������Ϣ</font></a> 
			  <a href="f1502_dDepositQry.jsp?contractNo=<%=(String)arlist.get(46)%>&bankCust=<%=(String)arlist.get(47)%>&workNo=<%=workNo%>&workName=<%=workName%>&powerName=<%=powerName%>&deptCode=<%=deptCode%>"><font color="#3366CC">�ʻ�Ѻ����Ϣ</font></a> 
			</div>
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
      <td>&nbsp;<td>
      <td>&nbsp;<td>
      <td>&nbsp;<td>
      <td>&nbsp;<td>

							
    </tr>
  </table>
  
  <table>
    <tr> 
    	 <td id="footer">
					<input class="b_foot" name=back onClick="location='f1500_1.jsp'" type=button value="  ��  ��  ">
	        <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value="  ��  ��  ">
       </td>
    </tr>
  </table>
  
  <%@ include file="/npage/include/footer.jsp" %>
  </form>
</BODY>

</HTML>
<!--***********************************************************************-->
