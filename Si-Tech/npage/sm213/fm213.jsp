<%
/********************
 version v2.0
������: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
		String regionCode= (String)session.getAttribute("regCode");
		String kyjfz="0";
		String custname="";
    String beizhuss="����activePhone:"+activePhone+"���в�ѯ";
    String iLoginPwd = (String) session.getAttribute("password");

		

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />

 	<!--2013/11/01 12:39:08 gaopeng �ͻ�������Ϣ�����θ������� -->
  	<wtc:service name="sUserCustInfo" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1"  outnum="40" >
      <wtc:param value=""/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=work_no%>"/>
      <wtc:param value="<%=iLoginPwd%>"/>
      <wtc:param value="<%=activePhone%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value="<%=beizhuss%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
    
	<wtc:array id="result1" scope="end" >
	</wtc:array>
	
<%
  if(RetCode1.equals("000000")) {
    custname=result1[0][5];
    System.out.println("gaopengSeeLog:"+custname);

 
  }else{
%>
  <script language="javascript">
    rdShowMessageDialog("��ѯ�û���Ϣ���󣬴�����룺" + RetCode1 + "��������Ϣ��" + RetMsg1,0);
    window.close();
  </script>
<%
	}


%>

	
	<wtc:service name="sMarkMsgQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="10" >
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=activePhone%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result" scope="end"  start="0"  length="3"/>	
		<%
			if(retCode1.equals("000000")) {
					if(result.length>0) {
					kyjfz=result[0][0];
					}
			}else {
%>
	<script language="javascript">
		rdShowMessageDialog("��ѯ��ǰ�û����û���ʧ�ܣ�������룺<%=retCode1%>��������Ϣ��<%=retMsg1%>");
	</script>
<%				
				}
		%>
	
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
  onload=function()
  {
  
  }

 function doCfm(){

 
	    	if(!checkElement(document.all.sr_phone)){
						return false;
					}    
	     
				var zz_jf = $("#zz_jf").val();				
				if(zz_jf.trim()=="") {
	        rdShowMessageDialog("ת�����ֲ���Ϊ�գ�");
   			  return false;					
				}
				var kyjfvalue = $("#kyjfvalue").val();
				if(Number(zz_jf)>Number(kyjfvalue)) {
					rdShowMessageDialog("ת�����ֲ��ܳ���ת���˵�ǰ���û��֣�");
   			  return false;		
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
      form1.submit();
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
			
    function printInfo(printType){
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   <%=custname%>|";
      opr_info +="ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' +  "|";
      opr_info +="ҵ�����ͣ�����ת��    ������ˮ: "+"<%=loginAccept%>" +"|";     
      opr_info +="ת���ֻ����룺"+$("#zr_phone").val()+"    ��ת���ֻ����룺"+$("#sr_phone").val()+"|";
      opr_info +="ת������ֵ��"+$("#zz_jf").val()+"|";
 
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }    
		
		function listtype()
{
		var phoneNo = $("#sr_phone").val();
		
		if(!checkElement(document.all.sr_phone)){
			return false;
		}

		if(phoneNo.trim()!="") {
    var myPacket = new AJAXPacket("queryCustname.jsp", "���ڲ�ѯ�ͻ���Ϣ�����Ժ�......");
    myPacket.data.add("phoneNo", phoneNo);
    core.ajax.sendPacket(myPacket,doShowName);
    myPacket = null;
    }
}

function doShowName(packet){
  var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  var custname = packet.data.findValueByName("custname");
  if(retCode!="000000"){
    rdShowMessageDialog("ȡ�û�������������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    return false;
  }else{			
			$("#sr_name").val(custname);
  }
}


 	function resetPage(){
 		window.location.href = "fm185.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}

</script>
</head>
<body>
<form name="form1" id="form1" method="POST"  action="fm213Cfm.jsp">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0">
         <tr> 
            <td width="16%"  > 
              <div align="left" class="blue">ת�����ֻ�����</div>
            </td>
            <td > 
            <div align="left"> 
                <input class="InputGrey" type="text" name="zr_phone" id="zr_phone" v_must="1" v_type="mobphone" v_must=1 value="<%=activePhone%>"  maxlength=11 index="3" readonly />
                </div>
            </td>
             <td width="16%"  > 
              <div align="left" class="blue">���û���</div>
            </td>
             <td > 
            <div align="left"> 
                <input class="InputGrey" type="text"  name="kyjfvalue" id="kyjfvalue"  value="<%=kyjfz%>"   readonly />
                </div>
            </td>        
       
         </tr>
                  <tr> 
            <td width="16%"  > 
              <div align="left" class="blue">���������ֻ�����</div>
            </td>
            <td > 
            <div align="left"> 
                <input   type="text"  name="sr_phone" id="sr_phone" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11"  value =""  onBlur="listtype()">
                <font class='orange'>*</font></div>
            </td>
                     <td width="16%"  > 
              <div align="left" class="blue">������������</div>
            </td>
            <td > 
            <div align="left"> 
                <input class="InputGrey" type="text" name="sr_name" id="sr_name"  readOnly />
                </div>
            </td>
       
         </tr>
         		  <TR> 
	    
	             <td width="16%"  > 
              <div align="left" class="blue">ת������ֵ</div>
            </td>
            <td colspan="3"> 
            <div align="left"> 
                <input  type="text" name="zz_jf" id="zz_jf"  value=""  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
                <font class='orange'>*</font>
                </div>
            </td>
         </TR> 

		       
	</table>

	<div id="showTab" ></div>
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              <input class="b_foot" type=button name="confirm" value="ȷ��&��ӡ" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="���" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
      <input type="hidden" name="loginAccept" id="loginAccept" value="<%=loginAccept%>" />
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>