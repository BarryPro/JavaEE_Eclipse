<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-3-4 15:52:06------------------
 

 -------------------------��̨��Ա��wangzc��zuolf--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode        = WtcUtil.repNull(request.getParameter("opCode"));
  String opName        = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");

	java.util.Calendar cal = java.util.Calendar.getInstance(); 
	String currentDate = "";
	
	String param = "select to_char(sysdate,'yyyyMMdd HH24:mi:ss') as currentDate from dual";
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=param%>" />
	</wtc:service>
	<wtc:array id="result_currentDate" scope="end"   />

<%	
	if(result_currentDate.length>0){
		currentDate = result_currentDate[0][0];
	}
	System.out.println("--hejwa------fm358_1.jsp----AAAAAAAAAAA-----Currentdate--AAAAAAAAAAA----------->"+currentDate);
	
	
	cal.add(Calendar.MONTH, 1); 
	cal.set(Calendar.DATE, 1); 
	String n_month_Date = new java.text.SimpleDateFormat("yyyyMMdd 00:00:00").format(new java.util.Date(cal.getTimeInMillis()));

	
	
	String paraAray[] = new String[9];
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = activePhone;                              //�û�����
	paraAray[6] = "";       
	paraAray[7] = "";  
	paraAray[8] = "";  
	
%> 
		
  <wtc:service name="sm357Check" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />	
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />					
		<wtc:param value="<%=paraAray[8]%>" />			
	</wtc:service>
	<wtc:array id="result_t2" scope="end"  />
		
<%
	String vChkFlag = "";
	String phoneNo_207 = "";
	/*@outparam			vChkFlag	        ��֤��� Y/N N:��Ҫ������ͥ��ϵ*/
	if("000000".equals(code)){
		
		if(result_t2.length>0){
			vChkFlag    = result_t2[0][0];
			phoneNo_207 = result_t2[0][1];
		}
		
		if("N".equals(vChkFlag)){
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("���û�δ������ͥ���뵽m357���д���");
	removeCurrentTab();
</SCRIPT>	
<%		
		}
	}else{
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("sm357CheckУ�����<%=code%>��<%=msg%>");
	removeCurrentTab();
</SCRIPT>
<%		
	}
	
	
	String paraAray1[] = new String[8];
	
	paraAray1[0] = "";                                       //��ˮ
	paraAray1[1] = "01";                                     //��������
	paraAray1[2] = opCode;                                   //��������
	paraAray1[3] = (String)session.getAttribute("workNo");   //����
	paraAray1[4] = (String)session.getAttribute("password"); //��������
	paraAray1[5] = activePhone;                            //�û�����
	paraAray1[6] = "";       
	paraAray1[7] = "3";    
	
%> 
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
		
  <wtc:service name="sm357Qry" outnum="12" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray1[0]%>" />
		<wtc:param value="<%=paraAray1[1]%>" />	
		<wtc:param value="<%=paraAray1[2]%>" />
		<wtc:param value="<%=paraAray1[3]%>" />
		<wtc:param value="<%=paraAray1[4]%>" />
		<wtc:param value="<%=paraAray1[5]%>" />
		<wtc:param value="<%=paraAray1[6]%>" />
		<wtc:param value="<%=paraAray1[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t2" scope="end"  />
		
<%




	String j_ProdCode = "";
	String j_ProdName = "";
	String j_GearCode = "";
	String j_GearName = "";
	String j_group_id = "";
	
	String j_offer_flag = "";
	String sp_type = "";
	
	if("000000".equals(code)){
		if(result_t2.length>0){
			j_ProdCode = result_t2[0][1];
			j_ProdName = result_t2[0][0];
			j_GearCode = result_t2[0][3];
			j_GearName = result_t2[0][2];
			j_group_id = result_t2[0][4];
			j_offer_flag = result_t2[0][5];
			sp_type = result_t2[0][11];
		}
	}else if("m35899".equals(code)){
		System.out.println("----------1-----2----m358a--2--1------->");
%>
<SCRIPT language=JavaScript>
		var path = "/npage/sm359/fm359_5.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhoneNo=<%=activePhone%>";
		location = path;		
</SCRIPT>			
<%	
	}else{
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("sm357Qry����<%=code%>��<%=msg%>");
	removeCurrentTab();
</SCRIPT>
<%}

	//��ѯ����ӽ�ɫ
	String paraAray2[] = new String[11];
	paraAray2[0] = "";                                       //��ˮ
	paraAray2[1] = "01";                                     //��������
	paraAray2[2] = opCode;                                   //��������
	paraAray2[3] = (String)session.getAttribute("workNo");   //����
	paraAray2[4] = (String)session.getAttribute("password"); //��������
	paraAray2[5] = activePhone;                            //�û�����
	paraAray2[6] = "";       
	paraAray2[7] = "4";    	
	paraAray2[8] = j_ProdCode;    	
	paraAray2[9] = j_GearCode;    	
	paraAray2[10] = j_group_id;    	

%>


  <wtc:service name="sm357Qry" outnum="9" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray2[0]%>" />
		<wtc:param value="<%=paraAray2[1]%>" />	
		<wtc:param value="<%=paraAray2[2]%>" />
		<wtc:param value="<%=paraAray2[3]%>" />
		<wtc:param value="<%=paraAray2[4]%>" />
		<wtc:param value="<%=paraAray2[5]%>" />
		<wtc:param value="<%=paraAray2[6]%>" />
		<wtc:param value="<%=paraAray2[7]%>" />	
		<wtc:param value="<%=paraAray2[8]%>" />	
		<wtc:param value="<%=paraAray2[9]%>" />	
		<wtc:param value="<%=paraAray2[10]%>" />				
	</wtc:service>
	<wtc:array id="result_t3" scope="end"  />
		
<%
	//���ݵ�λ�����ѯ�ʷ�
		 String paraAray3[] = new String[8];
						paraAray3[0] = "";                                       //��ˮ
						paraAray3[1] = "01";                                     //��������
						paraAray3[2] = opCode;                                   //��������
						paraAray3[3] = (String)session.getAttribute("workNo");   //����
						paraAray3[4] = (String)session.getAttribute("password"); //��������
						paraAray3[5] = activePhone;                            //�û�����
						paraAray3[6] = "";       
						paraAray3[7] = j_GearCode;    	
%>
  <wtc:service name="sm358Qry" outnum="20" retmsg="msg_sm358Qry" retcode="code_sm358Qry" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray3[0]%>" />
		<wtc:param value="<%=paraAray3[1]%>" />	
		<wtc:param value="<%=paraAray3[2]%>" />
		<wtc:param value="<%=paraAray3[3]%>" />
		<wtc:param value="<%=paraAray3[4]%>" />
		<wtc:param value="<%=paraAray3[5]%>" />
		<wtc:param value="<%=paraAray3[6]%>" />
		<wtc:param value="<%=paraAray3[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t4" scope="end"  />

<%


if(!"000000".equals(code_sm358Qry)){
%>

<SCRIPT language=JavaScript>
	rdShowMessageDialog("sm358Qry����<%=code_sm358Qry%>��<%=msg_sm358Qry%>");
	removeCurrentTab();
</SCRIPT>
<%
}
%>

<%
String outEffectType_id   = "";
String outEffectType_name = "";

//��ѯ��Ч��ʽ
//0   ����ʽЧ         	outEffectType    0 ������Ч 2ԤԼ��Ч

		 String paraAray4[] = new String[8];
						paraAray4[0] = "";                                       //��ˮ
						paraAray4[1] = "01";                                     //��������
						paraAray4[2] = opCode;                                   //��������
						paraAray4[3] = (String)session.getAttribute("workNo");   //����
						paraAray4[4] = (String)session.getAttribute("password"); //��������
						paraAray4[5] = activePhone;                            //�û�����
						paraAray4[6] = "";       
						paraAray4[7] = j_GearCode;    
						
						for(int hi=0;hi<paraAray4.length;hi++){
							System.out.println("-------hejwa--------------paraAray4["+hi+"]----------->"+paraAray4[hi]);
						}
%>
  <wtc:service name="sm358EffType" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray3[0]%>" />
		<wtc:param value="<%=paraAray3[1]%>" />	
		<wtc:param value="<%=paraAray3[2]%>" />
		<wtc:param value="<%=paraAray3[3]%>" />
		<wtc:param value="<%=paraAray3[4]%>" />
		<wtc:param value="<%=paraAray3[5]%>" />
		<wtc:param value="<%=paraAray3[6]%>" />
		<wtc:param value="<%=paraAray3[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t5" scope="end"  />

<%

	for(int iii=0;iii<result_t5.length;iii++){
		for(int jjj=0;jjj<result_t5[iii].length;jjj++){
			System.out.println("---------------------result_t5["+iii+"]["+jjj+"]=-----------------"+result_t5[iii][jjj]);
		}
	}
	
		
	if(result_t5.length>0){
		outEffectType_id   = result_t5[0][0];
		outEffectType_name = result_t5[0][1];
	}
	if(outEffectType_id==null||"null".equalsIgnoreCase(outEffectType_id)){
		outEffectType_id = "";
	}
	
	
		 String paraAray5[] = new String[8];
						paraAray5[0] = "";                                       //��ˮ
						paraAray5[1] = "01";                                     //��������
						paraAray5[2] = opCode;                                   //��������
						paraAray5[3] = (String)session.getAttribute("workNo");   //����
						paraAray5[4] = (String)session.getAttribute("password"); //��������
						paraAray5[5] = activePhone;                            //�û�����
						paraAray5[6] = "";       
						paraAray5[7] = j_GearCode;    
						
		String outMonthFee = "";						
		String outMonthNum = "";
%>

  <wtc:service name="sm358FeeQry" outnum="2" retmsg="msg_sm358FeeQry" retcode="code_sm358FeeQry" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray5[0]%>" />
		<wtc:param value="<%=paraAray5[1]%>" />	
		<wtc:param value="<%=paraAray5[2]%>" />
		<wtc:param value="<%=paraAray5[3]%>" />
		<wtc:param value="<%=paraAray5[4]%>" />
		<wtc:param value="<%=paraAray5[5]%>" />
		<wtc:param value="<%=paraAray5[6]%>" />
		<wtc:param value="<%=paraAray5[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t6" scope="end"  />
		
<%
	if(result_t6.length>0){
		outMonthFee = result_t6[0][0];
		outMonthNum = result_t6[0][1];
	}
%>
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>	
<SCRIPT language=JavaScript>
var returnValue="<%=sp_type%>";
var vChkFlag_j = "<%=vChkFlag%>";

var j_EFF_DATE = "";

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}

function check_offer(bt){
	var j_t_v_CodeValue     = $(bt).attr("v_CodeValue");
	var j_t_v_ClssName      = $(bt).attr("v_ClssName");
	var j_t_v_BPopedomCode  = $(bt).attr("v_BPopedomCode");
	
	
	var c_flag = false;
	var temp_v_OfferName = "";
	$("#offer_table").find("input[type='checkbox']").each(function(){
		var e_CodeValue     = $(this).attr("v_CodeValue");
		var e_BPopedomCode  = $(this).attr("v_BPopedomCode");
		
		if($(this).is(":checked")&&j_t_v_CodeValue==e_CodeValue&&e_BPopedomCode!=j_t_v_BPopedomCode){//�˷�������ѡ�еģ������Լ�
			temp_v_OfferName = $(this).attr("v_OfferName");
			c_flag = true;
			return false;
		}
	});
	
	if(c_flag){
		rdShowMessageDialog(j_t_v_ClssName+"��������ѡ��"+temp_v_OfferName+"��");
		$(bt).removeAttr("checked");
	}
}

