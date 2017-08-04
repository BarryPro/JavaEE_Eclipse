<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
    	String opCode = "d668";
    	String opName = "局数据管理";
    	String workNo = (String)session.getAttribute("workNo");
      String workName = (String)session.getAttribute("workName");
      String regionCode=(String)session.getAttribute("regCode");
      String orgCode = (String)session.getAttribute("orgCode");
      String region_Code = orgCode.substring(0,2);
      String title = "企业局数据复制添加";
      String opt_flag = request.getParameter("opt_flag");
      String spid = request.getParameter("check_flag");
      String sql1="select servtype,spid,spname,sptype,devcode,provcode,balprov,validdate,expiredate,serv_flag,nvl(SPATTR,'G'),nvl(SPSTATUS,'A'),spsvcid,spenname,spshortname,spdesc,csrtel,csrurl,contactperson,fixedline,op_time,op_flag from ddsmpspinfo where spid = '"+spid+"'";
      
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_Code%>" retval="val1" outnum="30">
<wtc:sql><%=sql1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" property="val1" scope="end" />
<HTML>
	<HEAD>
		<TITLE>企业局数据复制添加</TITLE>
		<%
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
		%>
	</HEAD>
	<BODY>
		<SCRIPT language="JavaScript">
			onload=function()
  		{
  			for(var i=0;i<document.frmd668_2_2.dsmpType.length;i++)
  			{
  				if(document.frmd668_2_2.dsmpType.options[i].value=="<%=result1[0][0]%>")
  						document.frmd668_2_2.dsmpType.options[i].selected=true;
  			}
  			document.frmd668_2_2.spid.value="<%=result1[0][1]%>"
  			document.frmd668_2_2.spname.value="<%=result1[0][2]%>"
  			if(<%=result1[0][3]%>=="1")
  			{
  				document.frmd668_2_2.spType.options[1].selected=true;
  			}
  			else
  			{
  				document.frmd668_2_2.spType.options[0].selected=true;
  			}
  			document.frmd668_2_2.devcode.value="<%=result1[0][4]%>"
  			document.frmd668_2_2.provcode.value="<%=result1[0][5]%>"
  			document.frmd668_2_2.balprov.value="<%=result1[0][6]%>"
  			document.frmd668_2_2.validdate.value="<%=result1[0][7]%>"
  			document.frmd668_2_2.expiredate.value="<%=result1[0][8]%>"
  			if("<%=result1[0][9]%>"=="1")
  			{
  				document.frmd668_2_2.servflag.options[1].selected=true;
  			}
  			else
  			{
  				document.frmd668_2_2.servflag.options[0].selected=true;
  			}
  			
  			if("<%=result1[0][10]%>"=="L")
  			{
  				document.frmd668_2_2.spattr.options[1].selected=true;
  			}
  			else
  			{
  				document.frmd668_2_2.spattr.options[0].selected=true;
  			}
  			
  			if("<%=result1[0][11]%>"=="N")
  			{
  				document.frmd668_2_2.spstatus.options[1].selected=true;
  			}
  			else
  			{
  				document.frmd668_2_2.spstatus.options[0].selected=true;
  			}
				document.frmd668_2_2.spsvcid.value="<%=result1[0][12]%>"
  			document.frmd668_2_2.spenname.value="<%=result1[0][13]%>"
  			document.frmd668_2_2.spshortname.value="<%=result1[0][14]%>"
  			document.frmd668_2_2.spdesc.value="<%=result1[0][15]%>"
  			document.frmd668_2_2.csrtel.value="<%=result1[0][16]%>"
  			document.frmd668_2_2.csrurl.value="<%=result1[0][17]%>"
  			document.frmd668_2_2.contactperson.value="<%=result1[0][18]%>"
  			document.frmd668_2_2.fixedline.value="<%=result1[0][19]%>"
  		}
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
				var retMsg = packet.data.findValueByName("retMsg");
				var opt_flag = "<%=opt_flag%>";
				if(opt_flag=="0")
				{
					if(retCode=="000000")
						rdShowMessageDialog("SP局数据添加成功!",2);
					else
						rdShowMessageDialog("SP局数据添加失败!"+retCode+" "+retMsg,0);
				}
				else
				{
					if(retCode=="000000")
						rdShowMessageDialog("SP局数据修改成功!",2);
					else
						rdShowMessageDialog("SP局数据修改失败!"+retCode+" "+retMsg,0);
				}
				
			}
			function doCheck()
			{
				var optflag = "0";
				var dsmpType =  document.frmd668_2_2.dsmpType.value;
				var spid = document.frmd668_2_2.spid.value;
				var spname = document.frmd668_2_2.spname.value;
				var spType = document.frmd668_2_2.spType.value;
				var devcode = document.frmd668_2_2.devcode.value;
				var provcode = document.frmd668_2_2.provcode.value;
				var balprov = document.frmd668_2_2.balprov.value;
				var servflag = document.frmd668_2_2.servflag.value;
				var inbegintime = document.frmd668_2_2.validdate.value;	
				var inEndtime = document.frmd668_2_2.expiredate.value;
				var spattr = document.frmd668_2_2.spattr.value;	
				var spstatus = document.frmd668_2_2.spstatus.value;
				var oButton = document.getElementById("Button1");
				var spsvcid = document.frmd668_2_2.spsvcid.value;
				var spenname = document.frmd668_2_2.spenname.value;
				var spshortname = document.frmd668_2_2.spshortname.value;
				var spdesc = document.frmd668_2_2.spdesc.value;
				var csrtel = document.frmd668_2_2.csrtel.value;
				var csrurl = document.frmd668_2_2.csrurl.value;
				var contactperson = document.frmd668_2_2.contactperson.value;
				var fixedline = document.frmd668_2_2.fixedline.value;
				if (document.frmd668_2_2.spid.value=="")
		    {
		      rdShowMessageDialog("请输入企业代码！");
		      document.frmd668_2_2.spid.value="";
		      document.frmd668_2_2.spid.select();
		      return false;
		    }
		    if (document.frmd668_2_2.spname.value=="")
		    {
		      rdShowMessageDialog("请输入企业名称！");
		      document.frmd668_2_2.spname.value="";
		      document.frmd668_2_2.spname.select();
		      return false;
		    }
		    if (document.frmd668_2_2.validdate.value=="")
		    {
		      rdShowMessageDialog("请输入生效时间！");
		      document.frmd668_2_2.validdate.value="";
		      document.frmd668_2_2.validdate.select();
		      return false;
		    }
		    if(document.frmd668_2_2.validdate.value.length != 8)
			  {
			    rdShowMessageDialog("生效时间长度不正确！");
			    document.frmd668_2_2.validdate.select();
			    return false;
			  }
			  if(!CheckIsDate(inbegintime))
			  {
			    rdShowMessageDialog("生效时间不合法！");
			    document.frmd668_2_2.validdate.select();
			    return false;
			  }
		    if (document.frmd668_2_2.expiredate.value=="")
		    {
		      rdShowMessageDialog("请输入失效时间！");
		      document.frmd668_2_2.expiredate.value="";
		      document.frmd668_2_2.expiredate.select();
		      return false;
		    }
		    
			  if(document.frmd668_2_2.expiredate.value.length != 8)
			  {
			    rdShowMessageDialog("失效时间长度不正确！");
			    document.frmd668_2_2.expiredate.select();
			    return false;
			  }
			  
			  if(!CheckIsDate(inEndtime))
			  {
			    rdShowMessageDialog("失效时间不合法！");
			    document.frmd668_2_2.expiredate.select();
			    return false;
			  }
			  if(inEndtime.localeCompare(inbegintime)<0)
				{
					rdShowMessageDialog("生效时间不能大于失效时间!");
					return;
				}
				if(rdShowConfirmDialog('确认要添加吗？')==1)
				{
					var myPacket = new AJAXPacket("fd668_add.jsp","正在提交，请稍候...");
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
			function doCheck1()
			{
				var optflag = "0";
				var dsmpType =  document.frmd668_2_2.dsmpType.value;
				var spid = document.frmd668_2_2.spid.value;
				var spname = document.frmd668_2_2.spname.value;
				var spType = document.frmd668_2_2.spType.value;
				var devcode = document.frmd668_2_2.devcode.value;
				var provcode = document.frmd668_2_2.provcode.value;
				var balprov = document.frmd668_2_2.balprov.value;
				var servflag = document.frmd668_2_2.servflag.value;
				var inbegintime = document.frmd668_2_2.validdate.value;	
				var inEndtime = document.frmd668_2_2.expiredate.value;
				var oButton = document.getElementById("Button1");
				var spattr = document.frmd668_2_2.spattr.value;	
				var spstatus = document.frmd668_2_2.spstatus.value;
				var spsvcid = document.frmd668_2_2.spsvcid.value;
				var spenname = document.frmd668_2_2.spenname.value;
				var spshortname = document.frmd668_2_2.spshortname.value;
				var spdesc = document.frmd668_2_2.spdesc.value;
				var csrtel = document.frmd668_2_2.csrtel.value;
				var csrurl = document.frmd668_2_2.csrurl.value;
				var contactperson = document.frmd668_2_2.contactperson.value;
				var fixedline = document.frmd668_2_2.fixedline.value;
		    if (document.frmd668_2_2.spname.value=="")
		    {
		      rdShowMessageDialog("请输入企业名称！");
		      document.frmd668_2_2.spname.value="";
		      document.frmd668_2_2.spname.select();
		      return false;
		    }
		    if (document.frmd668_2_2.validdate.value=="")
		    {
		      rdShowMessageDialog("请输入生效时间！");
		      document.frmd668_2_2.validdate.value="";
		      document.frmd668_2_2.validdate.select();
		      return false;
		    }
		    if(document.frmd668_2_2.validdate.value.length != 8)
			  {
			    rdShowMessageDialog("生效时间长度不正确！");
			    document.frmd668_2_2.validdate.select();
			    return false;
			  }
			  if(!CheckIsDate(inbegintime))
			  {
			    rdShowMessageDialog("生效时间不合法！");
			    document.frmd668_2_2.validdate.select();
			    return false;
			  }
		    if (document.frmd668_2_2.expiredate.value=="")
		    {
		      rdShowMessageDialog("请输入失效时间！");
		      document.frmd668_2_2.expiredate.value="";
		      document.frmd668_2_2.expiredate.select();
		      return false;
		    }
		    
			  if(document.frmd668_2_2.expiredate.value.length != 8)
			  {
			    rdShowMessageDialog("失效时间长度不正确！");
			    document.frmd668_2_2.expiredate.select();
			    return false;
			  }
			  
			  if(!CheckIsDate(inEndtime))
			  {
			    rdShowMessageDialog("失效时间不合法！");
			    document.frmd668_2_2.expiredate.select();
			    return false;
			  }
			  if(inEndtime.localeCompare(inbegintime)<0)
				{
					rdShowMessageDialog("生效时间不能大于失效时间!");
					return;
				}
				if(rdShowConfirmDialog('确认要修改吗？')==1)
				{
					var myPacket = new AJAXPacket("fd668_update.jsp","正在提交，请稍候...");
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
		</SCRIPT>
		<FORM method=post name="frmd668_2_2">
			<%@ include file="/npage/include/header.jsp" %>  
			<div class="title">
				<div id="title_zi"><%=title%></div>
			</div>
			<table>
				<TR>
	      	<TD class="blue" width=16%>局数据类型</TD>
	          <TD  colspan="3">
	          	<%if(opt_flag.equals("0")) {%>
	          	<select name="dsmpType">
	          	<%}else{%>
	            <select name="dsmpType" disabled="1">
	            <%}%>
	            	<wtc:qoption name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
	            		<wtc:sql>
										select servtype,servname from sdsmpservtype order by servtype
									</wtc:sql>
	            	</wtc:qoption>  
	            </select>
	          </TD>
	      </TR>
	      <TR>
	      	<td  class="blue">企业代码</td>
					<TD>
						<%if(opt_flag.equals("0")) {%>
	        	<input type="text" name="spid" size="20" maxlength="20">
	        	<%}else{%>
	        	<input type="text" name="spid" size="20" maxlength="20" disabled="1">
	        	<%}%>
	        </TD>
	        <td  class="blue">企业名称</td>
					<TD>
	        	<input type="text" name="spname" size="40" maxlength="64">
	        </TD>
      	</TR>
      	<TR>
      	<td  class="blue">业务类型</td>
      	<TD>
            <select name="spType">
                <option value="0" selected>普通SP</option>
                <option value="1">自有SP</option>
            </select>
        </TD>
      	<td  class="blue">平台代码</td>
      	<TD>
      		<input type="text" name="devcode" size="20" maxlength="8">
      	</TD>
      </TR>
      <TR>
      	<td  class="blue">接入省代码</td>
				<TD>
        	<input type="text" name="provcode" size="20" maxlength="5">
        </TD>
        <td  class="blue">结算省代码</td>
				<TD>
        	<input type="text" name="balprov" size="20" maxlength="5">
        </TD>
      </TR>
      <TR>
      	<td  class="blue">生效时间</td>
				<TD>
        	<input type="text" name="validdate" size="20" maxlength="8">
        </TD>
        <td  class="blue">失效时间</td>
				<TD>
        	<input type="text" name="expiredate" size="20" maxlength="8">
        </TD>
      </TR>
      <TR>
      	<td  class="blue">运营模式</td>
      	<TD>
            <select name="servflag">
                <option value="0" selected>非中国移动运营</option>
                <option value="1">中国移动运营</option>
            </select>
        </TD>
        <TD></TD>
        <TD></TD>
      </TR>
      <TR>
      	<td  class="blue">业务类型</td>
      	<TD>
            <select name="spattr">
                <option value="0" selected>全网业务</option>
                <option value="1">本地业务</option>
            </select>
        </TD>
      	<td  class="blue">状态标示</td>
      	<TD>
            <select name="spstatus">
                <option value="0" selected>生效</option>
                <option value="1">失效</option>
            </select>
        </TD>
      </TR>
      <TR>
      	<td  class="blue">服务代码</td>
      	<TD>
      		<input type="text" name="spsvcid" size="20" maxlength="21">
        </TD>
        <td  class="blue">企业英文名称</td>
      	<TD>
      		<input type="text" name="spenname" size="20" maxlength="128">
        </TD>
      </TR>
      <TR>
      	<td  class="blue">企业短名</td>
      	<TD>
      		<input type="text" name="spshortname" size="20" maxlength="32">
        </TD>
        <td  class="blue">企业描述</td>
      	<TD>
      		<input type="text" name="spdesc" size="20" maxlength="512">
        </TD>
      </TR>
      <TR>
      	<td  class="blue">联系电话</td>
      	<TD>
      		<input type="text" name="csrtel" size="20" maxlength="32">
        </TD>
        <td  class="blue">介绍网址</td>
      	<TD>
      		<input type="text" name="csrurl" size="20" maxlength="128">
        </TD>
      </TR>
      <TR>
      	<td  class="blue">联系人</td>
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
	        	<%if(opt_flag.equals("0")) {%>
	           <input type="button" name="addButton"    class="b_foot" value="添加" style="cursor:hand;" onclick="doCheck()">&nbsp;
	           <%}else{%>
	           <input type="button" name="addButton"    class="b_foot" value="修改" style="cursor:hand;" onclick="doCheck1()">&nbsp;
	           <%}%>
	           <input type="button" name="copyButton"   class="b_foot" value="返回" style="cursor:hand;" onclick="window.close()">&nbsp;
	        </td>
		     </tr>
			</TABLE>
			<%@ include file="/npage/include/footer.jsp" %>   
		</FORM>
  </BODY>
</HTML>