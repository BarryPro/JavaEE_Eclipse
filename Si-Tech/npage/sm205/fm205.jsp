<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ include file="/npage/sq100/getIccidFtpPas.jsp" %>
<%@ page import="import java.text.SimpleDateFormat;"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  

  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String  iLoginPwd = (String) session.getAttribute("password");
  String regionCode= (String)session.getAttribute("regCode");
  String custname="";
  String beizhuss="����activePhone:"+activePhone+"���в�ѯ";
  String custStatus="";
  
   
%>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
  	<!--2013/11/01 12:39:08 gaopeng �ͻ�������Ϣ�����θ������� -->
  	<wtc:service name="sUserCustInfo" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1"  outnum="40" >
      <wtc:param value=""/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=workNo%>"/>
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
  <script language="javascript">

    function save(){
   
    	if($("#offer_id").val()==null) {
    			rdShowMessageDialog("��ѡ��Ҫ����Ļ�Ա����");
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
			
    function printInfo(printType){
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4="";
      var retInfo = "";
      
      cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
      cust_info+="�ͻ�������   "+"<%=custname%>"+"|";
      opr_info +="ҵ�����ͣ��������Ա����    ������ˮ: "+"<%=loginAccept%>" +"|";
      opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' +  "|";
      opr_info += "���ζ���ҵ��"+$('#offer_id').find('option:selected').text()+"|";
 
      
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;
    }
   
    
    function reSetTab(){
      window.location.href="fm205.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
    }
		</script>
		<body>
		  <form name="frm" method="POST" action="fm205Cfm.jsp">
	    <%@ include file="/npage/include/header.jsp" %>
		    <div class="title">
		      <div id="title_zi"><%=opName%></div><p align="center"></p>
	      </div>
        <table cellspacing="0">
				  <tr>
			      <td class="blue" width="16%">�ֻ�����</td>
			      <td>
						  <input type="text" id="phoneNo" name="phoneNo"  v_must="1" 	v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			        <font class="orange">*</font>
	          </td>
	          <td class="blue" width="16%">�ͻ�����</td>
			      <td>
							<input type="text" id="custname" name="custname"    readOnly  Class="InputGrey" value ="<%=custname%>"/>
			        <font class="orange">*</font>
	          </td>
		      </tr>
		       <tr>
		       	<td class="blue" width="16%">��Ա����</td>
			      <td colspan="3">
					     <select name="offer_id" id="offer_id" class="button"  style="width:210px">
                <option value="46899">���������ͨ��Ա�ײ�(0Ԫ/��)</option>
                <option value="46900">���������Ӣ��Ա�ײ�(3Ԫ/��)</option>
                <option value="46901">������������Ա�ײ�(5Ԫ/��)</option>
                </select>
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
      	<input type="hidden" name="loginAccept"  value="<%=loginAccept%>">
      	<input type="hidden" name="banlitype" id="banlitype" value="06">

      </form>
    </body>
</html>