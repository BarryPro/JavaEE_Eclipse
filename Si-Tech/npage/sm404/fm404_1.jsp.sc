<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-9-14 10:29:46------------------
 �������롰 �ƶ�����ͨ����Ʒ����ר���Ŀ����մ�������ĺ���9��19-9��30��
 
 
 -------------------------��̨��Ա��xiahk--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%> 
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
<%	
	String custName = "";
	String pp_name  = "";
	String id_type  = "";
	String id_name  = "";
	String id_iccid = "";
	
	/*
          ��ѯ�ͻ���Ϣ��������
  */
   String paraAray[] = new String[9];
   paraAray[0]=loginAccept;
   paraAray[1]="01";
   paraAray[2]=opCode;
   paraAray[3]=workNo;
   paraAray[4]=password;
   paraAray[5]=activePhone;
   paraAray[6]="";
   paraAray[7]="";
   paraAray[8]="ͨ��phoneNo[" + activePhone + "]��ѯ�ͻ���Ϣ";
%>


	
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="80" >
      <wtc:param value="<%=paraAray[0]%>"/>
      <wtc:param value="<%=paraAray[1]%>"/>
      <wtc:param value="<%=paraAray[2]%>"/>
      <wtc:param value="<%=paraAray[3]%>"/>
      <wtc:param value="<%=paraAray[4]%>"/>
      <wtc:param value="<%=paraAray[5]%>"/>
      <wtc:param value="<%=paraAray[6]%>"/>
      <wtc:param value="<%=paraAray[7]%>"/>
      <wtc:param value="<%=paraAray[8]%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
<wtc:array id="result_t2" scope="end" />

<%

	for(int iii=0;iii<result_t2.length;iii++){
		for(int jjj=0;jjj<result_t2[iii].length;jjj++){
			System.out.println("--------hejwa-------------result_t2["+iii+"]["+jjj+"]=-----------------"+result_t2[iii][jjj]);
		}
	}

String custBrandName = "";
        if("000000".equals(retCode2)){
                if(result_t2.length>0){
                        custName = result_t2[0][5];
                        pp_name  = result_t2[0][38];
                        id_type  = result_t2[0][12];
                        id_iccid = result_t2[0][13];
                        
                  if (pp_name.equals("gn")) {
										custBrandName = "ȫ��ͨ";
									} else if (pp_name.equals("zn")) {
										custBrandName = "������";
									} else if (pp_name.equals("dn")) {
										custBrandName = "���еش�";
									} 
									
									
										if("0".equals(id_type)) {
											id_name="���֤";
									  }else if("1".equals(id_type)) {
									  	id_name="����֤";
									 	}else if("2".equals(id_type)) {
									 		id_name="���ڲ�";
									 	}else if("3".equals(id_type)) {
									 		id_name="�۰�ͨ��֤";
									 	}else if("4".equals(id_type)) {
									 		id_name="����֤";
									 	}else if("5".equals(id_type)) {
									 		id_name="̨��ͨ��֤";
									 	}else if("6".equals(id_type)) {
									 		id_name="���������";
									 	}else if("7".equals(id_type)) {
									 		id_name="����";
									 	}else if("8".equals(id_type)) {
									 		id_name="Ӫҵִ��";
									 	}else if("9".equals(id_type)) {
									 		id_name="����";
									 	}else if("A".equals(id_type)) {
									 		id_name="��֯��������";
									 	}else if("B".equals(id_type)) {
									 		id_name="��λ����֤��";
									 	}else if("C".equals(id_type)) {
									 		id_name="��λ֤��";
									 	}else if("00".equals(id_type)) {
									 		id_name="���֤";
									 	}
                }
        }else{
%>
                <script language="JavaScript">
                        rdShowMessageDialog("���û����������û���״̬��������");
                        removeCurrentTab();
                </script>
<%              
        }
%>     	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}


