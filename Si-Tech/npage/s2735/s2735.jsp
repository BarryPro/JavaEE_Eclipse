<%
/********************
 version v2.0
������: si-tech
��ѩ���޸�20070518
boss2.0 �½���:����:  ֤������:_________      ����š�     ���ſͻ�id:__________
                      ���ű�ţ�________                 ���ſͻ����ƣ�________
                      ��ѯ�·�:_________                 ���ſͻ����룺______  ����֤��
                                          ����ѯ��������� 
               ˵��: �û�����'֤����'��,���[��ѯ]����������������ѡ��ͻ�id,ѡ����
                     �Զ���д'���ű��'��'�ͻ�����'����;
                     �û������ѯ�·�YYYYMM ��,��֤����󡾲�ѯ����
                                                  

********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%
    Logger logger = Logger.getLogger("s2735.jsp");
    
    String opCode = "2735";
    String opName = "���ſͻ��굥��ѯ";
    
    String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
    String workno = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workname = WtcUtil.repNull((String)session.getAttribute("workName"));
    String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));

       String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String[] mon = new String[]{"", "", "", "", "", ""};

        Calendar cal = Calendar.getInstance(Locale.getDefault());
        cal.set(Integer.parseInt(dateStr.substring(0, 4)),
                (Integer.parseInt(dateStr.substring(4, 6)) - 1), Integer.parseInt(dateStr.substring(6, 8)));
        for (int i = 0; i <= 5; i++) {
            if (i != 5) {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                //cal.add(Calendar.MONTH, -1);
            } else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
        }
   
    String typeStr = "";
    String inputStr = "";
    
    String sqlStr1 = "";
    String sqlStrNum="";
	String sqlStr="";
	String cust_address = "";
        ArrayList retArray = new ArrayList();
	ArrayList retArray1 = new ArrayList();
        String return_code,return_message;
        String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
 	String resultPrintTemplet[][] = new String[][]{}; //��ӡģ��
	String resultPrintTemplet1[][] = new String[][]{}; 
		
//�õ�ҳ����� 
	String iccid =request.getParameter("iccid")==null?"":request.getParameter("iccid");       //֤������
	String cust_id = "";     //���ſͻ�ID
	String unit_id = "";     //���ű��
	String cust_name = "";   //���ſͻ�����
	String contract_no="" ;
	String unit_name="" ;
	String selType="radio";
	String account_id="";   //�˻����
	int recordNum = 0;      //��ѯ�õ��ļ�¼����
	//String dateStr=request.getParameter("dateStr")==null?"":request.getParameter("dateStr");
	
//������ѯҳ��Ĳ���
        String selected_contract_no="";
        String selected_login_accept="0";
        String selected_year_month="";	
        String selected_work_no="";
        String selected_op_code="";
        String selected_show_code="";
        String selected_print_type="";
        String selected_iccid_no="";
	
//�õ��б����
	String action=request.getParameter("action");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>���ſͻ��굥��ѯ</TITLE>
</HEAD>
<SCRIPT type=text/javascript>

//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function(){
	
    //core.rpc.onreceive = doProcess;
}
function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
		var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
 //---------------------------------------
     if(retType == "checkPwd") //���ſͻ�����У��
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
	        	frm.custPwd.value = "";
	        	frm.custPwd.focus();
    	    	return false;	        	
            } else {
                rdShowMessageDialog("�ͻ�����У��ɹ���",2);
                document.frm.commit.disabled=false;
            }
         }
        else
        {
            rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
            document.frm.commit.disabled=true;
    		return false;
        }
     }	

     //---------------------------------------
 }
function check_HidPwd()
{
    if(document.frm.custPwd.value != "" ) 
   {
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",cust_id);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
     document.frm.str_Begin.focus();
    }
    else
    {
       rdShowMessageDialog("����д���룡",0);    
    } 
}


//���ù������棬���м��ſͻ�ѡ��
function getInfo_Cust()
{
    var pageTitle = "���ſͻ�ѡ��";
    var fieldName = "֤������|�ͻ�ID|�ͻ�����|����ID|��������|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "5|0|1|2|3|4|";
    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|";
    var cust_id = document.frm.cust_id.value;

    if(document.frm.iccid.value == "" &&
       document.frm.cust_id.value == "" &&
       document.frm.unit_id.value == "")
    {
        rdShowMessageDialog("���������֤�š��ͻ�ID����ID���в�ѯ��",0);
        document.frm.iccid.focus();
        return false;
    }

    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}



function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s2735/f2735_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;
   

    retInfo = window.open(path,"newwindow","height=450, width=680,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

//��������-���м��ſͻ�ѡ�� ���ظ�ֵ
function getvaluecust(retInfo)
{
 		  
  var retToField = "iccid|cust_id|cust_name|unit_id|account_id|";
  if(retInfo ==undefined)      
    {   return false;   }

	var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
    
 document.frm.custPwd.focus();

}
function searchTO()
{
	var year_month_str="";
   if(document.all.str_Begin.value!=""&&document.all.iccid.value!="")
    {
    	//ʱ�䷶Χ
     	if(document.frm.searchType.value == "0")
     		year_month_str=document.frm.beginTime.value+"^"+document.frm.endTime.value+"^" ;
     	else
     		year_month_str=document.frm.str_Begin.value.substring(0,6);
     		
     
     	document.frm.selected_year_month.value=document.frm.str_Begin.value.substring(0,6);//����
     	document.frm.selected_iccid_no.value=document.frm.iccid.value;//����
     	document.frm.selected_contract_no.value=document.frm.cust_id.value;//�ʺ�
     	      
     	var path = "<%=request.getContextPath()%>/npage/s2735/f2735.jsp?";
    path = path + "selected_iccid_no=" + document.frm.selected_iccid_no.value;
    path = path + "&selected_contract_no=" + document.frm.selected_contract_no.value;
    path = path + "&selected_year_month=" + year_month_str;
    path = path + "&selectType=" + document.frm.selectType.value;
    path = path + "&meetingId=" + document.frm.meetingId.value;
    path = path + "&meetingInitiator=" + document.frm.meetingInitiator.value;
    path = path + "&searchType=" + document.frm.searchType.value;
//alert(path);

		window.open(path,"newwindow","height=450, width=1000,top=50,left=50,scrollbars=yes, resizable=no,location=no, status=yes");

    }
    else
        {
        	rdShowMessageDialog("������֤�����룬��ѯ�·ݵ���Ϣ��",0);
    	}

}

// add by wanglma 20110602
function selChange(selType){
   	if(selType.value == "02"){
   		$("#mettingTd").show();
   	}else{
   		$("#mettingTd").hide();
   	}
}


    function seltimechange() {
        if (document.frm.searchType.selectedIndex == 0) {
            IList1.style.display = "";
            IList2.style.display = "none";
        } else {
            IList1.style.display = "none";
            IList2.style.display = "";
        }
    }
</script>

<BODY>
<FORM action="" method="post" name="frm" >
<input type="hidden" name="account_id"  value="<%=account_id%>">
<input type="hidden" name="selected_contract_no"  value="<%=selected_contract_no%>">
<input type="hidden" name="selected_year_month"  value="<%=selected_year_month%>">
<input type="hidden" name="selected_iccid_no"  value="<%=selected_iccid_no%>">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">���ſͻ��굥��ѯ</div>
</div>
<table cellspacing=0>
	      <TR>
            <TD width="18%" class='blue'>��ѯ����</TD>
            <TD colspan="3">
                <select name="selectType" id="selectType" onchange="selChange(this)" style="width:150px">
                	<option value="01" >��ҵ����</option>
                	<option value="02" >�ƶ�����</option>
                	<option value="03" >���ſͻ�IDC���ڷ�����</option>
                	<option value="04" >��������ֱ��</option>
                	<option value="05" >��ҵ�Ķ�</option>
                	<option value="06" >��ҵ����</option>
                	<option value="07" >����Ƶ����</option>
									<option value="08" >��ҵ���˻�</option>
									<option value="09" >��ҵ����������</option>
                	<option value="00" >ȫ��</option>
            	</select>
            </TD>
            
          </TR>
          <TR style="display:none" id="mettingTd" name="mettingTd">
          	<td width="18%" class='blue'>����ID</td>
          	<td><input type="text" id="meetingId" name="meetingId" size="24" /></td>	
          	<td width="18%" class='blue'>���鷢����</td>
          	<td><input type="text" id="meetingInitiator" name="meetingInitiator" size="30" /></td>
     	  </TR>	
          
          <TR>
            <TD width="18%" class='blue'>֤������</TD>
            <TD width="32%">
                <input name=iccid id="iccid" size="24" maxlength="20" v_type="string" v_must=1 index="1" value="<%=iccid%>" onKeyDown="if(event.keyCode==13)getInfo_Cust();" >
                <font class='orange'>*</font>
                <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyDown="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value="��ѯ">
            </TD>
            <TD width="18%" class='blue'>���ſͻ�ID</TD>
            <TD width="32%">
              <input type="text"  name="cust_id" size="30" maxlength="11" v_type="0_9" v_must=1 index="2" value="<%=cust_id%>">
            </TD>
          </TR>
         
          <TR>
            <TD class='blue'>���ű��</TD>
            <TD>
		    <input name=unit_id  id="unit_id" size="24" maxlength="11" v_type="0_9" v_must=1  index="3" value="<%=unit_id%>">
            
            </TD>
            <TD class='blue'>���ſͻ�����</TD>
            <TD>
              <input name="cust_name" size="30" readonly v_must=1 v_type=string index="4" value="<%=cust_name%>">
          </TR>
          <TR>
            <TD width="18%" class='blue'>��ѯ����</TD>
            <TD colspan="3">
              <select name="searchType" onchange="seltimechange()">
                    <option value="0" >ʱ�䷶Χ</option>
                    <option value="1" selected>��������</option>
              </select>
            </TD>
            
        <TR style="display:none" id="IList1">
            <TD class="blue" width=16%>��ʼ����</TD>
            <TD width=34%>
                <input type="text" name="beginTime" id="beginTime" size="20" maxlength="8" value=<%=mon[1]+"01"%>>
            </TD>
            <TD class="blue" width=16%>��������</TD>
            <TD width=34%>
                <input type="text" name="endTime" id="endTime" size="20" maxlength="8" value=<%=mon[1]+"02"%>>
            </TD>
        </TR>

        <TR style="display:''" id="IList2">
            <TD class="blue" width=16%>��������</TD>
            <TD colspan="3">
                <input type="text" id="str_Begin" name="str_Begin" size="20" maxlength="6" value=<%=mon[1]%>>
            </TD>
        </TR>
          
          <TD class='blue'>���ſͻ�����</TD>
            <TD colspan="3">
                <jsp:include page="/npage/common/pwd_1.jsp">
                    <jsp:param name="width1" value="16%"  />
                    <jsp:param name="width2" value="34%"  />
                    <jsp:param name="pname" value="custPwd"  />
                    <jsp:param name="pwd" value="<%=123%>"  />
                </jsp:include>
               <input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=У��>
               <font class='orange'>*</font>
            </TD>
	   </tr>
 			<TR id='footer'>
          <td align=center	colspan=4 >
          <input class="b_foot" name=commit onClick="searchTO();" style="cursor:hand" type=button value=��ѯ  disabled >
   	  		<input class="b_foot" name=back  type=button value="���" onclick="window.location='s2735.jsp'">
   	  		<input class="b_foot" name=back onClick="removeCurrentTab()" style="cursor:hand" type=button value=�ر�>
  	 			</td>
  	 </tr>
  </TABLE>
<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="JavaScript">
document.frm.iccid.focus();
</script>
</BODY>
</HTML>
