<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ��ͥ����ƻ�����
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept_boss.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%		

	/**�����������Ǹ�ҳ�����,��ǰ�º���ʾ�õ�**/
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
 	String opFlag = request.getParameter("op_flag");
 	
 	/**������������ר�Ÿ�ͳһ�Ӵ��õ�**/   
    String cnttOpCode = request.getParameter("opCode");
    String cnttOpName = request.getParameter("opName");
   String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String regCode = (String)session.getAttribute("regCode");
  
  String retFlag="",retMsg="";//����Ƿ�У��ʧ�ܵı�־����Ϣ
/****************���ƶ�����õ����롢������������ܰ��ͥ�������Ϣ s1251Init***********************/
  String[] paraAray1 = new String[4];
  String main_card = request.getParameter("chief_srv_no");/* ��������*/
  String openType = request.getParameter("opFlag"); /* ��������*/
  
  String op_type ="���ʷ�������";
  String readtype="";
  /****�õ���ӡ��ˮ****/
	String printAccept="";		
%>
		<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" id="sLoginAccept"/>
<%		
		printAccept = sLoginAccept;

		paraAray1[0] = main_card; /* �ҳ�����   */ 
  	paraAray1[1] = opCode;	/* ��������  op_code */  
  	paraAray1[2] = opFlag;
  	paraAray1[3] = "0";
  	
%>
	<wtc:service name="s7327Qry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="12">			
	<wtc:param value="<%=paraAray1[0]%>"/>	
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[3]%>"/>		
	</wtc:service>	
	<wtc:array id="result0"  start="0" length="2" scope="end"/>
	<wtc:array id="result1"  start="2" length="1" scope="end"/>
	<wtc:array id="result2"  start="3" length="1" scope="end"/>
	<wtc:array id="result3"  start="4" length="1" scope="end"/>
	<wtc:array id="result4"  start="5" length="1" scope="end"/>	
	<wtc:array id="result5"  start="6" length="1" scope="end"/>	
	<wtc:array id="result6"  start="7" length="1" scope="end"/>
	<wtc:array id="result7"  start="8" length="3" scope="end"/>			
	<wtc:array id="result8"  start="11" length="1" scope="end"/>		
<%
  String  phone_no="",limit_pay="",begin_time="",end_time="",allpay_limit="",num_limit="";
  String bp_name="",cardId_no="",bp_add="";
  String[][] tempArr= new String[][]{};
  String[][] mainArr= new String[][]{};
  String[][] memArr= new String[][]{};
  String[][] payArr= new String[][]{};
  String[][] beginTimeArr= new String[][]{};
  String[][] endTimeArr= new String[][]{};
  String[][] allpayArr= new String[][]{};
  String[][] numArr= new String[][]{};
  String[][] bmArr= new String[][]{};
  tempArr = result0;
 allpayArr= result5;
 numArr = result6;
 bmArr = result7;
  String errCode = retCode1;
  String errMsg = retMsg1;
  if(result1.length==0)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag="1";
	   retMsg="s7327Qry���ú��������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg: " + errMsg ;
    }  
  }else if(errCode.equals("000000") && result1.length>0)
  {
			mainArr = result1;// ��������
	    
	    memArr = result8;//��������
	 
	    payArr = result2;//���ѽ��
	
	    beginTimeArr = result3;//��ʼ����
	 
	    endTimeArr = result4;//��������
	 
	    allpay_limit = allpayArr[0][0];//ʣ�������
		//out.print(allpay_limit);
	    num_limit = numArr[0][0];//ʣ������û�
	    
	    bp_name = bmArr[0][0]; //�ͻ�����
	    
	    bp_add = bmArr[0][1]; //�ͻ���ַ
	    
	    cardId_no = bmArr[0][2]; //�ͻ�֤��
	    
	 } else{
		if(!retFlag.equals("1"))
	    {
	       retFlag="1";
	       retMsg="s7327Qry���ú��������Ϣʧ��!"+errMsg;
        }
	}
