<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016/11/4 13:45:24------------------
���������ɡ������㡱Ӧ������֧�Ź�����֪ͨ 
 
 -------------------------��̨��Ա��jianglei--------------------------------------------
 
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

String custBrandName = "";
        if("000000".equals(retCode2)){
                if(result_t2.length>0){
                        custName = result_t2[0][5];
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



var PUBLIC_OPCODE = "";


//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}



function go_Cfm(){
 
	
	  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	 	if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
	 	
	 	
	var pactket = new AJAXPacket("fm427_Cfm.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
			pactket.data.add("opCode",PUBLIC_OPCODE);
			pactket.data.add("phoneNo","<%=activePhone%>");
			pactket.data.add("loginAccept","<%=loginAccept%>");
			
			core.ajax.sendPacket(pactket,do_Cfm);
			pactket=null;
}

function do_Cfm(packet){
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
	  var printStr = "";
	  
	  if("m427"==PUBLIC_OPCODE){
	  	printStr = printInfo_m427(printType);
		}
	  if("m428"==PUBLIC_OPCODE){
	  	printStr = printInfo_m428(printType);
		}
		                      //����printinfo()���صĴ�ӡ����
	  var mode_code=null;           							  //�ʷѴ���
	  var fav_code=null;                				 		//�ط�����
	  var area_code=null;             				 		  //С������
	  var opCode=PUBLIC_OPCODE ;                   			 	//��������
	  var phoneNo="<%=activePhone%>";                  //�ͻ��绰
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+PUBLIC_OPCODE+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				
//��ӡģ��idΪ�� 122
function printInfo_m427(printType){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
	  cust_info+="�ͻ�������   "+"<%=custName%>"+"|";
	  
	  
	  opr_info +="������ˮ: "+"<%=loginAccept%>" +"|";
	  opr_info += "����ҵ�񣺡������㡱Ӧ������ҵ��ͨ|";
	  opr_info += "ҵ��˵�����������㡱Ӧ������ҵ�������û��ܵ��������㡱��������������ͨ��ҵ���޷����е�����£�ͨ��Ӫҵ����10086�ͷ��绰���������뿪ͨ��һ��Ӧ��ͨ�ű��Ϸ���|";
	  
	  note_info1 = "��ע��|";
	  note_info1 = "�������㡱����ҵ�񵥴ο�ͨ��Ч��Ϊ72Сʱ�����ڻ��Զ�ȡ�����û����ٵ�Ӫҵ����ͨ��|";
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}

//��ӡģ��idΪ�� 122
function printInfo_m428(printType){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
	  cust_info+="�ͻ�������   "+"<%=custName%>"+"|";
	  
	  
	  opr_info +="������ˮ: "+"<%=loginAccept%>" +"|";
	  opr_info += "����ҵ�񣺡������㡱Ӧ������ҵ��ر�|";
	  
	  note_info1 = "��ע��|";
	  
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}

$(document).ready(function(){
	$("#radio_<%=opCode%>").click();
});

function pub_set_radio(bt,check_opCode){
	PUBLIC_OPCODE = check_opCode;
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
		<td class="blue" colspan="4" align="center">
			<input type="radio"   value="m427"  id="radio_m427" name="radio_check" style="cursor:hand"  onclick="pub_set_radio(this,'m427')"  />
			<span style="cursor:hand">m427���������㡱Ӧ����������</span>
			&nbsp;
			
			<input type="radio"  value="m428"  id="radio_m428" name="radio_check" style="cursor:hand"  onclick="pub_set_radio(this,'m428')" />
			<span style="cursor:hand">m428���������㡱Ӧ�������˶�</span>
		</td>
	</tr>
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