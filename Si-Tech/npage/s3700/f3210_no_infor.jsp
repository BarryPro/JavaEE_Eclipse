 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-14 ҳ�����,�޸���ʽ
	********************/
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "4112";	
	String opName = "�û���Ϣ";	//header.jsp��Ҫ�Ĳ���   
       
        String loginNo=(String)session.getAttribute("workNo");    //���� 
	String loginName =(String)session.getAttribute("workName");//��������  	
	String orgCode = (String)session.getAttribute("orgCode");      
	String regionCode = (String)session.getAttribute("regCode");    
	String ip_Addr = request.getRemoteAddr();   
        //SPubCallSvrImpl callView = new SPubCallSvrImpl();
%>

<%
    //String[] retStr = null;
     String [][] retStr = new String[][]{};   
    // ArrayList retArray = null;
    String error_code = "0";
    String error_msg="ϵͳ��������ϵͳ����Ա��ϵ";
    int valid = 1;  //0:��ȷ��1��ϵͳ����2��ҵ�����

    double dTotalOwe=0.00;
    String sTotalOwe="";

    String login_no = request.getParameter("loginNo");  /* �������� */
    String phone_no = request.getParameter("phoneNo");
    String op_code  = request.getParameter("opCode");
    String org_code = request.getParameter("orgCode");
    String iRegion_Code = org_code.substring(0,2);
    String v_smCode =  WtcUtil.repNull((String)request.getParameter("v_smCode"));/*diling add for Ʒ��@2012/9/26 */
    try
    {
       /* ArrayList paramsIn = new ArrayList();
        paramsIn.add(new String[]{login_no    });
        paramsIn.add(new String[]{phone_no    });
        paramsIn.add(new String[]{op_code     });
        paramsIn.add(new String[]{org_code    });*/

        //retStr = callView.callService("s2417Init", paramsIn, "38", "region", iRegion_Code);
  %>
  	     <wtc:service name="s2417InitExc" routerKey="region" routerValue=" <%=iRegion_Code%>" retcode="retCode2417" retmsg="retMsg2417" outnum="38">
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=op_code%>"/>	
		<wtc:param value="<%=org_code%>"/>
		<wtc:param value="<%=v_smCode%>"/>				
	    </wtc:service>
	    <wtc:array id="retStrArray" scope="end" />
  <%
	//callView.printRetValue();
        //error_code = callView.getErrCode();
       // error_msg= callView.getErrMsg();
       error_code=retCode2417;
       error_msg=retMsg2417;
       retStr=retStrArray;
    }catch(Exception e){
       
    }


  if( retStr == null ){
        valid = 1;
  }else if (!error_code.equals("000000")) {
        valid = 2;
  }else{
        valid = 0;
        if (Double.parseDouble(retStr[0][18]) > Double.parseDouble(retStr[0][17]))
        {
            sTotalOwe = "0.00";
        }else {
            dTotalOwe = Double.parseDouble(retStr[0][17])-Double.parseDouble(retStr[0][18]);
            String tmp1 = Double.toString(dTotalOwe*100+0.5);
            if (tmp1.indexOf(".")!=-1){
                String tmp2 = tmp1.substring(0,tmp1.indexOf("."));
                double tmp3 = Double.parseDouble(tmp2);
                sTotalOwe = Double.toString(tmp3/100);
            }
        }
  }
%>

