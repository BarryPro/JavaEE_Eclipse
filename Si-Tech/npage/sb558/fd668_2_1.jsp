<%
    /********************
     version v2.0
     ������: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
    	String opCode = "d668";
    	String opName = "�����ݹ���";
    	String workNo = (String)session.getAttribute("workNo");
      String workName = (String)session.getAttribute("workName");
      String regionCode=(String)session.getAttribute("regCode");
      String orgCode = (String)session.getAttribute("orgCode");
      String region_Code = orgCode.substring(0,2);
      String title = "��ҵ���������";
%>
<HTML>
	<HEAD>
		<TITLE>�����ݼ�¼��ѯ</TITLE>
		<%
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
		%>
	</HEAD>
	<BODY>
		<SCRIPT language="JavaScript">
			function   CheckIsDate(value)   
			{   
			  var   strValue     =   new   String();       
			  var   year   =   new   String();   
			  var   month   =   new   String();   
			  var   day   =   new   String();   
			  strValue   =   value;
			  year   =   strValue.substr(0,4);   
			  month   =   strValue.substr(4,2);   
			  month   =   month-1;     
			  day   =   strValue.substr(6,2);   
			  var   testDate   =   new   Date(year,month,day); 
			  return     (year   ==   testDate.getFullYear())   &&   (month   ==testDate.getMonth())&&(day   ==   testDate.getDate());   
			}
			function doProcess(packet)
			{
				var retCode = packet.data.findValueByName("retCode");
				var errMsg = packet.data.findValueByName("errMsg");
				rdShowMessageDialog("SP��������ӳɹ�!",2);
			}
			function doCheck()
			{
				var optflag = "0";
				var dsmpType =  document.frmd668_2_1.dsmpType.value;
				var spid = document.frmd668_2_1.spid.value;
				var spname = document.frmd668_2_1.spname.value;
				var spType = document.frmd668_2_1.spType.value;
				var devcode = document.frmd668_2_1.devcode.value;
				var provcode = document.frmd668_2_1.provcode.value;
				var balprov = document.frmd668_2_1.balprov.value;
				var servflag = document.frmd668_2_1.servflag.value;
				var inbegintime = document.frmd668_2_1.validdate.value;	
				var inEndtime = document.frmd668_2_1.expiredate.value;
				var spattr = document.frmd668_2_1.spattr.value;	
				var spstatus = document.frmd668_2_1.expiredate.value;
				var oButton = document.getElementById("Button1");
				var spsvcid = document.frmd668_2_1.spsvcid.value;
				var spenname = document.frmd668_2_1.spenname.value;
				var spshortname = document.frmd668_2_1.spshortname.value;
				var spdesc = document.frmd668_2_1.spdesc.value;
				var csrtel = document.frmd668_2_1.csrtel.value;
				var csrurl = document.frmd668_2_1.csrurl.value;
				var contactperson = document.frmd668_2_1.contactperson.value;
				var fixedline = document.frmd668_2_1.fixedline.value;
				if (document.frmd668_2_1.spid.value=="")
		    {
		      rdShowMessageDialog("��������ҵ���룡");
		      document.frmd668_2_1.spid.value="";
		      document.frmd668_2_1.spid.select();
		      return false;
		    }
		    if (document.frmd668_2_1.spname.value=="")
		    {
		      rdShowMessageDialog("��������ҵ���ƣ�");
		      document.frmd668_2_1.spname.value="";
		      document.frmd668_2_1.spname.select();
		      return false;
		    }
		    if (document.frmd668_2_1.validdate.value=="")
		    {
		      rdShowMessageDialog("��������Чʱ�䣡");
		      document.frmd668_2_1.validdate.value="";
		      document.frmd668_2_1.validdate.select();
		      return false;
		    }
		    if(document.frmd668_2_1.validdate.value.length != 8)
			  {
			    rdShowMessageDialog("��Чʱ�䳤�Ȳ���ȷ��");
			    document.frmd668_2_1.validdate.select();
			    return false;
			  }
			  if(!CheckIsDate(inbegintime))
			  {
			    rdShowMessageDialog("��Чʱ�䲻�Ϸ���");
			    document.frmd668_2_1.validdate.select();
			    return false;
			  }
		    if (document.frmd668_2_1.expiredate.value=="")
		    {
		      rdShowMessageDialog("������ʧЧʱ�䣡");
		      document.frmd668_2_1.expiredate.value="";
		      document.frmd668_2_1.expiredate.select();
		      return false;
		    }
		    
			  if(document.frmd668_2_1.expiredate.value.length != 8)
			  {
			    rdShowMessageDialog("ʧЧʱ�䳤�Ȳ���ȷ��");
			    document.frmd668_2_1.expiredate.select();
			    return false;
			  }
			  
			  if(!CheckIsDate(inEndtime))
			  {
			    rdShowMessageDialog("ʧЧʱ�䲻�Ϸ���");
			    document.frmd668_2_1.expiredate.select();
			    return false;
			  }
			  if(inEndtime.localeCompare(inbegintime)<0)
				{
					rdShowMessageDialog("��Чʱ�䲻�ܴ���ʧЧʱ��!");
					return;
				}
				if(rdShowConfirmDialog('ȷ��Ҫ���ô��')==1)
				{	
					var myPacket = new AJAXPacket("fd668_add.jsp","�����ύ�����Ժ�...");
					myPacket.data.add("dsmpType",dsmpType);
					myPacket.data.add("spid",spid);
					myPacket.data.add("spname",spname);
					myPacket.data.add("spType",spType);
					myPacket.data.add("devcode",devcode);
					myPacket.data.add("provcode",provcode);
					myPacket.data.add("balprov",balprov);
					myPacket.data.add("validdate",inbegintime);
					myPacket.data.add("expiredate",inEndtime);
					myPacket.data.add("servflag",servflag);
					myPacket.data.add("optflag",optflag);
					myPacket.data.add("spattr",spattr);
					myPacket.data.add("spstatus",spstatus);
					myPacket.data.add("spsvcid",spsvcid);
					myPacket.data.add("spenname",spenname);
					myPacket.data.add("spshortname",spshortname);
					myPacket.data.add("spdesc",spdesc);
					myPacket.data.add("csrtel",csrtel);
					myPacket.data.add("csrurl",csrurl);
					myPacket.data.add("contactperson",contactperson);
					myPacket.data.add("fixedline",fixedline);
					core.ajax.sendPacket(myPacket);
					myPacket=null;
				}
			}
			function dsmpTypechange()
			{
				document.all.dsmpTypeid.value= document.all.dsmpType.value; 
			}
			$(document).ready(function(){dsmpTypechange();});
		</SCRIPT>
		<FORM method=post name="frmd668_2_1">
			<%@ include file="/npage/include/header.jsp" %>  
			<div class="title">
				<div id="title_zi"><%=title%></div>
			</div>
			<table>
			<TR>
      	<TD class="blue" width=16%>����������</TD>
          <TD>
            <select name="dsmpType" onchange="dsmpTypechange()">
            	<wtc:qoption name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
            		<wtc:sql>
									select servtype,servname from sdsmpservtype order by servtype
								</wtc:sql>
            	</wtc:qoption>  
            </select>
          </TD>
        <td  class="blue">����������ID</td>
				<TD>
        	<input type="text" name="dsmpTypeid" size="20" maxlength="64" disabled="1">
        </TD>
      </TR>
      <TR>
      	<td  class="blue">��ҵ����</td>
				<TD>
        	<input type="text" name="spid" size="20" maxlength="20">
        </TD>
        <td  class="blue">��ҵ����</td>
				<TD>
        	<input type="text" name="spname" size="20" maxlength="64">
        </TD>
      </TR>
      <TR>
      	<td  class="blue">ҵ���־</td>
      	<TD>
            <select name="spType">
                <option value="0" selected>��ͨSP</option>
                <option value="1">����SP</option>
            </select>
        </TD>
      	<td  class="blue">ƽ̨����</td>
      	<TD>
      		<input type="text" name="devcode" size="20" maxlength="8">
      	</TD>
      </TR>
      <TR>
      	<td  class="blue">����ʡ����</td>
				<TD>
        	<input type="text" name="provcode" size="20" maxlength="5">
        </TD>
        <td  class="blue">����ʡ����</td>
				<TD>
        	<input type="text" name="balprov" size="20" maxlength="5">
        </TD>
      </TR>
       <TR>
      	<td  class="blue">��Чʱ��</td>
				<TD>
        	<input type="text" name="validdate" size="20" maxlength="8">
        </TD>
        <td  class="blue">ʧЧʱ��</td>
				<TD>
        	<input type="text" name="expiredate" size="20" maxlength="8">
        </TD>
      </TR>
      <TR>
      	<td  class="blue">��Ӫģʽ</td>
      	<TD>
            <select name="servflag">
                <option value="1" selected>�й��ƶ���Ӫ</option>
                <option value="0">���й��ƶ���Ӫ</option>
            </select>
        </TD>
        <TD></TD>
        <TD></TD>
      </TR>
      <TR>
      	<td  class="blue">ҵ������</td>
      	<TD>
            <select name="spattr">
                <option value="0" selected>ȫ��ҵ��</option>
                <option value="1">����ҵ��</option>
            </select>
        </TD>
      	<td  class="blue">״̬��ʾ</td>
      	<TD>
            <select name="spstatus">
                <option value="0" selected>��Ч</option>
                <option value="1">ʧЧ</option>
            </select>
        </TD>
      </TR>
      <TR>
      	<td  class="blue">�������</td>
      	<TD>
      		<input type="text" name="SPSVCID" size="20" maxlength="21">
        </TD>
        <td  class="blue">��ҵӢ������</td>
      	<TD>
      		<input type="text" name="spenname" size="20" maxlength="128">
        </TD>
      </TR>
      <TR>
      	<td  class="blue">��ҵ����</td>
      	<TD>
      		<input type="text" name="spshortname" size="20" maxlength="32">
        </TD>
        <td  class="blue">��ҵ����</td>
      	<TD>
      		<input type="text" name="spdesc" size="20" maxlength="512">
        </TD>
      </TR>
      <TR>
      	<td  class="blue">��ϵ�绰</td>
      	<TD>
      		<input type="text" name="csrtel" size="20" maxlength="32">
        </TD>
        <td  class="blue">������ַ</td>
      	<TD>
      		<input type="text" name="csrurl" size="20" maxlength="128">
        </TD>
      </TR>
      <TR>
      	<td  class="blue">��ϵ��</td>
      	<TD>
      		<input type="text" name="contactperson" size="20" maxlength="21">
        </TD>
        <td  class="blue">fixedline</td>
      	<TD>
      		<input type="text" name="fixedline" size="20" maxlength="20">
        </TD>
      </TR>
		</table>
			<TABLE cellSpacing="0">
				<tr> 
	        <td id="footer"> 
	           <input type="button" name="addButton"    class="b_foot" value="���" style="cursor:hand;" onclick="doCheck()">&nbsp;
	           <input type="button" name="copyButton"   class="b_foot" value="����" style="cursor:hand;" onclick="window.close()">&nbsp;
	        </td>
		     </tr>
			</TABLE>
			<%@ include file="/npage/include/footer.jsp" %>   
		</FORM>
  </BODY>
</HTML>