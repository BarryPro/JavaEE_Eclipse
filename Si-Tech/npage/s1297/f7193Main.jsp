 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-08 ҳ�����,�޸���ʽ
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gbK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
	String opCode = "7193";	
	String opName = "12580�ƶ�����̨����";		//header.jsp��Ҫ�Ĳ���   
		
	String orgCode=(String)session.getAttribute("orgCode"); 
  	String loginNo = (String)session.getAttribute("workNo");    //���� 
%>
<%
 	 String retFlag="",retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
	/************************���ƶ�����õ����롢���������Ȼ�����Ϣ s1297_Valid*******************************************/
  	
  	String[] paraAray1 = new String[4];
  	String phoneNo = request.getParameter("srv_no");
  	String passwordFromSer="";

	  paraAray1[0] = loginNo; 	/* ��������   */
	  paraAray1[1] = phoneNo;		/* �ֻ�����   */
	  paraAray1[2] = "7193";		/* ��������   */
	  paraAray1[3] = orgCode;	/* ��������   */
	  for(int i=0; i<paraAray1.length; i++)
	  {
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		}
	  }

 	// String[] ret = impl.callService("s1297_Valid",paraAray1,"23","phone",phoneNo);
 	%>
 	<wtc:service name="s1297_Valid" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="24" >
			<wtc:param value=""/>
			<wtc:param value="01"/>		
			<wtc:param value="<%=paraAray1[2]%>"/>
			<wtc:param value="<%=paraAray1[0]%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=paraAray1[1]%>"/>
			<wtc:param value=""/>  		
			<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
	<wtc:array id="ret" scope="end"/>
 	<%
  	String run_code="",bp_name="",hand_fee="",should_hand_fee="",sm_code="",idNo="",cmd_right="",favourCode="",cardId_type ="", cardId_no="",contract_phone="",cust_address="",print_note="",prepay_fee="";  	
  	String errCode=retCode1;
  	String errMsg=retMsg1;
  	System.out.println("errCode==============7193========="+errCode);
  	System.out.println("errMsg==============7193========="+errMsg);
  if(ret == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1297_Valid��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>" + errMsg;
    }
  }else if(!(ret == null))
  {
	if (errCode.equals("000000")){
	  run_code = ret[0][8];//����״̬
          bp_name = ret[0][5];//��������
          hand_fee = ret[0][9];//������
	  should_hand_fee = ret[0][9];//Ӧ��������
	  sm_code = ret[0][3];//ҵ������
	  idNo = ret[0][2];//�û�id
	  cmd_right = ret[0][16];//cmd_right
	  passwordFromSer = ret[0][6];//����
	  favourCode = ret[0][17];//�������Żݴ���
	  cardId_type = ret[0][18];//֤������
	  cardId_no = ret[0][19];//֤������
	  contract_phone = ret[0][21];//��ϵ�绰
	  cust_address = ret[0][20];//��ַ
	  prepay_fee = ret[0][22];//Ԥ���
	  print_note = ret[0][13];//����
	}else{
	  if(!retFlag.equals("1"))
	  {
	    retFlag = "1";
	    retMsg = "s1297_Valid��ѯ���������Ϣʧ��!<br>errCode: " + errCode + "<br>" + errMsg;
      }
	}
  }

