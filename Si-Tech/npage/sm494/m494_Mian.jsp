<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)[]------------------
 
 
 -------------------------��̨��Ա��[]--------------------------------------------
 
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
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>

//�ֻ�����
var PHONE_NO      = "";
//��ʼ��IMEI��Ȩ�ն����� N=�ֻ�  H=pad
var ARR_IMEI_TYPE = new Array("N","H");


/**
 * �Ƚ�2��������������
 * ���strDateStart ��ʼʱ�䣬����С�ڽ���ʱ��
 * ���strDateEnd   ����ʱ��  ������ڿ�ʼʱ��
 * ʱ���ʽ��Ϊ YYYYmmdd
 * �� 20161101 �� 20161110 ���ؽ��Ϊ9
 */
onload=function(){	  
  getIdCitys();
  getShopInfo();
}
function getIdCitys(){
	var pactket = new AJAXPacket("m494_ajax.jsp","���ڽ���13�����в�ѯ�����Ժ�......");
 	
			pactket.data.add("opCode","<%=opCode%>");
			
			core.ajax.sendPacketHtml(pactket,do_Query);
			pactket=null;
}
function getShopInfo(){
	var shop = $('#shopInfo option:selected').val();
	var pactket = new AJAXPacket("m494_ajax1.jsp","���ڽ�����Ϣ��ѯ�����Ժ�......");
 	//alert("shop:"+shop);
	pactket.data.add("opCode","<%=opCode%>");
	pactket.data.add("shop",shop);
	core.ajax.sendPacket(pactket,do_Query1);
	pactket=null;
}
function do_Query(data){
	//alert(data);
			//�ҵ���ӵ�select
				var markDiv=$("#tdappendSome"); 
				//���ԭ�б��
				markDiv.empty();
				markDiv.append(data);
}	
function do_Query1(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
		var retArray = packet.data.findValueByName("retArray");
		//alert(retArray);
		var markDiv=$("#tb_ifof2"); 
		//���ԭ�б��
		markDiv.empty();
		if ($("#tb_ifof2 th").length==0 )
		{
			$("#tb_ifof2").append("<tr>"
				+"<th align='center' width='20%'>��������</th>"
				+"<th align='center' width='20%' >�ֻ�����</th>"
				+"<th align='center' width='20%' >�����ܽ��</th>"
				+"<th align='center' width='20%' >����ʱ��</th>"
				+"<th align='center' width='20%' >����</th>"
			+"</tr>");
		}	
		for(var i=0;i<retArray.length;i++){
			$("#tb_ifof2").append("<tr>"
					+"<td align='center'>"
						+"<input type='text' name='o_addId'  ch_name='��������' value='"+retArray[i][0]+"' class='InputGrey' readOnly >"
						+"<input type='hidden' name='o_backFlag' id='o_backFlag"+i+"'  ch_name='' value='"+retArray[i][1]+"'>"
						+"<input type='hidden' name='o_regionCode' id='o_regionCode"+i+"'  ch_name='' value='"+retArray[i][4]+"'>"
					+"</td>"
					+"<td align='center'>"
						+"<input type='text' name='o_addName'  ch_name='�ֻ�����' value='"+retArray[i][1]+"' class='InputGrey' readOnly >"
					+"</td>"	
					+"<td align='center'>"
						+"<input type='text' name='o_efftime'  ch_name='�����ܽ��' "
							+"  value='"+retArray[i][2]+"' class='InputGrey' readOnly >"
					+"</td>"				
					+"<td align='center'>"
						+"<input type='text' name='o_exptime'  ch_name='����ʱ��' "
							+" value='"+retArray[i][3]+"' class='InputGrey' readOnly >"
					+"</td>"		
														
					+"<td align='center'>"
						+"<input type ='button' value='����' class='b_text'  id='b_back"+i+"' "
							+"style='cursor:Pointer;' class='del_cls'  alt='' "  
									
							+" onclick='fn_back("+i+")'>"	
											
											
					+"</td>"		
				+"</tr>");	
				
		}
		
		
		
	}else{
		rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
	
}

