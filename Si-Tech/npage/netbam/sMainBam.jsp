   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-10
********************/
%>
              
<%
  String opCode = "bammoni";
  String opName = "BAM������ݴ���";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
	



<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*"%>





<%
   String regionCode = (String)session.getAttribute("regCode");
	//String userPhoneNo=(String)session.getAttribute("userPhoneNo");
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");

    String work_Pwd = (String)session.getAttribute("password");
	boolean workNoFlag=false;
  //if(workNoFromSession.substring(0,1).equals("k"))
    workNoFlag=true;
    
    String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    boolean hfrf=false;
	for(int j=0;j<favStr.length;j++)
		System.out.println("======= favStr ======="+favStr[j]+"==============");
    if(WtcUtil.haveStr(favStr,"a272")){
		
	  pwrf=true;
	  System.out.println("===== pwrf ====" + pwrf);
	}
	//ArrayList initArr = new ArrayList();
        //ArrayList groupArr = new ArrayList();

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));

	String dirtPage=request.getParameter("dirtPage");



//----------------------------------------------------------
  
%>



<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="paraStr" /> 
	
	
<%
  request.setCharacterEncoding("GBK");

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
%>


<html>
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
 
 //--------4---------doProcess����----------------
function doProcess(packet)
{
    var vRetPage=packet.data.findValueByName("rpc_page");  
	  
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
	if(retCode == "000000"){
		document.all.confirm.disabled=false;
		
	}else
	{
		rdShowMessageDialog("����:"+ retCode + "->" + retMsg,0);
		return;
	}    
    
}

//-------2---------��֤���ύ����-----------------

function printCommit(){
	if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
  {
		s1448.submit();
	}

  return true;
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
		

    cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
    cust_info+="�ֻ����룺"+document.all.phoneno.value+"|";  
	  cust_info+="�ͻ���ַ��"+document.all.id_address.value+"|";
    cust_info+="֤�����룺"+document.all.id_iccid.value+"|";
	if(document.all.postFlag.value == "0")
	{
		opr_info+="�ʼķ�ʽ�� �ʼ�"+"|";
	}else if (document.all.postFlag.value == "0")
	{
		opr_info+="�ʼķ�ʽ�� ����"+"|";
	}
	else
	{
		opr_info+="�ʼķ�ʽ�� �����ʼ�"+"|";
	}
    opr_info+="�û�Ʒ�ƣ�"+document.all.sm_name.value+"|";
    if(document.all.r_cus[0].checked)
	{
      opr_info+="����ҵ��"+"����"+"|";
	}
	if(document.all.r_cus[1].checked)
	{
      opr_info+="����ҵ��"+"�޸�"+"|";
	}
	if(document.all.r_cus[2].checked)
	{
      opr_info+="����ҵ��"+"ɾ��"+"|";
	}
	if(document.all.r_cus[3].checked)
	{
      opr_info+="����ҵ��"+"��ѯ"+"|";
	}
		opr_info+="������ˮ��"+document.all.loginAccept.value+"|";
    opr_info+="�ʱࣺ"+document.all.post_zip.value+"|";
    opr_info+="�ʼĵ�ַ��"+document.all.post_address.value+"|";
    
    note_info1+="��ע��"+document.all.t_sys_remark.value+"|";
    note_info2+="��ע��"+document.all.t_op_remark.value+" "+document.all.simBell.value+"|";
      
  	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

    return retInfo;
  }

 //-->
</script>

<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
//String prtSql="select to_char(sMaxSysAccept.nextval) from dual";

%>



</head>
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<form action="BamPost.jsp" method="POST" name="s1448"  onKeyUp="chgFocus(s1448)">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">BAM������ݴ���</div>
	</div>
	<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	<input type="hidden" name="id_iccid"  value="">
	<input type="hidden" name="id_address"  value="">
	<input type="hidden" name="sm_name"  value="">
	
	<input type="hidden" name="loginAccept" value="<%=paraStr%>">
	<%@ include file="../../include/remark.htm" %>
        <table cellspacing="0" >
          <tr> 
            <td nowrap width="16%" class="blue">������1</td>
            <td  nowrap width="28%"> 
              <div align="left"> 
                <input name="line1" type="text"   v_name="������1"  value="" index="6" >
            </td>
            <td  nowrap width="16%" class="blue"></td>
            <td  nowrap width="40%"> 
            </td>
          </tr>
          <tr> 
            <td nowrap width="16%" class="blue">������2</td>
            <td  nowrap width="28%"> 
              <input type="text"  name="line2"  v_name="������2" maxlength=10 value="" tabindex="0">
            </td>
            <td  nowrap width="16%" class="blue"></td>
            <td  nowrap width="40%"> 
            </td>
          </tr>
          <tr bgcolor="e8e8e8"> 
            <td colspan="4" height="30" id="footer"> 
              <div align="center"> 
                <input  type="button" name="confirm" value="��ӡ&ȷ��"  onClick="printCommit()" index="26" class="b_foot_long">
                <input  type=reset name=back value="���" onClick="document.all.confirm.disabled=true;"  class="b_foot">
                <input  type="button" name="b_back" value="����"  onClick="window.close()" index="28" class="b_foot">
              </div>
            </td>
          </tr>
        </table>

  <%@ include file="/npage/include/footer.jsp" %>
  <input type="hidden"  name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  v_name="�û���ע" index="28" maxlength=60> 
</form>
</body>


</html>
