<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ȫ��ͨ��������1121
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String opCode="1121";
	String opName="ȫ��ͨ��������";
	String phoneNo = (String)request.getParameter("my_phone");
%>

<%
	Logger logger = Logger.getLogger("f1121_2.jsp");

    String workNo =(String)session.getAttribute("workNo");    		         //����
	String workName =(String)session.getAttribute("workName");               //��������
	String info =  (String)session.getAttribute("ipAddr");                   //��½IP
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");	
	String regionCode = (String)session.getAttribute("regCode");
	
	String orgCode =(String)session.getAttribute("orgCode");
	String stream = getMaxAccept();												//������ˮ
%>

<%
	String s1 = ReqUtil.get(request,"s1");                            //����������ֵ
	String geti1 = ReqUtil.get(request,"i1");                         //��ò�ѯ������ֵ���ֻ�
	String is = ReqUtil.get(request,"ii");                            //��ò�ѯ������ֵ����ˮ
	if(s1.equals("�ֻ�����")&&!is.equals(""))                //������ֻ��飬������ˮ��Ϊ�ս���ˮ��Ϊ��
	{
		is = "";
	}
	if(s1.equals("������ˮ")&&!geti1.equals(""))            //�������ˮ�飬�����ֻ����벻Ϊ�գ����ֻ���Ϊ��
	{
		geti1 = "";
	}
	String and = geti1 +is;
%>

<%
	String loginNote="";
	String sqlStr9 = "select back_char1 from snotecode where region_code='"+regionCode+"' and op_code='XXXX'";
	
%>

	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
   		<wtc:sql><%=sqlStr9%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="result9" scope="end" />
    	
<%
	System.out.println("@@@@@@@@@result9="+result9);
	
	for(int i=0;i<result9.length;i++){
		 loginNote = (result9[i][0]).trim();
		}
	loginNote = loginNote.replaceAll("\"","");
	loginNote = loginNote.replaceAll("\'","");
	loginNote = loginNote.replaceAll("\r\n","   ");  
	loginNote = loginNote.replaceAll("\r","   "); 
	loginNote = loginNote.replaceAll("\n","   "); 
%>

<html>
<head>
<title>������BOSS-������ȫ��ͨ��������</title>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<%
/*----------------------------��֯����s1121Init����Ĳ���---------------------------------*/
	String flag ="";                                                   //�����־λ 1:��ˮ 2:�ֻ���
	if(s1.equals("������ˮ")){
		flag = "1";
	}
	else{
		flag = "2";		//�ֻ���
	}					//�Բ����������ж�
	String glide=is;                                                   //������ˮ�������������ֻ�����Ϊ��
	String phone=geti1;                                                //�����ֻ��ţ����������ˮ��Ϊ��
	String op_code="1121";                                             //ҳ�����
	String org_code=orgCode;                                        //org_code
	String ret_code = "";
	String ret_msg = "";
	String openrandom ="";
	String i3="";
	String i4="";
	String i5="";
	String i6="";
	String i7="";
	String i8="";
	String i9="";
	String i10="";
	String i11="";
	String i12="";
	String i13="";
	String i14="";
	String i15="";
	String i16="";
	String i17="";
	String i18="";
%>

	<wtc:service name="s1121Init" routerKey="region" routerValue="<%=regionCode%>" outnum="19" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=flag%>"/>
		<wtc:param value="<%=glide%>"/>
		<wtc:param value="<%=phone%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=orgCode%>"/>
	    <wtc:param value="<%=workNo%>"/>
	</wtc:service>
	<wtc:array id="s1121InitArr" scope="end"/>
		
