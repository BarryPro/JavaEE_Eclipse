<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%    
    String opCode = "9107";
    String opName = "SPҵ����Ϣ���";
        //ArrayList arrSession = (ArrayList)session.getAttribute("allArr"); 
        //String[][] baseInfoSession = (String[][])arrSession.get(0);
        //String[][] otherInfoSession = (String[][])arrSession.get(2);
        //String[][] pass = (String[][])arrSession.get(4);
    String loginPasswd  = (String)session.getAttribute("password");       //ȡ����Ա����
    String workNo = (String) session.getAttribute("workNo");
    String workName = (String) session.getAttribute("workName");
    String op_name ="SPҵ����Ϣ���"; 
    
    String powerCode= (String)session.getAttribute("powerCode");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    
    String regionCode = orgCode.substring(0,2);

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sLoginAccept" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<script language=javascript>
		//core.loadUnit("debug");
		//core.loadUnit("rpccore");
			onload=function()
			{
			 //core.rpc.onreceive=doProcess;
			}
		function doProcess(packet)
	{	
		
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var operator_code = packet.data.findValueByName("operator_code");
		var operator_name = packet.data.findValueByName("operator_name");
		var serv_type = packet.data.findValueByName("serv_type");			
		var serv_attr = packet.data.findValueByName("serv_attr");
		var count = packet.data.findValueByName("count");
		var bill_flag = packet.data.findValueByName("bill_flag");
		var other_bal_obj1 = packet.data.findValueByName("other_bal_obj1");
		var other_bal_obj2 = packet.data.findValueByName("other_bal_obj2");
		var valid_date = packet.data.findValueByName("valid_date");
		var expire_date = packet.data.findValueByName("expire_date");
		var bal_prop = packet.data.findValueByName("bal_prop");
		var serv_type = packet.data.findValueByName("serv_type");
		if( parseInt(retCode) == 0 ){
			document.frm.operator_code.value= operator_code;
			document.frm.operator_name.value= operator_name;
			document.frm.serv_type.value= serv_type;
			document.frm.serv_attr.value= serv_attr;
			document.frm.count.value= count;
			document.frm.bill_flag.value= bill_flag;
			document.frm.other_bal_obj1.value= other_bal_obj1;
			document.frm.other_bal_obj2.value= other_bal_obj2;
			document.frm.valid_date.value= valid_date
			document.frm.expire_date.value= expire_date;
			document.frm.bal_prop.value= bal_prop;				
							
		}else{
			rdShowMessageDialog("����"+retMsg,0);
		}
	}
 function select_spmsg()
  {
   var maxaccept = document.frm.maxaccept.value;
   var page_type ="3";
      if(maxaccept == '') {
   document.frm.message.focus();
   	return false;
   	}
   var myPacket = new AJAXPacket("select_spmsg.jsp","���ڻ��SP��ҵ��Ϣ�����Ժ�......");
   myPacket.data.add("maxaccept",maxaccept);
   myPacket.data.add("page_type",page_type);
   core.ajax.sendPacket(myPacket);
	myPacket = null;	
  } 
  function printCommit()
			{
				     document.frm.check_flag.value = "yes"; 
			       document.frm.checkId.value = document.frm.maxaccept.value; 
			       document.frm.systemNote.value="����Ա:"+"<%=workNo%>"+"��SPҵ��:"+document.frm.operator_name.value+"�������";
			       conf();
			}     
	  function printCommit1()
			{
				     document.frm.check_flag.value = "no"; 
			       document.frm.checkId.value = document.frm.maxaccept.value; 
			       document.frm.systemNote.value="����Ա:"+"<%=workNo%>"+"��SPҵ��:"+document.frm.operator_name.value+"�������";
			       conf();
			} 		
			
	function conf()
			{		  
				    var checkId = document.frm.checkId.value;
				    if(checkId == ""){
				    	rdShowMessageDialog("��ѡ��У������");
							return false;
				    	}
			      frm.action="f9107_conf.jsp";
			      frm.submit();
			} 
