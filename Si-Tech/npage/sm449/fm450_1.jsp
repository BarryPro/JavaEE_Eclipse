<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)[2017/2/7 15:46:09]------------------
 �����·����ӻ��мۿ�ҵ��ȫ�����췽�������߼ƻ���֪ͨ
 
 -------------------------��̨��Ա��[liyang]--------------------------------------------
 
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
  String regionCode = (String)session.getAttribute("regCode");

	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
	
%> 
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
<%	
	String custName = "";
	String pp_name  = "";
	String id_type  = "";
	String id_iccid = "";
	
	/*
          ��ѯ�ͻ���Ϣ��������
  */
   String paraAray[] = new String[9];
   paraAray[0] = loginAccept;
   paraAray[1] = "01";
   paraAray[2] = opCode;
   paraAray[3] = workNo;
   paraAray[4] = password;
   paraAray[5] = activePhone;
   paraAray[6] = "";
   paraAray[7] = "";
   paraAray[8] = "ͨ��phoneNo[" + activePhone + "]��ѯ�ͻ���Ϣ";
%>


	
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="40" >
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


function go_Cfm(){
 
		var sel_val = $("#sel_ReSellType").val();
		if("1"==sel_val){
			if($("#ipt_OriTransactionID").val().trim()==""){
				rdShowMessageDialog("������ԭ������ˮ��");
				return;
			}
		}
		
		if("2"==sel_val){
			if($("#ipt_CardNo").val().trim()==""){
				rdShowMessageDialog("��������ӿ�����");
				return;
			}
		}
		
	  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	  show_bill_Prt();
	  
	 	if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
}

//��ӡ�վ�
function show_bill_Prt(){
 	     
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
 			$(billArgsObj).attr("10078", ""); //���Ʒ��	
 			$(billArgsObj).attr("10083", ""); //֤������
 			$(billArgsObj).attr("10084", ""); //֤������
 			$(billArgsObj).attr("10085", "zsj"); //���������ȡ��ʽ ֻ������ӡ�վݵĿ�
 			$(billArgsObj).attr("10086", "�𾴵��û���������Ҫ���߹�����20Ԫ���շѷ�Ʊ����Я���ѿ�ͨ�ƶ�����ͨ���ܲ�ʵ���ư󶨵�SIM��Ƭ�ڿ���30����������ָͨ��������ȡ��Ʊ��������Ϣ�ɹ�ע����ͨ΢��ƽ̨(hrbcst)��ѯ���ͷ��绰��95105188��"); //��ע
 			
 			$(billArgsObj).attr("10072","0"); //�Ʒ�xuxzҪ��д��

 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			
			$(billArgsObj).attr("11213","REC");  //�°淢Ʊ����Ʊ�ݱ�־λ��Ĭ�Ͽ�λ��Ʊ REC = �վ�
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
			
			var path = path +"&loginAccept=<%=loginAccept%>&opCode=<%=opCode%>&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
			
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
//��ӡģ��idΪ��
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
	  opr_info +="ҵ�����ͣ��ն��ͺ������ײͰ���    ������ˮ: "+"<%=loginAccept%>" +"|";
	  opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   " + "�û�Ʒ�ƣ�" + $('#band_ids').text()+ "|";
	  opr_info += "���������ѡ�ײͣ�"+$('#offerIdSel').find('option:selected').text()+"|";
	  opr_info += "IMEI��:"+$("#imeino").val()+"|";
	  opr_info += "�ʷ�������"+ $('#offercomments').text()+"|";
	  
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}


function set_show_tr(){
	var sel_val = $("#sel_ReSellType").val();
	if("1"==sel_val){
		$("#tr_OriTransactionID").show();
		$("#tr_CardNo").hide();
	}
	
	if("2"==sel_val){
		$("#tr_OriTransactionID").hide();
		$("#tr_CardNo").show();
	}
	
}

$(document).ready(function (){
	set_show_tr();
});
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
		  <td>
		  	<%=custName%>
		  </td>
	</tr>
		
	<tr>
	    <td class="blue" width="15%">��������</td>
		  <td width="35%" colspan="3">
		  	<select id="sel_ReSellType" name="sel_ReSellType" onchange="set_show_tr()" >
				    <option value="1">����ˮ����</option>
				    <option value="2">�����ŷ���</option>
				</select>
		  </td>
		 
	</tr>
	<tr id="tr_OriTransactionID">
	    <td class="blue">ԭ������ˮ��</td>
		  <td colspan="3">
					<input type="text" id="ipt_OriTransactionID" name="ipt_OriTransactionID"  />			    
		  </td>
	</tr>
	
	<tr id="tr_CardNo">
	    <td class="blue">���ӿ�����</td>
		  <td colspan="3">
					<input type="text" id="ipt_CardNo" name="ipt_CardNo"   />			    
		  </td>
	</tr>
	
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>