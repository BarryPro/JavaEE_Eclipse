<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2015-10-9 14:19:54------------------
 ���ں��˷���ҵ��ҵ�����Ƽ�����������չ����ĺ�
 	
 	ȡ��ҳ��
 
 -------------------------��̨��Ա��xiahk--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%

	 java.util.Calendar calendar = java.util.Calendar.getInstance();
	 calendar.add(Calendar.MONTH, 1);
	 calendar.set(Calendar.DAY_OF_MONTH, 1);
	 String next_month_Date = new java.text.SimpleDateFormat("yyyy��MM��dd��").format(calendar.getTime()); 
	 
	 
	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
  String opName      = WtcUtil.repNull(request.getParameter("opName"));
  String phone_no      = WtcUtil.repNull(request.getParameter("activePhone"));
  
  
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
	String cust_name_sql_param = "phone_no="+phone_no;       									 
	
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
	
	
	//7����׼�����
	String paraAray[] = new String[8];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = phone_no;                                  //�û�����
	paraAray[6] = "";                        
	paraAray[7] = "d";   //a���룬dɾ��ȡ��
	
%>

  <wtc:service name="sm324Qry" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />					
		<wtc:param value="<%=paraAray[7]%>" />			
	</wtc:service>
	<wtc:array id="result_sm324Qry"  start="0"  length="2" scope="end" />
	<wtc:array id="result_sm324Qry2" start="2"  length="3" scope="end" />

<%
	if(!"000000".equals(code)){
%>
<SCRIPT language=JavaScript>
		rdShowMessageDialog("<%=code%>��<%=msg%>");
		removeCurrentTab();
</SCRIPT>
<%	
	}
%>		
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}
    function goCfm(){
 			
 			var check_f = false;
 			$("#upgMainTab tr:gt(0)").each(function(){
				if($(this).find("input[type='checkbox']").attr("checked")==true){
					check_f = true;
					return false;
				}
			});
			
			if(!check_f){
				rdShowMessageDialog("��ѡ��Ҫȡ���ĸ�������");
				return;
			}
			
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
			
			var f_phone_no_strs   = "";
			
			$("#upgMainTab tr:gt(0)").each(function(){
				if($(this).find("input[type='checkbox']").attr("checked")==true){
					f_phone_no_strs += $(this).find("td:eq(1)").text().trim()+"|";
				}
			});
			
      var packet = new AJAXPacket("fm324_5.jsp","���Ժ�...");
    			packet.data.add("op_type","d");//
	    		packet.data.add("opCode","<%=opCode%>");//opcode
	    		packet.data.add("loginAccept","<%=loginAccept%>");//��ˮ
	        packet.data.add("iPhoneNoMaster","<%=phone_no%>");//��������
	        packet.data.add("f_phone_no_strs",f_phone_no_strs);//��������
	        packet.data.add("f_phone_pass_strs","");//��������
	    core.ajax.sendPacket(packet,do_frmCfm);
	    packet =null;	
    }
    
    function do_frmCfm(packet){
    	 	var error_code = packet.data.findValueByName("code");//���ش���
		    var error_msg =  packet.data.findValueByName("msg");//������Ϣ
		
		    if(error_code=="000000"){//�����ɹ�
		    	 rdShowMessageDialog("�����ɹ�",2);
					 location = location;
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
      var phoneNo="<%=phone_no%>";                  //�ͻ��绰
      
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
      
      cust_info+="�ֻ����룺   "+"<%=phone_no%>"+"|";
      cust_info+="�ͻ�������   "+"<%=cust_name%>"+"|";
      
      var f_phone_nos = "";
			
			$("#upgMainTab tr:gt(0)").each(function(){
				if($(this).find("input[type='checkbox']").attr("checked")==true){
					f_phone_nos += $(this).find("td:eq(1)").text().trim()+" ";
				}
			});
			
      opr_info +="ҵ�����ͣ����ſͻ���֮���˷���"+"|"+"ҵ����ˮ: "+"<%=loginAccept%>" +"|";
      opr_info += "�������룺<%=phone_no%>"+"|";
      opr_info += "�������룺"+f_phone_nos+"|";
      opr_info += "����ʱ�䣺" + "<%=new java.text.SimpleDateFormat("yyyy��MM��dd��", Locale.getDefault()).format(new java.util.Date())%>" + "|";
      opr_info += "ʧЧʱ�䣺<%=next_month_Date%>|";
      
      note_info1 += "��ע��|�𾴵Ŀͻ����ã����ѳɹ�������˷���ȡ��ҵ��ҵ��ȡ��������Ч�������������������������������ʱ�ɷѣ�����Ӱ����ʹ�á�"+"|";
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="frm" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">������Ϣ</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">ҵ������</td>
		  <td colspan="3">
			    ȡ��
		  </td>
	</tr>
	<tr>
	    <td class="blue" width="15%">��������</td>
		  <td width="35%">
			    <%=phone_no%>
		  </td>
		  <td class="blue" width="15%">�����ͻ�����</td>
		  <td width="35%">
			    <%=cust_name%>
		  </td>
	</tr>
		
</table>

<div class="title"><div id="title_zi">�����б�</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
    		<th width="25%">ѡ��</th>
        <th width="25%">��������</th>
        <th width="25%">��ʼʱ��</th>	
        <th width="25%">����ʱ��</th>	
    </tr>
<%
for(int i=0;i<result_sm324Qry2.length;i++){
	if(!"".equals(result_sm324Qry2[i][0].trim())){
		out.println("<tr>");
		out.println("<td><input type='checkbox' /></td>");
		out.println("<td>"+result_sm324Qry2[i][0]+"</td>");
		out.println("<td>"+result_sm324Qry2[i][1]+"</td>");
		out.println("<td>"+result_sm324Qry2[i][2]+"</td>");
		out.println("</tr>");
	}
}
%>
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��&��ӡ" onclick="goCfm()"           />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>