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
  
 	String loginName = (String)session.getAttribute("workName");
  String regCode = (String)session.getAttribute("regCode");
%>
<%
  String retFlag="",retMsg="";//����Ƿ�У��ʧ�ܵı�־����Ϣ
/****************���ƶ�����õ����롢������������ܰ��ͥ�������Ϣ s1251Init***********************/
  String[] paraAray1 = new String[4];
  String main_card = request.getParameter("chief_srv_no");/* �ҳ�����*/
  String phoneNo = request.getParameter("srv_no"); 
  String openType = request.getParameter("opFlag");/* ��������*/
  
  /**�����op_code�Ǹ������õ�**/ 
  
  String passwordFromSer="";
  String op_type ="���ʷ���ȡ��";
  String readtype="";
    
	String inputArry[] = new String[1];
	String Tmsql="select to_char(trunc(last_day(sysdate)+1),'yyyymmdd hh24:mi:ss') from dual";
	inputArry[0] = Tmsql;
%> 
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inputArry[0]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr1"  scope="end"/>
<%
	String exeTime = tempArr1[0][0].substring(0,8);
	String printAccept="";		
%>
		<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" id="sLoginAccept"/>
<%		
		printAccept = sLoginAccept;  
	
  paraAray1[0] = main_card; /* �������   */ 
  paraAray1[1] = opCode;	/* ��������  op_code */
  paraAray1[2] = opFlag;
  
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
%>  
	<wtc:service name="s7327Qry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="12">			
	<wtc:param value="<%=paraAray1[0]%>"/>	
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
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
	 
	    payArr = result2;//���ѽ��
	
	    beginTimeArr = result3;//��ʼ����
	 
	    endTimeArr = result4;//��������
	 
	    allpayArr = result5;//ʣ�������
	
	    numArr = result6;//ʣ������û�
	    
	    memArr = result8;//��������
	    
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
  onload=function()
  {		
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
	setOpNote();//Ϊ��ע��ֵ
	document.frm.action = "f7327Cfm.jsp";
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
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
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
	
	cust_info+="�ֻ����룺"+"<%=main_card%>"+"|";
	cust_info+="�ͻ�������"+document.all.bp_name.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.bp_addr.value+"|";
	cust_info+="֤�����룺"+document.all.cardId_no.value+"|";

	opr_info+="ҵ�����ͣ���ͥ����ƻ�����֮-->"+"<%=op_type%>"+"|";
	opr_info+="��ˮ��"+"<%=printAccept%>"+"|";
	opr_info+="������룺"+"<%=main_card%>"+"|";
	opr_info+="�������룺"+document.all.mem_num.value+"|";
	opr_info+="����ʱ�䣺"+exeDate+"|";
	opr_info+="��Чʱ�䣺"+ "<%=exeTime%>" +"|";
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

  function setOpNote(){
	if(document.frm.opNote.value.length==0)
	  document.frm.opNote.value = "���ʷ���ƻ����--<%=op_type%>����:"+document.all.mem_num.value; 
	return true;
}

 function f7327Init(obj){
 	document.all.confirm.disabled=false;
 	document.frm.main_card.value = obj.sMainCard;
	document.frm.mem_num.value = obj.slaveCard;
	document.frm.pay_fee.value = obj.payMon;
	document.frm.begin_time.value = obj.beginTime;
	document.frm.end_time.value = obj.endTime;
}
	
//-->
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
			  <input name="op_name" type="text" class="InputGrey" id="op_name" size="30" value="<%=op_type%>" readonly>
			</td>
          </tr>
          <tr> 
		    <td class="blue">��������</td>
            <td>
			  <input name="main_card" type="text" class="InputGrey" id="main_card" readonly >
			</td>
            <td class="blue">��������</td>
            <td>
			  <input name="mem_num" type="text" class="InputGrey" v_maxlength=16 id="mem_num"  readonly>
			</td>
          </tr>
          <tr> 
            <td class="blue">���ѽ��</td>
            <td>
			  <input name="pay_fee" type="text" class="InputGrey" id="pay_fee" size="30" readonly>
			</td>
			<td>
				<input name="op_flag" type="hidden" class="InputGrey" id="op_flag"  value="d">
			</td>
			<td>
				<input name="1" type="hidden" class="InputGrey" id="1" >
			</td>
		</tr>
			<tr>
			<td class="blue">��ʼ����</td>
            <td>
			  <input name="begin_time" type="text" class="InputGrey" id="begin_time" size="30"   readonly>
			</td>             
		    <td class="blue">��������</td>
            <td>
			  <input name="end_time" type="text" class="InputGrey" id="end_time" readonly >
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
		      <th width="10%" align=center>ѡ��</th>	
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
		      <tr>
		      <td class="Grey" align=center>
		      	<input type="radio" name="radio" sMainCard="<%=mainArr[j][0]%>" slaveCard="<%=memArr[j][0]%>" payMon="<%=payArr[j][0]%>" beginTime="<%=beginTimeArr[j][0]%>" endTime="<%=endTimeArr[j][0]%>" onclick="f7327Init(this)">
		      	</td> 
			  <td class="<%=tdClass%>" align=center><%=mainArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=memArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=payArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=beginTimeArr[j][0]%></td>
			  <td class="<%=tdClass%>" align=center><%=endTimeArr[j][0]%></td>
			</tr>				
			<%
			}
		}	
%>
		</table>
	    <TABLE cellSpacing="0">
          <TBODY> 
		  <tr> 
            <td colspan="4" id="footer"> <div align="center"> 
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
  <input type="hidden" name="exe_time" value="<%=exeTime%>">
  <input type="hidden" name="phoneNoForPrt" ><!--Ҫȡ�����ֻ�����,���ڴ�ӡ-->
  <input type="hidden" name="cardTypeForPrt" ><!--Ҫȡ���Ŀ�����,���ڴ�ӡ-->
  <input type="hidden" name="stream" value="<%=printAccept%>">
	<input type="hidden" name="opCode" value="7389">
  <input type="hidden" name="op_note" value="<%=openType%>" >
  <input type="hidden" name="opName" value="<%=opName%>" >
  <input type="hidden" name= "opNote" value="" >
  <input name="bp_name" type="hidden" id="bp_name" value="<%=bp_name%>">	<!--�ͻ�����-->
  <input name="bp_addr" type="hidden"  id="bp_addr" value="<%=bp_add%>">	<!--�ͻ���ַ-->
  <input name="cardId_no" type="hidden"  id="cardId_no" value="<%=cardId_no%>">	<!--�ͻ�֤��-->
  <input type="hidden" name="return_page" value="/npage/bill/f7327.jsp?activePhone=<%=main_card%>&opName=<%=opName%>">
  <!--����������������ר�Ÿ�ͳһ�Ӵ��õ�-->
   <input type="hidden" name= "cnttOpCode" value="<%=cnttOpCode%>">
    <input type="hidden" name= "cnttOpName" value="<%=cnttOpName%>">
   <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