//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************//
   //�Ż���Ϣ
  String[][]  favInfo = (String[][])session.getAttribute("favInfo");
  boolean pwrf = false;//a272 ��������֤
  String handFee_Favourable = "readonly";        //a230  �������Ż�
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    if(tempStr.compareTo(favourCode) == 0)
    {
      handFee_Favourable = "";
    }
    if(tempStr.compareTo("a272") == 0)
    {
      pwrf = true;
    }
  }

  /****************��phoneNo bp_flag�õ��ͻ������������Ϣ****************************/
  String bp_type = "1258";
  String bp_flag = "1";//bp_type2
  String function_code = "";
  String[] paraAray2 = new String[3];

  paraAray1[0] = loginNo; 	/* ��������   */
  paraAray1[1] = phoneNo;		/* �ֻ�����   */
  paraAray1[2] = bp_flag;		/* Ѱ������   */
  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }

  //String[] ret2 = impl.callService("s1298_Func",paraAray1,"10","phone",phoneNo);
  %>
	  <wtc:service name="s1298_Func" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="11" >
			<wtc:param value=""/>
			<wtc:param value="01"/>		
			<wtc:param value="7193"/>
			<wtc:param value="<%=paraAray1[0]%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=paraAray1[1]%>"/>
			<wtc:param value=""/>  		
			<wtc:param value="<%=paraAray1[2]%>"/>			
	  </wtc:service>
	<wtc:array id="ret2" scope="end"/>
  <%
	  String bp_title="",bp_title_name="",eng_chi="",eng_chi_name="",add_no="",month_code="",month_name="";	 
	 errCode=retCode2;
	 errMsg=retMsg2;
	 System.out.println("errCode2==============7193========="+errCode);
  	System.out.println("errMsg2==============7193========="+errMsg);
  if(ret2==null){
    if(!retFlag.equals("1"))
	{
	    retFlag = "1";
	    retMsg = "s1298_Func�ú���û�ж�Ӧ�Ŀ�����Ϣ!(��)<br>errCode: " + errCode + "<br>" + errMsg;
    }
  }else if(!(ret2 == null))
  {
 	if(errCode.equals("000000") )
	{
      bp_title = ret2[0][5];//�û���ν��ʶ
      if(!(bp_title==null)){
	    if(bp_title.equals("0")){
          bp_title_name="Ůʿ";
	    }else if(bp_title.equals("1")){
	      bp_title_name="����";
	    }
	  }
      eng_chi = ret2[0][4];//��Ӣ�ı�ʶ
	  if(!(eng_chi==null)){
	    if(eng_chi.equals("0")){
          eng_chi_name="Ӣ��";
	    }else if(eng_chi.equals("1")){
	      eng_chi_name="����";
	    }
	  }
	  add_no = ret2[0][6];//���Ӻ���
	  function_code = ret2[0][8];//�ط�����
	  month_code = ret2[0][9];
	  if(!(month_code==null)){
	    if(month_code.equals("01")){
          month_name="����";
	    }else if(month_code.equals("02")){
	      month_name="����";
	    }
	  System.out.println("month_name="+month_name);
	  }

    }else{
	  if(!retFlag.equals("1"))
	  {
	    retFlag = "1";
	    retMsg = "s1298_Func��ѯ���뿪����Ϣʧ��!<br>errCode: " + errCode + "<br>" + errMsg;
      }
	}
  }

  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();

%>

<html>
	<head>
	<title>12580����</title>
	<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
	<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
  	  <%
	  	if(retFlag.equals("1")){  	
	  %>	 
	  	<script type="text/javascript"> 
		    rdShowMessageDialog("<%=retMsg%>",0);
		    history.go(-1);
		</script>
	  <%
	  	    return;
	  	}
	  %>
	  
	<script type="text/javascript">
	<!--
	  //����Ӧ��ȫ�ֵı���
	  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
	  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
	  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�
	
	  var oprType_Add = "a";
	  var oprType_Upd = "u";
	  var oprType_Del = "d";
	  var oprType_Qry = "q";
	  core.loadUnit("debug");
	  core.loadUnit("rpccore");
	  onload=function()
	  {
	  }
	  //***
	  function frmCfm(){
	 	frm.submit();
		return true;
	  }
	  //***
	  function printCommit(){
	  	getAfterPrompt();
		//У��		
		if(!checkElement(document.frm.hand_fee)) return false;		
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
			return true;
		  }
	  function showPrtDlg(printType,DlgMessage,submitCfm)
	  {  
	  	var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     	var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
		var sysAccept ="<%=printAccept%>";                       // ��ˮ��
		var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
		var mode_code=null;                        //�ʷѴ���
		var fav_code=null;                         //�ط�����
		var area_code=null;                    //С������
		var opCode =   "<%=opCode%>";                         //��������
		var phoneNo = <%=phoneNo%>;                           //�ͻ��绰	
		//��ʾ��ӡ�Ի���
	   var h=162;
	   var w=352;
	   var t=screen.availHeight/2-h/2;
	   var l=screen.availWidth/2-w/2;			
		   
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);    
		return ret;
	  }
	
	  function printInfo(printType)
	  {
		 
		var sm_name = "";
		if("<%=sm_code%>"=="zn"){
			sm_name="������";
		}else if("<%=sm_code%>"=="gn"){
			sm_name = "ȫ��ͨ";
		}else {
			sm_name="���еش�";
		}		
	
		var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var retInfo = "";  //��ӡ����
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4 
		      
		cust_info+="�ͻ�������"+document.frm.bp_name.value+"|";
		cust_info+="�ֻ����룺"+document.frm.phoneNo.value+"|";
		cust_info+="�ͻ���ַ��"+"<%=cust_address%>"+"|";
		cust_info+="֤�����룺"+"<%=cardId_no%>"+"|";
		
		opr_info+="�û�Ʒ�ƣ�"+sm_name+"      "+"����ҵ��12580�ƶ����� ����"+"|";
		opr_info+="������ˮ:"+"<%=printAccept%>"+"|";
		opr_info+="ҵ�����ͣ�"+"<%=month_name%>"+"|" ;
		opr_info+="��Чʱ�䣺"+"<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>"+"|";
		
		note_info1+="��ע��"+"|";
		
		retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
		return retInfo;
	  }
	//-->
	</script>
	</head>
