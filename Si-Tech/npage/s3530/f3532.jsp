   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-10
********************/
%>
              
<%
  String opCode = "3532";
  String opName = "����һ�";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%  request.setCharacterEncoding("GBK"); %>


<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String pass = (String)session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");
    
		String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

			
		String ph_no = request.getParameter("ph_no");	
%>
<%
	
	String sqlClubType = "";
	String[][] ClubTypeStr= new String[][]{};
   
	sqlClubType = "select club_type,club_name from sClubType where region_code='"+org_code.substring(0,2) +"'" ;
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlClubType%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%
	//ArrayList ClubTypeArr = co.spubqry32("2",sqlClubType);
	ClubTypeStr = result_t;

//	System.out.println("ClubTypeArr"+ClubTypeArr);
	System.out.println("ClubTypeStr"+ClubTypeStr.length);
	
%>
<HTML>
<HEAD>


<script language="JavaScript">
<!--	
 function doProcess(packet)
{
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
	var retResult = packet.data.findValueByName("retResult");
    var type = packet.data.findValueByName("type");

		if(retResult == "000000"){
		 rdShowMessageDialog("��������׼ȷ��",2);
	     document.frm.query.disabled = false;
		 return true; 
		 }else{
		 rdShowMessageDialog("��������������������룡",0);
		 document.frm.cus_pass.focus();
		 document.frm.query.disabled = true;
		 return false;
		 
		 }
	
}
function verifyPass(){
    if (document.frm.phoneNo.value.length == 0) {
      rdShowMessageDialog("�ֻ����벻��Ϊ�գ����������� !!",0);
      document.frm.phoneNo.focus();
      return false;
     } 
    var myPacket = new AJAXPacket("pwd.jsp","���ڲ�ѯ�ͻ����룬���Ժ�......");
	myPacket.data.add("phoneNo",(document.frm.phoneNo.value).trim());
	myPacket.data.add("cus_pass",(document.frm.cus_pass.value).trim());
	myPacket.data.add("type","0");
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}
function check_HidPwd()
{
	if(document.frm.clubType.value=="")
	{
		rdShowMessageDialog("��ѡ����ֲ�����!",0);
		document.frm.clubType.focus();
		return false;
	}	  
	if(document.frm.phoneNo.value=="")
	{
		rdShowMessageDialog("������������!",0);
	    document.frm.phoneNo.focus();
 	    return false;
    }	  
    if(document.frm.phoneNo.value.length != 11 )
	{
        rdShowMessageDialog("�������ֻ����11λ!",0);
 	    document.frm.phoneNo.value = "";
 	    document.frm.phoneNo.focus();
 	    return false;
    }
	document.frm.action="f3532_1.jsp";
	document.frm.submit();
}
function doclear()
{
	frm.reset();
}
-->
 </script> 
 
<title>������BOSS-VIP���ֲ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<BODY>
<form action="" method="post" name="frm"  >
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">����һ�</div>
	</div>
<input type="hidden" name="opCode" value="3532">

 
		     <TABLE  cellSpacing="0">
		       <tr>
			    <td width="13%" class="blue">���ֲ�����</td>
			    <td width="87%" colspan="4">
			      <select  name="clubType" >
				   <option value="">--��ѡ��--</option>
				   <%for(int i = 0 ; i < ClubTypeStr.length ; i ++){%>
				   <option value="<%=ClubTypeStr[i][0]%>"><%=ClubTypeStr[i][1]%></option>
				   <%}%>
			      </select>
			    <font class="orange">*</font>
			    </td>
               </tr>
		       <tr> 
                 <td width="13%" class="blue">��������</td>
                 <td width="87%" colspan="4" class="blue"> 
					����һ�
				 </td>
				 <td>
				 </td>
			   </tr>
<%

%>
                <tr> 
                  <td width="13%" nowrap class="blue">�������</td>
                  <td width="35%"> 
                    <input type="text" name="phoneNo" size="20" maxlength="11"  value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly >
					<font class="orange">*
                  </td>
                  <td width="16%"   nowrap>
					<div align="left" class="blue">�ͻ����� </div>
				  </td>
				  <td width="40%"  nowrap>
				<jsp:include page="/npage/query/pwd_one.jsp">
	            <jsp:param name="width1" value="16%"  />
	            <jsp:param name="width2" value="34%"  />
			    <jsp:param name="pname" value="cus_pass"  />
	            <jsp:param name="pwd" value="12345"  />
 	           </jsp:include>
				<input class=b_text	 type=button size=17  value="��֤����" onclick="verifyPass()">
				</td>
                </tr>
              </table>

        <TABLE  cellSpacing="0">
          <TR > 
            <TD noWrap   align="center" id="b_footer"> 
                 <input type="button" name="query"   value="��ѯ" onclick="check_HidPwd()" class="b_foot">
                &nbsp;
                <input type="button" name="return1"  value="���" onclick="doclear()"  class="b_foot">
                &nbsp;
				<input type="button" name="return2"  value="�ر�" onClick="removeCurrentTab();"  class="b_foot">
             </TD>
          </TR>
        </TABLE>

<%@ include file="/npage/include/footer.jsp" %>
</form>
 </BODY>
</HTML>