<%
	String errCode = retCode ;
	ret_msg = retMsg ;
	if(s1121InitArr.length<1)
	{
		ret_msg = "��ѯ���������ϢΪ��";
	}
	else
	{
		if(!errCode.equals("000000"))
		{
			if(i9.trim().compareTo("")==0)
			{
				i9="0.00";
			}
			if(i10.trim().compareTo("")==0)
			{
				i10="0.00";
			}
			if(i11.trim().compareTo("")==0)
			{
				i11="0.00";
			}
			if(i12.trim().compareTo("")==0)
			{
				i12="0.00";
			}
			if(i13.trim().compareTo("")==0)
			{
				i13="0.00";
			}
			if(i14.trim().compareTo("")==0)
			{
				i14="0.00";
			}
			if(i15.trim().compareTo("")==0)
			{
				i15="0.00";
			}
			if(i16.trim().compareTo("")==0)
			{
				i16="0.00";
			}
%>
<script language="JavaScript">
	rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=ret_msg%>",0);
	history.go(-1);
</script>
<%	  }else{
				openrandom = s1121InitArr[0][2];	//������ˮ 
				i3 = s1121InitArr[0][3];			//�ͻ�ID 
				i4 = s1121InitArr[0][4];			//֤������ 
				i5 = s1121InitArr[0][5];			//�ͻ�ID 
				i6 = s1121InitArr[0][6];			//�ͻ�ID 
				i7 = s1121InitArr[0][7];			//�ͻ�ID 
				i8 = s1121InitArr[0][8];			//�ͻ�ID 
				i9 = s1121InitArr[0][9];			//�ͻ�ID 
				i10 = s1121InitArr[0][10];			//�ͻ�ID 
				i11 = s1121InitArr[0][11];			//�ͻ�ID 
				i12 = s1121InitArr[0][12];          //�ͻ�ID 
				i13 = s1121InitArr[0][13];			//�ͻ�ID 
				i14 = s1121InitArr[0][14];			//�ͻ�ID 
				i15 = s1121InitArr[0][15];			//�ͻ�ID 
				i16 = s1121InitArr[0][16];			//�ͻ�ID 
				i17 = s1121InitArr[0][17];			//�ͻ�ID 
				i18 = s1121InitArr[0][18];			//�ͻ�ID 
			}
			if(i9.trim().compareTo("")==0)
			{
				i9="0.00";
			}
			if(i10.trim().compareTo("")==0)
			{
				i10="0.00";
			}
			
			if(i11.trim().compareTo("")==0)
			{
				i11="0.00";
			}
			
			if(i12.trim().compareTo("")==0)
			{
				i12="0.00";
			}
			
			if(i13.trim().compareTo("")==0)
			{
				i13="0.00";
			}
			
			if(i14.trim().compareTo("")==0)
			{
				i14="0.00";
			}
			
			if(i15.trim().compareTo("")==0 ||i15==null )
			{
				i15="0.00";
				System.out.println("eeeeeeeeeeeeeeei15="+i15);
			}
			
			if(i16.trim().compareTo("")==0)
			{
				i16="0.00";
			}
		
		}
	ret_code="000000";
	
%>

</head>
<%
	if(!ret_code.equals("000000"))
	{
%>
<script language="javascript">
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��",0);
	document.location.replace("<%=request.getContextPath()%>/npage/innet/f1121_1.jsp?activePhone=<%=phoneNo%>");
</script>
	  
  <%}%>

<script language="javascript">

function printInfo(printType)
{
     var cust_info=""; //�ͻ���Ϣ
	 var opr_info=""; //������Ϣ
	 var note_info1=""; //��ע1
	 var note_info2=""; //��ע2
	 var note_info3=""; //��ע3
	 var note_info4=""; //��ע4
     var retInfo = "";  //��ӡ����

    if(printType == "Detail")
    {	
    	//��ӡ�������
		cust_info+= "�ֻ����룺     "+"<%=i8%>"+"|";
		cust_info+= "�ͻ�������     "+"<%=i6%>"+"|";
		cust_info+= "֤�����룺     "+"<%=i5%>"+"|";
		cust_info+= "�ͻ���ַ��     "+"<%=i7%>"+"|";
		opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		opr_info+= "ҵ�����ͣ�"+"��������"+"    ������ˮ��"+"<%=stream%>"+"|";
		opr_info+= "SIM���ѣ�      "+"<%=WtcUtil.formatNumber(i13,2)%>"+"|";
		if(document.all.i13.value=="0.00")
		{	
			opr_info+= "���ѷ�ʽ��     "+"֧Ʊ"+"|";
		}
		else{
			opr_info+= "���ѷ�ʽ��     "+"�ֽ�"+"|";
		}
		opr_info+= "Ԥ��       "+"<%=WtcUtil.formatNumber(i11,2)%>"+"|";
		note_info1+=document.all.note1.value+"|";
		note_info2+=" "+"|";
		note_info2+="��ע:"+document.all.i222.value+"|";
	
	}  
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 

	return retInfo;	
}