<body>
<form name="frm" method="post" action="f7193_confirm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">12580����</div>
		</div>
        <table cellspacing="0">
	          <tr>
		            <td class="blue">�ƶ�����</td>
		            <td>
					<input name="phoneNo" type="text"  id="phoneNo"   value="<%=phoneNo%>" readonly class="InputGrey">
		            </td>
		            <td class="blue">Ѱ������</td>
		            <td>
					<input name="bp_type" type="text"  id="bp_type" value="<%=bp_type%>" readonly class="InputGrey">
			    </td>
	          </tr>
	          <tr>
		            <td class="blue">����״̬</td>
		            <td>
					<input name="run_code" type="text"  id="run_code" value="<%=run_code%>" readonly class="InputGrey">
			    </td>
		            <td class="blue">���Ա�־</td>
		            <td>
					<input name="eng_chi_name" type="text"  id="eng_chi_name" value="<%=eng_chi_name%>" readonly class="InputGrey">
			    </td>	
	          </tr>
	          <tr>
		            <td class="blue">��������</td>
		            <td >
					  <input name="bp_name" type="text"  id="bp_name" value="<%=bp_name%>" readonly class="InputGrey">
					</td>
		            <td class="blue">�����Ա�</td>
		            <td>
					  <input name="bp_title_name" type="text"  id="bp_title_name" value="<%=bp_title_name%>" readonly class="InputGrey">
			    </td>
	          </tr>
	          <tr>
		            <td class="blue" >������</td>
		            <td colspan="3">
		            	<input name="hand_fee" type="text"  id="hand_fee" v_type="money" v_must=1 value="<%=hand_fee%>"  <%=handFee_Favourable%> class="InputGrey">
				<font class="orange">*</font>
			    </td>
	           
	          </tr>
	           <tr>
		            <td class="blue">��ע</td>
		            <td colspan="3" >
		            	<input name="opNote" type="text" readonly class="InputGrey" id="opNote" size="60" maxlength="60" value="<%="�û�" + phoneNo +"������"%>">
		            </td>		        
	          </tr> 
	  </table>
	  <table cellspacing="0">
	          <tr>
		            <td id="footer">
			                <input name="confirm" class="b_foot" type="button"  index="2" value="ȷ��" onClick="printCommit()">
			                &nbsp;
			                <input name="reset" class="b_foot" type="reset"  value="���" >
			                &nbsp;
			                <input name="back" class="b_foot" onClick="history.go(-1)" type="button"  value="����">
			                &nbsp; 
		             </td>
	          </tr>
        </table> 
	  <input type="hidden" name="idNo" value="<%=idNo%>"><!-- �û�id -->
	  <input type="hidden" name="sm_code" value="<%=sm_code%>" ><!-- ҵ������ -->
	  <input type="hidden" name="bp_flag" value="<%=bp_flag%>" ><!-- bp_flag -->
	  <input type="hidden" name="should_hand_fee" value="<%=should_hand_fee%>" ><!-- Ӧ�������� -->
	  <input type="hidden" name="cmd_right" value="<%=cmd_right%>" ><!-- cmd_right -->
	  <input type="hidden" name="function_code" value="<%=function_code%>" ><!-- Ѱ������ -->
	  <input type="hidden" name="eng_chi" value="<%=eng_chi%>" ><!-- ��Ӣ�ı�ʶ--���� -->
	  <input type="hidden" name="bp_title" value="<%=bp_title%>" ><!-- �û���ν--���� -->
	  <input type="hidden" name="add_no" value="<%=add_no%>" ><!-- ���Ӵ��룬�Ѳ��� -->
	  <input type="hidden" name="opCode" value="<%=opCode%>">
	  <input type="hidden" name="opName" value="<%=opName%>">
	  <%@ include file="/npage/include/footer.jsp" %>
	   <input type="hidden" name="printAccept" value="<%=printAccept%>" >
	</form>
</body>
</html>


