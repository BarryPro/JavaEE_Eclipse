<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ include file="/npage/sq100/getIccidFtpPas.jsp" %>
<%@ page import="import java.text.SimpleDateFormat;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>��������GPRS�ײͰ���</title>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  
  String opCode = "e224";
  String opName = "��������GPRS�ײͰ���";
  //String opCode = (String)request.getParameter("opCode");
  //String opName = (String)request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String) session.getAttribute("password");
  String nianyueri="";
  String current_timeNAME1=new SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date());
  String current_timeNAME2=new SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date());
  String current_timeNAME3=new SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date());
  nianyueri=current_timeNAME1+"��"+current_timeNAME2+"��"+current_timeNAME3+"��";
  //String sql1 ="select  a.cust_name  from dcustdoc a, dcustmsg b where a.cust_id = b.cust_id  and phone_no='"+activePhone+"'";
  
  String  inParams [] = new String[2];
  inParams[0] = "select  a.cust_name  from dcustdoc a, dcustmsg b where a.cust_id = b.cust_id  and phone_no=:phoneno";
  inParams[1] = "phoneno="+activePhone;
  String custname="";
  String ZSCustName11="";
  
  /* ��ȡ �ʷѱ��룬�ʷ�����@2013/1/25 */
  String sql_offerIds = "select a.offer_id, " 
                        +" a.offer_name, "     
                        +" a.offer_comments, "   
                        +" a.offer_attr_type, " 
                        +" a.eff_type, "        
                        +" a.exp_type "        
                        +" from product_offer  a " 
                        +" where a.offer_attr_type ='YnRM' " 
                        +" and a.eff_date<sysdate "
                        +" and a.exp_date>sysdate ";
   String contrySql = "SELECT code_id,code_name FROM pd_unicodedef_dict WHERE code_class = 'CODE01'";                   


	 String  inParamsGetCountry [] = new String[2];
	 inParamsGetCountry[0] = 
	 "SELECT m.code_id, m.code_name																							"
	+"  FROM pd_unicodedef_dict m                                                "
	+" WHERE m.code_class = 'CODE01'                                             "
	+"   and m.code_id not in                                                    "
	+"       (select b.code_id                                                   "
	+"          from product_offer_instance a, pd_unicodedef_dict b              "
	+"         where a.serv_id =                                                 "
	+"               (select id_no from dcustmsg where phone_no =:phoneNo) "
	+"           and a.offer_id = to_number(trim(b.code_value))                  "
	+"           and b.code_class = 'CODE02'                                     "
	+"           and a.exp_date > sysdate)                                      ";


	 inParamsGetCountry[1] = "phoneNo="+activePhone;
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="1"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result1"  scope="end"/>
  	
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="2"> 
    <wtc:param value="<%=inParamsGetCountry[0]%>"/>
    <wtc:param value="<%=inParamsGetCountry[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_GetCountry"  scope="end"/>
  	
  
<%
  if(RetCode1.equals("000000")) {
    custname=result1[0][0];
    
    	if(!("").equals(custname)) {
	
			if(custname.length() == 2 ){
				ZSCustName11 = custname.substring(0,1)+"*";
			}
			if(custname.length() == 3 ){
				ZSCustName11 = custname.substring(0,1)+"**";
			}
			if(custname.length() == 4){
				ZSCustName11 = custname.substring(0,2)+"**";
			}
			if(custname.length() > 4){
				ZSCustName11 = custname.substring(0,2)+"******";
			}
		}
  }else{
%>
  <script language="javascript">
    rdShowMessageDialog("������룺" + RetCode1 + "��������Ϣ��" + RetMsg1,0);
  </script>
<%
	}
%>
 
  	
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_contry" retmsg="retMsg_contry" outnum="2"> 
    <wtc:param value="<%=contrySql%>"/>
  </wtc:service>  
  <wtc:array id="contryArr"  scope="end"/>

   
<%
  
