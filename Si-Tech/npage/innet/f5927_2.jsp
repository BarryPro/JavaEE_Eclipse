<%

%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html;charset=GB2312"%>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  String regionCode = (String)session.getAttribute("regCode");
  String currentTime =  new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());//��ǰ����
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 

<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
	
%>
<%
String retFlag="",retMsg="";

  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer="";

  paraAray1[0] = phoneNo;		/* �ֻ�����   */
  paraAray1[1] = opCode; 	    /* ��������   */
  paraAray1[2] = loginNo;	    /* ��������   */
  paraAray1[3] = orgCode;

  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";

	}
  }
 /* ��������� �����룬������Ϣ���ͻ��������ͻ���ַ��֤�����ͣ�֤�����룬ҵ��Ʒ�ƣ�
 			�����أ���ǰ״̬��VIP���𣬵�ǰ����,����Ԥ��
 */

  %>
  
    <wtc:service name="s5927Qry" outnum="23" retmsg="msg" retcode="code" routerKey="phone" routerValue="<%=phoneNo%>">
			<wtc:param value="<%=paraAray1[0]%>" />
			<wtc:param value="<%=paraAray1[1]%>" />
			<wtc:param value="<%=paraAray1[2]%>" />
			<wtc:param value="<%=paraAray1[3]%>" />			
		</wtc:service>
		<wtc:array id="tempArr" scope="end" />
  <%
  String login_accept="",cust_iccid="",cust_phone="",cust_prepayfee="",cust_simfee="",cust_fee="",cust_name="";
  String agent_phone="",agent_iccid="",agt_name="";
  String cust_id="",userid="",accountid="",open_time="";
  String errCode = code;
  String errMsg = msg;
  
  
  for(int iii=0;iii<tempArr.length;iii++){
				for(int jjj=0;jjj<tempArr[iii].length;jjj++){
					System.out.println("---------------------tempArr["+iii+"]["+jjj+"]=-----------------"+tempArr[iii][jjj]);
				}
		}
		
  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s1141Qry��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(!errCode.equals("000000")){%>
		<script language="JavaScript">
			rdShowMessageDialog("�������<%=errCode%>��������Ϣ<%=errMsg%>");
			history.go(-1);
		</script>
	<%}
	else
	{
	  if(!(tempArr==null)){
	    login_accept = tempArr[0][2];//��������
	    
	  }
	  if(!(tempArr==null)){
	    cust_id = tempArr[0][3];//��������
	    
	  }
	  if(!(tempArr==null)){
	    cust_iccid = tempArr[0][5];//���֤����
	  }
	  if(!(tempArr==null)){
	    cust_name = tempArr[0][6];//���֤����
	  }
	  if(!(tempArr==null)){
	    cust_phone = tempArr[0][8];//�û�����
	  }
	  if(!(tempArr==null)){
	    cust_prepayfee = tempArr[0][11];//�û�Ԥ���
	  }
	  if(!(tempArr==null)){
	    cust_simfee = tempArr[0][13];//sim����
	  }
	  if(!(tempArr==null)){
	    cust_fee = tempArr[0][14];//������
	  }
	  if(!(tempArr==null)){
	    userid = tempArr[0][17];//������
	  }
	  if(!(tempArr==null)){
	    accountid = tempArr[0][18];//������
	  }
	  if(!(tempArr==null)){
	    agent_phone = tempArr[0][19];//�����̺���
	  }
	  if(!(tempArr==null)){
	    agent_iccid = tempArr[0][20];//���������֤��
	  }
	  if(!(tempArr==null)){
	    agt_name = tempArr[0][21];//���������֤��
	  }
	  if(!(tempArr==null)){
	    open_time = tempArr[0][22];//���������֤��
	  }
	}
  }

%>
 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>����ѡ�ſ�������</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="../../npage/s1400/pub.js"></script>

 <script language=javascript>
  
 
 //***IMEI ����У��
 
function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}

}

 </script>
<script language="JavaScript">