%> 
<head>
<title>���ʷ���ƻ�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
 
<script language="JavaScript">
    //���У��ʧ�ܣ��򷵻���һ����
	<%if(retFlag.equals("1")){%>
	 rdShowMessageDialog("<%= retMsg %>",0);
	 history.go(-1);
	<%}%>
<!--
  //����Ӧ��ȫ�ֵı���
 
  onload=function()
  {		
  }
  function doProcess(packet)
	{
		var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    var retFlag = packet.data.findValueByName("retFlag");	
    if(retType == "getPwd")
		{
			if(retCode == "000000" && retFlag != "1")
			{
			   rdShowMessageDialog("������֤�ɹ���");
			   document.all.confirm.disabled=false;
			}	        
			else
			{
			  retMessage = retMessage + "������ȷ�ϣ�";
			  document.frm.passwd.value="";
			  document.frm.passwd.focus(); 
			  document.all.confirm.disabled=true;
  			rdShowMessageDialog(retMessage,0);
				return false;
			}
		}
	}
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  
   function frmPrint(subButton){
	//controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	//subButton.disabled = true;
  getAfterPrompt();	
	if(document.frm.mem_num.value.length==0)
	{
	  rdShowMessageDialog("�����뱻���Ѻ���!");
	  document.frm.mem_num.focus();
      return false;
	}
	else if(document.frm.pay_fee.value.length==0)
	{
	  rdShowMessageDialog("��������!");
	  document.frm.pay_fee.focus();
      return false;
	}
	/*begin huangrong add �Ը��ѽ������ֵ����Ϊ�������ж� 2011-3-10*/
	else if(isNaN(document.frm.pay_fee.value))
	{
	  rdShowMessageDialog("���ѽ������֣�����������!");
	  document.frm.pay_fee.focus();
      return false;
	}
	
	else if(parseFloat(document.frm.pay_fee.value)<0)
	{
	  rdShowMessageDialog("���ѽ���Ϊ����������������!");
	  document.frm.pay_fee.focus();
      return false;
	}	
		
	/*end huangrong add �Ը��ѽ������ֵ����Ϊ�������ж� 2011-3-10*/
	else if(document.frm.numlimit.value == 0)
	{
	  rdShowMessageDialog("�������û�������,�����ٰ����ҵ��!");
	  history.go(-1);	     
	}
	else if(document.frm.feelimit.value == 0)
	{
	  rdShowMessageDialog("��Ľ���,���ܼ�������!");
	  history.go(-1);     
	}
	else if(parseFloat(document.frm.pay_fee.value) > parseFloat(document.frm.feelimit.value))
	{
	  rdShowMessageDialog("������Ľ��̫��,���ѽ�����ۼ��ѳ�ֵ!");
	  document.frm.pay_fee.focus();
      return false;     
	}
	
	else{
	
	document.frm.action = "f7327Cfm.jsp";
	
    //��ӡ�������ύ��
    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm")||(ret=="con1firm"))
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
}
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի��� 
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
   var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
   var sysAccept="<%=printAccept%>";                          // ��ˮ��
   var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
   var mode_code=null;                                        //�ʷѴ���
   var fav_code=null;                                         //�ط�����
   var area_code=null;                                        //С������
   var opCode="<%=opCode%>";                                  //��������
   var phoneNo="<%=main_card%>";                             //�ͻ��绰

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
  }

  function printInfo(printType)
  {
	var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//�õ�ִ��ʱ��
	
	var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4
	var retInfo = "";  //��ӡ����
	/********������Ϣ��**********/
	cust_info+="�ֻ����룺"+"<%=main_card%>"+"|";
	cust_info+="�ͻ�������"+document.all.bp_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.bp_addr.value+"|";
	cust_info+="֤�����룺"+document.all.cardId_no.value+"|";
	
	opr_info+="ҵ�����ͣ���ͥ����ƻ�����֮-->"+"<%=op_type%>"+"|";
	opr_info+="��ˮ��"+"<%=printAccept%>"+"|";
	opr_info+="������룺"+"<%=main_card%>"+"|";
	opr_info+="�������룺"+document.all.mem_num.value+"|";
	opr_info+="���ѽ�"+document.all.pay_fee.value+"|";
	opr_info+="����ʱ�䣺"+exeDate+"|";
	opr_info+="��Чʱ�䣺"+exeDate+"|";
	opr_info+=""+"|";
	opr_info+=""+"|";
	opr_info+=""+"|";
	note_info1+="������ע��"+"|";
	note_info1+="1.���⡢���񡢲��Կ��ͻ������������˻��Ŀͻ����ܰ����ҵ��"+"|";
	note_info1+="2.�������ֽ��˻�����Ϊ�������и��ѣ������ר���˻��޷�Ϊ�������и��ѡ�"+"|";
	note_info1+="3.����Ƿ��ͣ������������������ͣ����ͣ����"+"|";
	note_info1+="4.����Ϊ�������ѽ����������ĵ��������ڡ�"+"|";
	note_info1+="5.������Ϊȫ��ͨ�򶯸еش�Ʒ�ƿͻ�������Ϊ�������ѽ���������Ļ��֣��鸱�����С�������Ϊ�����пͻ���������Ϊ�������ѽ��������֡�"+"|";
	note_info1+="6.���롰���ʷ���ҵ�񣬰����������Ч��ȡ����ҵ��������Ч��"+"|";
	note_info1+="7.����Ϊ�������ѵĽ�����µ׳���ʱһ���Ի�����"+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	
	return retInfo;
  }