function fn_back( i )
{
	$("#b_back"+i).attr("disabled" , true);
	var pactket = new AJAXPacket("m494_chk.jsp","���ڽ�����Ϣ��ѯ�����Ժ�......");
	pactket.data.add("iLoginAccept" 		,'<%=loginAccept%>');
	pactket.data.add("iChnSource" 		,"01");
	pactket.data.add("iOpCode" 			,"<%=opCode%>");
	pactket.data.add("iLoginNo" 			,"<%=workNo%>");
	pactket.data.add("iLoginPwd" 		,"<%=password%>");
	pactket.data.add("iPhoneNo" 			,$('#o_backFlag'+i).val());
	pactket.data.add("iUserPwd" 			,"");
	pactket.data.add("iRegionCode"      ,$('#o_regionCode'+i).val());
	
	core.ajax.sendPacket(pactket,function(pactket){
		var code = pactket.data.findValueByName('code');
		var msg = pactket.data.findValueByName('msg');
		//alert(code+":"+msg);
		if ("000000" == code){
			if(!check(msgFORM)) return false;
			//show_bill_Prt();//��ӡ��Ʊ
		  //var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
		 	
			var myPacket = new AJAXPacket("m494_orderDraw.jsp","���������ύ�����Ժ�...");
			myPacket.data.add("accept",'<%=loginAccept%>' );
			myPacket.data.add("opCode", '<%=opCode%>');
			myPacket.data.add("phoneNo", $('#o_backFlag'+i).val());
			
			core.ajax.sendPacket(myPacket, function(packet){
					
					alert(errorCode+"aa:bb"+errorMsg);
					var errorCode = packet.data.findValueByName('errorCode');
					var errorMsg = packet.data.findValueByName('errorMsg');
					if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
					if ("000000" == errorCode){
							rdShowMessageDialog("�����ɹ���");
					} else {
							rdShowMessageDialog("����ʧ�ܣ�" + errorCode + errorMsg, 1);
					}
			});
			
			myPacket = null;
		}else{
			rdShowMessageDialog("����ʧ�ܣ�" + code + msg, 2);
		}
	});
	pactket=null;
	
			
			
	
}
function fn_chk(i)//����֤
{
	
}
function do_chk(){
	
}

function change_idType()//����֤
{
	var city = document.all.idType.value;
	if(document.all.idType.value=="00")
    { 
      /*ajax\*/
		//var packet = new AJAXPacket("fm494_ajax1.jsp","���Ժ�...");
		//packet.data.add("iLoginAccept" 		,"");
		//packet.data.add("iChnSource" 		,"01");
		//packet.data.add("iOpCode" 			,"");
		
	 
		//core.ajax.sendPacket(packet		,fn_doQryMPIfo,true);//�첽	
   		
    	
    }
}	
<%--
function getDays(strDateStart,strDateEnd){
	
   var strDateS = new Date(
   													parseInt(strDateStart.substring(0,4)), 
   													parseInt(strDateStart.substring(4,6))-1, 
   													parseInt(strDateStart.substring(6,8))
   												);
   												
   var strDateE = new Date(  
   													parseInt(strDateEnd.substring(0,4)),   
   													parseInt(strDateEnd.substring(4,6))-1,   
   													parseInt(strDateEnd.substring(6,8))
   											  );
   
   var iDays = parseInt(Math.abs(strDateE - strDateS ) / 1000 / 60 / 60 /24)//�����ĺ�����ת��Ϊ����
   
   return iDays ;
}

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}


