<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-8-3 10:14:30------------------
 ������¿����ͨ���ֻ����ѽ���
 
 
 -------------------------��̨��Ա��xiahk--------------------------------------------
 
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
	String groupId    = (String)session.getAttribute("groupId");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
<%	
	String custName = "";
         				/*
                        ��ѯ�ͻ���Ϣ��������
                */
                 String paraAray[] = new String[9];
                 paraAray[0]=sysAcceptl;
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
<wtc:array id="result2" scope="end" />

<%
        if("000000".equals(retCode2)){
                if(result2.length>0){
                        custName=result2[0][5];
                }
        }else{
%>
                <script language="JavaScript">
                        rdShowMessageDialog("���û����������û���״̬��������");
                        removeCurrentTab();
                </script>
<%              
        }
        
        
        String _note_info1 = "";
%>     


<wtc:service name="s9611Cfm1" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="retMessage"  outnum="2" >
		<wtc:param value="<%=opCode%>"/>
    <wtc:param value="1"/>
    <wtc:param value="13"/>
    <wtc:param value="10057"/>
    <wtc:param value="01"/>
</wtc:service>
<wtc:array id="result" scope="end" />
	
<%
	
	
	if(ret_code.equals("000000"))
	{
		if(result.length>0){
				_note_info1 = result[0][0] ;
		}
	}
	
	
	_note_info1 = _note_info1.replaceAll("\r\n","</br>");  
	_note_info1 = _note_info1.replaceAll("\r","</br>"); 
	_note_info1 = _note_info1.replaceAll("\n","</br>"); 
	_note_info1 = _note_info1.replaceAll("\"","&quot;"); 
	_note_info1 = _note_info1.replaceAll("\'","&quot;"); 
	
	
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
	if(!check(msgFORM)) return false;
		 showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
   if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
   
    var packet = new AJAXPacket("fm392_submit.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");// 
        packet.data.add("phoneNo","<%=activePhone%>");// 
        packet.data.add("cust_name",$("#cust_name").val());//�ͻ�����
        packet.data.add("kd_no",$("#kd_no").val());
    core.ajax.sendPacket(packet,do_cfm);
    packet =null;
}
//��ѯ�ͻ�������Ϣ�ص�
function do_cfm(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg,"0");
    }else{//
    	rdShowMessageDialog("����ɹ�",2);
    	removeCurrentTab();
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
		//��ӡģ��idΪ��38
    function printInfo(printType){
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+$("#cust_name").val()+"|";
      
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "|"
      						
      opr_info += "ҵ��������ƣ��ֻ�������˸���    ������ˮ: "+"<%=sysAcceptl%>" +"|";
      opr_info += "����˺ţ�"+$("#kd_no").val()+"|";
			 
      note_info2 += "˵����|<%=_note_info1%>|";
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
 
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">��ѯ����</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="20%">�ֻ�����</td>
		  <td width="30%">
			    <input type="text" name="phoneIn" id="phoneIn" value="<%=activePhone%>" readOnly class="InputGrey" /> 
		  </td>
		  <td class="blue" width="20%">�ֻ�����ͻ�����</td>
		  <td width="30%">
			    <input type="text" name="cust_name" id="cust_name" value="<%=custName%>" readOnly class="InputGrey"  />  
		  </td>
	</tr>
	<tr>
	    <td class="blue" width="20%">����˺�</td>
		  <td colspan="3">
			    <input type="text" name="kd_no" id="kd_no" value="" v_must="1"   onblur="checkElement(this)"/> 
			    <font class="orange">*</font>
		  </td>
	</tr>
</table>

 

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��&��ӡ" onclick="go_cfm()"           />
	 		<input type="button" class="b_foot" value="����"      onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�"      onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>