function printCommit()
{
	getAfterPrompt();
	var userid = "�ͻ�ID["+document.all.i2.value+"]";
    var openrandom = "������ˮ["+ <%=stream%> +"]";
    var sysnote = userid + "<%=stream%>";	
	var note1 = document.all.i7.value + "��������,"+"�ַ�Ӧ�ˣ�"+document.all.i15.value; 
	document.all.note1.value = note1;
	window.document.all.sysnote.value = sysnote;
	if((document.all.i222.value).trim().length==0)
	{
         document.all.i222.value="����Ա[<%=workName%>]"+"�Կͻ�["+(document.all.i5.value).trim()+"]����ȫ��ͨ��ͨ��������ҵ��"
	}
	showPrtdlg1("Detail","ȷʵҪ��ӡ���������","No");
	if(rdShowConfirmDialog("ȷ��Ҫ�ύȫ��ͨ����������Ϣ��")==1)
	{    
		document.all.printcount.value="1";
		conf();
    }
	else
	{   
		document.all.printcount.value="0"; 
		canc();
	}

}

 function showPrtdlg1(printType,DlgMessage,submitCfm)
 {
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="print";             				// ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 	//  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept ="<%=stream%>";               // ��ˮ��
	var printStr = printInfo(printType);			//����printinfo()���صĴ�ӡ����
	var mode_code=null;               				//�ʷѴ���
	var fav_code=null;                				//�ط�����
	var area_code=null;             				//С������
	var opCode="1121" ;                   			//��������
	var phoneNo="<%=phoneNo%>";                  	//�ͻ��绰

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+document.form1.i1.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	 
 }
/*-------------------------��ӡ�����ύ������-------------------*/
 function conf()
 {
   form1.action="f1121_3.jsp";
   form1.submit();
 }

 function canc()
 {
   /*
   form1.action="f1121_1.jsp";
   form1.submit();
   */
 }
/*-------------------------ҳ���ύ��ת����----------------------------*/

function pageSubmit(){
	document.form1.action="<%=request.getContextPath()%>/npage/innet/f1121_1.jsp?activePhone=<%=phoneNo%>";  
    form1.submit();
	  }
/*-------------------------ҳ���ύ��ת����----------------------------*/
</script>

		
<body>
<form action="" method=post name="form1"> 
		<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�ͻ�����</div>
</div>
<table cellspacing="0">
	<tr> 
		<td class="blue">
			��ѯ����
		</td>
		<td>
			<input type="text" value="<%=s1%>" size="20" class="InputGrey" readOnly>
		</td>
		<td colspan="2">
			<input name="i1" size="11" maxlength=11 value="<%=and%>" class="InputGrey" readOnly> 
			<input class="b_text" name=verify  type=button value="��ѯ" onclick = "if(check(form1)) pageSubmit(); " disabled >
		</td>
	</tr>
	
	<tr> 
		<td width="16%" class="blue">�ͻ�ID </td>
		<td width="34%">
			<input name="i2" size="20" maxlength=30  value="<%=i3%>" class="InputGrey" readOnly>
		</td>
		<td width="16%" class="blue">�ͻ�֤������ </td>
		<td width="34%">
		<%
			String subi4 = "";
			if(!i4.equals("")){
			subi4 = i4.substring(4);
			}
		%>
			<input name="i3" type="inpwd" size="20" maxlength=30  value="<%=subi4%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td width="16%" class="blue">�ͻ�֤������ </td>
		<td width="34%">
			<input name="i4" size="20" maxlength=30 value="<%=i5%>"  class="InputGrey" readOnly>
		</td>
		<td width="16%" class="blue">�ͻ����� </td>
		<td width="34%">
			<input name="i5" size="20" maxlength=30 value="<%=i6%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td width="16%" class="blue">�ͻ�סַ </td>
		<td width="34%">
			<input type="text" name="i6" size="30" maxlength=20 value="<%=i7%>" class="InputGrey" readOnly>
		</td>
		<td width="16%" class="blue">�ֻ����� </td>
		<td width="34%">
			<input type="text" name="i7" size="20"maxlength=20 value="<%=i8%>" class="InputGrey" readOnly>
		</td>
	</tr>
