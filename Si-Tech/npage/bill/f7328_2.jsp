<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ��ͥ����ƻ����
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");

  String loginNo = (String)session.getAttribute("workNo");
  String loginPwd = (String)session.getAttribute("password");
  String loginName = (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>
<%
  String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
/****************���ƶ�����õ����롢���������� ����Ϣ s1205Init***********************/
	String inputArry[] = new String[1];
	String Tmsql="select to_char(trunc(last_day(sysdate)+1),'yyyymmdd hh24:mi:ss') from dual";
	inputArry[0] = Tmsql;
%>
	<wtc:service name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inputArry[0]%>"/>
	</wtc:service>
	<wtc:array id="tempArr1"  scope="end"/>
<%
	String exeTime = tempArr1[0][0].substring(0,8);
  String[] paraAray1 = new String[7];

  String op_code = request.getParameter("op_code");
  String phoneNo = request.getParameter("parentPhoneNo"); /* �ҳ�����*/

  String home_no = request.getParameter("memberPhoneNo"); /* ��Ա����(����ʱ)*/
  String home_no1 = request.getParameter("srv_no1"); /* ��Ա����(�˳�ʱ)*/
  System.out.println("home_no1home_no1home_no1home_no1home_no1home_no1===="+home_no1);
  String openType = request.getParameter("openType");/* ��������*/
  String passwordFromSer="";
  String show_phone = "";
  String trOneView = "";
   /*****************
  	*add by zhanghonga@2009-02-06,
  	*����openType������opCode��opName,
  	*����ͳһ�Ӵ���opcode,opname��¼����
  	*������ǰ��ʾ�Ļ����벻��ʾ
  	****************/
	  switch(Integer.parseInt(openType)){
	  	case 0 :
	  					opCode = "7328";
	  					opName = "���ļƻ�������ͥ";
	  					break;
	  	case 1 :
	  					opCode = "7329";
	  					opName = "���ļƻ������ͥ";
	  					break;
	  	case 2 :
	  					opCode = "7330";
	  					opName = "���ļƻ��˳���ͥ";
	  					break;
	  	case 3 :
	  					opCode = "7331";
	  					opName = "���ļƻ�ȡ����ͥ";
	  					break;
	  	case 4 :
	  					opCode = "7329";
	  					opName = "���ļƻ������ͥ";
	  					break;  					
	  	default:
	  					opCode = "7328";
	  					opName = "���ļƻ�������ͥ";
	  					break;
	  }
	  System.out.println("########################################f7238 _2.jsp->opCode->"+opCode+"&opName->"+opName);
  /**************add end here******************/


  if(openType.equals("0")){
	op_code="7328";
	show_phone = phoneNo;
	trOneView = "display:none";//�пɼ�
  }else if(openType.equals("1")){
	op_code="7329";
	show_phone = home_no;
	trOneView = "display:none";//�пɼ�
	paraAray1[0] = home_no;		/* �ֻ�����   */
  }else if(openType.equals("2")){
	op_code="7330";
	if(home_no1.equals(""))
	{
		show_phone = home_no;
		paraAray1[0] = home_no;	/* �ֻ�����   */ 
	}
	else
	{	
		show_phone = home_no1;
		paraAray1[0] = home_no1;	/* �ֻ�����   */ 
	}
	trOneView = "display:none";//�в��ɼ�	
  }else if(openType.equals("4")){
	op_code="7329";
	show_phone = home_no;
	trOneView = "display:none";//�пɼ�
	paraAray1[0] = home_no;		/* �ֻ�����   */
  }else{
	op_code="7331";
	show_phone = phoneNo;
	trOneView = "display:none";//�в��ɼ�
  }

  paraAray1[1] = loginNo; 	    /* ��������   */
  paraAray1[2] = orgCode;	    /* ��������   */
  paraAray1[3] = op_code;		/* ��������   */
  paraAray1[4] = phoneNo;		/* �ҳ�����	*/
  paraAray1[5] = openType;		/* ��������	*/
  paraAray1[6] = loginPwd;		/* ��������	*/  

  System.out.println("show_phone === "+ show_phone);
  System.out.println("loginNo === "+ loginNo);
  System.out.println("orgCode === "+ orgCode);
  System.out.println("op_code === "+ op_code);
  System.out.println("phoneNo === "+ phoneNo);
  System.out.println("openType === "+ openType);

  for(int i=0; i<paraAray1.length; i++)
  {

	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }

  //retList = impl.callFXService("s7328Valid", paraAray1, "36");
%>
	<wtc:service name="s7328Valid" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="36">
	<wtc:param value="0"/>
	<wtc:param value="01"/>		
	<wtc:param value="<%=paraAray1[3]%>"/>
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[6]%>"/>		
	<wtc:param value="<%=paraAray1[0]%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=paraAray1[2]%>"/>		
	<wtc:param value="<%=paraAray1[4]%>"/>
	<wtc:param value="<%=paraAray1[5]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" start="0" length="26" scope="end"/>
	<wtc:array id="result1"  start="27" length="1" scope="end"/>
	<wtc:array id="result2"  start="28" length="1" scope="end"/>
	<wtc:array id="result3"  start="29" length="1" scope="end"/>
	<wtc:array id="result4"  start="30" length="1" scope="end"/>
	<wtc:array id="result5"  start="31" length="1" scope="end"/>
	<wtc:array id="result6"  start="32" length="1" scope="end"/>
	<wtc:array id="result7"  start="33" length="1" scope="end"/>
	<wtc:array id="result8"  start="34" length="1" scope="end"/>
	<wtc:array id="result9"  start="35" length="1" scope="end"/>
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",showflag="", password="",prod_name="";
  String errCode = retCode1;
  String errMsg = retMsg1;
  String familyNumber="";
  String[][] familyNo= new String[][]{};
  String[][] familyName= new String[][]{};
  String[][] familyProdCode= new String[][]{};
  String[][] familyProdName= new String[][]{};
  String[][] familyParentId= new String[][]{};
  String[][] MainProduct= new String[][]{};
  String[][] OtherProduct= new String[][]{};
  String[][] MainProductName= new String[][]{};
  String[][] OtherProductName= new String[][]{};
  	familyNo = result1; /*��ͥ����*/
	familyName = result2; /*��ͥ��ν*/
  	familyProdCode = result3;
	familyProdName = result4;
	familyParentId = result5;
	MainProduct = result6;
	OtherProduct = result7;
	MainProductName = result8;
	OtherProductName = result9;
 	System.out.println("0000000000000000  familyNo === "+ familyNo.length);
 	System.out.println("1111111111111111  familyProdCode === "+ familyProdCode.length);
 	System.out.println("2222222222222222  MainProduct === "+ MainProduct.length);
 	System.out.println("3333333333333333  familyProdCode === "+ MainProductName.length);
  System.out.println("errCode === "+ errCode);
  if(tempArr.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s7328Valid��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }else if(errCode.equals("000000") && tempArr.length>0)
  {

	    bp_name = tempArr[0][3];//��������

	    bp_add = tempArr[0][4];//�ͻ���ַ

	    passwordFromSer = tempArr[0][2];//����

	    sm_code = tempArr[0][11];//ҵ�����

	    sm_name = tempArr[0][12];//ҵ���������

	    hand_fee = tempArr[0][13];//������

	    favorcode = tempArr[0][14];//�Żݴ���

	    rate_code = tempArr[0][5];//�ʷѴ���

	    rate_name = tempArr[0][6];//�ʷ�����

	    next_rate_code = tempArr[0][7];//�����ʷѴ���

	    next_rate_name = tempArr[0][8];//�����ʷ�����

	    bigCust_flag = tempArr[0][9];//��ͻ���־

	    bigCust_name = tempArr[0][10];//��ͻ�����

	    lack_fee = tempArr[0][15];//��Ƿ��

	    prepay_fee = tempArr[0][16];//��Ԥ��

	    cardId_type = tempArr[0][17];//֤������

	    cardId_no = tempArr[0][18];//֤������

	    cust_id = tempArr[0][19];//�ͻ�id

	    cust_belong_code = tempArr[0][20];//�ͻ�����id

	    group_type_code = tempArr[0][21];//���ſͻ�����

	    group_type_name = tempArr[0][22];//���ſͻ���������

		 family_code = tempArr[0][23]; //�û���ͥ����

	    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ

	    showflag = tempArr[0][25];//��ʾ��Ϣ
	 	if(result1.length!=0)
	 	{
	 		familyNumber = familyNo[0][0];
		}
	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s7328Valid��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}

if(openType.equals("1"))
{
	String passTrans_2=WtcUtil.repNull(request.getParameter("password"));
		String passFromPage_2=Encrypt.encrypt(passTrans_2);
		 if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage_2))
		 {
			 if(!retFlag.equals("1"))
			 {
				retFlag = "1";
				retMsg = "�������!";
		}
	}
}

	String[] paramIn = new String[2];
	paramIn[0] = "select a.mode_code,a.mode_code||'--'||a.mode_name from sbillmodecode a,sFamModeCode b  where a.region_code=b.region_code and a.mode_code=b.mode_code and b.region_code=:regionCode";
	paramIn[1] = "regionCode="+regionCode;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:param value="<%=paramIn[0]%>"/>
	<wtc:param value="<%=paramIn[1]%>"/>
	</wtc:service>
	<wtc:array id="rateCodeStr"  scope="end"/>