<%if( valid != 0 ){%>
<html>
	<head>	
		<script language="JavaScript">
		<!--
		  function err_init()
		  {
		    rdShowMessageDialog("<br>�������:["+"<%=error_code %>]</br>"+"������Ϣ:["+"<%=error_msg %>"+"]");
		    window.close();
		  }
		//-->
		</script>
	</head>
	<body onLoad="err_init();">
	</body>
</html>
<%}else{%>
<html>
		<head>
			<title>�û���Ϣ</title>
			<script language="JavaScript">
			<!--
			    //����Ӧ��ȫ�ֵı���
			    var SUCC_CODE   = "0";          //�Լ�Ӧ�ó�����
			    var ERROR_CODE  = "1";          //�Լ�Ӧ�ó�����
			    var YE_SUCC_CODE = "0000";      //����Ӫҵϵͳ������޸�
			
			    var oprType_Add = "a";
			    var oprType_Upd = "u";
			    var oprType_Del = "d";
			    var oprType_Qry = "q";
			
			    onload=function()
			    {
			        init();
			       
			    }
			
			    //---------1------RPC������------------------
			    function doProcess(packet){
			        //ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
			        error_code = packet.data.findValueByName("errorCode");
			        error_msg =  packet.data.findValueByName("errorMsg");
			        verifyType = packet.data.findValueByName("verifyType");
			        backArrMsg = packet.data.findValueByName("backArrMsg");
			
			        self.status="";
			
			    }
			
			    function init()
			    {
			
			        <%
			            if( retStr.length > 0 ){
			        %>
			                document.frm.smName.value = "<%=retStr[0][2]%>";
			                document.frm.custName.value = "<%=retStr[0][3]%>";
			                document.frm.idIccid.value = "<%=retStr[0][14]%>";
			                document.frm.cardname.value = "<%=retStr[0][15]%>";
			                document.frm.grpbigname.value = "<%=retStr[0][16]%>";
			                document.frm.totalOwe.value = "<%=sTotalOwe%>";
			                document.frm.confirm.focus();
			
			        <%
			            }
			        %>
			
			    }
			
			    function save_to(){
			
			        var str="";
			
			        str = document.frm.custName.value.trim() + "|" + document.frm.idIccid.value.trim() + "|" +
			                document.frm.smCode.value + "|" + document.frm.totalOwe.value;
			
			        //alert(str);
			        window.returnValue=str;
			        window.close();
			    }
			
			    function quit(){
			        window.close();
			    }
			
			//-->
			</script>
	</head>


<body>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">�û���Ϣ</div>
	</div>
         <table cellspacing="0">
	          <tr>
	            	<td  class="blue">ҵ����������</td>
	            		<td><input name="smName" type="text" class="InputGrey" id="smName" readonly>
	            	</td>          
	           </tr>
	           <tr>
            		<td width="20%" class="blue">�ͻ�����</td>
            		<td>
            			<input name="custName" type="text"  id="custName" readonly class="InputGrey">
            		</td>
          	</tr>
          	<tr>
            		<td width="20%" class="blue">֤������</td>
            		<td>
            			<input name="idIccid" type="text"  id="idIccid" readonly class="InputGrey">
            		</td>
          	</tr>
          	<tr>
            		<td width="20%" class="blue">��ͻ�����</td>
            		<td>
            			<input name="cardname" type="text"  id="cardname" readonly class="InputGrey">
            		</td>
          	</tr>
          	<tr>
            		<td class="blue">���ſͻ�����</td>
            		<td>
            			<input name="grpbigname" type="text"  id="grpbigname" readonly class="InputGrey">
            		</td>
          	</tr>
          	<tr>
            		<td class="blue">��ǰǷ��</td>
            		<td>
            			<input name="totalOwe" type="text"  id="totalOwe" readonly class="InputGrey">
            		</td>          
            	</tr>
            </table>
             <table cellspacing="0">
          	<tr>
            		<td id="footer">            
		                <input name="confirm" type="button" class="b_foot" id="confirm" value="ȷ��" onClick="save_to()">
		                &nbsp;
		                <input name="return" type="button"  class="b_foot" id="return" value="����" onClick="quit()">             
	                </td>          
	        </tr>        
	    </table>
	    <%@ include file="/npage/include/footer_simple.jsp" %>	
    <input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
    <input type="hidden" name="loginName" id="loginName" value="">
    <input type="hidden" name="opCode" id="opCode" value="">
    <input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
    <input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
    <input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">
    <input type="hidden" name="smCode"  value="<%=retStr[0][1]%>">
</form>
</body>
</html>
<%}%>
