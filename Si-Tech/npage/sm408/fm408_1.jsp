<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-9-23 10:40:55------------------
 ������CRMϵͳ������Ŀ��Ʒ�������۵Ĺ�������
 
 
 -------------------------��̨��Ա��shiyong/liyang/yull--------------------------------------------
 
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
	String idNo     = "";
	
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


String custBrandName = "";
        if("000000".equals(retCode2)){
                if(result_t2.length>0){
                        custName = result_t2[0][5];
                        pp_name  = result_t2[0][38];
                        id_type  = result_t2[0][12];
                        id_iccid = result_t2[0][13];
                        idNo     = result_t2[0][30];
                        
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
        
        
String dic_C_sql = " select a.res_code, a.res_name  from rs_term_code_dict a    where a.res_name = any('C12','C13','C15')   ";

String offer_sql = " select a.offer_id, a.offer_name, a.offer_comments   from product_offer a   where a.offer_id in ('55367', '55429', '55430') ";

%>   	
  <wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=dic_C_sql%>" />
	</wtc:service>
	<wtc:array id="result_dic_C" scope="end"  />


  <wtc:service name="TlsPubSelCrm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=offer_sql%>" />
	</wtc:service>
	<wtc:array id="result_Offer" scope="end"  />
		
<%
	String offerSelect_opt = "";
	for(int i=0;i<result_Offer.length;i++){
		offerSelect_opt += "<option value='"+result_Offer[i][0]+"' v_offer_comments='"+result_Offer[i][2]+"' >"+result_Offer[i][0]+"->"+result_Offer[i][1]+"</option>";
	}
	String sqlFee = "select a.res_code, a.res_name, b.price_value from rs_term_code_dict a , dbchnterm.rs_term_price_info b where a.res_code = b.res_code and b.price_name = 'BSRETAILPRICE' and a.res_name = any('C12','C13','C15','C20')";
	String C12Str="368.00";
	String C13Str="268.00";
	String C15Str="498.00";
	String C20Str="0";
	
%>
<wtc:service name="TlsPubSelCrm" outnum="3" retmsg="retMsg3" retcode="retCode3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlFee%>" />
</wtc:service>
<wtc:array id="result_t3" scope="end"  />
<%
if("000000".equals(retCode3)){
	if(result_t3.length>0){
		for(int i=0;i<result_t3.length;i++){
			if(result_t3[i][1].equals("C12")){
				C12Str=result_t3[i][2];
			}
			else if(result_t3[i][1].equals("C13")){
				C13Str=result_t3[i][2];
			}
			else if(result_t3[i][1].equals("C15")){
				C15Str=result_t3[i][2];
			}
			else if(result_t3[i][1].equals("C20")){
				C20Str=result_t3[i][2];
			}
		}
	}
}
%>
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>



//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}

var COM_OPCODE = "";


/*-------------------------------------------m408-----------------��ʼ------------------------------*/

//�ύ����
function sm408_go_Cfm(){
 		
 
		if($("#sm408_imei_no").val().trim()==""){
			rdShowMessageDialog("������IMEI��");
	    return;
		}
		
		var ret = sm408_showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
		
		sm408_show_Bill_Prt();
		
		if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
		
		
	  var packet = new AJAXPacket("fm408_Cfm.jsp","���Ժ�...");
        packet.data.add("opCode",COM_OPCODE);//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("loginAccept","<%=loginAccept%>");//
        packet.data.add("iImeiCode",$("#sm408_imei_no").val());//
        packet.data.add("iResCode",$("#sm408_sel_zdType").val());//
        packet.data.add("iMachineFee",$("#sm408_i_pice").val());//
        packet.data.add("iOpFlag",$("#sm408_is_c_sa").val());//
        if("0"==$("#sm408_is_c_sa").val()){
        	packet.data.add("iOfferId","0");//
        }else{
        	packet.data.add("iOfferId",$("#sm408_sel_offer_info").val());//
        }
        
    core.ajax.sendPacket(packet,sm408_do_Cfm);
    packet =null;
}

// �ص�
function sm408_do_Cfm(packet){
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

		
function fm408_go_getMac_ByImei(bt){
		if($(bt).val().trim()=="") return;
		
		var packet = new AJAXPacket("fm408_getMac_ByImei.jsp","���Ժ�...");
        packet.data.add("val_imei",$(bt).val().trim());//
   
    core.ajax.sendPacket(packet,function(packet){
		    var error_code = packet.data.findValueByName("code");//���ش���
		    var error_msg =  packet.data.findValueByName("msg");//������Ϣ
		
		    if(error_code=="000000"){// 
		    	var retArray = packet.data.findValueByName("retArray");
		    	if(retArray.length>0){
		    		$(bt).attr("v_t_mac",retArray[0][0]);
		    	}else{
						rdShowMessageDialog("δ��ѯ��IMEI["+$(bt).val().trim()+"]��Ӧ��MAC",0);
						$(bt).val("");
		    	}
		    }
		    
		});
		
    packet =null;
}

 

function sm408_showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	  var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	  var sysAccept =<%=loginAccept%>;             	//��ˮ��
	  var printStr = sm408_printInfo(printType);
	  
		                      //����printinfo()���صĴ�ӡ����
	  var mode_code=null;           							  //�ʷѴ���
	  var fav_code=null;                				 		//�ط�����
	  var area_code=null;             				 		  //С������
	  var opCode=COM_OPCODE ;                   			 	//��������
	  var phoneNo="<%=activePhone%>";                  //�ͻ��绰
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+COM_OPCODE+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  
	  //window.open(path);	
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				
//��ӡģ��idΪ��122
function sm408_printInfo(printType){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
	  cust_info+="�ͻ�������   "+"<%=custName%>"+"|";
	  
	  
	  opr_info += "����ҵ�񣺺�Ŀҵ������" + "|";
	  opr_info += "������ˮ: "+"<%=loginAccept%>" +"|";
	  
	  opr_info += "�ն��ͺţ�"+"��Ŀ�ն�"+"    IMEI��"+$("#sm408_imei_no").val()+"    MAC��"+$("#sm408_imei_no").attr("v_t_mac")+ "|";
	  opr_info += "    �ն��ۼۣ�"+$("#sm408_i_pice").val()+"Ԫ" + "|";

		if($("#sm408_is_c_sa").val()=="1"){
			var offer_info_str = $("#sm408_sel_offer_info option:selected").text();
			if(offer_info_str.indexOf("->")!=-1){
				offer_info_str = offer_info_str.split("->")[1];
			}
			
	  	opr_info += "�ƴ洢�ײͣ�"+offer_info_str+"    ��Ч��ʽ��������Ч"+"|";
	  	opr_info += "�ײ�������"+$("#sm408_sel_offer_info option:selected").attr("v_offer_comments")+"|";
		}

		note_info1 += "��ע����Ŀ�ն��ṩ��ѱ�����Ϊ12���£��Բ�Ʒ����֮�տ�ʼ���㡣�������ڣ��뵽�ҹ�˾ָ���ص�����ۺ���"+"|";
		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}


//��ӡ��Ʊ
function sm408_show_Bill_Prt(){
		var custName       = "<%=custName%>";
		var phoneNo        = "<%=activePhone%>";
		var busiName       = "��Ŀ�ն˰���";
		var totalFee       = $("#sm408_i_pice").val();
		var prtLoginAccept = "<%=loginAccept%>";
		var shuilv         = "0.17";
	 	var billArgsObj    = new Object();
	 	
		$(billArgsObj).attr("10001","<%=workNo%>");     //����
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005",custName);   //�ͻ�����
		$(billArgsObj).attr("10006",busiName);    //ҵ�����
		$(billArgsObj).attr("10008",phoneNo);    //�û�����
		$(billArgsObj).attr("10015", totalFee);   //���η�Ʊ���
		$(billArgsObj).attr("10016", totalFee);   //��д���ϼ�
		$(billArgsObj).attr("10025", totalFee);   //��д���ϼ�
		
		var sumtypes1="*";
		var sumtypes2="";
		var sumtypes3="";
		$(billArgsObj).attr("10017",sumtypes1);        //���νɷѣ��ֽ�
		$(billArgsObj).attr("10018",sumtypes2);        //֧Ʊ
		$(billArgsObj).attr("10019",sumtypes3);        //ˢ��
		
		$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
	
		$(billArgsObj).attr("10036",COM_OPCODE);   //��������
	
		$(billArgsObj).attr("10041", "��Ϊ");              //Ʒ��
		$(billArgsObj).attr("10042","̨");                 //��λ
		$(billArgsObj).attr("10043","1");	                 //����
		$(billArgsObj).attr("10044",$("#sm408_i_pice").val());	 //����
		$(billArgsObj).attr("10045",$("#sm408_imei_no").attr("v_t_mac"));	 //IMEI
		$(billArgsObj).attr("10061",$("#sm408_sel_zdType").find("option:selected").text());	                 //�ͺ�
		
		
		$(billArgsObj).attr("10071","6");	    //��ӡģ��
		$(billArgsObj).attr("10062",shuilv);	//˰��
		$(billArgsObj).attr("10081","5");
   
 			
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
		var path = path +"&loginAccept=<%=loginAccept%>&opCode="+COM_OPCODE+"&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop);
			
}

//�Ƿ�����ƴ洢 �����ʷ��Ƿ���ʾ���۸�0.95��
function sm408_set_offerInfo(){
	if($("#sm408_is_c_sa").val()=="0"){
		$("#sm408_span_offerInfo1").hide();
		$("#sm408_i_pice").val($("#sm408_i_pice").attr("v_old_pice"));//����ԭʼ�۸�
		
	}else{
		$("#sm408_span_offerInfo1").show();
		$("#sm408_i_pice").val((parseInt($("#sm408_i_pice").val())*0.95).toFixed(2));
		
	}
}


//�ն����� ������ ���ü۸�
function sm408_set_Pice(){
	var selText = $("#sm408_sel_zdType option:selected").text();
	if("C12"== selText){
		$("#sm408_i_pice").val("<%=C12Str%>");
		$("#sm408_i_pice").attr("v_old_pice","<%=C12Str%>");
	}
	
	if("C13"== selText){
		$("#sm408_i_pice").val("<%=C13Str%>");
		$("#sm408_i_pice").attr("v_old_pice","<%=C13Str%>");
	}
	
	if("C15"== selText){
		$("#sm408_i_pice").val("<%=C15Str%>");
		$("#sm408_i_pice").attr("v_old_pice","<%=C15Str%>");
	}
	
	if("C20"== selText){
		$("#sm408_i_pice").val("<%=C20Str%>");
		$("#sm408_i_pice").attr("v_old_pice","<%=C20Str%>");
	}
	
	
	if("1" == $("#sm408_is_c_sa").val()){
		$("#sm408_i_pice").val((parseInt($("#sm408_i_pice").val())*0.95).toFixed(2));
	}
	
}

/*-------------------------------------------m408-----------------����------------------------------*/






/*-------------------------------------------m409-----------------��ʼ------------------------------*/


function sm409_chg_imei(bt){
	var offer_text = $(bt).parent().parent().find("td:eq(1)").text().trim();
	if(offer_text.indexOf("->")!=-1){
		var offerId = offer_text.split("->")[0];
		if(offerId=="0"){//���ʷѲ��ܴ���
			$("#sm409_sel_zdType").attr("v_Discount","N");
		}else{
			$("#sm409_sel_zdType").attr("v_Discount","Y");
		}
	}
	
	if($("#sm409_tab_chg_imei").is(":hidden")){
		$("#sm409_tab_chg_imei").show();
		$(bt).attr("disabled","disabled");
		$(bt).parent().parent().attr("chg_flag","1");
			if("Y" == $("#sm409_sel_zdType").attr("v_Discount")){
				$("#sm409_i_pice").val((parseInt($("#sm409_i_pice").val())*0.95).toFixed(2));
			}
	}else{
		rdShowMessageDialog("���ȱ����رձ��IMEI��");
	}
	
}
function sm409_closeChgIMEI(){
	$("#sm409_tab_chg_imei").hide();
	$("#sm409_imeiList_tab tr:gt(0)").each(function(){
		$(this).attr("chg_flag","0");
		$(this).find("input:disabled").removeAttr("disabled");
	});
}

//�ն����� ������ ���ü۸�
function sm409_set_Pice(){
	var selText = $("#sm409_sel_zdType option:selected").text();
	
	if("C12"==selText){
		$("#sm409_i_pice").val("272");
		$("#sm409_i_pice").attr("v_old_pice","272");
	}
	
	if("C13"==selText){
		$("#sm409_i_pice").val("194");
		$("#sm409_i_pice").attr("v_old_pice","194");
	}
	
	if("C15"==selText){
		$("#sm409_i_pice").val("377");
		$("#sm409_i_pice").attr("v_old_pice","377");
	}
	
	if("C20"==selText){
		$("#sm409_i_pice").val("461");
		$("#sm409_i_pice").attr("v_old_pice","461");
	}
	
	
	if("Y" == $("#sm409_sel_zdType").attr("v_Discount")){
		$("#sm409_i_pice").val((parseInt($("#sm409_i_pice").val())*0.95).toFixed(2));
	}
}


function sm409_go_chgIMeiCfm(){
		if($("#sm409_imei_no").val().trim()==""){
			rdShowMessageDialog("������IMEI��");
	    return;
		}
		
		var ret = sm409_chgIMei_showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
		
		sm409_show_Bill_Prt();
		
		if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
		
		
		var iImeiCode  = "";
		var iOldAccept = "";
		
		$("#sm409_imeiList_tab tr:gt(0)").each(function(){
			if($(this).attr("chg_flag")=="1"){
				iImeiCode  = $(this).find("td:eq(3)").text().trim();
				iOldAccept = $(this).find("td:eq(2)").text().trim();
			}
		});
		
		var packet = new AJAXPacket("fm409_Cfm.jsp","���Ժ�...");
        packet.data.add("opCode",COM_OPCODE);//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("loginAccept","<%=loginAccept%>");//
        packet.data.add("iImeiCode",iImeiCode);//
				packet.data.add("iOldAccept",iOldAccept);//
				packet.data.add("iFlag","4");//
				packet.data.add("iNewImeiCode",$("#sm409_imei_no").val());//
				packet.data.add("iOfferId","0");//
				packet.data.add("iMachineFee",$("#sm409_i_pice").val());//
    core.ajax.sendPacket(packet,sm409_do_washed);
    packet =null;
}

function sm409_do_washed(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			rdShowMessageDialog("�����ɹ�",2);
			reSetThis();
	}else{
		  rdShowMessageDialog("����ʧ�ܣ�"+code+"��"+msg,0);
	}
}





function sm409_washed_showPrtDlg(printType,DlgMessage,submitCfm,bt){  //��ʾ��ӡ�Ի��� 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	  var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	  var sysAccept =<%=loginAccept%>;             	//��ˮ��
	  
 
	  var	printStr = sm409_washed_printInfo(printType,bt);
	  
		                      //����printinfo()���صĴ�ӡ����
	  var mode_code=null;           							  //�ʷѴ���
	  var fav_code=null;                				 		//�ط�����
	  var area_code=null;             				 		  //С������
	  var opCode=COM_OPCODE;                   			 	//��������
	  var phoneNo="<%=activePhone%>";                  //�ͻ��绰
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path += "&mode_code="+mode_code+
				  	"&fav_code="+fav_code+"&area_code="+area_code+
				  	"&opCode="+COM_OPCODE+"&sysAccept="+sysAccept+
				  	"&phoneNo="+phoneNo+
				  	"&submitCfm="+submitCfm+"&pType="+
				  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				


//��ӡģ��idΪ��122 ����
function sm409_washed_printInfo(printType,bt){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
	  cust_info+="�ͻ�������   "+"<%=custName%>"+"|";
	  
  
	  opr_info += "����ҵ�񣺺�Ŀҵ���������" + "|";
	  opr_info += "������ˮ: "+"<%=loginAccept%>" +"|";
	  
		opr_info += "�ն��ͺţ�"+$(bt).parent().parent().find("td:eq(0)").text().trim()+
								"    IMEI��"+$(bt).parent().parent().find("td:eq(3)").text().trim()+ 
		            "    MAC��"+$(bt).parent().parent().find("td:eq(6)").text().trim()+"|";
	  opr_info += "    �ն��ۼۣ�"+$(bt).parent().parent().find("td:eq(4)").text().trim()+"|";


		var offer_info_str = $(bt).parent().parent().find("td:eq(1)").text().trim();
			if(offer_info_str.indexOf("->")!=-1){
				offer_info_str = offer_info_str.split("->")[1];
			}
			
	  opr_info += "�ƴ洢�ײͣ�"+offer_info_str+"    ��Ч��ʽ��������Ч"+"|";
	  opr_info += "�ײ�������"+$(bt).parent().parent().find("td:eq(5)").text().trim()+"|";


	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}



function sm409_chgIMei_showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	  var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	  var sysAccept =<%=loginAccept%>;             	//��ˮ��
	  
 
	  var	printStr = sm409_chgImei_printInfo(printType);
	  
		                      //����printinfo()���صĴ�ӡ����
	  var mode_code=null;           							  //�ʷѴ���
	  var fav_code=null;                				 		//�ط�����
	  var area_code=null;             				 		  //С������
	  var opCode=COM_OPCODE;                   			 	//��������
	  var phoneNo="<%=activePhone%>";                  //�ͻ��绰
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+COM_OPCODE+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				



//��ӡģ��idΪ��122 ����imei
function sm409_chgImei_printInfo(printType){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
	  cust_info+="�ͻ�������   "+"<%=custName%>"+"|";
	  
  
	  opr_info += "����ҵ�񣺺�Ŀҵ����" + "|";
	  opr_info += "������ˮ: "+"<%=loginAccept%>" +"|";
	  
	  
	 	var old_mac_code  = "";
		var old_zdType    = "";
		var old_imei_code = "";
		
	  $("#sm409_imeiList_tab tr:gt(0)").each(function(){
			if($(this).attr("chg_flag")=="1"){
				old_imei_code  = $(this).find("td:eq(3)").text().trim();
				old_mac_code   = $(this).find("td:eq(6)").text().trim();
				old_zdType     = $(this).find("td:eq(0)").text().trim();
			}
		});
		
	  opr_info += "ԭ�ն��ͺţ�"+old_zdType+"    ԭ�ն�IMEI��"+old_imei_code+"    ԭ�ն�MAC��"+old_mac_code+"|";
		opr_info += "���ն��ͺţ�"+$("#sm409_sel_zdType option:selected").text()+
								"    ���ն�IMEI��"+$("#sm409_imei_no").val()+
		            "    ���ն�MAC��"+$("#sm409_imei_no").attr("v_t_mac")+"|";
		opr_info += "    �ն��ۼۣ�"+$("#sm409_i_pice").val()+"Ԫ"+"|";

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}

//��ӡ��Ʊ
function sm409_show_Bill_Prt(){
		var custName       = "<%=custName%>";
		var phoneNo        = "<%=activePhone%>";
		var busiName       = "��Ŀ�ն˱��";
		var totalFee       = $("#sm409_i_pice").val();
		var prtLoginAccept = "<%=loginAccept%>";
		var shuilv         = "0.17";
	 	var billArgsObj    = new Object();
	 	
		$(billArgsObj).attr("10001","<%=workNo%>");     //����
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005",custName);   //�ͻ�����
		$(billArgsObj).attr("10006",busiName);    //ҵ�����
		$(billArgsObj).attr("10008",phoneNo);    //�û�����
		$(billArgsObj).attr("10015", totalFee);   //���η�Ʊ���
		$(billArgsObj).attr("10016", totalFee);   //��д���ϼ�
		$(billArgsObj).attr("10025", totalFee);   //��д���ϼ�
		
		var sumtypes1="*";
		var sumtypes2="";
		var sumtypes3="";
		$(billArgsObj).attr("10017",sumtypes1);        //���νɷѣ��ֽ�
		$(billArgsObj).attr("10018",sumtypes2);        //֧Ʊ
		$(billArgsObj).attr("10019",sumtypes3);        //ˢ��
		
		$(billArgsObj).attr("10030",prtLoginAccept);   //��ˮ�ţ�--ҵ����ˮ
	
		$(billArgsObj).attr("10036",COM_OPCODE);   //��������
	
		$(billArgsObj).attr("10041", "��Ϊ");              //Ʒ��
		$(billArgsObj).attr("10042","̨");                 //��λ
		$(billArgsObj).attr("10043","1");	                 //����
		$(billArgsObj).attr("10044",$("#sm409_i_pice").val());	 //����
		$(billArgsObj).attr("10045",$("#sm409_imei_no").val());	 //IMEI
		$(billArgsObj).attr("10061",$("#sm409_sel_zdType").find("option:selected").text());	                 //�ͺ�
		
		
		$(billArgsObj).attr("10071","6");	    //��ӡģ��
		$(billArgsObj).attr("10062",shuilv);	//˰��
		$(billArgsObj).attr("10081","5");
   
 			
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
		var path = path +"&loginAccept=<%=loginAccept%>&opCode="+COM_OPCODE+"&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop);
			
}


//��ȡ���е�imei�б�
function sm409_go_getImeiList(){
	  var packet = new AJAXPacket("fm409_getImeiList.jsp","���Ժ�...");
        packet.data.add("opCode",COM_OPCODE);//
        packet.data.add("idNo","<%=idNo%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
    core.ajax.sendPacket(packet,sm409_do_getImeiList);
    packet =null;
}

// �ص�
function sm409_do_getImeiList(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][1]+"->"+retArray[i][5]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+ //
														 "<td>"+retArray[i][4]+"</td>"+ //
														 "<td style='display:none'>"+retArray[i][6]+"</td>"+ //
														 "<td style='display:none'>"+retArray[i][7]+"</td>"+ //mac��ַ
														 "<td>"+
														 		   "<input type='button' class='b_text' value='����'     onclick='sm409_go_washed(this)' />"+
															    	"&nbsp;"+
															    	"&nbsp;"+
															     "<input type='button' class='b_text' value='���IMEI' onclick='sm409_chg_imei(this)' />";
														 
														 "</td>"+//
														
												 "</tr>";
			}
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#sm409_imeiList_tab tr:gt(0)").remove();
			$("#sm409_imeiList_tab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}

//m409 ����
function sm409_go_washed(bt){
		var ret = sm409_washed_showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes",bt); 
		
	  if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
	  
	  var offer_id = "";
	  var offerId_text = $(bt).parent().parent().find("td:eq(1)").text().trim();
	  if(offerId_text.indexOf("->")!=-1){
	  	offer_id = offerId_text.split("->")[0];
	  }
	  
		var packet = new AJAXPacket("fm409_Cfm.jsp","���Ժ�...");
        packet.data.add("opCode",COM_OPCODE);//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("loginAccept","<%=loginAccept%>");//
        packet.data.add("iImeiCode",$(bt).parent().parent().find("td:eq(3)").text().trim());//
				packet.data.add("iOldAccept",$(bt).parent().parent().find("td:eq(2)").text().trim());//
				packet.data.add("iFlag","5");//
				packet.data.add("iNewImeiCode","");//
				packet.data.add("iOfferId","");//
				packet.data.add("iMachineFee",$(bt).parent().parent().find("td:eq(4)").text().trim());//
    core.ajax.sendPacket(packet,sm409_do_washed);
    packet =null;
}

function sm409_do_washed(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			rdShowMessageDialog("�����ɹ�",2);
			reSetThis();
	}else{
		  rdShowMessageDialog("����ʧ�ܣ�"+code+"��"+msg,0);
	}
}


/*-------------------------------------------m409-----------------����------------------------------*/





/*-------------------------------------------m410-----------------��ʼ------------------------------*/

function sm410_go_getImeiList(){
	  var packet = new AJAXPacket("fm409_getImeiList.jsp","���Ժ�...");
        packet.data.add("opCode",COM_OPCODE);//
        packet.data.add("idNo","<%=idNo%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
    core.ajax.sendPacket(packet,sm410_do_getImeiList);
    packet =null;
}
// �ص�
function sm410_do_getImeiList(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			
			
			var offer_select_html = "<select  style='width:170px;'> "+
														  "<%=offerSelect_opt%>"+
															"	</select> ";
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ //
														 //"<td>"+retArray[i][1]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td>"+offer_select_html+"</td>"+ //
														 "<td style='display:none'>"+retArray[i][7]+"</td>"+ //mac��ַ
														 "<td>"+
														 		   "<input type='button' class='b_text' value='����' onclick='sm410_go_Cfm(this)' />";
														 "</td>"+//
												 "</tr>";
			}
			
			
	 
	
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#sm410_imeiList_tab tr:gt(0)").remove();
			$("#sm410_imeiList_tab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}


function sm410_go_Cfm(bt){
 
		if(!check(msgFORM)) return false;
		
		var ret = sm410_showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes",bt); 
		
		
		if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
		
	  var packet = new AJAXPacket("fm410_Cfm.jsp","���Ժ�...");
	  
	      packet.data.add("opCode",COM_OPCODE);//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("loginAccept","<%=loginAccept%>");//
        packet.data.add("iOfferId",$(bt).parent().parent().find("select").val());//
        packet.data.add("iEmeiCode","");//
        packet.data.add("iEmeiCodeOld",$(bt).parent().parent().find("td:eq(1)").text().trim());//
        packet.data.add("opNote","��ע��<%=activePhone%>����m410����Ŀ�ն��ײͶ��� ");//
        
    core.ajax.sendPacket(packet,sm410_do_Cfm);
    packet =null;
}

// �ص�
function sm410_do_Cfm(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			rdShowMessageDialog("�����ɹ�",2);
			reSetThis();
	}else{
		  rdShowMessageDialog("����ʧ�ܣ�"+code+"��"+msg,0);
	}
}





function sm410_showPrtDlg(printType,DlgMessage,submitCfm,bt){  //��ʾ��ӡ�Ի��� 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	  var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	  var sysAccept =<%=loginAccept%>;             	//��ˮ��
	  
	  var printStr = sm410_printInfo(printType,bt);
	  
		                      //����printinfo()���صĴ�ӡ����
	  var mode_code=null;           							  //�ʷѴ���
	  var fav_code=null;                				 		//�ط�����
	  var area_code=null;             				 		  //С������
	  var opCode=COM_OPCODE;                   			 	//��������
	  var phoneNo="<%=activePhone%>";                  //�ͻ��绰
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+COM_OPCODE+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				

//��ӡģ��idΪ��122 ����imei
function sm410_printInfo(printType,bt){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
	  cust_info+="�ͻ�������   "+"<%=custName%>"+"|";
	  
  
	  opr_info += "����ҵ���ƴ洢�ײͶ���" + "|";
	  opr_info += "������ˮ: "+"<%=loginAccept%>" +"|";
	  
	  opr_info += "�ն��ͺţ�"+$(bt).parent().parent().find("td:eq(0)").text().trim()+
	  						"    IMEI��"+$(bt).parent().parent().find("td:eq(1)").text().trim()+
	  						"    MAC��"+$(bt).parent().parent().find("td:eq(4)").text().trim()+"|";
		
		
		var offer_info_str = $(bt).parent().parent().find("select option:selected").text();
			if(offer_info_str.indexOf("->")!=-1){
				offer_info_str = offer_info_str.split("->")[1];
			}
				  						
	  opr_info += "�ƴ洢�ײͣ�"+offer_info_str+"    ��Ч��ʽ��������Ч"+"|";
	  opr_info += "�ײ�������"+$(bt).parent().parent().find("select option:selected").attr("v_offer_comments")+"|";
	  
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}

/*-------------------------------------------m410-----------------����------------------------------*/




/*-------------------------------------------m411-----------------��ʼ------------------------------*/
function sm411_go_getImeiList(){
	  var packet = new AJAXPacket("fm409_getImeiList.jsp","���Ժ�...");
        packet.data.add("opCode",COM_OPCODE);//
        packet.data.add("idNo","<%=idNo%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
    core.ajax.sendPacket(packet,sm411_do_getImeiList);
    packet =null;
}
// �ص�
function sm411_do_getImeiList(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			
			
			var offer_select_html = "<select  style='width:170px;'> "+
														  "<%=offerSelect_opt%>"+
															"	</select> ";
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+ //
														 "<td>"+retArray[i][1]+"->"+retArray[i][5]+"</td>"+ //
														 "<td>"+offer_select_html+"</td>"+ //
														 "<td style='display:none'>"+retArray[i][6]+"</td>"+ //
														 "<td style='display:none'>"+retArray[i][7]+"</td>"+ //mac��ַ
														 "<td>"+
														 		   "<input type='button' class='b_text' value='����' onclick='sm411_go_Cfm(this)' />";
														 "</td>"+//
												 "</tr>";
			}
			
			
	 
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#sm411_imeiList_tab tr:gt(0)").remove();
			$("#sm411_imeiList_tab tr:eq(0)").after(trObjdStr);
			sm411_setChg_offer();//����Ҫչʾ�Ѷ����ʷѣ���js����һ��
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}

function sm411_setChg_offer(){
	$("#sm411_imeiList_tab tr:gt(0)").each(function(){
		var old_offer_text = $(this).find("td:eq(2)").text().trim();
		
		var old_offerId = "";
		if(old_offer_text.indexOf("->")!=-1){
		 old_offerId = old_offer_text.split("->")[0];
		}
		
		$(this).find("select option").each(function(){
			var new_offerId = $(this).val();
			if(old_offerId==new_offerId){
				$(this).remove();
			}
		});
		
	});
}

function sm411_go_Cfm(bt){
 
		if(!check(msgFORM)) return false;
		
		var ret = sm411_showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes",bt); 
		
		
		if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
		
		
	  var packet = new AJAXPacket("fm410_Cfm.jsp","���Ժ�...");

		    packet.data.add("opCode",COM_OPCODE);//
		    packet.data.add("phoneNo","<%=activePhone%>");//
		    packet.data.add("loginAccept","<%=loginAccept%>");//
		    packet.data.add("iOfferId",$(bt).parent().parent().find("select").val());//
		    packet.data.add("iEmeiCode","");//
		    packet.data.add("iEmeiCodeOld",$(bt).parent().parent().find("td:eq(1)").text().trim());//
        packet.data.add("opNote","��ע��<%=activePhone%>����m411����Ŀ�ն��ײͱ��");//
        
    core.ajax.sendPacket(packet,sm410_do_Cfm);
    packet =null;
    
    
}





function sm411_showPrtDlg(printType,DlgMessage,submitCfm,bt){  //��ʾ��ӡ�Ի��� 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	  var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	  var sysAccept =<%=loginAccept%>;             	//��ˮ��
	  
	  var printStr = sm411_printInfo(printType,bt);
	  
		                      //����printinfo()���صĴ�ӡ����
	  var mode_code=null;           							  //�ʷѴ���
	  var fav_code=null;                				 		//�ط�����
	  var area_code=null;             				 		  //С������
	  var opCode=COM_OPCODE;                   			 	//��������
	  var phoneNo="<%=activePhone%>";                  //�ͻ��绰
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+COM_OPCODE+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				

//��ӡģ��idΪ��122 
function sm411_printInfo(printType,bt){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
	  cust_info+="�ͻ�������   "+"<%=custName%>"+"|";
	  
  
	  opr_info += "����ҵ���ƴ洢�ײͱ��" + "|";
	  opr_info += "������ˮ: "+"<%=loginAccept%>" +"|";
	  
	  opr_info += "�ն��ͺţ�"+$(bt).parent().parent().find("td:eq(0)").text().trim()+
	 					"    IMEI��"+$(bt).parent().parent().find("td:eq(1)").text().trim()+
						"    MAC��"+$(bt).parent().parent().find("td:eq(5)").text().trim()+"|";

		var offer_info_str1 = $(bt).parent().parent().find("td:eq(2)").text().trim();
			if(offer_info_str1.indexOf("->")!=-1){
				offer_info_str1 = offer_info_str1.split("->")[1];
			}

		var offer_info_str2 = $(bt).parent().parent().find("select option:selected").text();
			if(offer_info_str2.indexOf("->")!=-1){
				offer_info_str2 = offer_info_str2.split("->")[1];
			}
			
						
	  opr_info += "ԭ�ƴ洢�ײͣ�"+offer_info_str1+"|";
	  opr_info += "�ײ�������"+$(bt).parent().parent().find("td:eq(4)").text().trim()+"|";
	  
	  opr_info += "���ƴ洢�ײͣ�"+offer_info_str2+"|";
	  opr_info += "�ײ�������"+$(bt).parent().parent().find("select option:selected").attr("v_offer_comments")+"|";
	  
	  opr_info += "��Ч��ʽ��ԤԼ��Ч"+"|";


	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}


/*-------------------------------------------m411-----------------����------------------------------*/




/*-------------------------------------------m412-----------------��ʼ------------------------------*/
function sm412_go_getImeiList(){
	  var packet = new AJAXPacket("fm409_getImeiList.jsp","���Ժ�...");
        packet.data.add("opCode",COM_OPCODE);//
        packet.data.add("idNo","<%=idNo%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
    core.ajax.sendPacket(packet,sm412_do_getImeiList);
    packet =null;
}
// �ص�
function sm412_do_getImeiList(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			
			
			var offer_select_html = "<select  style='width:170px;'> "+
														  "<%=offerSelect_opt%>"+
															"	</select> ";
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+ //
														 "<td>"+retArray[i][1]+"->"+retArray[i][5]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td style='display:none'>"+retArray[i][6]+"</td>"+ //
														 "<td style='display:none'>"+retArray[i][7]+"</td>"+ //mac��ַ
														 "<td>"+
														 		   "<input type='button' class='b_text' value='�˶�' onclick='sm412_go_Cfm(this)' />";
														 "</td>"+//
												 "</tr>";
			}
			
			
	 
	
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#sm412_imeiList_tab tr:gt(0)").remove();
			$("#sm412_imeiList_tab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}





function sm412_go_Cfm(bt){
 
		if(!check(msgFORM)) return false;
		
		var ret = sm412_showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes",bt); 
		
		if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
		
		var j_iOfferId = "";
		var td_2_text  = $(bt).parent().parent().find("td:eq(2)").text().trim();
		if(td_2_text.indexOf("->")!=-1){
			j_iOfferId = td_2_text.split("->")[0];
		}
				
	  var packet = new AJAXPacket("fm410_Cfm.jsp","���Ժ�...");

		    packet.data.add("opCode",COM_OPCODE);//
		    packet.data.add("phoneNo","<%=activePhone%>");//
		    packet.data.add("loginAccept","<%=loginAccept%>");//
		    packet.data.add("iOfferId",j_iOfferId);//
		    packet.data.add("iEmeiCode","");//
		    packet.data.add("iEmeiCodeOld",$(bt).parent().parent().find("td:eq(1)").text().trim());//
		    packet.data.add("opNote","��ע��<%=activePhone%>����m412����Ŀ�ն��ײ��˶�");//
        
    core.ajax.sendPacket(packet,sm410_do_Cfm);
    packet =null;
    
}





function sm412_showPrtDlg(printType,DlgMessage,submitCfm,bt){  //��ʾ��ӡ�Ի��� 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	  var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	  var sysAccept =<%=loginAccept%>;             	//��ˮ��
	  
	  var printStr = sm412_printInfo(printType,bt);
	  
		                      //����printinfo()���صĴ�ӡ����
	  var mode_code=null;           							  //�ʷѴ���
	  var fav_code=null;                				 		//�ط�����
	  var area_code=null;             				 		  //С������
	  var opCode=COM_OPCODE;                   			 	//��������
	  var phoneNo="<%=activePhone%>";                  //�ͻ��绰
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+COM_OPCODE+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				

//��ӡģ��idΪ�� 
function sm412_printInfo(printType,bt){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
	  cust_info+="�ͻ�������   "+"<%=custName%>"+"|";
	  
  
	  opr_info += "����ҵ���ƴ洢�ײ��˶�" + "|";
  	opr_info += "������ˮ: "+"<%=loginAccept%>" +"|";
  
	  opr_info += "�ն��ͺţ�"+$(bt).parent().parent().find("td:eq(0)").text().trim()+
	              "    IMEI��"+$(bt).parent().parent().find("td:eq(1)").text().trim()+
								"    MAC��"+$(bt).parent().parent().find("td:eq(5)").text().trim()+"|";


		var offer_info_str = $(bt).parent().parent().find("td:eq(2)").text().trim();
			if(offer_info_str.indexOf("->")!=-1){
				offer_info_str = offer_info_str.split("->")[1];
			}
			
			
	  opr_info += "�ƴ洢�ײͣ�"+offer_info_str+"    ��Ч��ʽ��������Ч"+"|";
	  opr_info += "�ײ�������"+$(bt).parent().parent().find("td:eq(4)").text().trim()+"|";
	  

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}


/*-------------------------------------------m412-----------------����------------------------------*/

$(document).ready(function(){
	$("#radio_<%=opCode%>").click();
	
});

function pub_set_radio(bt){
	$(bt).prev().click();
	
}
function show_p_div(bt,check_opcode){
	$("div[id^=div_show_]").hide();
	$("#div_show_"+$(bt).val()).show();
	COM_OPCODE = check_opcode;
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>

<!----------------------------------------------��������-----------------��ʼ----------------------------->
<table cellSpacing="0">
	<tr>
		<td class="blue" align="center">
			<input type="radio" id="radio_m408"  value="m408" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m408')" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">m408����Ŀ�ն˰���</span>
			&nbsp;&nbsp;
			<input type="radio" id="radio_m409"  value="m409" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m409'),sm409_go_getImeiList()" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">m409����Ŀ�ն˱��</span>
			&nbsp;&nbsp;
			<input type="radio" id="radio_m410"  value="m410" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m410'),sm410_go_getImeiList()" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">m410����Ŀ�ն��ײͶ���</span>
			&nbsp;&nbsp;
			<input type="radio" id="radio_m411"  value="m411" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m411'),sm411_go_getImeiList()" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">m411����Ŀ�ն��ײͱ��</span>
			&nbsp;&nbsp;
			<input type="radio" id="radio_m412"  value="m412" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m412'),sm412_go_getImeiList()" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">m412����Ŀ�ն��ײ��˶�</span>
		</td>
	</tr>
</table>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">�ֻ�����</td>
		  <td width="35%">
			    <%=activePhone%>
		  </td>
		  <td class="blue">�ͻ�����</td>
		  <td>
			    <%=custName%>
		  </td>
	</tr>
</table>


<!----------------------------------------------��������-----------------����----------------------------->



<!----------------------------------------------m408-----------------��ʼ----------------------------->
<div id="div_show_m408"> 
	
	
<table cellSpacing="0">
	<tr>
	    
		  <td class="blue" width="15%">�ն�����</td>
		  <td width="35%">
			    <select id="sm408_sel_zdType" onchange="sm408_set_Pice()">
			    	<% 
			    	for (int i=0; i<result_dic_C.length;i++){
			    	%>
			    	<option value="<%=result_dic_C[i][0]%>"><%=result_dic_C[i][1]%></option>
			    	<%
			    	}
			    	%>
			    </select>
		  </td>
		  
		  <td class="blue" width="15%">�ն˼۸�</td>
		  <td width="35%">
			    <input type="text"  value="<%=C12Str%>" name="sm408_i_pice" id="sm408_i_pice"  v_old_pice="272" readyOnly="readOnly" class="InputGrey"/>
		  </td>
		  
	</tr>
	
	<tr>
	    <td class="blue">IMEI��</td>
		  <td>
			    <input type="text"  value="" name="sm408_imei_no" id="sm408_imei_no" v_type="0_9" v_t_mac="";    onblur="checkElement(this),fm408_go_getMac_ByImei(this)" maxlength="15" />
		  </td>
		  
		  <td class="blue">�Ƿ�����ƴ洢</td>
		  <td>
			    <select id="sm408_is_c_sa" onchange="sm408_set_offerInfo()" >
			    	<option value="0">��</option>
						<option value="1">��</option>
					</select>
		  </td>
		  
	</tr>
	
		<tr id="sm408_span_offerInfo1" style="display:none">
		  <td class="blue"> �ײ���Ϣ </td>
		  <td colspan="3">
			    <select id="sm408_sel_offer_info" style="width:170px;">
			    	<%=offerSelect_opt%>
					</select>
		  </td>
	</tr>
	
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="sm408_go_Cfm()"            />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>


</div>
<!----------------------------------------------m408-----------------����----------------------------->





<!----------------------------------------------m409-----------------��ʼ----------------------------->
<div id="div_show_m409"> 

<table cellSpacing="0" id="sm409_imeiList_tab">
		<tr>
			<th width="17%">�ն�����</th>
			<th width="17%">�ʷ�</th>
			<th width="17%">������ˮ</th>
			<th width="17%">IMEI</th>
			<th width="17%">����</th>
			<th >����</th>
		</tr>
		 
</table>

<table cellSpacing="0" id="sm409_tab_chg_imei" style="display:none">	
	<tr>
 
		  <td class="blue" width="15%">�ն�����</td>
		  <td  width="35%">
			    <select id="sm409_sel_zdType" v_Discount="" onchange="sm409_set_Pice()">
			    	<% 
			    	for (int i=0; i<result_dic_C.length;i++){
			    	%>
			    	<option value="<%=result_dic_C[i][0]%>"><%=result_dic_C[i][1]%></option>
			    	<%
			    	}
			    	%>
			    </select>
		  </td>
		  
		  <td class="blue"  width="15%">�ն˼۸�</td>
		  <td  width="35%">
			    <input type="text"  value="272" name="sm409_i_pice" id="sm409_i_pice"  v_old_pice="272" readyOnly="readOnly" class="InputGrey"/>
		  </td>
	</tr>
	
	<tr>
	    <td class="blue">IMEI��</td>
		  <td>
			    <input type="text"  value="" name="sm409_imei_no" id="sm409_imei_no" v_type="0_9"  v_t_mac="";  onblur="checkElement(this),fm408_go_getMac_ByImei(this)" maxlength="15"  />
		  </td>
		  
			<td class="blue">&nbsp;</td>
		  <td>
			   &nbsp;
		  </td>
		  
	<tr>
	 	<td align="center" colspan="4">
	 		<input type="button" class="b_foot" value="����" onclick="sm409_go_chgIMeiCfm()"            />
	 		<input type="button" class="b_foot" value="�ر�" onclick="sm409_closeChgIMEI()"            />
	 	</td>
	</tr>
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

</div>
<!----------------------------------------------m409-----------------����----------------------------->	








<!----------------------------------------------m410-----------------��ʼ----------------------------->
<div id="div_show_m410"> 

<table cellSpacing="0" id="sm410_imeiList_tab">
		<tr>
			<th width="20%">�ն�����</th>
			<th width="20%">IMEI</th>
			<th width="20%">������ˮ</th>
			<th width="20%">���ʷ�</th>
			<th width="20%">����</th>
		</tr>
</table>




</div>
<!----------------------------------------------m410-----------------����----------------------------->	







<!----------------------------------------------m411-----------------��ʼ----------------------------->
<div id="div_show_m411"> 
 
<table cellSpacing="0" id="sm411_imeiList_tab" >
		<tr>
			<th width="20%">�ն�����</th>
			<th width="20%">IMEI</th>
			<th width="20%">ԭ�ʷ�</th>
			<th width="20%">���ʷ�</th>
			<th width="20%">����</th>
		</tr>
 
</table>



<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
</div>
<!----------------------------------------------m411-----------------����----------------------------->	




	
	
<!----------------------------------------------m412-----------------��ʼ----------------------------->
<div id="div_show_m412"> 
  
<table cellSpacing="0" id="sm412_imeiList_tab" >
		<tr>
			<th width="20%">�ն�����</th>
			<th width="20%">IMEI</th>
			<th width="20%">�ʷ�</th>
			<th width="20%">��ˮ</th>
			<th width="20%">����</th>
		</tr>
 
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
</div>
<!----------------------------------------------m412-----------------����----------------------------->	
			
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>