<%

	System.out.println("retCode2==="+retCode2);
	System.out.println("rateCodeStr"+rateCodeStr.length);

 String op_note="";
  if(openType.equals("0")){
	op_note="������ͥ";
  }else if(openType.equals("1")){
	op_note="�����ͥ";
  }else if(openType.equals("2")){
	op_note="�˳���ͥ";
  }else if(openType.equals("3")){
	op_note="ȡ����ͥ";
  }else{
	op_note="����ģʽ��Ա����";
  }
    /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>��ͥ����ƻ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>",0);
    history.go(-1);
  <%}%>

<!--
  //����Ӧ��ȫ�ֵı���
  onload=function()
  {
  }


  function frmCfm()
  {
 	frm.submit();
	return true;
  }
  //У��
  function check()
  {
 		with(document.frm)
		{
		var now_rate_code = "<%=rate_code%>";
		var next_rate_code = "<%=next_rate_code%>";
		return true;
    }
  }

  function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }

 function printCommitOne(subButton){
 	getAfterPrompt();
	//controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	subButton.disabled = true;
	//alert(document.all.show_phone.value);
	//document.frm.new_rate_code.value=document.frm.add_mode.value.substring(0,8);
	setOpNote();//Ϊ��ע��ֵ
 	document.frm.action = "f7328Cfm.jsp";
	var openType =document.all.open_type.value;
 	var ret1 = document.all.show_flag.value;
 	if((typeof(ret1)!="undefined")&&openType=="2")
 	{
		if((ret1=="Y"))
		{
			if(rdShowConfirmDialog('�ó�Ա�˳��󣬼�ͥ��Ա��С��3�ˣ���ͥ����ɢ���Ƿ������')==1)
			{
			//��ӡ�������ύ��
		    	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		    	if(typeof(ret)!="undefined")
		    	{
		      		if((ret=="confirm"))
		      	{
			        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
			        {
				      frmCfm();
			        }
				}
			  if(ret=="continueSub")
			  {
		        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		        {
			      frmCfm();
		        }
			  }
		    }
		    else
		    {
		       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		       {
			     frmCfm();
		       }
		    }
			}
			else
			{
				document.all.confirm.disabled=false;
			}
		}
		else
		{
			//��ӡ�������ύ��
		    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		    if(typeof(ret)!="undefined")
		    {
		    	if((ret=="confirm"))
				{
			        if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
			        {
				      frmCfm();
			        }
				}
				if(ret=="continueSub")
				{
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
					{
						frmCfm();
					}
				}
		    }
		    else
		    {
		       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		       {
			     frmCfm();
		       }
		    }
		}
  	}
  	else
  	{
  		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
		if(typeof(ret)!="undefined")
		{

			if((ret=="confirm"))
		  	{
				if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
			    {
					frmCfm();
			    }
			}
			if(ret=="continueSub")
			{
		    	if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		        {
			      frmCfm();
		        }
			}
		}
		else
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		    {
				frmCfm();
		    }
		}
  	}
  return true;
}

 function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի���
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept=<%=printAccept%>;                            // ��ˮ��
		var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
		var mode_code=null;                                        //�ʷѴ���
		var fav_code=null;                                         //�ط�����
		var area_code=null;                                        //С������
		var opCode="<%=op_code%>";                                  //��������
		var phoneNo=document.frm.show_phone.value;                 //�ͻ��绰

		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
  }

  function printInfo(printType)
  {
		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//�õ�ִ��ʱ��
		var count=0;
		var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		var retInfo = "";  //��ӡ����

		cust_info+="�ֻ����룺"+"<%=show_phone%>"+"|";
		cust_info+="�ͻ�������"+"<%=bp_name%>"+"|";


		opr_info+="�û�Ʒ�ƣ�"+document.all.sm_name.value+"   "+"����ҵ�񣺳��ļ�֮ͥ--<%=op_note%>"+"|";

		opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
		if("<%=openType%>"== "2")
		{
			opr_info+="�ҳ����룺"+"<%=familyNumber%>"+"   "+"���ΰ�����룺"+"<%=show_phone%>"+"|";
	
		}
		else
		{
			opr_info+="�ҳ����룺"+"<%=phoneNo%>"+"   "+"���ΰ�����룺"+document.frm.show_phone.value+"|";

		}
		if("<%=openType%>"== "1"||"<%=openType%>"== "2"||"<%=openType%>"== "3" || "<%=openType%>"== "4")
		{
			<%
			if(familyNo.length >= 1)
			{%>
				opr_info+="��ֹĿǰ��ͥ���г�Ա��"+"|";
			<%
				for(int j=0;j<familyNo.length;j++)
				{%>
					opr_info+="<%=familyName[j][0]%>��<%=familyNo[j][0]%>";
					count ++;
					if(count > 3)
					opr_info+=""+"|";
				<%}%>
			<%}
			else
			{%>
				opr_info+="��ֹĿǰ��ͥ���г�Ա��"+"0";
			<%}%>
		}
		else
		{
			 opr_info+=""+"|";
			 opr_info+="��ֹĿǰ��ͥ���г�Ա��"+"0" +"|";
		}
		if("<%=openType%>"== "1"||"<%=openType%>"== "2"||"<%=openType%>"== "3" || "<%=openType%>"== "4")
		{
			<%
			if(familyProdCode.length >= 1 )
			{%>
				opr_info+=""+"|";
				opr_info+="��ֹĿǰ��ͥ���в�Ʒ��"+"|";
			<%
				for(int i=0;i<familyProdCode.length;i++)
				{
					if(familyParentId[i][0].equals("0"))
					{
						prod_name="��ͥ������";
					}
					else
					{
						prod_name="��ͥ�Żݰ�";
					}
			%>
					opr_info+="  <%=MainProduct[i][0]%>   <%=MainProductName[i][0]%>  ";
					opr_info+="  <%=OtherProduct[i][0]%>   <%=OtherProductName[i][0]%>  (<%=prod_name%>)"+"|";
			 <%}%>
		<%}
			else
			{%>
				opr_info+=""+"|";
				opr_info+="��ֹĿǰ��ͥ���в�Ʒ��"+"0"+"|";
	  	<%}%>
	  }
	  else
	  {

	  	opr_info+="��ֹĿǰ��ͥ���в�Ʒ��"+"0"+"|";
	  }
		if("<%=openType%>"== "0"||"<%=openType%>"== "1"||"<%=openType%>"== "2")
		{
			opr_info+="ҵ����Чʱ�䣺 "+"����"+"|";
		}
		else if("<%=openType%>"== "3")
		{
			opr_info+="ҵ����Чʱ�䣺 "+"����"+"|";
		}
		else 
		{
			opr_info+="���ļ�ͥҵ������ɹ������Ѿ�����<%=show_phone%>����ü�ͥ���������Ա��24Сʱ�ڻظ�ȷ�϶��Ų��ܳɹ�����ü�ͥ�������ظ������ʧ�ܡ���������֪ͨ������ļ�ͥ��Ա����֪��ҵ���Ż����ݡ�"+"|";
		}		
		note_info1+="��ע��"+document.all.opNote.value+"|";

		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
  }
  //�ύ����
  function printCommit(subButton){
  	getAfterPrompt();
	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	//У��
	setOpNote();//Ϊ��ע��ֵ
    //�ύ��
    frmCfm();
	return true;
  }


