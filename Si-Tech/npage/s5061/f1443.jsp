   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-10
********************/
%>
              
<%
  String opCode = "1443";
  String opName = "�ļ�����";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*"%>

<%
    String phone_no = (String)request.getParameter("activePhone");
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String work_Pwd = (String)session.getAttribute("password");
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	String dirtPage=request.getParameter("dirtPage");

  request.setCharacterEncoding("GBK");
%>

<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
	//String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
	//paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
	String regionCode = (String)session.getAttribute("regCode");
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" routerValue="<%=regionCode%>"  id="paraStr1" /> 

<%	
	String paraStr= paraStr1;
	System.out.println("11111111111" +paraStr);
	String sqlStr="";
	int recordNum=0;
    int i=0;
    String[][] result = new String[][]{};
%>


<%
  HashMap hm=new HashMap();
  hm.put("1","û�пͻ�ID��");
  hm.put("3","�������");
  hm.put("4","�����Ѳ�ȷ���������ܽ����κβ�����");
  
  hm.put("2","δȡ������1����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("10","δȡ������2����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("11","δȡ������3����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("12","δȡ������4����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("13","δȡ������5����˲����ݻ���ѯϵͳ����Ա��");
  hm.put("14","δȡ������6����˲����ݻ���ѯϵͳ����Ա��");
  String op_name="";
  String op_code = request.getParameter("op_code");
  //System.out.println("op_code === "+ op_code );
  //op_code="1250";
 
  if(op_code.equals("1220"))
    op_name="�������";
  else if(op_code.equals("1217"))
    op_name="Ԥ���ָ�";
  else if(op_code.equals("1260"))
    op_name="Ԥ��ָ�";
  else if(op_code.equals("2419"))
    op_name="����ת��ҵ������";
  else if(op_code.equals("1296"))
    op_name="���еش�����ת��";
  else if(op_code.equals("1250"))
    op_name="���ֶҽ�";
  else if(op_code.equals("1221"))
    op_name="��������";
  else if(op_code.equals("1353"))
    op_name="��������";
  else if(op_code.equals("1290"))
    op_name="���֤��ʧ";
  else if(op_code.equals("1291"))
    op_name="�ֻ�֤ȯ����";
  else if(op_code.equals("1295"))
    op_name="������";
  else if(op_code.equals("1299"))
    op_name="���еش�Mֵ�һ�";
  else if(op_code.equals("2420"))
    op_name="����ת��ҵ�����";
  else if(op_code.equals("2421"))
    op_name="�ĺ�֪ͨҵ��";
  else if(op_code.equals("1442"))
    op_name="SIM��Ӫ��";
  else if(op_code.equals("1445"))
    op_name="ȫ��ͨǩԼ�ƻ�";
  else if(op_code.equals("1448"))
    op_name="�ʼ��ʵ�";
  else if(op_code.equals("7114"))
    op_name="�굥��ѯ��������";
  else if(op_code.equals("1458"))
    op_name="��Ϣ�ռ�";
  else if(op_code.equals("1469"))
    op_name="ȫ��spҵ���˷�";
  else if(op_code.equals("7115"))
    op_name="����绰��ѻ���";
  else if(op_code.equals("2299"))
    op_name="�������֤����������";
  else if(op_code.equals("1499"))
    op_name="����ҵ�񸶽�����ά��";
  else if(op_code.equals("1451"))
    op_name="�����ʵ�����";
  else if(op_code.equals("1452"))
    op_name="�������֤";
  else if(op_code.equals("5036"))
    op_name="�ͷ�ϵͳ�ײ�����";
  else if(op_code.equals("5037"))
    op_name="������ò�ѯ";
  else if(op_code.equals("1577"))
    op_name="���ź˼컰����ѯ";
  else if(op_code.equals("1446"))
    op_name="�ĺ�֪ͨ";
  else if(op_code.equals("1440"))
    op_name="��ҵ��ҽ�";
  else if(op_code.equals("5118"))
    op_name="����ҵ�񸶽�";
  else if(op_code.equals("1449"))
    op_name="ȫ��ͨǩԼ�ƻ�����";
  else if(op_code.equals("1450"))
    op_name="���ֶһ�����";
  else if(op_code.equals("1443"))
    op_name="�ļ�����";
  else if(op_code.equals("2267"))
    op_name="�ֻ��û�ʵ��Ԥ�Ǽǲ�ѯ/ȷ��";
  else if(op_code.equals("2266"))
    op_name="����Ʒͳһ����";
  else if(op_code.equals("2849"))
    op_name="�������ż��ŷ��������Ϣ��ѯ";
  else if(op_code.equals("5303"))
    op_name="���ŵ�½������������";
  else if(op_code.equals("5309"))
    op_name="���ŵ�½��������������ʷ��ѯ";
%>


<head>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<title><%=op_name%></title>

<script language=javascript>
<!--
  onload=function()
  {
   	self.status="";
  }
 
function simChk()
{
	if((document.all.phoneno.value).trim().length<1){
  		rdShowMessageDialog("�ֻ����벻��Ϊ�գ�");
 	  	return;
	} 
  	var myPacket = new AJAXPacket("post1443.jsp","���ڲ�ѯ�ͻ������Ժ�......");
	myPacket.data.add("phoneNo",(document.all.phoneno.value).trim());
	myPacket.data.add("opCode",(document.all.op_code.value).trim());
	myPacket.data.add("mode_type",(document.all.mode_type.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

 //--------4---------doProcess����----------------
function doProcess(packet)
{
 	var vRetPage=packet.data.findValueByName("rpc_page");  
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var cust_name = packet.data.findValueByName("cust_name");
	var user_name = packet.data.findValueByName("user_name");
	var address = packet.data.findValueByName("address");
	var id_iccid = packet.data.findValueByName("id_iccid");
	if(retCode == 0){
		document.all.phoneno.value = cust_name;
		document.all.user_name.value = user_name;
		document.all.address.value = address;
		document.all.id_iccid.value = id_iccid;
		document.all.confirm.disabled=false;
	}else{
		rdShowMessageDialog("����:"+ retCode + "->" + retMsg);
		return;
	}   
    
}

//-------2---------��֤���ύ����-----------------

function printCommit()
{
	getAfterPrompt();
	//У��
	
  	if(!checkElement(document.f1443.phoneno)) return false;
  
	if(!check(f1443)) return false;
	
   //��ӡ�������ύ��
	document.all.t_sys_remark.value="�û�"  + document.all.phoneno.value +":"+document.all.tranType[document.all.tranType.selectedIndex].value+"����";
  	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");

  	if((ret=="confirm")){
  		if(rdShowConfirmDialog('ȷ�ϵ��������')==1){  
	  	f1443.submit();
    }
		
	if(ret=="remark"){
    	if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
	       ��f1443.submit();
         }
	   }
	}
    else
    {
       if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
       {
	     ��f1443.submit();
       }
    }	
    return true;
  }
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի��� 
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=paraStr%>;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = <%=activePhone%>;                            //�ͻ��绰
     
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	 var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	 var ret=window.showModalDialog(path,printStr,prop);   
  }

  function printInfo(printType)
  {
 
    var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
		
    cust_info+="�ֻ����룺"+document.all.phoneno.value+"|";  
    cust_info+="�ͻ�������"+document.all.user_name.value+"|";  
    cust_info+="�ͻ���ַ��"+document.all.address.value+"|";  
    cust_info+="֤�����룺"+document.all.id_iccid.value+"|";  
    
    opr_info+="ҵ�����ͣ�"+"�ļ�����"+"|";  
    opr_info+="ҵ����ˮ��"+document.all.loginAccept.value+"|";  
    
	note_info1+="��ע��"+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

    return retInfo;
  }

 //-->
</script>


</head>
<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<form action="f1443BackCfm.jsp" method="POST" name="f1443"  onKeyUp="chgFocus(f1443)">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	<input type="hidden" name="loginAccept" value="<%=paraStr%>">
	<input type="hidden" name="user_name" value="">
	<input type="hidden" name="address" value="">
	<input type="hidden" name="id_iccid" value="">
	<%@ include file="../../include/remark.htm" %>
	
	<div class="title">
		<div id="title_zi">�ļ�����</div>
	</div>
        <table cellspacing="0">
        	<TR>
                 <TD class="blue" >ҵ������&nbsp;</td>
                 <td colspan="3">
                 	<select id=tranType name=tranType onChange="onTranType()" >
<%      
				  sqlStr ="select op_code,op_type,op_type||'-->'||op_name,note from sGiftType where op_code='1443'";
%>
			
					<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			  	 <wtc:sql><%=sqlStr%></wtc:sql>
			 	  </wtc:pubselect>
				 <wtc:array id="result_t1" scope="end"/>
<%                      
                      result = result_t1;
                      recordNum = result.length;
                      System.out.println("recordNum"+recordNum);
		
                  for(i=0;i<recordNum;i++)
                  {
                    System.out.println("result[i][0]="+result[i][0]);
                    out.println("<option class='button' value='" + result[i][1] + "'>" + result[i][2] + "</option>");
                  }
%>
                    </select>             
     				</td>
                </TR>
                
    
          <tr> 
             <td nowrap class="blue">�û�����</td>
             <td>
	              <input type="text" name="phoneno" v_must=1 v_type="mobphone" onBlur="if(this.value!=''){if(checkElement(document.all.phoneno)==false){return false;}}" maxlength=11  index="6" value ="<%=phone_no%>"  Class="InputGrey" readOnly >  
	            <font class="orange">*</font>
	            <input type="button" name="qryId_No" value="У��" onClick="simChk()"  class="b_text"> 
         	 </td>
         	 
         	<%
         	String sql_newP1443 = "select offer_name,to_char(offer_id) from product_offer where offer_code like '%00070AAA%'";
         	%> 
         	<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			  	 <wtc:sql><%=sql_newP1443%></wtc:sql>
			 	  </wtc:pubselect>
				 <wtc:array id="result_newP1443" scope="end"/>
				 	
				 	<%
				 	String offer_namew = "";
				 	String offer_codew = "";
				 	if(result_newP1443.length>0){
				 	offer_namew = result_newP1443[0][0];
				 	offer_codew = result_newP1443[0][1];
				 		
				 	}
				 	
				 	%>
			<TD colspan="2" width="50%" class="blue"><%=offer_namew%>
				<select name=mode_type >
            	<option value="<%=offer_codew%>" selected><%=offer_codew%></option>
				</select>
            </TD>   
          </tr>
 
          <tr> 
              <td class="blue">��ע</td>
              <td colspan="3">
              <input type="text"  name="t_sys_remark" id="t_sys_remark" size="60"  maxlength=30   Class="InputGrey" readOnly>
            	</td>
          </tr>
          </tr>
          <tr> 
            <td colspan="4" height="30" id="footer"> 
              <div align="center"> 
                <input  type="button" name="confirm" value="��ӡ&ȷ��"  onClick="printCommit()" index="26" disabled class="b_foot_long">
                <input  type=reset name=back value="���" onClick="document.all.confirm.disabled=true;" class="b_foot">
                <input  type="button" name="b_back" value="�ر�"  onClick="removeCurrentTab()" index="28" class="b_foot">
              </div>
            </td>
          </tr>
        </table>

  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>


</html>
<script language="javascript">
 function onTranType()
{
	
	if(document.f1443.tranType.value==1)
	{
		document.all.mode_type.disabled=false;
	}
	else
	{
		document.all.mode_type.disabled=true;
	}
}	
</script>