//��ѯ�ͻ�������Ϣ
function getAjaxInfo(){
    var packet = new AJAXPacket("ajaxGetServRe.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("cust_name",$("#cust_name").val());//
    core.ajax.sendPacket(packet,doGetAjaxInfo);
    packet =null;
}
//��ѯ�ͻ�������Ϣ�ص�
function doGetAjaxInfo(packet){
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

//
function go_Query(){
	if($("#phoneNo").val().trim()==""){
		rdShowMessageDialog("�������ֻ�����");
		return;
	}
	//m239��������ҵ��ͨ״̬��ѯ  ��ӡ�������÷������״̬
 	var pactket = new AJAXPacket("/npage/sm390/fm390UpDserv.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
			pactket.data.add("id_no","0");
			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("paySeq",$("#accepts").val().trim());
			core.ajax.sendPacket(pactket,do_Query);
			pactket=null;
}

--%>





<%--
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
 			//$(billArgsObj).attr("10088","m404"); //�վ�ģ��
 			

 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			
			$(billArgsObj).attr("11213","REC");  //�°淢Ʊ����Ʊ�ݱ�־λ��Ĭ�Ͽ�λ��Ʊ REC = �վ�
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
			
			
			var path = path +"&loginAccept=<%=loginAccept%>&opCode=<%=opCode%>&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
			
}--%>

<%--
function frmCfm(){
	  frm.submit();
	  return true;
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
$(document).ready(function(){
	//�Զ���ѯ�Ѿ���Ȩ��IMEI�б�
	ajaxGetAndroidCrmUpgList();
});
--%>
//չʾ�ƶ��̳ǳ�ʱ�ܳ�����Ϣ
function fn_doQryMPIfo( packet )
{
	<%--var v_oRetCode=packet.data.findValueByName("code");
	var v_oRetMsg=packet.data.findValueByName("msg");
	
	if ( "000000"==v_oRetCode )
	{

		var v_jsn=packet.data.findValueByName("retArray") ;

		var v_jsn1 = JSON.parse(v_jsn,function(key,value){
			return value;
		});
		
		document.all.showText.value=v_jsn;
		if ($("#tb_ifof2 th").length==0 )
		{
			$("#tb_ifof2").append("<tr>"
				+"<th align='center' >��������</th>"
				+"<th align='center' >�ֻ�����</th>"
				+"<th align='center' >�����ܽ��</th>"
				+"<th align='center' >����ʱ��</th>"
				
			+"</tr>");
		}		
		
		var i=0;

		while (v_jsn1.ProdInfo[i]!=null )
		{
			var j=0;
			var s_ServiceID="";
			var s_AttrKey="";
			var s_AttrValue="";
			
			if (v_jsn1.ProdInfo[i].ProdAttrInfo!=null)
			{
				while ( v_jsn1.ProdInfo[i].ProdAttrInfo[j]!=null  )
				{
					s_ServiceID=s_ServiceID+v_jsn1.ProdInfo[i].ProdAttrInfo[j].ServiceID+"@";
					s_AttrKey=s_AttrKey+v_jsn1.ProdInfo[i].ProdAttrInfo[j].AttrKey+"@";
					s_AttrValue=s_AttrValue+v_jsn1.ProdInfo[i].ProdAttrInfo[j].AttrValue+"@";
					j=j+1;
				}				
			}
			
			
			var ret_S = "";
			var is_disabled = "";
			
			if("A"==v_jsn1.ProdInfo[i].State){
				ret_S = "����";
			}else if("F"==v_jsn1.ProdInfo[i].State){
				ret_S = "��ͣ";
			}else{
				ret_S = "���˶�";
				is_disabled = "disabled";
			}
			
			
			var v_dis = v_jsn1.ProdInfo[i].State=="A" ? "disabled" :" ";
			
			$("#tb_ifof2").append("<tr>"
				+"<td align='center'>"
					+"<input type='text' name='o_addId'  ch_name='��������' value='"+v_jsn1.ProdInfo[i].OfferId+"' class='InputGrey' readOnly >"
					+"<input type='hidden' name='o_backFlag' id='o_backFlag"+i+"'  ch_name='' value='0'>"
					+"<input type='hidden' name='o_ServiceID' id='o_ServiceID"+i+"'  ch_name='' value='"+s_ServiceID+"'>"
					+"<input type='hidden' name='o_AttrKey' id='o_AttrKey"+i+"'  ch_name='' value='"+s_AttrKey+"'>"
					+"<input type='hidden' name='o_AttrValue' id='o_AttrValue"+i+"'  ch_name='' value='"+s_AttrValue+"'>"
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' name='o_addName'  ch_name='�ֻ�����' value='"+v_jsn1.ProdInfo[i].OfferName+"' class='InputGrey' readOnly >"
				+"</td>"	
				+"<td align='center'>"
					+"<input type='text' name='o_efftime'  ch_name='�����ܽ��' "
						+"  value='"+v_jsn1.ProdInfo[i].ProdInstEffTime+"' class='InputGrey' readOnly >"
				+"</td>"				
				+"<td align='center'>"
					+"<input type='text' name='o_exptime'  ch_name='����ʱ��' "
						+" value='"+v_jsn1.ProdInfo[i].ProdInstExpTime+"' class='InputGrey' readOnly >"
				+"</td>"		
				+"<td align='center' width='50px'>"
					+
					 ret_S
				+"</td>"										
				+"<td align='center'>"
					+"<input type ='button' value='�˶�' class='b_text'  id='b_back"+i+"' "
						+"style='cursor:Pointer;' class='del_cls'  alt='' "  
						
						+  
						is_disabled
						
						+" onclick='fn_back("+i+")'>"	
											
				+"</td>"		
			+"</tr>");	
			i=i+1;		
		}	
	}
	else
	{
		rdShowMessageDialog(v_oRetCode+":"+v_oRetMsg , 0);	
		return false;	
	}--%>	
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>
<table  id='tb_ifof1'>
	<tr>
		<td class="blue" width="16%">����</td>
		<td class="blue" id="tdappendSome" >
				
		</td>
	</tr>
</table>
<div class="title" >
			<div id="title_zi">�ƶ��̳ǳ�ʱ</div>
		</div>
		<table   id='tb_ifof2'>
			<tr>
				<th>��������</th>		
				<th>�ֻ�����</th>		
				<th>�����ܽ��</th>		
				<th>����ʱ��</th>	
				<th>����</th>						
			</tr>
		</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>




<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>