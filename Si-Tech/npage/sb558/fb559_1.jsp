<%
    /********************
     version v2.0
     ������: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String opCode = "b559";
	String opName = "�����ݼ�¼��ѯ";
	String workNo = (String)session.getAttribute("workNo");
  String workName = (String)session.getAttribute("workName");
  String regionCode=(String)session.getAttribute("regCode");
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
			function checknum(fData)
			{
				if(fData == "")
					return false;
				if ((isNaN(fData)) || (fData.indexOf(".")!=-1) || (fData.indexOf("-")!=-1))
					return false;
				return true;
			}
			function CheckIsDate(value)   
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
			function doCheck()
			{
				if(document.frmb559.spno.value!="")
				{
					if(!checknum(document.frmb559.spno.value))
					{
						rdShowMessageDialog("SP�������������֣�",0);
	        	return false;
					}
				}
				if(document.frmb559.validdate.value!="")
				{
					if(!checknum(document.frmb559.validdate.value))
					{
						rdShowMessageDialog("������Ϸ�����Ч���ڣ�",0);
	        	return false;
					}
				}
				if(document.frmb559.expiredate.value!="")
				{
					if(!checknum(document.frmb559.expiredate.value))
					{
						rdShowMessageDialog("������Ϸ���ʧЧ���ڣ�",0);
	        	return false;
					}
				}
				if (document.frmb559.searchType.selectedIndex == 0)
				{
					if(document.frmb559.provcode.value!="")
					{
						if(!checknum(document.frmb559.provcode.value))
						{
							rdShowMessageDialog("����ʡ�������������֣�",0);
		        	return false;
						}
					}
					if(document.frmb559.balprov.value!="")
					{
						if(!checknum(document.frmb559.balprov.value))
						{
							rdShowMessageDialog("����ʡ�������������֣�",0);
		        	return false;
						}
					}
					if(document.frmb559.devcode.value!="")
					{
						if(!checknum(document.frmb559.devcode.value))
						{
							rdShowMessageDialog("����ʡ�������������֣�",0);
		        	return false;
						}
					}
					if(document.frmb559.pagecount.value=="")
					{
						document.frmb559.pagecount.value=20;
					}
					else
					{
						if(!checknum(document.frmb559.pagecount.value))
						{
							document.frmb559.pagecount.value=20;
						}
						if(document.frmb559.pagecount.value<20)
						{
							document.frmb559.pagecount.value=20;
						}
					}
				}
				else
				{
					if(document.frmb559.infofee.value!="")
					{
						if(!checknum(document.frmb559.infofee.value))
						{
							rdShowMessageDialog("��Ϣ�����������֣�",0);
		        	return false;
						}
					}
				}
				var oButton = document.getElementById("queryButton"); 
				oButton.disabled = true; 
				if (document.frmb559.searchType.selectedIndex == 0)
				{
					document.frmb559.action="fb559_2.jsp"
					frmb559.submit();
				}
				else
				{
					document.frmb559.action="fb559_3.jsp"
					frmb559.submit();
				}
			}
			function typechange() 
			{
        if (document.frmb559.searchType.selectedIndex == 0) {
            IList1.style.display = "";
            IList2.style.display = "none";
        } else {
            IList1.style.display = "none";
            IList2.style.display = "";
        }
    	}
		</SCRIPT>
		<FORM method=post name="frmb559">
		<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">�����ݵ����¼��ѯ</div>
			</div>
			<TABLE cellSpacing="0">
				<TR>
					<TD class="blue" width=30%>��ѯ����</TD>
            <TD>
                <select name="searchType" onchange="typechange()">
                    <option value="0" selected>SP��ҵ������</option>
                    <option value="1">SPҵ�������</option>
                </select>
            </TD>
				</TR>
				<TR>
        	<TD class="blue">����������</TD>
            <TD>
                <select name="dsmpType">
                	<option value="0" selected></option>
                	<wtc:qoption name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
                		<wtc:sql>
											select servtype,servname from sdsmpservtype order by servtype
										</wtc:sql>
                	</wtc:qoption>  
                </select>
            </TD>
        </TR>
        <TR>
        	<td  class="blue">�����ļ���</td>
					<TD>
          	<input type="text" name="filename" size="20" maxlength="20">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">��������</td>
					<TD>
          	<select name="optype">
                    <option value="0" selected></option>
                    <option value="1">����</option>
                    <option value="2">�޸�</option>
                    <option value="3">ɾ��</option>
            </select>
          </TD>
        </TR>
        <TR>
        	<td  class="blue">SP��ҵ����</td>
					<TD>
          	<input type="text" name="spno" size="20" maxlength="20">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">��Ч����</td>
					<TD>
          	<input type="text" name="validdate" size="10" maxlength="8">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">ʧЧ����</td>
					<TD>
          	<input type="text" name="expiredate" size="10" maxlength="8">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">ÿҳ��ʾ����</td>
					<TD>
          	<input type="text" name="pagecount" size="10" maxlength="8" value="20">
          </TD>
        </TR>
      </TABLE>
      <TABLE cellSpacing="0" style="display:''" id="IList1">
        <TR>
        	<td  class="blue" width=30%>SP��ҵ����</td>
					<TD>
          	<input type="text" name="spname" size="20" maxlength="64">
          </TD>
        </TR>
        <TR>
					<TD class="blue" >SP����</TD>
            <TD>
                <select name="spType">
                    <option value="0" selected></option>
                    <option value="1">��ͨSP</option>
                    <option value="2">����SP</option>
                </select>
            </TD>
				</TR>
				<TR>
        <TR>
        	<td  class="blue" >����ʡ����</td>
					<TD>
          	<input type="text" name="provcode" size="20" maxlength="3">
          </TD>
        </TR>
         <TR>
        	<td  class="blue" >����ʡ����</td>
					<TD>
          	<input type="text" name="balprov" size="20" maxlength="3">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">ƽ̨����</td>
					<TD>
          	<input type="text" name="devcode" size="20" maxlength="21">
          </TD>
        </TR>
			</TABLE>
			<TABLE cellSpacing="0" style="display:none" id="IList2">
				<TR>
        	<td  class="blue" width=30%>ҵ�����</td>
					<TD>
          	<input type="text" name="bizno" size="20" maxlength="21">
          </TD>
        </TR>
        	<TR>
        	<td  class="blue">ҵ���Ʒ����</td>
					<TD>
          	<input type="text" name="bizname" size="20" maxlength="64">
          </TD>
        </TR>
        <TR>
					<TD class="blue" >�Ʒ�����</TD>
            <TD>
                <select name="bizType">
                    <option value="0" selected></option>
                    <option value="1">���</option>
                    <option value="2">����/����</option>
                    <option value="3">����</option>
                    <option value="4">����</option>
                    <option value="5">����</option>
                    <option value="6">����Ŀ</option>
                    <option value="7">ʱ��</option>
                </select>
            </TD>
				</TR>
				<TR>
        	<td  class="blue">��Ϣ��</td>
					<TD>
          	<input type="text" name="infofee" size="20" maxlength="12">
          </TD>
        </TR>
        <TR>
        	<td  class="blue">���뷽����</td>
					<TD>
          	<input type="text" name="balprop" size="20" maxlength="16">
          </TD>
        </TR>
        <TR>
					<TD class="blue" >����ȷ�ϱ�ʾ</TD>
            <TD>
                <select name="reconfirm">
                    <option value="0" selected></option>
                    <option value="1">����Ҫ</option>
                    <option value="2">��Ҫ</option>
                </select>
            </TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="0">
				<tr> 
	        <td id="footer"> 
	           <input type="button" name="queryButton"  class="b_foot" value="��ѯ" style="cursor:hand;" onclick="doCheck()">&nbsp;
	           <input type="button" name="resetButton"  class="b_foot" value="����" style="cursor:hand;" onclick="document.frmb559.reset();typechange()">&nbsp;
	           <input type="button" name="closeButton" class="b_foot" value="�ر�" style="cursor:hand;" onClick="parent.removeTab('<%=opCode%>')">&nbsp;
	        </td>
		     </tr>
			</TABLE>
		</FORM>
	</BODY>
</HTML>