function getFlagCode()
{ 
	var verify_code = document.frm.verify_code2.value;
	var message = document.frm.message.value;
	var pageTitle = "SP��Ϣ��ѯ";
	var fieldName = "��ҵ����|ҵ�����|ҵ���Ʒ����|��Ч����|ʧЧ����|������ˮ|";
	var sqlStr = "";
	if(parseInt(verify_code)==0){
	 sqlStr = "select a.SP_CODE,a.OPERATOR_CODE,a.OPERATOR_NAME,a.VALID_DATE,a.EXPIRE_DATE,to_char(a.MAXACCEPT) from TDSMPSPBIZINFOPREMSG a,CDSMPCHECKCODE b where trim(a.SERV_TYPE) = trim(b.SERV_TYPE) and a.SERV_ATTR = b.LOCALCODE and b.SPTYPE in (select sptype from dDsmpSpInfo where spid = a.sp_code) and  b.auto_flag = '0' and nvl(a.SP_CODE,'') like '%' || :message || '%'";
	}else if(parseInt(verify_code)==1){
	 sqlStr = "select a.SP_CODE,a.OPERATOR_CODE,a.OPERATOR_NAME,a.VALID_DATE,a.EXPIRE_DATE,to_char(a.MAXACCEPT) from TDSMPSPBIZINFOPREMSG a,CDSMPCHECKCODE b where trim(a.SERV_TYPE) = trim(b.SERV_TYPE) and a.SERV_ATTR = b.LOCALCODE and b.SPTYPE in (select sptype from dDsmpSpInfo where spid = a.sp_code) and  b.auto_flag = '0' and nvl(a.OPERATOR_CODE,'') like '%' || :message || '%'";	 
	}else if(parseInt(verify_code)==2){
	 sqlStr = "select a.SP_CODE,a.OPERATOR_CODE,a.OPERATOR_NAME,a.VALID_DATE,a.EXPIRE_DATE,to_char(a.MAXACCEPT) from TDSMPSPBIZINFOPREMSG a,CDSMPCHECKCODE b where trim(a.SERV_TYPE) = trim(b.SERV_TYPE) and a.SERV_ATTR = b.LOCALCODE and b.SPTYPE in (select sptype from dDsmpSpInfo where spid = a.sp_code) and  b.auto_flag = '0' and nvl(a.OPERATOR_NAME,'') like '%' || :message || '%'";	 
	}else{
	 sqlStr = "select a.SP_CODE,a.OPERATOR_CODE,a.OPERATOR_NAME,a.VALID_DATE,a.EXPIRE_DATE,to_char(a.MAXACCEPT) from TDSMPSPBIZINFOPREMSG a,CDSMPCHECKCODE b where trim(a.SERV_TYPE) = trim(b.SERV_TYPE) and a.SERV_ATTR = b.LOCALCODE and b.SPTYPE in (select sptype from dDsmpSpInfo where spid = a.sp_code) and  b.auto_flag = '0'";
	}	 		
	var varStr="message="+message;           
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "6|1|2|3|4|5|";
	var retToField = "operator_code|operator_name|valid_date|expire_date|maxaccept|";
	var serviceName = "TlsPubSelCrm";
	var routerKey = "region";
	var routerValue = "<%=regionCode%>";
	PubSimpSel_BD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue);
  	select_spmsg();
}	
  function PubSimpSel_BD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue)
	{
	    var path = "/npage/public/fPubSimpSelBD.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType;
	    path = path + "&serviceName=" + serviceName;
	    path = path + "&routerKey=" + routerKey;
	    path = path + "&routerValue=" + routerValue;
	    path = path + "&varStr=" + varStr;
	
	    retInfo = window.showModalDialog(path);
		if(typeof(retInfo) == "undefined")     
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
	}