function show_offer_det(outClssName,offer_name,offer_desc,offer_sum){
	  var h     = 400;
    var w     = 880;
    var t     = screen.availHeight/2-h/2;
    var l     = screen.availWidth/2-w/2;
    var prop  = "dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var tpath = "fm358_2.jsp"+
    												"?outClssName="+outClssName+//
    												"&offer_name="+offer_name+//
    												"&offer_desc="+offer_desc+
    												"&offer_sum="+offer_sum+
    												"&opCode=<%=opCode%>"+
    												"&opName=<%=opName%>";
    var ret   = window.showModalDialog(tpath,"",prop);
}

function go_check_OfferSum(){
   var packet = new AJAXPacket("fm358_3.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("inPrePayFee",$("#span_OfferSum").text().trim());//
    core.ajax.sendPacket(packet,do_check_OfferSum);
    packet =null;
}
//��ѯ�ͻ�������Ϣ�ص�
function do_check_OfferSum(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
      rdShowMessageDialog("Ԥ��У��ɹ�",2);
      //$("#btn_check_OfferSum").attr("disabled","disabled");
    }else{//���÷���ʧ��
    	rdShowMessageDialog("Ԥ��У��ʧ�ܣ�"+error_code+"��"+error_msg,0);
    }
}

function add_OfferSum(bt){
	
	var t_offerSum = 0;
	$("#offer_table").find("input[type='radio']").each(function(){
		if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
			t_offerSum += parseInt($(this).attr("v_OfferSum"));
		}
	});
	
	$("#span_OfferSum").text(t_offerSum);
	//�����б仯��У�鰴ťȥ���û�
	//$("#btn_check_OfferSum").removeAttr("disabled");
}


function cen_radio_all(bt){
	$(bt).parent().parent().find("input[type='radio']").removeAttr("checked");
	
	if($(bt).parent().parent().find("td:eq(0)").text().trim()=="ħ�ٺ�"){
		$("tr[name='mobaihegroup']").hide();
	}
	
	add_OfferSum();//ˢ��Ԥ��
}