function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path);
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
	return true;
}
/******Ϊ��ע��ֵ********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "��ͥ����ƻ����֮--<%=op_note%> ����:"+document.frm.show_phone.value; 
	}
	return true;
}
//-->
//������ʾ

</script>

</head>


<body>
<form name="frm" method="post">
	<%@ include file="/npage/include/header.jsp" %>

		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
		  <tr>
		    <td class="blue">��������</td>
            <td colspan="3">
			  <input name="op_type" type="text" class="InputGrey" id="op_type" value="<%=op_note%>" readonly>
			</td>
          </tr>
		  <tr>
		    <td class="blue">�ֻ�����</td>
            <td>
			  <input name="show_phone" type="text" class="InputGrey" id="show_phone" value="<%=show_phone%>" readonly>
			</td>
		    <td class="blue">��������</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>
			</td>
          </tr>
          <tr>
		    <td class="blue">ҵ��Ʒ��</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_name%>" readonly>
			</td>
            <td class="blue">��ͻ���־</td>
            <td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
			</td>
          </tr>
		  <tr>
		    <td class="blue">֤������</td>
            <td>
			  <input name="cardId_type" type="text" class="InputGrey" id="cardId_type" value="<%=cardId_type%>" readonly>
			</td>
            <td class="blue">֤������</td>
            <td>
			<input name="cardId_no" type="text" class="InputGrey" id="cardId_no" value="<%=cardId_no%>" readonly>
			</td>
          </tr>
          <tr>
            <td class="blue">��ǰ���ײ�</td>
            <td>
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">�������ײ�</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>
          </tr>
		  <tr>
			<td class="blue">��ͥ����</td>
            <td colspan="<%=(trOneView=="display:none"?"3":"1")%>">
			  <input type="text" name="family_code" id="family_code"  v_must=1 value = "<%=family_code%>" readonly class="InputGrey">
			   <font color="orange"></font>
			</td>
			<TD class="blue" style=<%=trOneView%>> ��ͥ�ײʹ���</TD>
			<TD style="<%=trOneView%>" id="ipTd">
			  <select  name="add_mode" id="add_mode" onChange="controlFlagCodeTdView();">
				<option value="">--��ѡ��--</option>
				<%for(int i = 0 ; i < rateCodeStr.length ; i ++){%>
				<option value="<%=rateCodeStr[i][0]%>"><%=rateCodeStr[i][1]%></option>
				<%}%>
			  </select>
			  <font color="orange">*</font>
			</TD>
          </tr>

          <tr>
            <td class="blue">��ע</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" value="" onFocus="setOpNote();" readonly size="60" class="InputGrey">
            </td>
          </tr>
		  <tr>
            <td colspan="4" id="footer"> <div align="center">
                &nbsp;
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="ȷ��&��ӡ" onClick="printCommitOne(this)" >
                &nbsp;
                <input name="reset" type="hidden" class="b_foot" value="���" >
                &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
                &nbsp;
				</div>
			</td>
          </tr>
      </table>

  <input type="hidden" name="favorcode">
  <input type="hidden" name="bp_addr" id="bp_addr" value="<%=bp_add%>"> <!--�ͻ���ַ-->
  <input type="hidden" name="next_main_stream">
  <input type="hidden" name="open_type" value="<%=openType%>">
  <input type="hidden" name="home_no" value="<%=home_no%>">
  <input type="hidden" name="home_no1" value="<%=home_no1%>">
  <input type="hidden" name="new_rate_code" value=""><!--��������ѡ�ʷѴ���-->
  <input type="hidden" name="printAccept" value="<%=printAccept%>"><!--��ӡ��ˮ-->
  <input type="hidden" name="show_flag" value="<%=showflag%>"><!--��ӡ�������-->
  <input type="hidden" name="op_code" value="<%=op_code%>"><!--��������-->
  <input type="hidden" name="phoneNo" value="<%=phoneNo%>"><!--��ӡ�������-->
   <input type="hidden" name="return_page" value="/npage/bill/f7328_login.jsp?activePhone=<%=phoneNo%>&opName=<%=opName%>&opCode=<%=opCode%>">
    <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