</script>	
</head>
<BODY>
<form name="frm" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">SPҵ����Ϣ��˲�ѯ</div>
</div>
<input type="hidden" name="loginAccept" value="<%=sLoginAccept%>">
<input type="hidden" name="maxaccept" value="">
<input type="hidden" name="workno" value="<%=workNo%>">
<input type="hidden" name="checkId" value="">
<input type="hidden" name="check_flag" value="">	 
<table cellSpacing="0">
 	      <tr> 
            <td class=blue nowrap> 
              <div align="left">��ѯ��ʽ</div>
            </td>
            <td nowrap> 
              <div align="left"> 
               <select size=1 name=verify_code2 >                
                 <option value="0">SP����</option>
                 <option value="1">ҵ�����</option>
                 <option value="2">ҵ������</option>
                 <option value="3">ȫ��</option>
               </select>
              </div>
            </td>	
          </tr>
          <tr>
            <td class=blue nowrap> 
              <div align="left">��ѯ����</div>
            </td>
            <td nowrap>
            	<input name="message" type="text" maxlength="30" id="message" value="">
                <input name="select" class="b_text" type="button"  value="��ѯ" onClick="getFlagCode()">
             </td>
          </tr>
 </table>  
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">�����SPҵ����Ϣ�б�</div>
</div>
<table cellSpacing="0">              
        <tr> 
          <td class=blue>
          <div align="left">ҵ�����</div>
          </td>
          <td colspan="7"> 
          <input type="text" name="operator_code" value="" size=20 class="InputGrey" readonly>	
          </td>
        </tr>
        <tr> 
          <td class=blue>
          <div align="left">ҵ���Ʒ����</div>
          </td>
          <td colspan="7"> 
          <input type="text" name="operator_name" value="" size=60 class="InputGrey" readonly>	
          </td>
        </tr>
        <tr> 
          <td class=blue>
          <div align="left">ҵ������</div>
          </td>
          <td colspan="1"> 
          <input type="text" name="serv_type" value="" size=11 class="InputGrey" readonly>	
          </td>
          <td class=blue>
          <div align="left">ҵ������</div>
          </td>
          <td colspan="1"> 
          <input type="text" name="serv_attr" value="" size=20 class="InputGrey" readonly>	
          </td>
          <td class=blue>
          <div align="left">���δ���/��������</div>
          </td>
          <td colspan="3"> 
          <input type="text" name="count" value="" size=20 class="InputGrey" readonly> 	
          </td>
        </tr>
         <tr> 
          <td class=blue>
          <div align="left">�Ʒ�����</div>
          </td>
          <td colspan="1"> 
          <input type="text" name="bill_flag" value="" size=11 maxlength=3 class="InputGrey" readonly>	
          </td>
          <td class=blue>
          <div align="left">�������㷽ʽ1</div>
          </td>
          <td colspan="1"> 
          <input type="text" name="other_bal_obj1" value="" size=11 maxlength=3 class="InputGrey" readonly>	
          </td>
          <td class=blue>
          <div align="left">�������㷽ʽ2</div>
          </td>
          <td colspan="3"> 
          <input type="text" name="other_bal_obj2" value="" size=11 class="InputGrey" readonly>	
          </td>
        </tr>
        <tr> 
          <td class=blue>
          <div align="left">��Ч����</div>
          </td>
          <td colspan="1"> 
          <input type="text" name="valid_date" value="" size=14 class="InputGrey" readonly>	
          </td>
          <td class=blue>
          <div align="left">ʧЧ����</div>
          </td>
          <td colspan="3"> 
          <input type="text" name="expire_date" value="" size=14 class="InputGrey" readonly>	
          </td>
          <td class=blue>
          <div align="left">�������</div>
          </td>
          <td colspan="1"> 
          <input type="text" name="bal_prop" value="" size=10 class="InputGrey" readonly> 	
          </td>
        </tr>       
     <tr> 
        <td class=blue>
          <div align="left">��ע</div>
        </td>
        <td nowrap colspan="7"> 
          <div align="left"> 
            <input type="text" class="InputGrey" name="systemNote" id="systemNote" size="60" readonly maxlength=60>
          </div>
        </td>
      </tr>
      <tr style='display:none'> 
        <td class=blue>
          <div align="left">�û���ע</div>
        </td>
        <td nowrap colspan="7"> 
          <div align="left"> 
            <input type="text" name="opNote" id="opNote" size="60" v_maxlength=60  v_type=string index="28" maxlength=60>
          </div>
        </td>
      </tr>
      <tr> 
                  <td nowrap id="footer" colspan="8"> 
                    <div align="center"> 
                      <input class="b_foot" type="button" name="b_print" value="���" onClick="printCommit()" index="29">
                      <input class="b_foot" type="button" name="b_clear" value="��˲�ͨ��" onClick="printCommit1()" index="30">
                      <input class="b_foot" type="button" name="b_clear" value="���" onClick="frm.reset();" index="30">
                      <input class="b_foot" type="button" name="b_back" value="����" onClick="location='f9107_1.jsp'" index="31">
                    </div>
                  </td>
      </tr>
</table>  
<%@ include file="/npage/include/footer.jsp"%>
</form>	 	
</body>	
</html>