var in_JSONText="";
function go_cfm(){
	if("<%=outEffectType_id%>"==""){
		rdShowMessageDialog("δ��ѯ����Ч��ʽ");
		return;
	}

	if($("#sel_outEffectType").val()==""){
		rdShowMessageDialog("��ѡ����Ч��ʽ");
		return false;
	}
	var submitFlag=false;
	if(!$("tr[name='mobaihegroup']").is(":hidden")){
		if(!subFlag){
			rdShowMessageDialog("imeiУ��û��ͨ���������ύ!");
			submitFlag=true;
		}
		
	 
	}
	if(submitFlag){
		return false;
	}
	
	var t_flag     = false;
	var t_ClssName = "";
	$("#offer_table tr:gt(0)").each(function(){
		var t_OfferFlag = $(this).attr("v_OfferFlag");
		if("0"==t_OfferFlag){
			if($(this).find("input[type='radio']:checked").size()==0){
				t_flag     = true;
				t_ClssName = $(this).find("td:eq(0)").text().trim();
				return false;
			}
		}
	});
	
	
	if(t_flag){
		rdShowMessageDialog("����["+t_ClssName+"]����ѡ��һ���ʷ�");
		return;
	}
	
	t_flag = false;
	$("#offer_table tr:gt(0):visible").each(function(){
			var offer_name=$(this).find("td:eq(0)").text().trim();
		
			var U_v_B17_value = $(this).attr("v_B17_value");
			var U_v_H19_value = $(this).attr("v_H19_value");
			
			
			if(U_v_B17_value!="SS"){
				
				var U_v_E18_value = $(this).attr("v_E18_value");
				
				//alert("offer_name = "+offer_name+"\n"+"U_v_B17_value = "+U_v_B17_value+"\n"+"U_v_E18_value = "+U_v_E18_value+"\n"+"U_v_H19_value = "+U_v_H19_value+"\n");
				
				var D_i = 0;//ѡ���˼���
				//�������б�ѡ��ĵ�ѡ��
				$("#offer_table tr:gt(0)").each(function(){
					var D_v_B17_value = $(this).attr("v_B17_value");
					if(U_v_B17_value==D_v_B17_value){
						if($(this).find("input[type='radio']:checked").size()>0){
							D_i ++;
						}
					}
				});				
				
				//alert("D_i = "+D_i+"\nU_v_E18_value = "+U_v_E18_value);
				if(D_i!=parseInt(U_v_E18_value)){
					//alert(1);
					//rdShowMessageDialog(U_v_H19_value);
					//t_flag = true;
					//return false;
				}
			}
			
			
	});
	
	if(t_flag){
		return;
	}
	
	
	/*
	var is_check_inPrePayFee = $("#btn_check_OfferSum").is(":disabled");
	if(!is_check_inPrePayFee&& "<%=j_offer_flag%>"=="Y"){
		rdShowMessageDialog("����У��Ԥ��");
		return;
	}
	*/
	
	var j_FX_FEE = "";

	
	if("D014"=="<%=j_GearCode%>"){
		j_FX_FEE = "238";
	}
	if("D013"=="<%=j_GearCode%>"){
		j_FX_FEE = "158";
	}
	if("D012"=="<%=j_GearCode%>"){
		j_FX_FEE = "138";
	}	
	if("D011"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	if("D010"=="<%=j_GearCode%>"){
		j_FX_FEE = "58";
	}
	if("D021"=="<%=j_GearCode%>"){
		j_FX_FEE = "58";
	}
	
	
	if("D022"=="<%=j_GearCode%>"){
		j_FX_FEE = "68";
	}

	if("D023	"=="<%=j_GearCode%>"){
		j_FX_FEE = "58";
	}
	
	if("D024"=="<%=j_GearCode%>"){
		j_FX_FEE = "138";
	}
	
	
	if("D029"=="<%=j_GearCode%>"){
		j_FX_FEE = "38";
	}
	
	if("D030"=="<%=j_GearCode%>"){
		j_FX_FEE = "58";
	}
	
	if("D031"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	
	if("D040"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	
	if("D041"=="<%=j_GearCode%>"){
		j_FX_FEE = "38";
	}
	
	if("D042"=="<%=j_GearCode%>"){
		j_FX_FEE = "58";
	}
	
	if("D043"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	
	if("D044"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	
	if("D045"=="<%=j_GearCode%>"){
		j_FX_FEE = "38";
	}
	
	if("D046"=="<%=j_GearCode%>"){
		j_FX_FEE = "58";
	}
	
	if("D047"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	
	if("D048"=="<%=j_GearCode%>"){
		j_FX_FEE = "88";
	}
	
	
	
	
	
		var DEPOSIT_FEE = "";
		if(!$("tr[name='mobaihegroup']").is(":hidden")){
			if(typeof($("#mobaiheyajin").val())!="undefined"){
				DEPOSIT_FEE = $("#mobaiheyajin").val().trim();
			}
			
			if(is_show_mobaihe!="Y"){
				DEPOSIT_FEE = "0";
			}
		}
		
		var OPR_INFO_json = {
												"PHONE_NO":"<%=activePhone%>",
								        "OP_CODE": "<%=opCode%>",
								        "LOGIN_NO": "<%=workNo%>",
								        "LOGIN_ACCEPT": "<%=sysAcceptl%>",
								        "BACK_ACCEPT": "",
								        "OPR_TIME": "<%=currentDate%>",
								        "PROD_CODE":"<%=j_ProdCode%>",//��Ʒ����
        								"PROD_CODE_DW":"<%=j_GearCode%>",//��λ����
        								"OP_NOTE":"��ͥ��Ʒ����",//������ע
        								"GROUP_ID":"<%=j_group_id%>",
        								"FX_FEE":j_FX_FEE,
        								"SP_TYPE":returnValue,
        								"DEPOSIT_FEE":DEPOSIT_FEE
											};


		//����ӽ�ɫ����־λΪY��ƴһ����¼
		var PAY_INFO_json      = [];
		var BASELINE_INFO_json = [];
		
		$("#old_mem_table tr:gt(0)").each(function(){
			if($(this).find("td:eq(5)").text().trim()=="Y"){//�±�8�ı�־λ
				var t_PAY_INFO_json = {
									"OPERATE_TYPE": "I",
	                "MASTER_PHONE": "<%=activePhone%>",
	                "MEMBER_PHONE": $(this).find("td:eq(0)").text().trim(),
	                "EFF_DATE":j_EFF_DATE,
	                "EXP_DATE": $(this).find("td:eq(4)").text().trim()
				};
				PAY_INFO_json.push(t_PAY_INFO_json);
			}
			
			if($(this).find("td:eq(6)").text().trim()=="Y"){//�±�7�ı�־λ
				var t_BASELINE_INFO_json = {
					 			"OPERATE_TYPE": "1",
                "HOME_PHONE": "<%=phoneNo_207%>",
                "MASTER_PHONE": "<%=activePhone%>",
                "MEMBER_PHONE": $(this).find("td:eq(0)").text().trim(),
                "GROUP_ID": "<%=j_group_id%>",
                "EFF_DATE": j_EFF_DATE,
                "EXP_DATE": $(this).find("td:eq(4)").text().trim()
									 
				};
				BASELINE_INFO_json.push(t_BASELINE_INFO_json);
			}
		});
		
		
		var ADD_OFFER_LIST_json  = [];
		var MAIN_OFFER_LIST_json = [];
    var SP_OFFER_LIST_json   = [];
    
    var LOGINOPR_json = [];
		
		var temp_json = {"PHONE_NO":"<%=activePhone%>"};
    LOGINOPR_json.push(temp_json);
    
    
		var sp_offer_flag=false;
		$("#offer_table").find("input[type='radio']").each(function(){
			if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
				
				var t_v_CodeName = $(this).attr("v_CodeName");//ƴ�ڵ������
				
				var t_PHONE_NO = "";
				
				//һ����ɫ��ʶ�� �ý�ɫ��ʶȥ��������б����ҵ���Ӧ��ɫ�ĺ���
					var t_v_CodeId = $(this).attr("v_CodeId");
					$("#old_mem_table tr:gt(0)").each(function(){
						var e_role_code = $(this).find("td:eq(1)").text().trim();
						if(t_v_CodeId==e_role_code){
							t_PHONE_NO = $(this).find("td:eq(0)").text().trim();
							return false;
						}
					});
				
		 
				
				//3�����ͽڵ㣬��Ҫ�ж�
				if(t_v_CodeName=="ADD_OFFER_LIST"){
					var t_temp_json={
									"OPERATE_TYPE": "I",
	                "PHONE_NO": t_PHONE_NO,
	                "EFF_DATE": j_EFF_DATE,
	                "EXP_DATE": "20500101 00:00:00",
	                "OFFER_ID": $(this).attr("v_BPopedomCode")
					};
					
					ADD_OFFER_LIST_json.push(t_temp_json);
				}else if(t_v_CodeName=="MAIN_OFFER_LIST"){
					var t_temp_json={
	                "PHONE_NO": t_PHONE_NO,
	                "EFF_DATE": j_EFF_DATE,
	                "EXP_DATE": "20500101 00:00:00",
	                "OFFER_ID": $(this).attr("v_BPopedomCode")
					};
					if($(this).attr("v_CodeId")=="21098"){
						//alert($(this).attr("v_CodeId"));
						if("<%=j_ProdCode%>"=="JTFX"){
							go_showPrompt();
						}
					}
					
					MAIN_OFFER_LIST_json.push(t_temp_json);
				}else if(t_v_CodeName=="SP_OFFER_LIST"){
					var SPID=$("#sp_id").val().trim();
					var BIZCODE=$("#biz_code").val().trim();
					var STBID=$("#stb_id").val().trim();
					var CFM_LOGIN="";
					
					if("1"==J_count_result){
						SPID    = "";
						BIZCODE = "";
						STBID   = "";
    				}else{
    					if(!$("tr[name='mobaihegroup']").is(":hidden")){
							if(SPID==""){
								rdShowMessageDialog("��ѡ����ҵ����!");
								sp_offer_flag=true;
							}
							else if(BIZCODE==""){
								rdShowMessageDialog("��ѡ��ҵ�����!");
								sp_offer_flag=true;
							}
							else if(STBID==""||STBID.length<15){
								rdShowMessageDialog("IMEI�벻��Ϊ��,��λ15λ!");
								sp_offer_flag=true;
							}
						}
					}
					
					

					$("#old_mem_table").find("td[name='rolename']").each(function(i){
						if($(this).text()=="�����Ա"){
							CFM_LOGIN=$("#old_mem_table").find("td[name='phonenumber']").eq(i).text();
						}
					});
					var t_temp_json={
									 "OPERATE_TYPE": "I",//I�������� U�����˶�
		                "MEMBER_PHONE": t_PHONE_NO,//��Ա����
		                "MASTER_PHONE":"<%=activePhone%>",//�����˺���
		                "OFFER_ID": $(this).attr("v_BPopedomCode"),//�ʷѴ���
		                "EFF_DATE": j_EFF_DATE,
		                "EXP_DATE": "20500101 00:00:00",
		                "SPID":SPID,//��ҵ����
		                "BIZCODE":BIZCODE,//ҵ�����
		                "STBID":STBID,//������ID
		                "CFM_LOGIN":CFM_LOGIN//����˺�
					};					
					SP_OFFER_LIST_json.push(t_temp_json);
				}
				
				
			}
		});
		if(sp_offer_flag){
			return false;
		}
		
	 showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	 if(!$("tr[name='mobaihegroup']").is(":hidden")){
 		sm358_show_Bill_Prt();
 	}
   if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
    
    
		var BUSI_INFO_json={};
		BUSI_INFO_json = {
					"ADD_OFFER_LIST":ADD_OFFER_LIST_json,
					"PAY_INFO":PAY_INFO_json,
      		"FAM_INS_INFO":{
						"OPERATE_TYPE": "U",//��������  U�����޸�
						"GROUP_ID":"<%=j_group_id%>",//��ͥȺ��
						"STATE":"2",//Ĭ��2
						"PROD_EFF_DATE": j_EFF_DATE,//��Ʒ��Чʱ�� 
						"PROD_EXP_DATE": "20500101 00:00:00"//��ƷʧЧʱ��
					},
					"LOGINOPR":LOGINOPR_json
					
		};
		
		
		
		if(MAIN_OFFER_LIST_json.length>0){
			BUSI_INFO_json["MAIN_OFFER_LIST"]=MAIN_OFFER_LIST_json;
		}
		
		if(SP_OFFER_LIST_json!=""){
			BUSI_INFO_json["SP_OFFER_LIST"]=SP_OFFER_LIST_json;
		}
		if(BASELINE_INFO_json.length>0){
			BUSI_INFO_json["BASELINE_INFO"]=BASELINE_INFO_json;
		}
		if("<%=j_offer_flag%>"=="Y"){
			var temp_j_EFF_DATE = "";
			if(j_EFF_DATE.length>8){
				temp_j_EFF_DATE = j_EFF_DATE.substring(0,8);
			}
			BUSI_INFO_json["SPECIAL_FUND_INFO"]={
		    "OPERATE_TYPE": "I",//I����ר�� Uȡ��ר�� D����ר��
		    "SPECIAL_FUND_FEE": "<%=outMonthFee%>",//ר����
		    "EFF_DATE":temp_j_EFF_DATE ,//ר�ʼʱ��
		    "EXP_DATE": "20500101",//ר�����ʱ��
		    "SPECIAL_FUND_MONTHS":"<%=outMonthNum%>"
			};
		}
					
		var in_json_obj = {
												"OPR_INFO":OPR_INFO_json,
												"BUSI_INFO":BUSI_INFO_json
											};
											
		
		
	  //ƴ���json
		in_JSONText = JSON.stringify(in_json_obj,function(key,value){return value;});
		
		var packet = new AJAXPacket("fm358_4.jsp","���Ժ�...");
		packet.data.add("opCode","<%=opCode%>");// 
		packet.data.add("phoneNo","<%=activePhone%>");//�ֻ���
		packet.data.add("sysAcceptl","<%=sysAcceptl%>");//��ˮ
		packet.data.add("in_JSONText",in_JSONText);//
		core.ajax.sendPacket(packet,do_cfm);
		packet =null;
}
function do_cfm(packet){
	var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
   		rdShowMessageDialog("�����ɹ�",2);
      removeCurrentTab();
    }else{//���÷���ʧ��
    	rdShowMessageDialog(error_code+":"+error_msg);
	    return;
   }
}
var subFlag=false;

function go_stb_id(){
	if(!$("#jiaoyanButton").is(":disabled")){
		$("#jiaoyanButton").attr("disabled","disabled");
		$("#stb_id").attr("readonly","readonly");
		// readonly="readonly"
	}
	var packet = new AJAXPacket("fm358_6.jsp","���Ժ�...");
	packet.data.add("opCode","<%=opCode%>");// 
	packet.data.add("phoneNo","<%=activePhone%>");//�ֻ���
    packet.data.add("stb_id",$("#stb_id").val());//
    core.ajax.sendPacket(packet,do_stb_id);
    packet =null;
}

var is_show_mobaihe = "";

function do_stb_id(packet){
	subFlag=false;
	var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
    	subFlag=true;
    	returnValue=packet.data.findValueByName("returnValue");
    	is_show_mobaihe = packet.data.findValueByName("returnValue");
    	if(is_show_mobaihe=="Y"){
    		$("#td_mobaihe1").show();
    		$("#td_mobaihe2").show();
    	}else{
    		$("#td_mobaihe1").hide();
    		$("#td_mobaihe2").hide();
    	}
    	rdShowMessageDialog("IMEI��У��ɹ�!");
    }else{//���÷���ʧ��
    	subFlag = false;
    	rdShowMessageDialog(error_code+":"+error_msg);
    	if($("#jiaoyanButton").is(":disabled")){
    		$("#jiaoyanButton").attr("disabled","");
    		$("#stb_id").attr("readonly","");
    	}
	    return;
   }
}


function set_EFF_DATE(){
	
	if($("#sel_outEffectType").val()=="0"){//������Ч
		j_EFF_DATE = "<%=currentDate%>";
	}else if($("#sel_outEffectType").val()=="2"){//ԤԼ��Ч
		j_EFF_DATE = "<%=n_month_Date%>";
	}
}
var J_count_result = "";
$(document).ready(function(){
	$("#sel_outEffectType").val("<%=outEffectType_id%>");
	set_EFF_DATE();
	$("tr[name='mobaihegroup']").hide();
	
	$("input[type='radio']").click(function (){
		
		
		if($(this).parent().parent().find("td:eq(0)").text().trim()=="ħ�ٺ�"){
			go_check_DDSMPORDERMSG();
		}
		
	})
	

//�ҵ�����13λΪN����������Ĭ��ѡ��	
$("#offer_table input[type='radio'][v_is_show='N']").each(function(){
	$(this).attr("checked","checked");
	$(this).parent().parent().hide();
});
	
	
	var hit_tr_array = new Array();
	$("#offer_table tr:gt(0):visible").each(function(){
			var U_v_H19_value = $(this).attr("v_H19_value");
			var U_v_B17_value = $(this).attr("v_B17_value");
			
			if(U_v_B17_value!="SS"&&U_v_B17_value!=""){
				if(!re_check_arr(hit_tr_array,U_v_H19_value)){//У�����������Ƿ��Ѿ�����
					hit_tr_array.push(U_v_H19_value);
				}
			}
	});
	
	/*
	var tr_hit_html = "<tr><td colspan='4' align='left'><b>��ܰ��ʾ��<br>";
	for(var i=0;i<hit_tr_array.length;i++){
		tr_hit_html += hit_tr_array[i]+"<br>";
	}
	tr_hit_html += "</b></td></tr>"
	$("#offer_table_hit").append(tr_hit_html);
	*/
	
});

function re_check_arr(arr,val){
	var ret_B = false;
	for(var i=0;i<arr.length;i++){
		if(arr[i]==val){
			ret_B = true;
			break;
		}
	}
	return ret_B;
}
function go_check_DDSMPORDERMSG(){
		var packet = new AJAXPacket("fm358_5.jsp","���Ժ�...");
	      packet.data.add("phoneNo","<%=activePhone%>");//�ֻ���
    core.ajax.sendPacket(packet,do_check_DDSMPORDERMSG);
    packet =null;
}
function do_check_DDSMPORDERMSG(packet){
		var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg  =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
    	J_count_result = packet.data.findValueByName("count_result");//������Ϣ
    	if("1"==J_count_result){
    		if("<%=j_ProdCode%>"=="JTRH"){
    			rdShowMessageDialog("�û��Ѿ�����ħ�ٺͣ��������ٶ���");
    			$("input[type='radio']").click(function (){
						if($(this).attr("v_ClssName")=="ħ�ٺ�"){
							$(this).removeAttr("checked");
						}
					})
    		}
    		if("<%=j_ProdCode%>"=="JTDX"){
    		}
    		returnValue="N";
    	}else{
    		$("tr[name='mobaihegroup']").show();
    		subFlag = false;
				$("#jiaoyanButton").attr("disabled","");
				$("#stb_id").attr("readonly","");
				$("#stb_id").val("");
    		
    	}
    }
}

   function showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
      var h=180;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;		   	   
      var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
      var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
      var sysAccept =<%=sysAcceptl%>;             	//��ˮ��
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
    
    
    function printInfo(printType){
    	
    	
    	if("<%=j_ProdCode%>"=="JTRH"){
    		return printInfo_JTRH();
    	}else if("<%=j_ProdCode%>"=="JTDX"){
    		return printInfo_JTDX();
    	}else if("<%=j_ProdCode%>"=="JTHX"){
    		return printInfo_JTHX();
    	}else if("<%=j_ProdCode%>"=="JTFX"){
    		if("D025"=="<%=j_GearCode%>"||"D026"=="<%=j_GearCode%>"||"D027"=="<%=j_GearCode%>"){
    			return printInfo_JTFX_D();
    		}else if("D028"=="<%=j_GearCode%>"){
    			return printInfo_JTFX_D028();
    		}else{
    			return printInfo_JTFX();
    		}
    	}else if("<%=j_ProdCode%>"=="JTHB"){
    	
    		return printInfo_JTHB();
    	}else if("<%=j_ProdCode%>"=="JTHA"){
    	
    		return printInfo_JTHA();
    	}else if("<%=j_ProdCode%>"=="JTHC"){
    	
    		return printInfo_JTHC();
    	}else if("<%=j_ProdCode%>"=="JTCN"){
    	
    		return printInfo_JTCN();
    	}
    	
    	
    }

        
    function printInfo_JTCN(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      opr_info += "����ҵ�����ƣ���ͥC�ƻ�    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      
      note_info1 += "�ʷ�������"+"|";
	 



     
      if("<%=j_GearCode%>"=="D049"||
      	"<%=j_GearCode%>"=="D050"||
      	"<%=j_GearCode%>"=="D051"||
      	"<%=j_GearCode%>"=="D052"
      	){
      	
      	 note_info1 += "���Ѷ����й��ƶ���ͥC�ƻ��ײ���ͨ��������ײ���Ч�ڼ䣬";
      }else if(
      	"<%=j_GearCode%>"=="D053"||
      	"<%=j_GearCode%>"=="D054"||
      	"<%=j_GearCode%>"=="D055"||
      	"<%=j_GearCode%>"=="D056"
      	){
      	
      	 note_info1 += "���Ѷ����й��ƶ���ͥC�ƻ��ײ��Ҹ���ͥ�����ײ���Ч�ڼ䣬";
      }else if(
      	"<%=j_GearCode%>"=="D057"||
      	"<%=j_GearCode%>"=="D058"||
      	"<%=j_GearCode%>"=="D059"||
      	"<%=j_GearCode%>"=="D060"
      	){
      	
      	 note_info1 += "���Ѷ����й��ƶ���ͥC�ƻ��ײͺ�����ͥ�����ײ���Ч�ڼ䣬";
      }else{
      	
      	note_info1 += "���Ѷ����й��ƶ���ͥC�ƻ��ײͣ�";
      }
 
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"��";
					}
				}
			});      
			
			var fanhuanjuntan = "0";

			note_info1 += temp_note_info1;
			
			var suojiaonaStr="";
			if("D029"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���360Ԫ��";
			}
			else if("D030"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���240Ԫ��";
			}
			else if("D031"=="<%=j_GearCode%>"){
				
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
				
				$("#offer_table").find("input[type='radio']").each(function(){
					if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
						var t_v_BPopedomCode = $(this).attr("v_BPopedomCode");
						
						if(
							"51508"==t_v_BPopedomCode||
							"51509"==t_v_BPopedomCode||
							"51510"==t_v_BPopedomCode||
							"51511"==t_v_BPopedomCode||
							"51512"==t_v_BPopedomCode||
							"51513"==t_v_BPopedomCode||
							"51514"==t_v_BPopedomCode||
							"51515"==t_v_BPopedomCode||
							"51516"==t_v_BPopedomCode||
							"51517"==t_v_BPopedomCode||
							"51518"==t_v_BPopedomCode||
							"51519"==t_v_BPopedomCode||
							"51520"==t_v_BPopedomCode
						){
							suojiaonaStr="������Ԥ���0Ԫ";
							fanhuanjuntan = "1";
						}
					}
				});   
				
			}else if("D040"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
			}else if("D041"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���360Ԫ��";
			}else if("D042"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���240Ԫ��";
			}else if("D043"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
			}else if("D044"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
			}else if("D045"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���360Ԫ��";
			}else if("D046"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���240Ԫ��";
			}else if("D047"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
			}else if("D048"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
			}
			
			if("D049"=="<%=j_GearCode%>"||"D053"=="<%=j_GearCode%>"||"D057"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���360Ԫ��";
			}
			
			if("D050"=="<%=j_GearCode%>"||"D054"=="<%=j_GearCode%>"||"D058"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���240Ԫ��";
			}
			
			if("D051"=="<%=j_GearCode%>"||"D055"=="<%=j_GearCode%>"||"D059"=="<%=j_GearCode%>"||"D052"=="<%=j_GearCode%>"||"D056"=="<%=j_GearCode%>"||"D060"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
			}

			
			
			if("1"!=fanhuanjuntan){
				note_info1 += "���ʵ�ʿ���ʱ���Կ����װ����ɹ�Ϊ׼��"+suojiaonaStr+"һ���ڰ��¾�̯����������ʱ��Ϊÿ�³���"+"|";
    	}else{
				note_info1 += "���ʵ�ʿ���ʱ���Կ����װ����ɹ�Ϊ׼��"+suojiaonaStr+"|";
    		
    	}
		
		
			 
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){
					
					var offer_id_temp = $(this).attr("v_BPopedomCode");
					var j_EFF_DATE_fl = "<%=outEffectType_id%>";
					var j_EFF_DATE_de = "";
					
					
							if(j_EFF_DATE_fl=="0"){//������Ч
									j_EFF_DATE_de = "�ײ�24Сʱ����Ч";
							}else if(j_EFF_DATE_fl=="2"){//ԤԼ��Ч
									j_EFF_DATE_de = "�ײ�����1����Ч";
							}
							
						if("57572"==offer_id_temp){
							note_info1 += "���ѳɹ�����10Ԫ�����ܰ���"+j_EFF_DATE_de+"��ÿ�³�Ա�ɹ������ײ��ڵ������������ܼ�ͥ����ʡ���ƶ���������500�ף���Ա�䱾��ͨ�������Ż�500���ӣ��������Ӳ�����4����ͥ��Ա��2������ÿ����һ����10Ԫ���ܷѣ���"+"|";
						}
						
						if("52837"==offer_id_temp){
							note_info1 += "���ѳɹ�����IMS�̻�ҵ������10Ԫ/�£�����200�����л����л�0.1Ԫ/���ӣ���;0.15Ԫ/����,���ͥ��Ա�以����ѡ�"+"|";
						}
					 
				}
			});  	
			

		  note_info1 += "|";
		  
		  
      note_info2 += "��ע��|";
      
      note_info2 += "1�������ͥC�ƻ���һ���ڲ�����ȡ���ײ͡�|";
      note_info2 += "2�����ֻ�����״̬�쳣��ͬʱ��ͣ����������ܣ�״̬�ָ�ͬʱ��������������ܡ�|";
      note_info2 += "3�����ֻ�����״̬�쳣���ͥ��Աֹͣ���ܹ��������Żݺ����������Żݣ�״̬������ָ��Żݡ�|";
      note_info2 += "4����ͥ��Ʒȡ��ǰ�������԰���Ԥ������ͣ��ҵ��|";
      note_info2 += "5����ͥ��Ʒʹ���ڼ�ɸ�����Ҫ��������������λ�ײͣ��µ�λ��Ч��ʽΪԤԼ��Ч��|";
      note_info2 += "6��������ͥ��Ա������Ч��ɾ����ͥ��Ա������Ч��|";
      note_info2 += "7����Ч��һ�꣬�����������ߵ������Զ���ǩ��|";
      note_info2 += "8���û���������ɢ���˻�ħ�ٺ��ն�ʱ������ȡʣ��Ԥ���30%��ΪΥԼ���û���������ɢ�Ҳ��˻�ħ�ٺ��ն�ʱ������ȡʣ��Ԥ���100%��ΪΥԼ��|";


      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
    
    function printInfo_JTHA(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      opr_info += "����ҵ�����ƣ���ͥA�ƻ�    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      
      note_info1 += "�ʷ�������"+"|";
	 

	 
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){
					
					var offer_id_temp = $(this).attr("v_BPopedomCode");
					var j_EFF_DATE_fl = "<%=outEffectType_id%>";
					var j_EFF_DATE_de = "";
					
						if(j_EFF_DATE_fl=="0"){//������Ч
								j_EFF_DATE_de = "�ײ�24Сʱ����Ч";
						}else if(j_EFF_DATE_fl=="2"){//ԤԼ��Ч
								j_EFF_DATE_de = "�ײ�����1����Ч";
						}
							
						if("57572"==offer_id_temp){
							note_info1 += "���ѳɹ�����10Ԫ�����ܰ���"+j_EFF_DATE_de+"��ÿ�³�Ա�ɹ������ײ��ڵ������������ܼ�ͥ����ʡ���ƶ���������500�ף���Ա�䱾��ͨ�������Ż�500���ӣ��������Ӳ�����4����ͥ��Ա��2������ÿ����һ����10Ԫ���ܷѣ���"+"|";
						}
						
						if("52837"==offer_id_temp){
							note_info1 += "���ѳɹ�����IMS�̻�ҵ������10Ԫ/�£�����200�����л����л�0.1Ԫ/���ӣ���;0.15Ԫ/����,���ͥ��Ա�以����ѡ�"+"|";
						}
						
						if("57570"==offer_id_temp){
							note_info1 += "���ѳɹ�����10Ԫ1Gʡ���������Ͱ���"+j_EFF_DATE_de+"�����¿������Ӱ���10�Ρ� "+"|";
						}
					 
				}
			});  	
			

		  note_info1 += "|";
		  
		  
      note_info2 += "��ע��|";

      note_info2 += "1�����ֻ�����״̬�쳣���ͥ��Աֹͣ���ܹ��������Żݺ����������Żݣ�״̬������ָ��Żݡ�|";
      note_info2 += "2����ͥ��Ʒȡ��ǰ�������԰���Ԥ������ͣ��ҵ��|";
      note_info2 += "3����ǩԼ��ͥA�ײ͵Ŀͻ������뽵���������ʷѣ����ɢ��ͥ��|";
      note_info2 += "4��������ͥ��Ա������Ч��ɾ����ͥ��Ա������Ч��|";
      note_info2 += "5��10Ԫ1Gʡ�ڼ��Ͱ������ڰ������������10�Ρ�|";
      note_info2 += "6����Ч��һ�꣬�����������ߵ������Զ���ǩ��|";

      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }

    
    
    
        
    function printInfo_JTHB(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      opr_info += "����ҵ�����ƣ���ͥB�ƻ�    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      
      note_info1 += "�ʷ�������"+"|";
	 



     
      if("<%=j_GearCode%>"=="D029"||
      	"<%=j_GearCode%>"=="D030"||
      	"<%=j_GearCode%>"=="D031"||
      	"<%=j_GearCode%>"=="D040"
      	){
      	
      	 note_info1 += "���Ѷ����й��ƶ���ͥB�ƻ��ײ���ͨ��������ײ���Ч�ڼ䣬";
      }else if(
      	"<%=j_GearCode%>"=="D041"||
      	"<%=j_GearCode%>"=="D042"||
      	"<%=j_GearCode%>"=="D043"||
      	"<%=j_GearCode%>"=="D044"
      	){
      	
      	 note_info1 += "���Ѷ����й��ƶ���ͥB�ƻ��ײ��Ҹ���ͥ�����ײ���Ч�ڼ䣬";
      }else if(
      	"<%=j_GearCode%>"=="D045"||
      	"<%=j_GearCode%>"=="D046"||
      	"<%=j_GearCode%>"=="D047"||
      	"<%=j_GearCode%>"=="D048"
      	){
      	
      	 note_info1 += "���Ѷ����й��ƶ���ͥB�ƻ��ײͺ�����ͥ�����ײ���Ч�ڼ䣬";
      }else{
      	
      	note_info1 += "���Ѷ����й��ƶ���ͥB�ƻ��ײ��գ�";
      }
 
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"��";
					}
				}
			});      
			
			var fanhuanjuntan = "0";

			note_info1 += temp_note_info1;
			
			var suojiaonaStr="";
			if("D029"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���360Ԫ��";
			}
			else if("D030"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���240Ԫ��";
			}
			else if("D031"=="<%=j_GearCode%>"){
				
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
				
				$("#offer_table").find("input[type='radio']").each(function(){
					if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
						var t_v_BPopedomCode = $(this).attr("v_BPopedomCode");
						
						if(
							"51508"==t_v_BPopedomCode||
							"51509"==t_v_BPopedomCode||
							"51510"==t_v_BPopedomCode||
							"51511"==t_v_BPopedomCode||
							"51512"==t_v_BPopedomCode||
							"51513"==t_v_BPopedomCode||
							"51514"==t_v_BPopedomCode||
							"51515"==t_v_BPopedomCode||
							"51516"==t_v_BPopedomCode||
							"51517"==t_v_BPopedomCode||
							"51518"==t_v_BPopedomCode||
							"51519"==t_v_BPopedomCode||
							"51520"==t_v_BPopedomCode
						){
							suojiaonaStr="������Ԥ���0Ԫ";
							fanhuanjuntan = "1";
						}
					}
				});   
				
			}else if("D040"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
			}else if("D041"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���360Ԫ��";
			}else if("D042"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���240Ԫ��";
			}else if("D043"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
			}else if("D044"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
			}else if("D045"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���360Ԫ��";
			}else if("D046"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���240Ԫ��";
			}else if("D047"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
			}else if("D048"=="<%=j_GearCode%>"){
				suojiaonaStr="������Ԥ���0Ԫ";
				fanhuanjuntan = "1";
			}
			
			
			if("1"!=fanhuanjuntan){
				note_info1 += "��ѡ��ħ�ٺ�ҵ���ײ���Ч�ڼ䣬�����ħ�ٺ�ʵ�ʿ���ʱ���Կ����װ����ɹ�Ϊ׼��"+suojiaonaStr+"һ���ڰ��¾�̯����������ʱ��Ϊÿ�³���"+"|";
    	}else{
				note_info1 += "��ѡ��ħ�ٺ�ҵ���ײ���Ч�ڼ䣬�����ħ�ٺ�ʵ�ʿ���ʱ���Կ����װ����ɹ�Ϊ׼��"+suojiaonaStr+"|";
    		
    	}
		
		
			 
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){
					
					var offer_id_temp = $(this).attr("v_BPopedomCode");
					var j_EFF_DATE_fl = "<%=outEffectType_id%>";
					var j_EFF_DATE_de = "";
					
					
							if(j_EFF_DATE_fl=="0"){//������Ч
									j_EFF_DATE_de = "�ײ�24Сʱ����Ч";
							}else if(j_EFF_DATE_fl=="2"){//ԤԼ��Ч
									j_EFF_DATE_de = "�ײ�����1����Ч";
							}
							
						if("57572"==offer_id_temp){
							note_info1 += "���ѳɹ�����10Ԫ�����ܰ���"+j_EFF_DATE_de+"��ÿ�³�Ա�ɹ������ײ��ڵ������������ܼ�ͥ����ʡ���ƶ���������500�ף���Ա�䱾��ͨ�������Ż�500���ӣ��������Ӳ�����4����ͥ��Ա��2������ÿ����һ����10Ԫ���ܷѣ���"+"|";
						}
						
						if("52837"==offer_id_temp){
							note_info1 += "���ѳɹ�����IMS�̻�ҵ������10Ԫ/�£�����200�����л����л�0.1Ԫ/���ӣ���;0.15Ԫ/����,���ͥ��Ա�以����ѡ�"+"|";
						}
					 
				}
			});  	
			

		  note_info1 += "|";
		  
		  
      note_info2 += "��ע��|";
      
      note_info2 += "1�������ͥB�ƻ���һ���ڲ�����ȡ���ײ͡�|";
      note_info2 += "2�����ֻ�����״̬�쳣��ͬʱ��ͣ����������ܣ�״̬�ָ�ͬʱ��������������ܡ�|";
      note_info2 += "3�����ֻ�����״̬�쳣���ͥ��Աֹͣ���ܹ��������Żݺ����������Żݣ�״̬������ָ��Żݡ�|";
      note_info2 += "4����ͥ��Ʒȡ��ǰ�������԰���Ԥ������ͣ��ҵ��|";
      note_info2 += "5����ͥ��Ʒʹ���ڼ�ɸ�����Ҫ��������������λ�ײͣ��µ�λ��Ч��ʽΪԤԼ��Ч��|";
      note_info2 += "6��������ͥ��Ա������Ч��ɾ����ͥ��Ա������Ч��|";
      note_info2 += "7����Ч��һ�꣬�����������ߵ������Զ���ǩ��|";
      note_info2 += "8���û���������ɢ���˻�ħ�ٺ��ն�ʱ������ȡʣ��Ԥ���30%��ΪΥԼ���û���������ɢ�Ҳ��˻�ħ�ٺ��ն�ʱ������ȡʣ��Ԥ���100%��ΪΥԼ��|";


      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }

    
    function printInfo_JTFX_D028(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      
      opr_info += "����ҵ�����ƣ���������ں��ײ�    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      
      note_info1 += "�ʷ�������"+"|";
      note_info1 += "���Ѷ����й��ƶ���������ں��ײͣ�";
 
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"��";
					}
				}
			});      

	 
			note_info1 += temp_note_info1;
			
			
			note_info1 += "��ѡ��ħ�ٺ�ҵ���ײ���Ч�ڼ䣬�����ħ�ٺ�ʵ�ʿ���ʱ���Կ����װ����ɹ�Ϊ׼��������Ԥ���120Ԫ��һ���ڰ��¾�̯����������ʱ��Ϊÿ�³��� "+"|";
      
		 
      note_info2 += "��ע��|";
      

      note_info2 += "1���ʷѰ���������޺������ƶ���˾�����Դ��������|";
      note_info2 += "2���û���ŵ������й��ƶ���������ں��ײ���Ч�ڼ䣬�����������Ԥ������ͣ����ֹʹ����ҵ�����ֻ�Ƿ�ѣ��������쳣��������ͣ���ֻ�״̬�ָ������������������ܣ�|";
      note_info2 += "3���ײ���Ч�ڼ䣬���û�ԭ����û�סַ�ⲿ����ԭ���²��߱���װ������������ײͷ������û����ге���|";
      note_info2 += "4���û�����18Ԫ������ָ�����ʷѣ�����Ԥ���120Ԫ�����԰�����������ں��ײ͡�|";
      note_info2 += "5����ǰ��Ч18Ԫ������ָ�����ʷ��û���������������ںϿ��24Сʱ����Ч��|";
      note_info2 += "6��ԤԼ��Ч18Ԫ������ָ�����ʷ��û�������������ں��ײͣ���������ںϿ��ԤԼ��Ч��|";
      note_info2 += "7��ֻ����������ں��ײ�ԤԼʧЧ���û��ſ��������ʷѳ�����|";
      note_info2 += "8���ײ���Ч��Ϊһ�꣬�������޵����Զ���ǩ��|";
      note_info2 += "9��ֻ���������ר���ײ�ԤԼʧЧ���û��ſ��������ʷ�ԤԼȡ����ԤԼ����ȫ��ȡ��������Ϊ0Ԫ����ʷѣ�����תΪ��׼�ʷѡ�|";
      note_info2 += "10�����������ר���ײ���Ч12�������ڣ��û��������ײ��ڵ�4G�Ϳ���ʷѣ���������������ԭ�ײ�����Ч�ʷѽ��ܱ��Ϊ�۸���ߵ��ʷѵ�λ��|";
      note_info2 += "11���û���������ɢ���˻�ħ�ٺ��ն�ʱ������ȡʣ��Ԥ���30%��ΪΥԼ���û���������ɢ�Ҳ��˻�ħ�ٺ��ն�ʱ������ȡʣ��Ԥ���100%��ΪΥԼ��|";
      if(printm358){
    	  note_info2 += "12��Ϊ��������Ȩ�棬��ԭ"+retResult2m358+"���ʷѰ����Ĳ���ҵ��Ϊ����ѱ���һ�꣬�����ڼ�ҵ��ÿ�·���Ϊ"+retResult1m358+"Ԫ��ϵͳÿ��������"+retResult1m358+"Ԫר��൱�����ʹ�á��ñ����Ĳ���ҵ���������ʷ���Ч�����ڿ�ʼ���㣬���ں����ޱ仯���Żݽ��Զ�˳��һ�꣬���б仯ϵͳ����ǰ1���¶���֪ͨ��|";
      }
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }


    
    function printInfo_JTFX_D(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      
      opr_info += "����ҵ�����ƣ��ͼ������ײ�    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      opr_info += "��ͥ��Ա���룺"+$("#phoneNumbers").val() +"|";
      
      note_info1 += "�ʷ�������"+"|";
      note_info1 += "���Ѷ����й��ƶ��ͼ������ײͣ��ײ�24Сʱ����Ч��";
 
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"��";
					}
				}
			});      

		  var temp_preFee = "0.00";
		  
		  if("<%=outMonthFee%>".trim()!=""&&"<%=outMonthNum%>".trim()!=""){
		  	temp_preFee =  Number("<%=outMonthFee%>")*Number("<%=outMonthNum%>");
		  }
		  
			note_info1 += temp_note_info1;
			
			if("D025"=="<%=j_GearCode%>"){
				note_info1 += "�ײ���Ч�ڼ䣬���ʵ�ʿ���ʱ���Կ����װ����ɹ�Ϊ׼��";
			}else{
				note_info1 += "�ײ���Ч�ڼ䣬�����ħ�ٺ�ʵ�ʿ���ʱ���Կ����װ����ɹ�Ϊ׼��";
			}
			
			note_info1 += "������Ԥ���"+temp_preFee+"Ԫ��һ���ڰ��¾�̯����������ʱ��Ϊÿ�³���"+"|";
      
		 
      note_info2 += "��ע��|";
      
      note_info2 += "1���ʷѰ����������ĵ�����ƶ���˾�����Դ��������|";
      note_info2 += "2���û���ŵ����ĺͼ������ײ���Ч�ڼ䣬�������ֻ����ʷѱ������������Ԥ������ͣ����ֹʹ����ҵ�����ֻ�Ƿ�ѣ��������쳣��������ͣ���ֻ�״̬�ָ������������������ܣ�����ҵ��һ���ڣ��û���ŵ�������ͥ��ɢҵ�������Ѱ�װ��ϣ��û���������ɢ���˻�ħ�ٺ��ն�ʱ������ȡʣ��Ԥ���30%��ΪΥԼ���û���������ɢ�Ҳ��˻�ħ�ٺ��ն�ʱ������ȡʣ��Ԥ���100%��ΪΥԼ��|";
      note_info2 += "3���ײ���Ч�ڼ䣬���û�ԭ����û�סַ�ⲿ����ԭ���²��߱���װ������������ײͷ������û����ге���|";
      if(printm358){
    	  note_info2 += "4��Ϊ��������Ȩ�棬��ԭ"+retResult2m358+"���ʷѰ����Ĳ���ҵ��Ϊ����ѱ���һ�꣬�����ڼ�ҵ��ÿ�·���Ϊ"+retResult1m358+"Ԫ��ϵͳÿ��������"+retResult1m358+"Ԫר��൱�����ʹ�á��ñ����Ĳ���ҵ���������ʷ���Ч�����ڿ�ʼ���㣬���ں����ޱ仯���Żݽ��Զ�˳��һ�꣬���б仯ϵͳ����ǰ1���¶���֪ͨ��|";
      }


      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }


    
    function printInfo_JTFX(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      
      
      
      if("D022"=="<%=j_GearCode%>"){
      	opr_info += "����ҵ�����ƣ�������¿�    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      }else{
      	opr_info += "����ҵ�����ƣ��ͼҷ����ײ�    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      }
      
      opr_info += "��ͥ��Ա���룺"+$("#phoneNumbers").val() +"|";


      
      note_info1 += "�ʷ�������"+"|";
      if("D022"=="<%=j_GearCode%>"){
      	note_info1 += "���ã����ѳɹ������й��ƶ�������¿��ײͣ�24Сʱ����Ч��";
      }else{
	      if($("#sel_outEffectType").val()=="0"){//������Ч
						note_info1 += "���Ѷ����й��ƶ��ͼҷ����ײͣ��ײ�24Сʱ����Ч��";
				}else if($("#sel_outEffectType").val()=="2"){//ԤԼ��Ч
						note_info1 += "���Ѷ����й��ƶ��ͼҷ����ײͣ��ײʹ���1����Ч��";
				}
			}
			note_info1 += "�ײ���ʹ�÷�"+$("#span_OfferSum").text().trim()+"Ԫ";
			
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){
					var offer_id_temp = $(this).attr("v_BPopedomCode");
					
						if("52963"==offer_id_temp){
							note_info1 += "��7���Żݣ�";
						}
						
						if("52964"==offer_id_temp){
							note_info1 += "��8���Żݣ�";
						}
						
						if("52965"==offer_id_temp){
							note_info1 += "��9���Żݣ�";
						}
						
				}
			});  	
			note_info1 += "�ײͰ���";
			
			
			var temp_note_info_53341 = "";
			var temp_note_info_52839 = "";
			var temp_note_info_52837 = "";
			var temp_note_info_55090 = "";
			
			
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
					
					var offer_id_temp = $(this).attr("v_BPopedomCode");
					
					if("53341"==offer_id_temp){
						temp_note_info_53341 = "���ѳɹ�����10Ԫ�����ܰ����ײ�24Сʱ����Ч��ÿ�¿����ܼ�ͥ��Ա�䱾��ͨ��������ѣ����������ײ�����������������2����ͥ��Ա���û�������������Ա��ÿ��1����ȡ10Ԫ/�£���ͥ�ڹ����������ܳ���5�ˣ���������������ʹ�ü�ͥ��Ա������������ʹ�ü�ͥ�ײ��ڹ���������������״̬�쳣���ͥ��Աֹͣ���ܹ��������Żݺ����������Żݣ�״̬������ָ��Żݣ�������ͥ��Ա������Ч��ɾ����ͥ��Ա������Ч�� |";
					}
					
					if("52839"==offer_id_temp){
						temp_note_info_52839 = "���ѳɹ�����10Ԫ1Gʡ�����������ײ�24Сʱ����Ч�����¿������Ӱ���10�Ρ�|";
					}

					if("52837"==offer_id_temp){
						temp_note_info_52837 = "���ѳɹ�����IMS�̻�ҵ������10Ԫ/�£�����200�����л����л�0.1Ԫ/���ӣ���;0.15Ԫ/����,��ͥ��Ա�䱾�ػ�����ѡ�|";
					}
					
					if("55090"==offer_id_temp){
						temp_note_info_55090 = "���ѳɹ�����10Ԫ1Gʡ�������������������°���ͼҷ����ײͣ����������ײ���Чʱ����ͬ�������Ѱ���ͼҷ����ײͣ�����������24Сʱ����Ч������ʹ���ڼ����˶�Ҫ�������������Զ�������|";
					}


					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"��";
					}
				}
			});      

			
			note_info1 += temp_note_info1;
			
			if("D022"=="<%=j_GearCode%>"){
			  var phoneNo1 = "";
      	var phoneNo2 = "";
      	
      	$("#old_mem_table tr:gt(0)").each(function(){
						var e_role_code = $(this).find("td:eq(1)").text().trim();
						if("21096"==e_role_code){
							phoneNo2 = $(this).find("td:eq(0)").text().trim();
						}
						if("21098"==e_role_code){
							phoneNo1 = $(this).find("td:eq(0)").text().trim();
						}
				});
				
      	note_info1 += "��������"+phoneNo1+"Ϊ�����������ֻ�����"+phoneNo2;
      	note_info1 += "������0Ԫ������ʾ���������й���0.19Ԫ/���ӣ����ڱ�����ѣ����ڷ�Χ���������۰�̨������������100Mʡ���������������ֻ�����������ձ�׼�ʷ���ȡ��ע���ײ���Ч��ÿ������5GBʡ���乾��Ƶ����������ͬʱ�Զ���ͨ3Ԫ1GBʡ�������������ÿ��ʡ����������5M���շѣ�����5M����ȡ�ײ�ʹ�÷�3Ԫ���������ʹ��ʡ��������1GB������������Ч������ת�� �ײ���Ч��Ϊһ�꣬�������޵����Զ���ǩ��";
      }else{
	      note_info1 += "�����ײ�ʱ���ʷѱ�׼Ϊ����������0.19Ԫ/���ӣ������ƶ���������0.29Ԫ/M���������ձ�׼�ʷ���ȡ�����Ϲ��ھ������۰�̨�������ײ���Ч�ڼ䣬�����ħ�ٺ�ʵ�ʿ���ʱ���Կ����װ����ɹ�Ϊ׼��������Ԥ���240Ԫ�������ڰ��¾�̯����������ʱ��Ϊÿ�³��� ";			
				note_info1 += "||";
    	}

			note_info1 +=  "|"+temp_note_info_53341+temp_note_info_52839+temp_note_info_52837+temp_note_info_55090;
      note_info2 += "��ע��|";
      


      note_info2 += "1���ʷѰ���������޺������ƶ���˾�����Դ��������|";
		note_info2 += "2���û���ŵ����ĺͼҷ����ײ���Ч�ڼ䣬������Ԥ������ͣ����ֹʹ����ҵ�����ֻ�Ƿ�ѣ��������쳣��������ͣ���ֻ�״̬�ָ������������������ܣ�����ҵ�������ڣ��û���ŵ�������ͥ��ɢҵ�������Ѱ�װ��ϣ��û���������ɢ���˻�ħ�ٺ��ն�ʱ������ȡʣ��Ԥ���30%��ΪΥԼ���û���������ɢ�Ҳ��˻�ħ�ٺ��ն�ʱ������ȡʣ��Ԥ���100%��ΪΥԼ��|";
		note_info2 += "3���ײ���Ч�ڼ䣬���û�ԭ����û�סַ�ⲿ����ԭ���²��߱���װ������������ײͷ������û����ге���|";
		note_info2 += "4���ײ�ʹ���ڼ�ɸ�����Ҫ���������������λ�ײͣ��µ�λ��Ч��ʽΪԤԼ��Ч��|";
		note_info2 += "5����ͥ�ײͺ�Լ��Ϊ24���£����ں������ߵ����Զ�˳��ԭ�ײ͡� |";
		if(printm358){
			note_info2 += "6��Ϊ��������Ȩ�棬��ԭ"+retResult2m358+"���ʷѰ����Ĳ���ҵ��Ϊ����ѱ���һ�꣬�����ڼ�ҵ��ÿ�·���Ϊ"+retResult1m358+"Ԫ��ϵͳÿ��������"+retResult1m358+"Ԫר��൱�����ʹ�á��ñ����Ĳ���ҵ���������ʷ���Ч�����ڿ�ʼ���㣬���ں����ޱ仯���Żݽ��Զ�˳��һ�꣬���б仯ϵͳ����ǰ1���¶���֪ͨ��|";
      	}

      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }

    
 function printInfo_JTHX(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      opr_info += "����ҵ�����ƣ��ͼһ���������    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      
      opr_info += "��ͥ��Ա���룺"+$("#phoneNumbers").val() +"|";
			var is_mbh_flag = "";//�Ƿ�ħ�ٺ�
			var hj_xf_count = 0;//��ͥ�ϼ��µ�������
			var m_num_count = 0;//��ͥ��Ա����Ϊ
			var m_phone_no  = "";//��Ա�ֻ�����
			
			$("#old_mem_table tr:gt(0)").each(function(){
				if($(this).find("td:eq(2)").text().trim()=="��ͨ��Ա"){
					m_num_count ++ ;
					m_phone_no += $(this).find("td:eq(0)").text().trim()+"��";
				}
			});
			
			if(m_phone_no.length>0){
				m_phone_no = m_phone_no.substring(0,m_phone_no.length-1);
			}
			
			var temp_note_info1 = "";
			var temp_note_info_52837 = "";
			
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
					
					var offer_id_temp = $(this).attr("v_BPopedomCode");
					
					if("52837"==offer_id_temp){
						temp_note_info_52837 = "|���ѳɹ�����IMS�̻�ҵ������10Ԫ/�£�����200�����л����л�0.1Ԫ/���ӣ���;0.15Ԫ/����,��ͥ��Ա�䱾�ػ�����ѡ�|";
					}
					
										
					if("ħ�ٺ�"==$(this).attr("v_ClssName")){
						is_mbh_flag = "ħ�ٺͻ���������ҵ��";//����Ϊһ�仰
					}
					
					hj_xf_count = hj_xf_count + parseInt($(this).attr("v_OfferSum"));
					
					
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"��";
					}
					
				}
			});      
			
			note_info1 += "�ʷ�������"+"|";
			note_info1 += "�ͼһ����������Żݣ�";
			if(m_num_count != 0){
				note_info1 += "��ͥ��Ա����Ϊ"+m_num_count+"�ˣ�"+
										"��Ա�ֻ�����ֱ�Ϊ"+m_phone_no+"��";
			}
			
			if("D070"=="<%=j_GearCode%>"){
      	note_info1 +=temp_note_info1+
										"���¼�ͥ��Ա�ϼ����Ѳ���"+hj_xf_count+"Ԫ�����ֽ��ӻ���<%=activePhone%>�˻��п۳���";
      }else{
      	note_info1 +=temp_note_info1+
										"���¼�ͥ��Ա�ϼ����Ѳ���"+hj_xf_count+"Ԫ�����ֽ��ӻ���<%=activePhone%>�˻��п۳���������Ԥ���240Ԫ�������ڰ��¾�̯����������ʱ��Ϊÿ�³�";

      }
      note_info1 += "|";
      
      
      note_info1 +=  temp_note_info_52837;


      note_info2 += "��ע��|";
      
      note_info2 += "1���ʷѰ���������޺������ƶ���˾�����Դ��������|";
			note_info2 += "2���û���ŵ����ĺͼһ����ײ���Ч�ڼ䣬������Ԥ������ͣ����ֹʹ����ҵ�����ֻ�Ƿ�ѣ��������쳣��������ͣ���ֻ�״̬�ָ������������������ܣ�����ҵ�������ڣ��û���ŵ�������ͥ��ɢҵ�������Ѱ�װ��ϣ��û���������ɢ���˻�ħ�ٺ��ն�ʱ������ȡʣ��Ԥ���30%��ΪΥԼ���û���������ɢ�Ҳ��˻�ħ�ٺ��ն�ʱ������ȡʣ��Ԥ���100%��ΪΥԼ��|";
			note_info2 += "3���ײ���Ч�ڼ䣬���û�ԭ����û�סַ�ⲿ����ԭ���²��߱���װ������������ײͷ������û����ге��� |";
			note_info2 += "4���ײ�ʹ���ڼ�ɸ�����Ҫ���������������λ�ײͣ��µ�λ��Ч��ʽΪԤԼ��Ч��|";
			note_info2 += "5���ײ���Ч�ڼ䣬����ʹ�ü�ͥ��Ա������������ʹ�ü�ͥ�ײ��ڹ���������������״̬�쳣���ͥ��Աֹͣ���ܹ��������Żݺ����������Żݣ�״̬������ָ��Żݣ�������ͥ��Ա������Ч��ɾ����ͥ��Ա������Ч|";

			note_info2 += "|";
			note_info2 += "��ͥ�ײͺ�Լ��Ϊ24���£����ں������ߵ����Զ�˳��ԭ�ײ͡� |";
			
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
		//��ӡģ��idΪ��
    function printInfo_JTRH(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      opr_info += "����ҵ�����ƣ��ͼ�ͥ�����ײ�    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      
      opr_info += "��ͥ��Ա���룺"+$("#phoneNumbers").val() +"|";
      
      
      note_info1 += "�ʷ�������"+"|";
      
      
      
      if($("#sel_outEffectType").val()=="0"){//������Ч
					note_info1 += "���������й��ƶ��ͼ�ͥ�����ײͣ�24Сʱ����Ч��";
			}else if($("#sel_outEffectType").val()=="2"){//ԤԼ��Ч
					note_info1 += "���������й��ƶ��ͼ�ͥ�����ײͣ�����1����Ч��";
			}
			note_info1 += "��ʹ�÷�"+$("#span_OfferSum").text().trim()+"Ԫ";
			note_info1 += "����";
			
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
					
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"��";
					}
				}
			});      
			
			note_info1 += temp_note_info1;
      note_info1 += "�����װ���°�ʵ��ʹ�������շѣ����ײ�������ƶ���������0.29Ԫ/M��ʡ�ڳ�������һ��������0.1Ԫ/���ӣ�ʡ�ڽ�����ѣ�ʡ��������й���˫���շ�0.3Ԫ/���ӣ������۰�̨�����������Ӳ�����6����ͥ��Ա��3������ÿ����һ����5Ԫ���ܷѣ��������ձ�׼�ʷ���ȡ��";			
			note_info1 += "||";
      
      
      note_info2 += "��ע��|";
      
      note_info2 += "1�����ֻ�����������Ϊ�����������ײ�������Ч�������������Ч��|";
      note_info2 += "2�����ֻ�������������������������ײ�������Ч�������ʹ�õ�������ԭ���¼Ʒѹ���۷ѣ�ʣ���������ײͰ��¹���Ʒѡ�|";
      note_info2 += "3�����ֻ�������������������������ײʹ�����Ч�������������Ч��|";
      note_info2 += "4�����ֻ����롢��������������ײʹ�����Ч��|";
      note_info2 += "5������ͼ�ͥ�����ײͺ�����ڣ�����ѿ���������ȡ���ײͣ�����ȡ�ײ�ʣ��Ԥ��ר���30%��ΪΥԼ�𣬿��תΪ��ͨ��׼�����ʷѡ�|";
      note_info2 += "6�����ֻ�����״̬�쳣��ͬʱ��ͣ����������ܣ�״̬�ָ�ͬʱ��������������ܡ�|";
      note_info2 += "7�����ֻ�����״̬�쳣���ͥ��Աֹͣ���ܹ��������������Żݣ�״̬������ָ��Żݡ�|";
      note_info2 += "8���ײ�ȡ��ǰ�������԰���Ԥ������ͣ��ҵ��|";
      note_info2 += "9������ǿͻ�ԭ���¿���޷���װ�����ֻ������ʷ�����Ч��������ͥ��ɢ���ֻ�������Ϊָ���ʷѣ�����ɰ����������ʷѴ�����Ч�������԰�ȥ������·Ѻ�ķ��ÿ۷ѡ����ֻ������ʷ�δ��Ч���������������¿ɰ��ͻ�Ҫ�󽫶���Ԥ������ֽ���ʽ������|";
      note_info2 += "10�������ײ���Ч�����ڶ���ħ�ٺͻ��������Ӱ���ҵ��|";
      note_info2 += "11���ײ�ʹ���ڼ�ɸ�����Ҫ������������λ������������ѡ����|";
      note_info2 += "12��������ͥ��Ա������Ч��ɾ����ͥ��Ա������Ч��|";
      note_info2 += "13������ʹ�ü�ͥ��Ա�以��ͨ��ʱ������ͥ������������������ʹ�ü�ͥ��Ա����������������|";
      note_info2 += "14��ħ�ٺͶ���һ���ڲ������������˶���|";

			note_info2 += "|";
			note_info2 += "��ͥ�ײͺ�Լ��Ϊ12���£����ں������ߵ����Զ�˳��ԭ�ײ͡� |";

      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }



 function printInfo_JTDX(printType){
    	go_get_prt_info();
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#prt_cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + 
      						"    �û�Ʒ�ƣ�"+$("#prt_cust_bran").val()+"|";
      						
      opr_info += "����ҵ�����ƣ���ͥ���������Ż�    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      opr_info += "��ͥ��Ա���룺"+$("#phoneNumbers").val() +"|";
      
			var is_mbh_flag = "";//�Ƿ�ħ�ٺ�
			var hj_xf_count = 0;//��ͥ�ϼ��µ�������
			var m_num_count = 0;//��ͥ��Ա����Ϊ
			var m_phone_no  = "";//��Ա�ֻ�����
			
			$("#old_mem_table tr:gt(0)").each(function(){
				if($(this).find("td:eq(2)").text().trim()=="��ͨ��Ա"){
					m_num_count ++ ;
					m_phone_no += $(this).find("td:eq(0)").text().trim()+"��";
				}
			});
			
			if(m_phone_no.length>0){
				m_phone_no = m_phone_no.substring(0,m_phone_no.length-1);
			}
			
			var temp_note_info1 = "";
			$("#offer_table").find("input[type='radio']").each(function(){
				if($(this).is(":checked")){//����ѡ�еĵ�ѡ��
					if("ħ�ٺ�"==$(this).attr("v_ClssName")){
						is_mbh_flag = "ħ�ٺͻ���������ҵ��";//����Ϊһ�仰
					}
					
					hj_xf_count = hj_xf_count + parseInt($(this).attr("v_OfferSum"));
					
					
					var t_v_OfferDesc = $(this).attr("v_OfferDesc");
					if(typeof(t_v_OfferDesc)!="undefined"&&t_v_OfferDesc!=""&&t_v_OfferDesc!="undefined"){
						temp_note_info1 += t_v_OfferDesc+"��";
					}
					
				}
			});      
			
			note_info1 += "�ʷ�������"+"|";
			note_info1 += "��ͥ���������Żݣ���ͥ��Ա����Ϊ"+m_num_count+"�ˣ�"+
										"��Ա�ֻ�����ֱ�Ϊ"+m_phone_no+"��"+temp_note_info1+
										"���¼�ͥ��Ա�ϼ����Ѳ���"+hj_xf_count+"Ԫ��δʹ�õĻ��ѽ��ӻ���<%=activePhone%>�˻��۳�";
      note_info1 += "|";

      note_info1 += "��ע��"+"|";
      note_info1 += "��ͥ�������Ѳ�Ʒ�����󣬴���Ч��һ����ͥ�������Ѳ�Ʒ��ʼ���㣬һ��֮�ڲ���������ͥ��Ʒ�˶�"+"|";


			note_info2 += "|";
			note_info2 += "��ͥ�ײͺ�Լ��Ϊ12���£����ں������ߵ����Զ�˳��ԭ�ײ͡� |";
			
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
    
    
function go_get_prt_info(){
		var packet = new AJAXPacket("/npage/sm357/fm357_7.jsp","���Ժ�...");
	      packet.data.add("opCode","<%=opCode%>");// 
	      packet.data.add("phoneNo","<%=activePhone%>");//�ֻ���
	      packet.data.add("inProdCode","");//
	      packet.data.add("inGearCode","");//
    core.ajax.sendPacket(packet,do_get_prt_info);
    packet =null;	
}

function do_get_prt_info(packet){
		var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
    	$("#prt_cust_name").val(packet.data.findValueByName("prt_cust_name"));
    	$("#prt_cust_bran").val(packet.data.findValueByName("prt_cust_bran"));
    	$("#prt_note_into").val(packet.data.findValueByName("prt_note_into"));
    }
}

