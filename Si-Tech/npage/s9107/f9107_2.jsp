<%@ include file="/include/public_title_name.jsp"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%    
  			ArrayList arrSession = (ArrayList)session.getAttribute("allArr"); 
				String[][] baseInfoSession = (String[][])arrSession.get(0);
				String[][] otherInfoSession = (String[][])arrSession.get(2);
				String[][] pass = (String[][])arrSession.get(4);
			  String loginPasswd  = pass[0][0];       //ȡ����Ա����
        String workNo = (String) session.getAttribute("workNo");
        String workName = (String) session.getAttribute("workName");
				String op_name ="SPҵ����Ϣ���"; 
				
				String powerCode= otherInfoSession[0][4];
				String orgCode = baseInfoSession[0][16];
				String ip_Addr = request.getRemoteAddr();
				
				String regionCode = orgCode.substring(0,2);
				String region_Name = otherInfoSession[0][5];
				String town_Name = otherInfoSession[0][7];
				String loginNoPass = pass[0][0];

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="sLoginAccept" />

<html>
<head>
<title><%=op_name%></title>
<script language=javascript>
		core.loadUnit("debug");
		core.loadUnit("rpccore");
			onload=function()
			{
			 core.rpc.onreceive=doProcess;
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
			rdShowMessageDialog("����"+retMsg);
		}
	}
  function printCommit()
			{
			       conf();
			       document.frm.systemNote.value="SPҵ��"+document.frm.operator_name.value+"�����޸�";
			}
			
			
	function conf()
			{		  
			      frm.action="f9107_21.jsp";
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
	 sqlStr = "select SP_CODE,OPERATOR_CODE,OPERATOR_NAME,VALID_DATE,EXPIRE_DATE,to_char(MAXACCEPT) from TDSMPSPBIZINFOMSG  where SP_CODE like '%' || :message || '%'";
	}else if(parseInt(verify_code)==1){
	 sqlStr = "select SP_CODE,OPERATOR_CODE,OPERATOR_NAME,VALID_DATE,EXPIRE_DATE,to_char(MAXACCEPT) from TDSMPSPBIZINFOMSG  where OPERATOR_CODE like '%' || :message || '%'";	 
	}else if(parseInt(verify_code)==2){
	 sqlStr = "select SP_CODE,OPERATOR_CODE,OPERATOR_NAME,VALID_DATE,EXPIRE_DATE,to_char(MAXACCEPT) from TDSMPSPBIZINFOMSG  where OPERATOR_NAME like '%' || :message || '%'";	 
	}else{
	sqlStr = "select SP_CODE,OPERATOR_CODE,OPERATOR_NAME,VALID_DATE,EXPIRE_DATE,to_char(MAXACCEPT) from TDSMPSPBIZINFOMSG ";}	 		
	var varStr="message="+message;           
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "5|1|2|3|4|5|";
	var retToField = "operator_code|operator_name|valid_date|expire_date|maxaccept|";
	var serviceName = "TlsPubSelCen";
	var routerKey = "region";
	var routerValue = "<%=regionCode%>";
	PubSimpSel_BD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue)
  select_spmsg();
}	
 function select_spmsg()
  {
   var maxaccept = document.frm.maxaccept.value;
   var page_type ="2";
   var myPacket = new RPCPacket("select_spmsg.jsp","���ڻ��SP��ҵ��Ϣ�����Ժ�......");
   myPacket.data.add("maxaccept",maxaccept);
   myPacket.data.add("page_type",page_type);
   core.rpc.sendPacket(myPacket);
	 delete(myPacket);	
  } 