function rpc_chkX(){
		if(document.frm.mem_num.value.length==0)
		{
		  rdShowMessageDialog("��������Ҫ��ѯ�ĺ���!");
		  document.frm.passwd.value = "";
		  document.frm.mem_num.focus();
  	  return false;
		}
		else if(document.frm.passwd.value == "")
  	{
  	    rdShowMessageDialog("���������룡",0);
  	    document.frm.passwd.focus();
  	    return false;
  	}
  	else if(document.frm.passwd.value.length != 6)
  	{
  			rdShowMessageDialog("���볤����������������6λ���룡",0);
  			document.frm.passwd.value = "";
  	    document.frm.passwd.focus(); 
  	    return false;
  	}
		//2010-10-2 wanghfa�޸� ������� start
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
		checkPwd_Packet.data.add("custType", "01");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
		checkPwd_Packet.data.add("phoneNo", document.frm.mem_num.value);			//�ƶ�����,�ͻ�id,�ʻ�id
		checkPwd_Packet.data.add("custPaswd", document.frm.passwd.value);//�û�/�ͻ�/�ʻ�����
		checkPwd_Packet.data.add("idType", "un");				//en ����Ϊ���ģ�������� ����Ϊ����
		checkPwd_Packet.data.add("idNum", "");					//����
		checkPwd_Packet.data.add("loginNo", "<%=loginNo%>");		//����
		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
		checkPwd_Packet=null;
		//2010-10-2 wanghfa�޸� ������� end
	}
	
	//2010-10-2 wanghfa�޸� ������� start
	function doCheckPwd(packet) {
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		
		if (retResult != "000000") {
			rdShowMessageDialog(msg);
			document.frm.passwd.value="";
			document.frm.passwd.focus(); 
			document.all.confirm.disabled=true;
			return false;
		} else {
			rdShowMessageDialog("������֤�ɹ���");
			document.all.confirm.disabled=false;
		}
	}
	//2010-10-2 wanghfa�޸� ������� end

//-->
</script>

</head>

