   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-10
********************/
%>
              
<%
  String opCode = "1448";
  String opName = "�ʼ��ʵ�";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
	



<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*"%>





<%
   String regionCode = (String)session.getAttribute("regCode");
	//String userPhoneNo=(String)session.getAttribute("userPhoneNo");
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");

    String work_Pwd = (String)session.getAttribute("password");
	boolean workNoFlag=false;
  //if(workNoFromSession.substring(0,1).equals("k"))
    workNoFlag=true;
    
    String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    boolean hfrf=false;
	for(int j=0;j<favStr.length;j++)
		System.out.println("======= favStr ======="+favStr[j]+"==============");
    if(WtcUtil.haveStr(favStr,"a272")){
		
	  pwrf=true;
	  System.out.println("===== pwrf ====" + pwrf);
	}
	//ArrayList initArr = new ArrayList();
        //ArrayList groupArr = new ArrayList();

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));

	String dirtPage=request.getParameter("dirtPage");



//----------------------------------------------------------
  
%>



<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="paraStr" /> 
	
	
<%
  request.setCharacterEncoding("GBK");

  HashMap hm=new HashMap();
  hm.put("1","û�пͻ�ID��");
  hm.put("3","�������");
  hm.put("4","�����Ѳ�ȷ���������ܽ����κβ�����");
  
  hm.put("2","δȡ������1����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("10","δȡ������2����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("11","δȡ������3����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("12","δȡ������4����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("13","δȡ������5����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("14","δȡ������6����˲����ݻ���ѯϵͳ����Ա��");
  String op_name="";
  String op_code = request.getParameter("op_code");
  //System.out.println("op_code === "+ op_code );
  //op_code="1250";
 
  if(op_code.equals("1220"))
    op_name="�������";
  else if(op_code.equals("1217"))
    op_name="Ԥ���ָ�";
  else if(op_code.equals("1260"))
    op_name="Ԥ��ָ�";
  else if(op_code.equals("2419"))
    op_name="����ת��ҵ������";
  else if(op_code.equals("1296"))
    op_name="���еش�����ת��";
  else if(op_code.equals("1250"))
    op_name="���ֶҽ�";
  else if(op_code.equals("1221"))
    op_name="��������";
  else if(op_code.equals("1353"))
    op_name="��������";
  else if(op_code.equals("1290"))
    op_name="���֤��ʧ";
  else if(op_code.equals("1291"))
    op_name="�ֻ�֤ȯ����";
  else if(op_code.equals("1295"))
    op_name="������";
  else if(op_code.equals("1299"))
    op_name="���еش�Mֵ�һ�";
  else if(op_code.equals("2420"))
    op_name="����ת��ҵ�����";
  else if(op_code.equals("2421"))
    op_name="�ĺ�֪ͨҵ��";
  else if(op_code.equals("1442"))
    op_name="SIM��Ӫ��";
  else if(op_code.equals("1445"))
    op_name="ȫ��ͨǩԼ�ƻ�";
  else if(op_code.equals("1448"))
    op_name="�ʼ��ʵ�";
  else if(op_code.equals("7114"))
    op_name="�굥��ѯ��������";
  else if(op_code.equals("1458"))
    op_name="��Ϣ�ռ�";
  else if(op_code.equals("1469"))
    op_name="ȫ��spҵ���˷�";
  else if(op_code.equals("7115"))
    op_name="����绰��ѻ���";
  else if(op_code.equals("2299"))
    op_name="�������֤����������";
  else if(op_code.equals("1499"))
    op_name="����ҵ�񸶽�����ά��";
  else if(op_code.equals("1451"))
    op_name="�����ʵ�����";
  else if(op_code.equals("1452"))
    op_name="�������֤";
  else if(op_code.equals("5036"))
    op_name="�ͷ�ϵͳ�ײ�����";
  else if(op_code.equals("5037"))
    op_name="������ò�ѯ";
  else if(op_code.equals("1577"))
    op_name="���ź˼컰����ѯ";
  else if(op_code.equals("1446"))
    op_name="�ĺ�֪ͨ";
  else if(op_code.equals("1440"))
    op_name="��ҵ��ҽ�";
  else if(op_code.equals("5118"))
    op_name="����ҵ�񸶽�";
  else if(op_code.equals("1449"))
    op_name="ȫ��ͨǩԼ�ƻ�����";
  else if(op_code.equals("1450"))
    op_name="���ֶһ�����";
  else if(op_code.equals("1443"))
    op_name="�ļ�����";
  else if(op_code.equals("2267"))
    op_name="�ֻ��û�ʵ��Ԥ�Ǽǲ�ѯ/ȷ��";
  else if(op_code.equals("2266"))
    op_name="����Ʒͳһ����";
  else if(op_code.equals("2849"))
    op_name="�������ż��ŷ��������Ϣ��ѯ";
  else if(op_code.equals("5303"))
    op_name="���ŵ�½������������";
  else if(op_code.equals("5309"))
    op_name="���ŵ�½��������������ʷ��ѯ";
%>

<html>
<head>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>



<title><%=op_name%></title>

<script language=javascript>
<!--
  onload=function()
  {
    	self.status="";
  }
 
function simChk()
{
	if((document.all.phoneno.value).trim().length<1)
	{
      rdShowMessageDialog("�ֻ����벻��Ϊ�գ�",0);
 	  return;
	} 	
	//begin huangrong add �ж��ʼ��˵�ҵ�����ȫ��ͨ�ͻ����� 2011-2-24
	if(document.all.r_cus[0].checked || document.all.r_cus[1].checked ||document.all.r_cus[3].checked)
	{
		if("<%=op_code%>"=="1448")
		{
			var myPacket1 = new AJAXPacket("getSmCode.jsp","���ڲ�ѯ�ͻ��ֻ�Ʒ�ƣ����Ժ�......");
			myPacket1.data.add("phoneNo",(document.all.phoneno.value).trim());
			core.ajax.sendPacket(myPacket1,doGetSmCode);
    	myPacket1 = null;
    }
    var flag=document.getElementById("flag");
    if(flag.value=="1")
    {
    	return;
    }
  }
  
			
	//end huangrong add �ж��ʼ��˵�ҵ�����ȫ��ͨ�ͻ����� 2011-2-24
	
  
  var myPacket = new AJAXPacket("postSim.jsp","���ڲ�ѯ�ͻ������Ժ�......");
	myPacket.data.add("phoneNo",(document.all.phoneno.value).trim());
	myPacket.data.add("pssword",(document.all.cus_pass.value).trim());
	myPacket.data.add("opCode",(document.all.op_code.value).trim());
	myPacket.data.add("postFlag",(document.all.postFlag.value).trim());
	for(var i = 0 ; i < document.all.r_cus.length ; i ++){
		if(document.all.r_cus[i].checked)
		{
			var value = document.all.r_cus[i].value;
			myPacket.data.add("r_cus",(value).trim());
		}
	}
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

function doGetSmCode(packet)
{
	  		var smCode=packet.data.findValueByName("smCode");  

				if(smCode!="gn")
				{
		    	rdShowMessageDialog("���û���ȫ��ͨ�û������ܰ����ʼ��ʵ�ҵ��");	
		    	var flag=document.getElementById("flag");
		    	flag.value="1";
		    	return;
				}
		
}

 //--------4---------doProcess����----------------
function doProcess(packet)
{
    var vRetPage=packet.data.findValueByName("rpc_page");  
	  
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    
	var post_address = packet.data.findValueByName("post_address");
	var post_zip = packet.data.findValueByName("post_zip");
	var fax_no = packet.data.findValueByName("fax_no");
	var mail_address = packet.data.findValueByName("mail_address");
	var post_name = packet.data.findValueByName("post_name");
	var cust_name = packet.data.findValueByName("cust_name");
	var id_iccid = packet.data.findValueByName("id_iccid");
	var id_address = packet.data.findValueByName("id_address");
	var sm_name = packet.data.findValueByName("sm_name");
//	alert(retCode+retMsg);
	if(retCode == "000000"){
	
		document.all.post_address.value = post_address;
		document.all.post_zip.value = post_zip;
		if(fax_no=="000000")
		{
			document.all.fax_no.value="";
		}else{
		  document.all.fax_no.value = fax_no;
		}
		document.all.mail_address.value = mail_address;
		document.all.post_name.value = post_name;
		document.all.cust_name.value = cust_name;
		document.all.id_iccid.value = id_iccid;
		document.all.id_address.value = id_address;
		document.all.sm_name.value = sm_name;
		document.all.confirm.disabled=false;
		
	}else
	{
		rdShowMessageDialog("����:"+ retCode + "->" + retMsg,0);
		return;
	}    
    
}

//-------2---------��֤���ύ����-----------------

function printCommit(){
	getAfterPrompt();
   if( document.all.r_cus[3].checked)
   {
   	rdShowMessageDialog("��ѯ����ȷ���ύ",0);
		return;
   }
	//У��
    if(!checkElement(document.s1448.phoneno)) return false;	
	if(!check(s1448)) return false;
   //��ӡ�������ύ��
   document.all.t_sys_remark.value="�û�"  + document.all.phoneno.value + "�ʼ��ʵ�";
    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");

     if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
        {  
	      ��s1448.submit();
        }


	    if(ret=="remark")
	    {
         if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
         {
	       s1448.submit();
         }
	   }
	}
    else
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
       {
	     s1448.submit();
       }
    }	
    return true;
  }
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի��� 
     var h=150;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=paraStr%>;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = document.all.phoneno.value;                            //�ͻ��绰
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	 var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	 var ret=window.showModalDialog(path,printStr,prop);   
		
		
  }

  function printInfo(printType)
  {
   	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		

    cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
    cust_info+="�ֻ����룺"+document.all.phoneno.value+"|";  
	  cust_info+="�ͻ���ַ��"+document.all.id_address.value+"|";
    cust_info+="֤�����룺"+document.all.id_iccid.value+"|";
	if(document.all.postFlag.value == "0")
	{
		opr_info+="�ʼķ�ʽ�� �ʼ�"+"|";
	}else if (document.all.postFlag.value == "0")
	{
		opr_info+="�ʼķ�ʽ�� ����"+"|";
	}
	else
	{
		opr_info+="�ʼķ�ʽ�� �����ʼ�"+"|";
	}
    opr_info+="�û�Ʒ�ƣ�"+document.all.sm_name.value+"|";
    if(document.all.r_cus[0].checked)
	{
      opr_info+="����ҵ��"+"����"+"|";
	}
	if(document.all.r_cus[1].checked)
	{
      opr_info+="����ҵ��"+"�޸�"+"|";
	}
	if(document.all.r_cus[2].checked)
	{
      opr_info+="����ҵ��"+"ɾ��"+"|";
	}
	if(document.all.r_cus[3].checked)
	{
      opr_info+="����ҵ��"+"��ѯ"+"|";
	}
		opr_info+="������ˮ��"+document.all.loginAccept.value+"|";
    opr_info+="�ʱࣺ"+document.all.post_zip.value+"|";
    opr_info+="�ʼĵ�ַ��"+document.all.post_address.value+"|";
    
    note_info1+="��ע��"+document.all.t_sys_remark.value+"|";
    note_info2+="��ע��"+document.all.t_op_remark.value+" "+document.all.simBell.value+"|";
      
  	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

    return retInfo;
  }

 //-->
</script>

<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
//String prtSql="select to_char(sMaxSysAccept.nextval) from dual";

%>



</head>
<script language=javascript>
function showWorldMsg()
{
		
     if( document.all.r_cus[0].checked){}
}
</script>
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<form action="1448BackCfm.jsp" method="POST" name="s1448"  onKeyUp="chgFocus(s1448)">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">�ʼ��ʵ�</div>
	</div>
	<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	<input type="hidden" name="id_iccid"  value="">
	<input type="hidden" name="id_address"  value="">
	<input type="hidden" name="sm_name"  value="">
	<input type="hidden" name="flag" id="flag" value="">
	
	<input type="hidden" name="loginAccept" value="<%=paraStr%>">
	<%@ include file="../../include/remark.htm" %>
        <table cellspacing="0" >
          <tr> 
            <td class="blue" nowrap height=10>��������</td>
            <td class="blue" nowrap colspan="3" height=10>
            <input type="radio" name="r_cus" index="0" value="0" checked class="blue">�Ǽ�
  					<input type="radio" name="r_cus"  index="1" value="1" class="blue">�޸�
  					<input type="radio" name="r_cus" index= "2" value="2" class="blue">ɾ��
  					<input type="radio" name="r_cus" index="3" value="-1" class="blue">��ѯ
            </td>
          </tr>
          <tr> 
            <td nowrap width="16%" class="blue">�û�����</td>
            <td nowrap> 
  <%
  		String ph_no=request.getParameter("ph_no");
  %>          	
              <input   type="text" name="phoneno" v_name="�û�����" v_must=1  v_type="mobphone" onBlur="if(this.value!=''){if(checkElement('phoneno')==false){return false;}}" maxlength=11  index="6" value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly >              
            </td>
            <td class="blue">�û�����</td>
          	<td>
          	<jsp:include page="/npage/common/pwd_one.jsp">
							      <jsp:param name="width1" value="16%"  />
							      <jsp:param name="width2" value="34%"  />
							      <jsp:param name="pname" value="cus_pass"  />
							      <jsp:param name="pwd" value="12345"  />
	 	  			</jsp:include>
            <input  type="button" name="qryId_No" value="��ѯ" onClick="simChk()" class="b_text">
            </td>
          </tr>
          <tr> 
            <td nowrap width="16%" class="blue">�û�����</td>
            <td  nowrap width="28%"> 
              <div align="left"> 
                <input name="cust_name" type="text"   v_name="�û�����" index="6" >
            </td>
            <td  nowrap width="16%" class="blue">�ʼķ�ʽ</td>
            <td  nowrap width="40%"> 
             <select name="postFlag"  index="15">
		 						<option value="1" selected >�ʼ�</option>
               <!-- <option value="2">�����ʼ�</option>
                <option value="3">����</option>
                -->
                </select>
            </td>
          </tr>
          <tr> 
            <td nowrap width="16%" class="blue">��������</td>
            <td  nowrap width="28%"> 
              <input type="text"  name="post_zip"  v_minlength=0 v_maxlength=10  v_type=zip  v_name="��������" maxlength=10 value="" tabindex="0">
            </td>
            <td  nowrap width="16%" class="blue">ͨ�ŵ�ַ</td>
            <td  nowrap width="40%"> 
             <input type="text"  name="post_address" maxlength=60 v_must=0 v_minlength=0 v_type=string v_name = "ͨ�ŵ�ַ" value="" tabindex="0">
            </td>
          </tr>
          <tr> 
            <td nowrap height=10 class="blue">��������</td>
             <td nowrap colspan="3" height=10>
              <input  type="test" name="post_name" v_must=0 v_name="��������"  v_type=string v_minlength=0 value="">
             </td>
          </tr>
          <tr> 
            <td nowrap width="16%" class="blue">E_mailַ</td>
            <td  nowrap  width="28%"> 
              <input  type="text" name="mail_address" value="" >
            </td>
            <td  nowrap width="16%" class="blue">��    ��</td>
            <td  nowrap width="40%"> 
            <input  type="text" name="fax_no"  v_must=0 v_maxlength=30 v_minlength=0 v_type=phone v_name="����" value="" tabindex="0">
            </td>
          </tr>
          
          <tr bgcolor="eeeeee"> 
            <td valign="top"> 
              <div align="left" class="blue">��ע</div>
            </td>
            <td colspan="4" valign="top"> 
            	
              <input type="text"  name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30  Class="InputGrey">
            </td>
          <tr bgcolor="e8e8e8"> 
            <td colspan="4" height="30" id="footer"> 
              <div align="center"> 
                <input  type="button" name="confirm" id="comSubmit" value="��ӡ&ȷ��"  onClick="printCommit()" index="26" disabled class="b_foot_long">
                <input  type=reset name=back value="���" onClick="document.all.confirm.disabled=true;"  class="b_foot">
                <input  type="button" name="b_back" value="����"  onClick="removeCurrentTab()" index="28" class="b_foot">
              </div>
            </td>
          </tr>
        </table>

  <%@ include file="/npage/include/footer.jsp" %>
  <input type="hidden"  name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  v_name="�û���ע" index="28" maxlength=60> 
</form>
</body>


</html>
