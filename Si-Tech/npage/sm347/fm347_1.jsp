<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2015-12-14 9:45:39------------------
 ���ڽ���һ����Ŷ�����״���ӿ������������
 
 
 -------------------------��̨��Ա��jingang--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  
  String regionCode = (String)session.getAttribute("regCode");
	
	String cust_name = "";
  String cust_name_sql = " select b.cust_name "+
  											 " from dcustdoc b "+
 												 " where b.cust_id = "+
       									 " (select a.cust_id from dcustmsg a where a.phone_no = :phone_no) ";
	String cust_name_sql_param = "phone_no="+activePhone;       									 
	
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
		
		
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=cust_name_sql%>" />
		<wtc:param value="<%=cust_name_sql_param%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>
		
<%
	if(result_t.length>0){
		cust_name = result_t[0][0];
	}
%>
	
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>


//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}

function show_iSubPhoneNo(){
	if($("#iCategory").val()=="1"){
		$("#iSubPhoneNo").removeAttr("readOnly");
		$("#iSubPhoneNo").removeClass("InputGrey");
	}else{
		$("#iSubPhoneNo").val("");
		$("#iSubPhoneNo").attr("readOnly","readOnly");
		$("#iSubPhoneNo").addClass("InputGrey");
	}
}

function get_iCategory(){
	  var packet = new AJAXPacket("fm347_2.jsp","���Ժ�...");
        packet.data.add("iChrgType",$("#iChrgType").val());
    core.ajax.sendPacket(packet,do_get_iCategory);
    packet =null;
}
function do_get_iCategory(packet){
	 var retArray = packet.data.findValueByName("retArray");//���ش���
	 $("#bizcode option[index!='0']").remove(); 
   for(var i=0;i<retArray.length;i++){
   		$("#bizcode").append("<option value='"+retArray[i][0]+"'>"+retArray[i][1]+"</option>"); 
   }
}

function go_cfm(){
	
	if($("#iCategory").val()=="1"&&$("#iSubPhoneNo").val().trim()==""){
		rdShowMessageDialog("������ʵ�帱�ŵ��ֻ�����");
		$("#iSubPhoneNo").focus();
		return;
	}else{
		if($("#iSubPhoneNo").val()=="<%=activePhone%>"){
			rdShowMessageDialog("�������벻��������һ��");
			$("#iSubPhoneNo").val("");
			$("#iSubPhoneNo").focus();
			return;
		}
	}
	
	
	
	if($("#iChrgType").val()==""){
		rdShowMessageDialog("��ѡ��Ʒ�����");
		return;
	}
	
	if($("#bizcode").val()==""){
		rdShowMessageDialog("��ѡ���Ʒ����");
		return;
	}
	
	if(!check(msgFORM)) return false;
	
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
	var packet = new AJAXPacket("fm347_3.jsp","���Ժ�...");
			packet.data.add("loginAccept","<%=loginAccept%>");
			packet.data.add("iPhoneNo","<%=activePhone%>");
			packet.data.add("opCode","<%=opCode%>");
      packet.data.add("iCategory",$("#iCategory").val());
      packet.data.add("iSubPhoneNo",$("#iSubPhoneNo").val());
      packet.data.add("iChrgType",$("#iChrgType").val());
      packet.data.add("bizcode",$("#bizcode").val());
      packet.data.add("opnote","BOSSϵͳ�������⸱�����룺"+$("#iCategory option:selected").text());
      
	    core.ajax.sendPacket(packet,do_frmCfm);
	    packet =null;
}
function do_frmCfm(packet){
	  var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
			rdShowMessageDialog("�����ɹ�",2);      
			location = location;
	    return;
    }else{//���÷���ʧ��
	    rdShowMessageDialog(error_code+":"+error_msg);
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
			
    function printInfo(printType){
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+"<%=cust_name%>"+"|";
      
      opr_info +="ҵ�����ƣ�һ������������븱��    ������ˮ: "+"<%=loginAccept%>" +"|";
      
      
    	opr_info +="�������ͣ�"+$("#iCategory option:selected").text();
    	opr_info +="    �����ֻ����룺"+$("#iSubPhoneNo").val()+"|";
     
      opr_info +="�Ʒ����ͣ�"+$("#iChrgType option:selected").text()+"|";
      opr_info +="��Ʒ���ƣ�"+$("#bizcode option:selected").text()+"|";
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">ҵ������</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">�ֻ�����</td>
		  <td width="35%">
			     <%=activePhone%>
		  </td>
		  
		  <td class="blue" width="15%">�ͻ�����</td>
		  <td width="35%">
			    <%=cust_name%>
		  </td>
	</tr>
	
	<tr>
	    <td class="blue" width="15%">��������</td>
		  <td width="35%">
			    <select id="iCategory" onchange="show_iSubPhoneNo()" style="width:180px">
			    	<option value="1" selected>ʵ�帱��</option>
			    	<option value="0"         >���⸱��</option>
			    </select>
		  </td>
		  
		  <td class="blue" width="15%">ʵ�帱���ֻ�����</td>
		  <td width="35%">
			    <input type="text" v_type="mobphone" maxlength="11" id="iSubPhoneNo" onblur="checkElement(this)" /><font class="orange">*</font> 
		  </td>
	</tr>
	
	<tr>
	  <td class="blue" width="15%">�Ʒ�����</td>
		  <td width="35%">
			    <select id="iChrgType" onchange="get_iCategory()" style="width:180px">
			    	<option value="" >--��ѡ��--</option>
			    	<option value="0" >���</option>
			    	<option value="1" >����</option>
			    	<option value="2" >����</option>
			    </select>
		  </td>
		  
		  <td class="blue" width="15%">��Ʒ����</td>
		  <td width="35%">
			    <select id="bizcode" style="width:180px">
			    	<option value="" >--��ѡ��--</option>
			    </select>
		  </td>
	</tr>
	
	
</table>

 

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��&��ӡ" onclick="go_cfm()"            />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>