<body>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
		  <tr> 
            <td class="blue">��������</td> 
      <td>        
			  <input name="op_name" type="text" class="InputGrey" id="op_name" size="30" value="<%=op_type%>" readonly>
			</td>           
		    <td class="blue">��������</td>
            <td>
			  <input name="main_card" type="text" class="InputGrey" id="main_card" value="<%=main_card%>" readonly >
			</td>
      </tr>
      <tr>
            <td class="blue">�����Ѻ���</td>
            <td>
			  <input name="mem_num" type="text" class="button" id="mem_num" >				
			</td>
			<td class="blue">���룺</td>
       <td>
			  <input name="passwd" type="password" class="button" id="passwd" v_type=int v_must=1>	
			  <input type="button" name="idCheck" class="b_text" value="��֤" onclick="rpc_chkX()" >			
			</td>
          </tr>
          <tr> 
            <td class="blue">���ѽ��</td>
            <td>
			  <input name="pay_fee" type="text" class="button" id="pay_fee" size="10" >
			</td>
			<td colspan=2>
				<input name="1" type="hidden" class="button" id="1" size="30" >
			</td>
		</tr>
		<tr>
            <td colspan=4>
			  <input name="begin_time" type="hidden" class="button" id="begin_time" size="10" maxlength=8>
		
			  <input name="end_time" type="hidden" class="button" id="end_time" size="10" maxlength=8 >
			  <input name="op_flag" type="hidden" class="InputGrey" id="op_flag"  value="a">
			</td>
          </tr>
		</table>
		</div>
		
	<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">������Ϣ</div>
</div>
		<TABLE border=0 align="center" cellSpacing="0">
          <TBODY> 
		  <tr>
			<tr align="middle">	
		      <th width="10%"align=center>��������</th>
			  <th width="10%"align=center>��������</th>
			  <th width="20%" align=center>���ѽ��</th>
			  <th width="25%" align=center>��ʼʱ��</th>
			  <th width="25%" align=center>����ʱ��</th>
			</tr>
			
			<% 
				if(errCode.equals("000000"))
				{
				for(int j=0;j<memArr.length;j++){
					String tdClass = (j%2==0)?"Grey":"";
			%>
		    <tr>
			  <td class="<%=tdClass%>" align=center><%=mainArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=memArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=payArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=beginTimeArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=endTimeArr[j][0]%></td>
			</tr>				
			<%}
}
%>
	
		  <tr> 
            <td colspan=6 > <div align="center"> 
                &nbsp; 
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="ȷ��&��ӡ" onClick="frmPrint(this)" disabled>
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="���" >
                &nbsp; 
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
                &nbsp; 
				</div>
			</td>
          </tr>
       </table>
  </div>
  <input type="hidden" name="phoneNoForPrt" ><!--Ҫȡ�����ֻ�����,���ڴ�ӡ-->
  <input type="hidden" name="cardTypeForPrt" ><!--Ҫȡ���Ŀ�����,���ڴ�ӡ-->
  <input type="hidden" name="stream" value="<%=printAccept%>">
	<input type="hidden" name="op_note" value="<%=openType%>" >
	<input type="hidden" name="opCode" value="7327">
  <input type="hidden" name="opName" value="<%=opName%>" >
  <input type="hidden" name= "opNote" value="">
<input name="feelimit" type="hidden" class="button" id="feelimit" size="30" value="<%=allpay_limit%>">
  <input name="numlimit" type="hidden" class="button" id="numlimit" size="30" value="<%=num_limit%>">
  <!--����������������ר�Ÿ�ͳһ�Ӵ��õ�-->
   <input type="hidden" name= "cnttOpCode" value="<%=cnttOpCode%>">
    <input type="hidden" name= "cnttOpName" value="<%=cnttOpName%>">
    <input name="bp_name" type="hidden" id="bp_name" value="<%=bp_name%>">	<!--�ͻ�����-->
    <input name="bp_addr" type="hidden"  id="bp_addr" value="<%=bp_add%>">	<!--�ͻ���ַ-->
    <input name="cardId_no" type="hidden"  id="cardId_no" value="<%=cardId_no%>">	<!--�ͻ�֤��-->
    <input type="hidden" name="return_page" value="/npage/bill/f7327.jsp?activePhone=<%=main_card%>&opName=<%=opName%>">
   <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