function go_cfm(){
	
	  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	  show_SJ_Prt();
	  
	 	if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
	 	
	  var packet = new AJAXPacket("fm404_Cfm.jsp","���Ժ�...");
	      packet.data.add("opCode","<%=opCode%>");//
	      packet.data.add("opName","<%=opName%>");//
	      
	      packet.data.add("custName","<%=custName%>");//
	      packet.data.add("phoneNo","<%=activePhone%>");//
	      packet.data.add("loginAccept","<%=loginAccept%>");//
	      packet.data.add("nfc_fee","20");//
	  core.ajax.sendPacket(packet,do_cfm);
	  packet =null;
}

function do_cfm(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//�����ɹ�
    	rdShowMessageDialog("�����ɹ�",2);
    	reSetThis();
    }
} 

function showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	  var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	  var sysAccept =<%=loginAccept%>;             	//��ˮ��
	  var printStr = printInfo(printType);
	  
		                      //����printinfo()���صĴ�ӡ����
	  var mode_code=null;           							  //�ʷѴ���
	  var fav_code=null;                				 		//�ط�����
	  var area_code=null;             				 		  //С������
	  var opCode="<%=opCode%>" ;                   			 	//��������
	  var phoneNo="<%=activePhone%>";                  //�ͻ��绰
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode=<%=opCode%>&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				
    
//��ӡģ��idΪ��122
function printInfo(printType){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
	  cust_info+="�ͻ�������   "+"<%=custName%>"+"|";
	  
	  opr_info +="�����ͣ�NFC����ͨ��    ����ҵ�񣺳���ͨ�������շ�" +"|";
	  opr_info +="������ˮ: "+"<%=loginAccept%>    ����ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' +"|";
	  opr_info +="���չ����ѣ�20Ԫ"+"|";
	  
	  note_info1 += "�����ں�20Ԫ�������ѣ����ںͰ��ͻ��˿�ͨ�ƶ�����ͨ���ܲ�����ʵ���󶨺󷽿�ʹ�á�"+"|";
	  
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}



//��ӡ�վ�
function show_SJ_Prt(){
 	     
	  	var  billArgsObj = new Object();

			$(billArgsObj).attr("10001","<%=workNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005","<%=custName%>");   //�ͻ�����
			$(billArgsObj).attr("10006","NFC����ͨ��");    //ҵ�����
			$(billArgsObj).attr("10008","<%=activePhone%>");    //�û�����
			$(billArgsObj).attr("10015","20");   //���η�Ʊ���
			$(billArgsObj).attr("10016","20");   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
			$(billArgsObj).attr("10030","<%=loginAccept%>");   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opCode%>");   //��������
	    $(billArgsObj).attr("10071","6");	//ģ��
 			$(billArgsObj).attr("10078", "<%=custBrandName%>"); //���Ʒ��	
 			$(billArgsObj).attr("10083", "<%=id_name%>"); //֤������
 			$(billArgsObj).attr("10084", "<%=id_iccid%>"); //֤������
 			$(billArgsObj).attr("10085", "zsj"); //���������ȡ��ʽ ֻ������ӡ�վݵĿ�
 			$(billArgsObj).attr("10086", "�𾴵��û���������Ҫ���߹�����20Ԫ���շѷ�Ʊ����Я���ѿ�ͨ�ƶ�����ͨ���ܲ�ʵ���ư󶨵�SIM��Ƭ�ڿ���30����������ָͨ��������ȡ��Ʊ��������Ϣ�ɹ�ע����ͨ΢��ƽ̨(hrbcst)��ѯ���ͷ��绰��95105188��"); //��ע
 			
 			$(billArgsObj).attr("10072","0"); //�Ʒ�xuxzҪ��д��
 			//$(billArgsObj).attr("10088","m404"); //�վ�ģ��
 			
 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			
			var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
			
			var path = path +"&loginAccept=<%=loginAccept%>&opCode=m404&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
			
}


</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">�ֻ�����</td>
		  <td width="35%">
			    <%=activePhone%>
		  </td>
		  <td class="blue" width="15%">�ͻ�����</td>
		  <td width="35%">
			    <%=custName%>
		  </td>
		  
	</tr>
	<tr>
	    <td class="blue" width="15%">NFC����ͨ���շ�</td>
		  <td colspan="3">
			    20��Ԫ��
		  </td>
	</tr>
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="go_cfm()"           />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>