<!--
  //����Ӧ��ȫ�ֵı���
  var _KMap=function(){
	this.init.apply(this,arguments);
	}
	_KMap.prototype={
		init:function(){
			this.map={};
		},
		add:function(key,value){
			if(this.map[key]==null){
				this.map[key]=new Array();	
			}
			this.map[key].push(value);		
		}
	
	}
	
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  



  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
 //***
 function printCommit()
 {
  //У��
  //if(!check(frm)) return false;

  with(document.frm){
   	if(sysnote.value==""){
   		sysnote.value="����ѡ�ſ�������";
   	}
  }
 var selObj = document.getElementsByName("custOrderIds"); 
 var map=new _KMap();
	var tab=document.all.dataTable;
	for(var i=0;(i+1)<tab.rows.length;i++){
		var key=tab.rows[i+1].cells[1].innerText;
		var value=tab.rows[i+1].cells[3].innerText;
		if(selObj[i].checked == true){
			map.add(key,value);
		}
	}
	var result="";
	for(var e in map.map){
		var result2="";//���񶩵���e�ǿͻ�����
		for(var i=0;i<map.map[e].length;i++){
			result2+=map.map[e][i]+"~";
		}
		result2=result2.substring(0,result2.length-1);//ȥ��~
		result+=e+"@"+result2+"|";
	}
	
	document.all.result.value = result;
 //��ӡ�������ύ��
  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
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

function showPrtDlg(printType,DlgMessage,submitCfm,printInfoStr)
  {  //��ʾ��ӡ�Ի��� 
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		
		var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept=<%=sysAcceptl%>;                            // ��ˮ��
		var printStr=printInfo(printType,printInfoStr);                         //����printinfo()���صĴ�ӡ����
		var mode_code=null;                                        //�ʷѴ���
		var fav_code=null;                                         //�ط�����
		var area_code=null;                                        //С������
		var opCode = "<%=opCode%>";
		var phoneNo=document.all.cust_phone.value             //�ͻ��绰
		
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
  }

function printInfo(printType)
{
		var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		var retInfo = "";  //��ӡ����
		
	cust_info+="�ֻ����룺"+document.all.cust_phone.value+"|";//3
	cust_info+="֤�����룺"+document.all.cust_iccid.value+"|";
	
	
	opr_info+=document.all.cust_phone.value+"��"+"<%=open_time%>"+"��"+document.all.agent_phone.value+document.all.agt_name.value+"����"+"|";
	opr_info+="���г���������ӪҵԱΪ"+document.all.work_no.value+"|";

		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		return retInfo;
}


	function doSearch(){
		var idType = "0"; //��ѯ����
		var servno = "<%=cust_phone%>"; //����ֵ
		 
		var searchDate = "<%=currentTime%>"; //��ѯ����
		var packet = new AJAXPacket("searchData5927.jsp","���Ժ�...");
		packet.data.add("idType",idType); 
		packet.data.add("servno",servno); 
		packet.data.add("selFlag",idType); 
		packet.data.add("modeFlag","5927"); 
		packet.data.add("searchDate",searchDate);
		core.ajax.sendPacketHtml(packet,doSearchData);
		packet = null;
	}
	
	function doSearchData(data){
		$("#searchResult").html(data);
	}
	//-->
	
</script>



</head>


<body onload="doSearch();">
<form name="frm" method="post" action="f5927_3.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>                         
<div class="title">
		<div id="title_zi">����ѡ�ſ�������</div>
	</div>
        <table cellspacing="0" >
            
          <tr >
            <td class="blue">�û�����</td>
            <td>
			  <input name="cust_phone" value="<%=cust_phone%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_phone" maxlength="20" >
			  <font class="orange">*</font>
            </td>
            <td class="blue">������ˮ</td>
            <td>
			  <input name="back_accept" value="<%=login_accept%>" type="text"  v_must=1 readonly class="InputGrey" id="login_accept" maxlength="20" >
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr >
            <td class="blue">�û�֤������</td>
            <td>
			  <input name="cust_iccid" value="<%=cust_iccid%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_iccid" maxlength="20" >
			  <font class="orange">*</font>
            </td>
            <td class="blue">����SIM����</td>
            <td>
			  <input name="cust_simfee" value="<%=cust_simfee%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_simfee" maxlength="20" >
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr >
            <td class="blue">����Ԥ��</td>
            <td>
			  <input name="cust_prepayfee" value="<%=cust_prepayfee%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_prepayfee" maxlength="20" >
			  <font class="orange">*</font>
            </td>
            <td class="blue">�����̺���</td>
            <td>
			  <input name="agent_phone" value="<%=agent_phone%>" type="text"  v_must=1 readonly class="InputGrey" id="run_type" maxlength="20" >
			  <font class="orange">*</font>
            </td>
            </tr>
            <tr >
            <td class="blue">������֤������</td>
            <td>
			  <input name="agent_iccid" value="<%=agent_iccid%>" type="text"  v_must=1 readonly class="InputGrey" id="agent_iccid" maxlength="20" >
			  <font class="orange">*</font>
            </td>
            <td class="blue">����������</td>
            <td>
            	<input name="agt_name" value="<%=agt_name%>" type="text"  v_must=1 readonly class="InputGrey" id="agt_name" maxlength="20" >

			  <font class="orange">*</font>
            </td>
            </tr>
            <tr >
            <td class="blue">��ע</td>
            <td colspan="3" >
			  <input name="sysnote"  type="text"   id="sysnote" maxlength="20" size="60" >
			  <font class="orange">*</font>
            </td>
            <td></td>
            
            </tr>
            <input type="hidden" name="accountid" value="<%=accountid%>">
            <input type="hidden" name="userid" value="<%=userid%>">
            <input type="hidden" name="cust_id" value="<%=cust_id%>">
            <input type="hidden" name="cust_fee" value="<%=cust_fee%>">
            <input type="hidden" name="cust_name" value="<%=cust_name%>">
          <tr >
            <td colspan="4" id="footer"> <div align="center">
                <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��&��ӡ" onClick="printCommit()"  >
                &nbsp;
                <input name="reset" type="reset"  class="b_foot"  value="���" >
                &nbsp;
                <input name="back"  class="b_foot" onClick="location='f5927_1.jsp'" type="button"  value="����">
                &nbsp; </div></td>
          </tr>
        </table>
 <div id="searchResult"></div>
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginNo%>">

    <input type="hidden" name="card_dz" >
    <input type="hidden" name="used_point" value="0" >
    <input type="hidden" name="point_money" value="0" >
    <input type="hidden" name="result" value="" >
    
    
    <input type="hidden" name="sysAcceptl" value="<%=sysAcceptl%>">
    
    <input type="hidden" name="opcode" value="<%=opCode%>">
    <input type="hidden" name="sale_type" value="0" >
    <input type="hidden" name="phone_typename" >
    <input type="hidden" name="card_type" >
    <input type="hidden" name="cardy" >
    
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>