//��ӡ��Ʊ
function sm358_show_Bill_Prt(){
			var jf_money = "";
			if(is_show_mobaihe=="Y"){
				jf_money = $("#mobaiheyajin").val();
			}else{
				jf_money = "0";
			}
			var  billArgsObj = new Object();
			$(billArgsObj).attr("10001","<%=workNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",$("#prt_cust_name").val());   //�ͻ�����
			$(billArgsObj).attr("10006","��ͥ��Ʒ����-ħ�ٺ�Ѻ��");    //ҵ�����
			
			$(billArgsObj).attr("10008","<%=activePhone%>");    //�û�����
			$(billArgsObj).attr("10015",jf_money);   //���η�Ʊ���
			$(billArgsObj).attr("10016",jf_money);   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
			/*10028 10029 ����ӡ*/
		  	$(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029","");	 //Ӫ������	
			$(billArgsObj).attr("10030","<%=sysAcceptl%>");   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","m358");   //��������
			/**/

			
			/*�ͺŲ���*/
			$(billArgsObj).attr("10061","");	       //�ͺ�
			$(billArgsObj).attr("10062","");	//˰��
			$(billArgsObj).attr("10063","");	//˰��	   
	    	$(billArgsObj).attr("10071","6");	//
	 		$(billArgsObj).attr("10076",0);
 			
 			$(billArgsObj).attr("10083", ""); //֤������
 			$(billArgsObj).attr("10084", ""); //֤������
 			$(billArgsObj).attr("10086", "�𾴵Ŀͻ�����������ҵ���˶���ȡ������ֹҵ��ʹ�õĲ���ʱ����Я�����վݡ���Ч���֤��������ҵ��ʱ����ħ�ٺ��ն˵��ƶ�ָ������Ӫҵ������Ѻ���˻�������"); //��ע
 			$(billArgsObj).attr("10065", ""); //����˺�
 			$(billArgsObj).attr("10087", $("#stb_id").val()); //imei����
 			
			$(billArgsObj).attr("10041", "ħ�ٺ��ն�Ѻ�����");           //Ʒ�����
			$(billArgsObj).attr("10042","̨");                   //��λ
			$(billArgsObj).attr("10043","1");	                   //����
			$(billArgsObj).attr("10044",jf_money);	                //����
			
 			$(billArgsObj).attr("10085", "zsj"); //���������ȡ��ʽ ֻ������ӡ�վݵĿ�
 			$(billArgsObj).attr("10072","1"); //1--������Ʊ  2--�����෢Ʊ  2--�˷��෢Ʊ

 			$(billArgsObj).attr("10088","m358"); //�վ�ģ��
 			
 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
			
						//��Ʊ��Ŀ�޸�Ϊ��·��
			$(billArgsObj).attr("11213","REC");  //�°淢Ʊ����Ʊ�ݱ�־λ��Ĭ�Ͽ�λ��Ʊ REC == ֻ�� ��ӡֽ���վ�
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";

			var loginAccept = "<%=sysAcceptl%>";
			var path = path +"&loginAccept="+loginAccept+"&opCode=m358&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);		

}
var printm358=false;
var retResult1m358="";
var retResult2m358="";
function go_showPrompt(){
	var packet = new AJAXPacket("../s1270/ajax_showPrompt.jsp","���Ժ�...");
	packet.data.add("iOpCode","<%=opCode%>");
	packet.data.add("iPhoneNo","<%=activePhone%>");
	packet.data.add("iUserPwd","");
	packet.data.add("iOfferId","");
	core.ajax.sendPacket(packet,do_showPrompt);
	packet =null; 
}
function do_showPrompt(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retCode = packet.data.findValueByName("retCode"); 
	if(retCode =="000000"){
		retResult1m358 = packet.data.findValueByName("retResult1");
		retResult2m358 = packet.data.findValueByName("retResult2");
		if(retResult1m358!=""&&retResult2m358!=""){
			alert("Ϊ��������Ȩ�棬��ԭ"+retResult2m358+"���ʷѰ����Ĳ���ҵ��Ϊ����ѱ���һ�꣬�����ڼ�ҵ��ÿ�·���Ϊ"+retResult1m358+"Ԫ��ϵͳÿ��������"+retResult1m358+"Ԫר��൱�����ʹ�á��ñ����Ĳ���ҵ���������ʷ���Ч�����ڿ�ʼ���㣬���ں����ޱ仯���Żݽ��Զ�˳��һ�꣬���б仯ϵͳ����ǰ1���¶���֪ͨ��");
			printm358=true;
		}
		else{
			printm358=false;
		}
	}
}  
    
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
<input type="hidden" id="prt_cust_name" name="prt_cust_name" value="" />
<input type="hidden" id="prt_cust_bran" name="prt_cust_bran" value="" />
<input type="hidden" id="prt_note_into" name="prt_note_into" value="" />	
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">ѡ���Ʒ</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="25%">��ͥ��Ʒ��</td>
		  <td width="25%">
		  	<%=j_ProdName%>
		  </td>
 
	    <td class="blue" width="25%">��Ʒ��λ��</td>
		  <td width="25%">
			   <%=j_GearName%>
		  </td>
	</tr>
	<tr>
		<td class="blue">Ⱥ�飺</td>
		<td>
			<%=j_group_id%>
		</td>
		<%if("JTHB".equals(j_ProdCode)){%>
			<td class="red" colspan="2">���Ǳ�ʡħ�ٺ��նˣ�ϵͳ�Զ�ǩԼ0Ԫ/�¡�</td>
		<%}else{%>
			<td class="red" colspan="2"></td>
		<%}%>
	</tr>
</table>

<div class="title"><div id="title_zi">����ӽ�ɫ</div></div>
<table cellSpacing="0"  id="old_mem_table">
	<tr>
		<th width="25%" name="phonenumber">�ֻ�����</th>
		<th style="display:none">��ɫ����</th>
		<th width="25%" name="rolename">��ɫ����</th>
		<th width="25%">��Чʱ��</th>
		<th width="25%">ʧЧʱ��</th>
		<th style="display:none">��־λ����ʶ�Ƿ���Ҫ���ѣ�����Y�Ĵ�����Ҫ���ѣ���Ҫƴһ��PAY_INFO</th>
	</tr>
<%
String phoneNumbers="";
for(int i=0;i<result_t3.length;i++){
%>
<tr>
	<td name="phonenumber"><%=result_t3[i][0]%></td>
	<td  style="display:none"><%=result_t3[i][6]%></td>
	<td name="rolename"><%=result_t3[i][1]%></td>
	<td><%=result_t3[i][2]%></td>
	<td><%=result_t3[i][3]%></td>
	<td  style="display:none" ><%=result_t3[i][8]%></td>
	<td  style="display:none" ><%=result_t3[i][7]%></td>
</tr>
<%
	phoneNumbers+=result_t3[i][0]+",";
	if(i%4==0&&i!=0){
		phoneNumbers+="|";
	}
}
%>
<input type="hidden" id="phoneNumbers" value="<%=phoneNumbers%>"/>
</table>


<div class="title"><div id="title_zi">�ʷ��б�</div></div>
<table cellSpacing="0"  id="offer_table">
	 <tr>
		<th width="15%">�ʷѷ���</th>
		<th colspan='2'>�ʷ�����</th>
		<th width="7%">����</th>
	</tr>
<%
String ja_ClssName = "";
if(result_t4.length>0){
	ja_ClssName = result_t4[0][10];
	out.print("<tr v_OfferFlag='"+result_t4[0][11]+"' v_H19_value='"+result_t4[0][19]+"' v_B17_value='"+result_t4[0][17]+"' v_E18_value='"+result_t4[0][18]+"' >");
	out.print("<td>"+result_t4[0][10]+"</td>");
	out.print("<td colspan='2'>");
}

for(int i=0;i<result_t4.length;i++){

if(ja_ClssName.equals(result_t4[i][10])){//һ��
	
%>

	<input  type="radio" name="offer_radio_<%=result_t4[i][4]%>"
														v_PopedomCode='<%=result_t4[i][0]%>' 
														v_CodeId='<%=result_t4[i][1]%>' 
														v_TopCodeId='<%=result_t4[i][2]%>' 
														v_CodeName='<%=result_t4[i][3]%>' 
														v_CodeValue='<%=result_t4[i][4]%>' 
														v_BPopedomCode='<%=result_t4[i][5]%>' 
														v_OfferName='<%=result_t4[i][6]%>' 
														v_OfferComments='<%=result_t4[i][7]%>' 
														v_OfferSum='<%=result_t4[i][8]%>' 
														v_IsOrder='<%=result_t4[i][9]%>' 
														v_ClssName='<%=result_t4[i][10]%>' 
														v_OfferFlag='<%=result_t4[i][11]%>' 
														v_OfferDesc='<%=result_t4[i][12]%>' 
														v_is_show='<%=result_t4[i][13]%>'
			onclick="add_OfferSum(this)"														
	 />
	
<a href="javascript:void(0)" onclick="show_offer_det('<%=result_t4[i][10]%>','<%=result_t4[i][6]%>','<%=result_t4[i][7]%>','<%=result_t4[i][8]%>')"><%=result_t4[i][6]%></a>

<%	
}else{
	out.print("</td>");
	out.print("<td><input type='button' value='ȡ��' class='b_text' onclick='cen_radio_all(this)' ></td>");
	out.print("</tr>");
	out.print("<tr v_OfferFlag='"+result_t4[i][11]+"'   v_H19_value='"+result_t4[i][19]+"' v_B17_value='"+result_t4[i][17]+"' v_E18_value='"+result_t4[i][18]+"'  >");
	out.print("<td>"+result_t4[i][10]+"</td>");
	out.print("<td colspan='2'>");
%>
	<input  type="radio" name="offer_radio_<%=result_t4[i][4]%>"
														v_PopedomCode='<%=result_t4[i][0]%>' 
														v_CodeId='<%=result_t4[i][1]%>' 
														v_TopCodeId='<%=result_t4[i][2]%>' 
														v_CodeName='<%=result_t4[i][3]%>' 
														v_CodeValue='<%=result_t4[i][4]%>' 
														v_BPopedomCode='<%=result_t4[i][5]%>' 
														v_OfferName='<%=result_t4[i][6]%>' 
														v_OfferComments='<%=result_t4[i][7]%>' 
														v_OfferSum='<%=result_t4[i][8]%>' 
														v_IsOrder='<%=result_t4[i][9]%>' 
														v_ClssName='<%=result_t4[i][10]%>' 
														v_OfferFlag='<%=result_t4[i][11]%>' 
														v_OfferDesc='<%=result_t4[i][12]%>' 
														v_is_show='<%=result_t4[i][13]%>'
						onclick="add_OfferSum(this)"														
	 />
	
<a href="javascript:void(0)" onclick="show_offer_det('<%=result_t4[i][10]%>','<%=result_t4[i][6]%>','<%=result_t4[i][7]%>','<%=result_t4[i][8]%>')"><%=result_t4[i][6]%></a>

<%	
	ja_ClssName = result_t4[i][10];
}
%>

	
<%
}

if(result_t4.length>0){
	out.print("</td>");
	out.print("<td><input type='button' value='ȡ��' class='b_text' onclick='cen_radio_all(this)' ></td>");
	out.print("</tr>");
}	
%>
</table>
<table  cellSpacing="0" >
 <tr name="mobaihegroup" style="display:none">
 	<td scope="col" >��ҵ����</td>
 	<td scope="col">
	 	<select id="sp_id" name="sp_id">
	 		<option value="">-��ѡ��-</option>
	 		<option value="699213">δ������</option>
	 		<option value="699212">����ͨ</option>
	 	</select>
 	</td>
 	<td scope="col"  >ҵ�����</td>
 	<td scope="col" >
 		<select id="biz_code" name="biz_code">
 			<!-- <option value="">-��ѡ��-</option> -->
	 		<option value="20830000">20830000</option>
	 	</select>
 	</td>
 	
 	</tr>
 <tr name="mobaihegroup" style="display:none">
 	<td scope="col">IMEI��</td>
 	<!-- 003903FF00210070 -->
 	<td scope="col"><input type="text" id="stb_id" name="stb_id" size="40" value="" maxlength="32">
 	<input type="button" class='b_text' id="jiaoyanButton" value="У��" onclick="go_stb_id()"/>
 	</td>
 	<td scope="col" id="td_mobaihe1" style="display:none">ħ�ٺ�Ѻ��</td>
 	<td  id="td_mobaihe2" style="display:none">
 		
 		<input type="text" id="mobaiheyajin" name="mobaiheyajin" maxlength="3"  readOnly="readOnly" class="InputGrey" value="0" v_must="0" v_type="money"  onblur = "checkElement(this)"  />
 	</td>
 	</tr>
 
</table>
<table  cellSpacing="0" id="offer_table_hit">
 
</table>



<table cellSpacing="0"  id="offer_table">
	<%
	//��Y�ͼ����ʷ��ܶN������ 
	if("Y".equals(j_offer_flag)){
	%>
	<tr>
		<td class="blue" width="25%">�ײ��ܶ</td>
		<td >
			<span id="span_OfferSum">0</span>
			&nbsp;&nbsp;&nbsp;
			<!--
			<input type="hieedn" value="У��Ԥ��" class="b_text" id="btn_check_OfferSum" onclick="go_check_OfferSum()" >
			-->
		</td>
	</tr>
	<%
	}
	%>
	<td class="blue" width="25%" style="display: none">��Ч��ʽ��</td>
		<td style="display: none">
			<select id="sel_outEffectType" onchange="set_EFF_DATE()">
				<option value="">--��ѡ��--</option>
				<% for(int i=0;i<result_t5.length;i++){
						System.out.println("-------hejwa----------result_t5--------------->"+result_t5[i][0]);
						System.out.println("-------hejwa----------result_t5--------------->"+result_t5[i][1]);
				
				%>
						<option value="<%=result_t5[i][0]%>"><%=result_t5[i][1]%></option>
				<%}%>
			</select>
		</td>
</table>

<%
if(
	 (
		"JTFX".equals(j_ProdCode)&&
		!"D022".equals(j_GearCode)&&
    !"D023".equals(j_GearCode)&&
    !"D024".equals(j_GearCode)&&
    !"D028".equals(j_GearCode)&&
    !"D025".equals(j_GearCode)
   )
   ||"JTHX".equals(j_ProdCode)){
 
%>
<table cellSpacing="0">
	 <tr>
	 	<td>
	 		<font class="orange">��ħ�ٺ͡�Ϊ��ѡҵ�����û�����ħ�ٺ͹��ܣ���Ĭ��Ϊ�û���������ħ�ٺ͹��ܣ����¿�ʼħ�ٺ���ѡ�</font>
	 	</td>
	 </tr>
</table>
<%
}%>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="go_cfm()"           />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
<div id="messagediv"></div>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>