</table>
	</div>
	
	<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">��ط��� </div>
</div>

	<table cellspacing="0">	
	<tr> 
		<td width="16%" class="blue">������ </td>
		<td width="34%">
			<input name="i8" size="20" maxlength=2 value="<%=WtcUtil.formatNumber(i9,2)%>"  class="InputGrey" readOnly>
		</td>
		<td width="16%" class="blue">ѡ�ŷ� </td>
		<td width="34%">
			<input name="i9" size="20"maxlength=20 value="<%=WtcUtil.formatNumber(i10,2)%>"  class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td width="16%" class="blue">Ԥ��� </td>
		<td width="34%">
			<input name="i10" size="20" maxlength=2  value="<%=WtcUtil.formatNumber(i11,2)%>" class="InputGrey" readOnly>
		</td>
		<td width="16%" class="blue">������ </td>
		<td width="34%">
			<input name="i11" size="20" maxlength=20 value="<%=WtcUtil.formatNumber(i12,2)%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td width="16%" class="blue">SIM���� </td>
		<td width="34%">
			<input name="i12" size="20"maxlength=20 value="<%=WtcUtil.formatNumber(i13,2)%>" class="InputGrey" readOnly>
		</td>
		<td width="16%" class="blue">�ֽ𽻿� </td>
		<td width="34%">
			<input type="text" name="i13" size="20" maxlength=20 value="<%=WtcUtil.formatNumber(i14,2)%>" class="InputGrey" readOnly>
		</td>  
	</tr>
	<tr> 
		<td width="16%" class="blue">֧Ʊ���� </td>
		<td width="34%" >
			<input name="i14" size="20" maxlength=20 value="<%=WtcUtil.formatNumber(i15,2)%>" class="InputGrey" readOnly>
		</td>
		<%
			double theback=0.00;
			if(!i14.equals("")&&!i15.equals("")){
				double thei14 = Double.parseDouble(i14);
				double thei15 = Double.parseDouble(i15);
				theback = thei14+thei15;			
			}
		%>
		<td width="16%" class="blue">�˿��ܶ� </td>
		<td width="34%" >
			<input name="i15" size="20" maxlength=20 value="<%=WtcUtil.formatNumber(theback,2)%>" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr> 
		<td width=16% class="blue">��ע </td>
		<td colspan="3"><input name=sysnote size=75 maxlength="60" class="InputGrey" readOnly></td>
	      <TR style="display:none"> 
				  <TD>������ע��</TD>
				  <TD><input name=i222 class="button" size=75 maxlength="60" ></TD>
          </TR>
	</tr>
	
	<tr>
		<td colspan="4" align="center">
			<input class="b_foot" name="doSure"  onclick="if(check(form1)) printCommit();" type=button value=ȷ��>
			<input class="b_foot" name=reset onClick="pageSubmit()" type=reset value=���>
			<input class="b_foot" name=kkkk  onClick="history.go(-1)" type=button value=����>
		</td>
	</tr>
<!------------���������ֶΣ�������ˮ�������ͻ�ID���û�ID------------------------��˳��-------->
			<input type="hidden" name="userid" value="<%=i17%>">
			<input type="hidden" name="accountid" value="<%=i18%>">
            <input type="hidden" name="openrandom" value="<%=openrandom%>">
			<input type="hidden" name="mob_phone" value="<%=i8%>">
			<input type="hidden" name="note1" >
			<input type="hidden" name="innetFee" value="<%=i16%>">
			<input type="hidden" name="stream" value="<%=stream%>">
      		<input type="hidden" name="opr_info">
      		<input type="hidden" name="note_info1">
      		<input type="hidden" name="note_info2">
      		<input type="hidden" name="note_info3">
      		<input type="hidden" name="note_info4">
      		<input type="hidden" name="printcount">
      		<input type="hidden" name="activePhone" value="<%=phoneNo%>">
<!--------------------------------------------------------------------------------------->

</table>
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