%>

  <script language="javascript">
  	
  	$(document).ready(function(){
			selOpFlag();
		});
		
    var ioprcode="01";
    function save(){
    	
    	/*���������б�*/
  		var contrySel = $.trim($("select[name='contrySel']").find("option:selected").val());
  		/*���������б�*/
  		var contrySelText = $.trim($("select[name='contrySel']").find("option:selected").text());
  		/*���������б�*/
  		var daynumSel = $.trim($("select[name='daynumSel']").find("option:selected").val());
  		
  		if(contrySel == "$$"){
  			rdShowMessageDialog("��ѡ����ҡ�������",1);
  			reSetOffer();
  			return false;
  		}
  		if(daynumSel == "$$"){
  			rdShowMessageDialog("��ѡ��������",1);
  			reSetOffer();
  			return false;
  		}
  		
  		var offerIdHiden = $.trim($("#offerIdHiden").val());
  		var offerName = $.trim($("#offerName").val());
      var needMoney = $.trim($("#needMoney").val());
      
      if(offerIdHiden.length == 0 ){
      	rdShowMessageDialog("���ҡ�������"+contrySelText+"��"+daynumSel+"��δ��ѯ���ʷ���Ϣ�������ԣ�",1);
      	reSetOffer();
  			return false;
      }
    	
     	$("#ioprcode").val("01");
     	
      var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
      if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
            frmCfm();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
            frmCfm();
          }
        }
      }else{
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
          frmCfm();
        }
      }
    }
      
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
      var sysAccept =<%=loginAccept%>;   
      var printStr = printInfo(printType);
      var mode_code=null;           							  //�ʷѴ���
      var fav_code=null;                				 		//�ط�����
      var area_code=null;             				 		  //С������
      var opCode="e224" ;                   			 	//��������
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
    	
    	/*���������б�*/
  		var contrySel = $.trim($("select[name='contrySel']").find("option:selected").val());
  			/*���������б�*/
  		var contrySelText = $.trim($("select[name='contrySel']").find("option:selected").text());
  		/*���������б�*/
  		var daynumSel = $.trim($("select[name='daynumSel']").find("option:selected").val());
  		
  		var offerName = $("#offerName").val();
  		var needMoney = $("#needMoney").val();
    	
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+"<%=custname%>"+"|";
      opr_info+="ҵ�����ͣ���������GPRS��ͨ"+"|";
      opr_info+="���ҡ�������"+contrySelText+"|";
      opr_info+="������"+daynumSel+"��|";
      opr_info+="��"+needMoney+"Ԫ|";
        
      if("AYX" == contrySel)
			{
				note_info1+="��ע���𾴵Ŀͻ�����������"+offerName+"�Ѿ���Ч����ͨ����ҵ�������"+contrySelText+"���й��ƶ��������Э�����Ӫ������������ʱ�����״β�������������"+daynumSel+"����Ȼ�������������õ���ʹ���������ٶ����շѣ�ͨ������¿�����ʹ�������������ײͷ���"+needMoney+"Ԫһ������ȡ��֧���ɹ���ҵ�񶩹��ɹ�������ɹ��󲻿��˶������ײ�����9��30��ǰʹ�ã������ײ�ʧЧ�Ҳ����˷ѡ����������ײͷ�������ܵ�����Ӫ��������Ӫ�̹�ƽʹ��ԭ��Լ�������ͻ��ڶ�ʱ����ʹ�ù���������ﵽ��ƽʹ������������Ӫ�̿��ܻ�Կͻ���ͣ���������������٣�����֪����"+"|";
      	
      }else{
      	note_info1+="��ע���𾴵Ŀͻ�����������"+offerName+"�Ѿ���Ч����ͨ����ҵ�������"+contrySelText+"���й��ƶ��������Э�����Ӫ������������ʱ�����״β�����������������"+daynumSel+"���ڣ�ͨ������£���������ʹ���ƶ������������ײͷ�"+needMoney+"Ԫһ������ȡ��֧���ɹ���ҵ�񶩹��ɹ�������ɹ��󲻿��˶������ڶ����ɹ��󣱣�������δʹ���ײ����ݵģ��ײ�ʧЧ�Ҳ����˷ѡ����������ײͷ�������ܸ�����Ӫ�����繫ƽʹ��ԭ��Լ�������ͻ��ڶ�ʱ����ʹ�ù���������ﵽ��ƽʹ������������Ӫ�̿��ܻ�Կͻ���ͣ���������������٣�����֪����  "+"|";
    	}
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
    
    /*2015/12/25 10:50:16 gaopeng ��ѯ�Ѱ���Ϳɰ��� */
    function selOpFlag(){
      
      
    }
    
    function dogetOfferInfo(packet){
			var retCode = packet.data.findValueByName("retCode");
      var retMsg = packet.data.findValueByName("retMsg");
      
      if(retCode == "000000"){
      	var offerId = packet.data.findValueByName("offerId");
      	var offerName = packet.data.findValueByName("offerName");
      	var offerFee = packet.data.findValueByName("offerFee");
      	
      	$("#offerIdHiden").val(offerId);
      	$("#offerName").val(offerName);
      	$("#needMoney").val(offerFee);
      }else{
      	rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
      	reSetOffer();
      }
     
    }
    
    function reSetOffer(){
    	$("#offerIdHiden").val("");
    	$("#offerName").val("");
      $("#needMoney").val("");
    }
    
    function reSetTab(){
      window.location.href="fe224.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
    }
    var daynumArrayNormal = [3,5,7];
    var daynumArraySpecial = [7];
    var daynumArraySpecialA = [7,15];
    function changeCountry(){
    	reSetOffer();
    	var daynumSelObj = $("select[name='daynumSel']");
    	daynumSelObj.empty();
  		$("<option value='$$'>--��ѡ��--</option>").appendTo(daynumSelObj);
  		
    	/*���������б�*/
  		var contrySel = $.trim($("select[name='contrySel']").find("option:selected").val());
    	if(contrySel == "$$"){
  			rdShowMessageDialog("��ѡ����ҡ�������",1);
  			reSetOffer();
  			return false;
  		}
  		/*��ֵ����*/
  		if("AYX" == contrySel)
			{
				for(var i=0 ;i<daynumArraySpecialA.length;i++){
      			$("<option value='"+daynumArraySpecialA[i]+"' >"+daynumArraySpecialA[i]+"</option>").appendTo(daynumSelObj);
      		}
			}
  		else if("EU" != contrySel){
      		for(var i=0 ;i<daynumArrayNormal.length;i++){
      			$("<option value='"+daynumArrayNormal[i]+"' >"+daynumArrayNormal[i]+"</option>").appendTo(daynumSelObj);
      		}
  		}
  		else{
      		for(var i=0 ;i<daynumArraySpecial.length;i++){
      			$("<option value='"+daynumArraySpecial[i]+"' >"+daynumArraySpecial[i]+"</option>").appendTo(daynumSelObj);
      		}
  		}
  		
    }
    
   	/**/
    function giveMoneyFee(){
    	
    	/*���������б�*/
  		var contrySel = $.trim($("select[name='contrySel']").find("option:selected").val());
  		/*���������б�*/
  		var daynumSel = $.trim($("select[name='daynumSel']").find("option:selected").val());
  		
  		if(contrySel == "$$"){
  			rdShowMessageDialog("��ѡ����ҡ�������",1);
  			reSetOffer();
  			return false;
  		}
  		if(daynumSel == "$$"){
  			rdShowMessageDialog("��ѡ��������",1);
  			reSetOffer();
  			return false;
  		}
  		var phoneNo = $("#phoneNo").val();
  		/*���÷�����ѯ�ʷѺͽ��*/
  		var packet = new AJAXPacket("/npage/se224/fe224Qry.jsp","���ڻ�����ݣ����Ժ�......");
    	packet.data.add("phoneNo",phoneNo);
    	packet.data.add("opCode","<%=opCode%>");
    	packet.data.add("opName","<%=opName%>");
    	
    	packet.data.add("countryCode",contrySel);
    	packet.data.add("dayNum",daynumSel);
    	
    	core.ajax.sendPacket(packet,dogetOfferInfo);
    	packet = null;
  		
    	
    }
   
		</script>
		<body>
		  <form name="frm" method="POST" action="fe224_1.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
        <table cellspacing="0">
				  <tr>
			      <td class="blue" width="25%">�ֻ�����</td>
			      <td>
						  <input type="text" id="phoneNo" name="phoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			        <font class="orange">*</font>
	          </td>
	          <td class="blue" width="25%">�ͻ�����</td>
			      <td>
							<input type="text" id="custname" name="custname"  v_must="1" v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=ZSCustName11%>"/>
			        <font class="orange">*</font>
	          </td>
		      </tr>
          <tr>
            <td class="blue" width="25%">��������</td>
            <td colspan="3">
              <input type="radio" name="opFlag" id="11" value="one"   checked onclick="selOpFlag()" />����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <!-- <input type="radio" name="opFlag" id="22" value="two" onclick="selOpFlag()" />ȡ��-->
            </td>
          </tr>
          <tr>
          	<td class="blue" width="25%">���ҡ�����</td>
          	<td width="25%">
          		<select id="contrySel" name="contrySel"  style="width:220px" onchange="changeCountry();">
          			<option value="$$" selected>--��ѡ��--</option>
                <%
                	if(result_GetCountry.length > 0 && retCode_mail.equals("000000")){
                		for(int i=0;i<result_GetCountry.length;i++){
                		%>
                			<option value="<%=result_GetCountry[i][0]%>" ><%=result_GetCountry[i][1]%></option>
                		<%
                		}
                	}
                
                %>
          		</select>	
          	</td>
          	<td class="blue" width="25%">����</td>
          	<td width="25%">
          		<select id="daynumSel" name="daynumSel"  style="width:220px" onchange="giveMoneyFee();">
          			<option value="$$" selected>--��ѡ��--</option>
                  
          		</select>	
          	</td>
          </tr>
          
          <tr id="needMoneyShow" style="display:block">
          	<td class="blue" width="25%">�ʷ�����</td>
          	<td>
          		<input type="text" name="offerName" id="offerName" value="" style="width:250px;" class="InputGrey" size="40" readonly/>
          	</td>
          	<td class="blue" width="25%">���</td>
          	<td>
          		<input type="text" name="needMoney" id="needMoney" value="" class="InputGrey" readonly/>����λ��Ԫ��
          	</td>
          	
          </tr>
          
        </table>
        <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
                <input type="button" name="quchoose" class="b_foot" value="ȷ��&��ӡ" onclick="save()" />		
                &nbsp;
                <input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
              </div>
            </td>
          </tr>
        </table>
        <input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
        <input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
      	<input type="hidden" name="phoneNo"  value="<%=activePhone%>" />
      	<input type="hidden" id="ioprcode" name="ioprcode"  value="" />
      	<input type="hidden" name="loginAccept"  value="<%=loginAccept%>">
      	<input type="hidden" id="offerIdHiden" name="offerIdHiden"  value="" />
      	<input type="hidden" id="effectWayHiden" name="effectWayHiden"  value="" />
      </form>
    </body>
</html>