</script>	
</head>
<BODY bgcolor="#FFFFFF" text="#000000" background="../../images/jl_background_2.gif" leftmargin = "0" topmargin = "0" marginwidth = "0" marginheight = "0">
<form name="frm" method="POST" >
<input type="hidden" name="loginAccept" value="<%=sLoginAccept%>">
<input type="hidden" name="maxaccept" value="">
<input type="hidden" name="workno" value="<%=workNo%>">	 
<%@ include file="/include/header.jsp"%>
<table  width=98% height=25 border="0" align="center" bgcolor="#FFFFFF">
 	      <tr> 
            <td width="16%" bgcolor="#eeeeee" nowrap> 
              <div align="left">��ѯ��ʽ��</div>
            </td>
            <td nowrap bgcolor="#eeeeee" colspan="1"> 
              <div align="left"> 
               <select size=1 name=verify_code2 >                
                 <option value="0">SP����</option>
                 <option value="1">ҵ�����</option>
                 <option value="2">ҵ������</option>
                 <option value="3">ȫ��</option>
               </select>
              </div>
            </td>
            <td nowrap bgcolor="#eeeeee" colspan="6">
            </td>	
          </tr>
          <tr>
            <td width="16%" bgcolor="#eeeeee" nowrap> 
              <div align="left">��ѯ���ݣ�</div>
            </td>
            <td nowrap width="16%" bgcolor="#eeeeee" colspan="1" >
            	<input name="message" type="text" maxlength="30" id="message" value="">
            	</td>
            <td nowrap bgcolor="#eeeeee" colspan="6">
            	<div align="left"><input name="select" class="button" type="button"  value="��ѯ" onClick="getFlagCode()"></div>
             </td>
          </tr>
 </table>  
 <table  width=98% height=25 border="0" align="center" bgcolor="#FFFFFF">
 	 	   <tr bgcolor="#eeeeee" class="title"> 
            <td width="13%" bgcolor="eeeeee" colspan="8"> 
            <div align="left">��˺�SP��Ϣ�б�</div>
            </td>
        </tr>               
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">ҵ�����:</div>
          </td>
          <td colspan="7" bgcolor="eeeeee"> 
          <input type="text" name="operator_code" value="" size=20 >	
          </td>
        </tr>
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">ҵ���Ʒ���ƣ�</div>
          </td>
          <td colspan="7" bgcolor="eeeeee"> 
          <input type="text" name="operator_name" value="" size=60>	
          </td>
        </tr>
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">ҵ�����ͣ�</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" name="serv_type" value="" size=11>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">ҵ�����ԣ�</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" name="serv_attr" value="" size=20>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">���δ���/����������</div>
          </td>
          <td colspan="3" bgcolor="eeeeee"> 
          <input type="text" name="count" value="" size=20>	
          </td>
        </tr>
         <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">�Ʒ����ͣ�</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" name="bill_flag" value="" size=11 maxlength=3>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">�������㷽ʽ1��</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" name="other_bal_obj1" value="" size=11 maxlength=3>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">�������㷽ʽ2��</div>
          </td>
          <td colspan="3" bgcolor="eeeeee"> 
          <input type="text" name="other_bal_obj2" value="" size=11>	
          </td>
        </tr>
        <tr bgcolor="#eeeeee"> 
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">��Ч���ڣ�</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" name="valid_date" value="" size=14>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">ʧЧ���ڣ�</div>
          </td>
          <td colspan="3" bgcolor="eeeeee"> 
          <input type="text" name="expire_date" value="" size=14>	
          </td>
          <td width="13%" bgcolor="eeeeee" > 
          <div align="left">�������</div>
          </td>
          <td colspan="1" bgcolor="eeeeee"> 
          <input type="text" name="bal_prop" value="" size=10>	
          </td>
        </tr>       
        <tr bgcolor="eeeeee"> 
        <td nowrap width="10%"> 
          <div align="left">ϵͳ��ע��</div>
        </td>
        <td nowrap colspan="7"> 
          <div align="left"> 
            <input type="text" class="button" name="systemNote" id="systemNote" size="60" readonly maxlength=60>
          </div>
        </td>
      </tr>
      <tr bgcolor="eeeeee"> 
        <td nowrap width="10%"> 
          <div align="left">�û���ע��</div>
        </td>
        <td nowrap colspan="7"> 
          <div align="left"> 
            <input type="text" class="button" name="opNote" id="opNote" size="60" v_maxlength=60  v_type=string  v_name="�û���ע" index="28" maxlength=60>
          </div>
        </td>
      </tr>
      <tr bgcolor="eeeeee"> 
                  <td nowrap colspan="8"> 
                    <div align="center"> 
                      <input class="button" type="button" name="b_print" value="ȷ��" onClick="printCommit()" index="29">
                      <input class="button" type="button" name="b_clear" value="���" onClick="frm.reset();" index="30">
                      <input class="button" type="button" name="b_back" value="����" onClick="location='f9107_1.jsp'" index="31">
                    </div>
                  </td>
      </tr>
</table>          
<%@ include file="/include/footer.jsp"%>	
</form>	 	
</body>	
</html>
