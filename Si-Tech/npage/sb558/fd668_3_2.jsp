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
      String title = "业务局数据添加";
      String opt_flag = request.getParameter("opt_flag");
      String check_flag = request.getParameter("check_flag");
      String tmp[] = check_flag.split(",");
      String strtmp = "";
      String spid = tmp[0];
      String bizcode = tmp[1];
      String sql = "select serv_type,spid,bizcode,servname,billingtype,price," +
      						 "balprop,validdate,expiredate,count,thirdvalidate,reconfirm," +
      						 "BIZTYPE,BIZDESC,SERVTYPE,SERVIDALIAS,SUBMETHOD,"+
      						 "ACCESSMODEL,PROVADDR,PROVPORT,USAGEDESC,INTROURL,"+
      						 "OTHER_BAL_OBJ1,OTHER_BAL_OBJ2,INNETCOUNT,"+
      						 "SERVATTR,BIZSTATUS,SERV_PROPERTY,OP_TIME,OP_FLAG "+
      						 "from ddsmpspbizinfo WHERE SPID = '"+spid+"' and bizcode = '"+bizcode+"'";
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_Code%>" retval="val1" outnum="40">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" property="val1" scope="end" />
<HTML>
	<HEAD>
		<TITLE>局数据记录查询</TITLE>
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
				for(var i=0;i<document.frmd668_3_2.dsmpType.length;i++)
  			{
  				if(document.frmd668_3_2.dsmpType.options[i].value=="<%=result1[0][0]%>")
  						document.frmd668_3_2.dsmpType.options[i].selected=true;
  			}
  			document.frmd668_3_2.spid.value="<%=result1[0][1]%>"
  			document.frmd668_3_2.bizno.value="<%=result1[0][2]%>"
  			document.frmd668_3_2.bizname.value="<%=result1[0][3]%>"
  			<%
  			int feetype =Integer.parseInt(result1[0][4],10);
  			%>
				if("<%=feetype%>"==0)
					document.frmd668_3_2.billingtype.options[0].selected=true;
				else if("<%=feetype%>"==1)
					document.frmd668_3_2.billingtype.options[1].selected=true;
				else if("<%=feetype%>"==2)
					document.frmd668_3_2.billingtype.options[2].selected=true;
				else if("<%=feetype%>"==4)
					document.frmd668_3_2.billingtype.options[3].selected=true;
				else if("<%=feetype%>"==5)
					document.frmd668_3_2.billingtype.options[4].selected=true;
				else if("<%=feetype%>"==3)
					document.frmd668_3_2.billingtype.options[5].selected=true;
				else if("<%=feetype%>"==12)
					document.frmd668_3_2.billingtype.options[6].selected=true;
  			document.frmd668_3_2.infofee.value="<%=result1[0][5]%>"
  			document.frmd668_3_2.balprop.value="<%=result1[0][6]%>"
  			document.frmd668_3_2.validdate.value="<%=result1[0][7]%>"
  			document.frmd668_3_2.expiredate.value="<%=result1[0][8]%>"
  			document.frmd668_3_2.num.value="<%=result1[0][9]%>"
  			if(<%=result1[0][10]%>=="1")
  			{
  				document.frmd668_3_2.isthirdvalidate.options[1].selected=true;
  			}
  			else
  			{
  				document.frmd668_3_2.isthirdvalidate.options[0].selected=true;
  			}
  			if(<%=result1[0][11]%>=="1")
  			{
  				document.frmd668_3_2.reconfirm.options[1].selected=true;
  			}
  			else
  			{
  				document.frmd668_3_2.reconfirm.options[0].selected=true;
  			}
  			document.frmd668_3_2.biztype.value="<%=result1[0][12]%>"
				document.frmd668_3_2.bizdesc.value="<%=result1[0][13]%>"
				document.frmd668_3_2.servtype.value="<%=result1[0][14]%>"
				document.frmd668_3_2.servidalias.value="<%=result1[0][15]%>"
				document.frmd668_3_2.submethod.value="<%=result1[0][16]%>"
				document.frmd668_3_2.accessmodel.value="<%=result1[0][17]%>"
				document.frmd668_3_2.provaddr.value="<%=result1[0][18]%>"
				document.frmd668_3_2.provport.value="<%=result1[0][19]%>"
				document.frmd668_3_2.usagedesc.value="<%=result1[0][20]%>"
				document.frmd668_3_2.introurl.value="<%=result1[0][21]%>"
				document.frmd668_3_2.other_bal_obj1.value="<%=result1[0][22]%>"
				document.frmd668_3_2.other_bal_obj2.value="<%=result1[0][23]%>"
				document.frmd668_3_2.innetcount.value="<%=result1[0][24]%>"
  			
  			if("<%=result1[0][25]%>"=="L")
  			{
  				document.frmd668_3_2.servattr.options[1].selected=true;
  			}
  			else
  			{
  				document.frmd668_3_2.servattr.options[0].selected=true;
  			}
  			
  			if("<%=result1[0][26]%>"=="N")
  			{
  				document.frmd668_3_2.bizstatus.options[1].selected=true;
  			}
  			else
  			{
  				document.frmd668_3_2.bizstatus.options[0].selected=true;
  			}
  			if("<%=result1[0][27]%>"=="1")
					document.frmd668_3_2.serv_property.options[1].selected=true;
				else if("<%=result1[0][27]%>"=="2")
					document.frmd668_3_2.serv_property.options[2].selected=true;
				else if("<%=result1[0][27]%>"=="3")
					document.frmd668_3_2.serv_property.options[3].selected=true;
				else if("<%=result1[0][27]%>"=="4")
					document.frmd668_3_2.serv_property.options[4].selected=true;
				else if("<%=result1[0][27]%>"=="5")
					document.frmd668_3_2.serv_property.options[5].selected=true;
				else if("<%=result1[0][27]%>"=="6")
					document.frmd668_3_2.serv_property.options[6].selected=true;
				else if("<%=result1[0][27]%>"=="7")
					document.frmd668_3_2.serv_property.options[7].selected=true;
				else if("<%=result1[0][27]%>"=="8")
					document.frmd668_3_2.serv_property.options[8].selected=true;
				else if("<%=result1[0][27]%>"=="9")
					document.frmd668_3_2.serv_property.options[9].selected=true;
				else
					document.frmd668_3_2.serv_property.options[0].selected=true;
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
				var errMsg = packet.data.findValueByName("errMsg");
				var opt_flag = "<%=opt_flag%>";
				if(opt_flag=="0")
				{
					if(retCode=="000000")
						rdShowMessageDialog("SP局数据添加成功!",2);
					else
						rdShowMessageDialog("SP局数据添加失败!"+retCode+" "+errMsg);
				}
				else
				{
					if(retCode=="000000")
						rdShowMessageDialog("SP局数据修改成功!",2);
					else
						rdShowMessageDialog("SP局数据修改失败!"+retCode+" "+errMsg);
				}
				
			}
			function doCheck()
			{
				var dsmpType =  document.frmd668_3_2.dsmpType.value;
				var spid = document.frmd668_3_2.spid.value;
				var bizno = document.frmd668_3_2.bizno.value;
				var bizname = document.frmd668_3_2.bizname.value;
				var billingtype = document.frmd668_3_2.billingtype.value;
				var infofee = document.frmd668_3_2.infofee.value;
				var balprop = document.frmd668_3_2.balprop.value;
				var validdate = document.frmd668_3_2.validdate.value;
				var expiredate = document.frmd668_3_2.expiredate.value;	
				var reconfirm = document.frmd668_3_2.reconfirm.value;
				var num = document.frmd668_3_2.num.value;	
				var isthirdvalidate = document.frmd668_3_2.isthirdvalidate.value;
				var optflag = "1";
				var biztype = document.frmd668_3_2.biztype.value;
				var bizdesc = document.frmd668_3_2.bizdesc.value;
				var servtype = document.frmd668_3_2.servtype.value;
				var servidalias = document.frmd668_3_2.servidalias.value;
				var submethod = document.frmd668_3_2.submethod.value;
				var accessmodel = document.frmd668_3_2.accessmodel.value;
				var provaddr = document.frmd668_3_2.provaddr.value;
				var provport = document.frmd668_3_2.provport.value;
				var usagedesc = document.frmd668_3_2.usagedesc.value;
				var introurl = document.frmd668_3_2.introurl.value;
				var other_bal_obj1 = document.frmd668_3_2.other_bal_obj1.value;
				var other_bal_obj2 = document.frmd668_3_2.other_bal_obj2.value;
				var innetcount = document.frmd668_3_2.innetcount.value;
				var servattr = document.frmd668_3_2.servattr.value;
				var bizstatus = document.frmd668_3_2.bizstatus.value;
				var serv_property = document.frmd668_3_2.serv_property.value;
				if (document.frmd668_3_2.spid.value=="")
		    {
		      rdShowMessageDialog("请输入企业代码！");
		      document.frmd668_3_2.spid.value="";
		      document.frmd668_3_2.spid.select();
		      return false;
		    }
		    if (document.frmd668_3_2.bizno.value=="")
		    {
		      rdShowMessageDialog("请输入业务代码！");
		      document.frmd668_3_2.bizno.value="";
		      document.frmd668_3_2.bizno.select();
		      return false;
		    }
		    if (document.frmd668_3_2.bizname.value=="")
		    {
		      rdShowMessageDialog("请输入业务名称！");
		      document.frmd668_3_2.bizname.value="";
		      document.frmd668_3_2.bizname.select();
		      return false;
		    }
		    if (document.frmd668_3_2.infofee.value=="")
		    {
		      rdShowMessageDialog("请输入信息费金额！");
		      document.frmd668_3_2.infofee.value="";
		      document.frmd668_3_2.infofee.select();
		      return false;
		    }
		    if (document.frmd668_3_2.balprop.value=="")
		    {
		      rdShowMessageDialog("请输入结算比例！");
		      document.frmd668_3_2.balprop.value="";
		      document.frmd668_3_2.balprop.select();
		      return false;
		    }  
		    if (document.frmd668_3_2.validdate.value=="")
		    {
		      rdShowMessageDialog("请输入生效时间！");
		      document.frmd668_3_2.validdate.value="";
		      document.frmd668_3_2.validdate.select();
		      return false;
		    }
		    if(document.frmd668_3_2.validdate.value.length != 8)
			  {
			    rdShowMessageDialog("生效时间长度不正确！");
			    document.frmd668_3_2.validdate.value="";
			    document.frmd668_3_2.validdate.select();
			    return false;
			  }
			  if(!CheckIsDate(validdate))
			  {
			    rdShowMessageDialog("生效时间不合法！");
			    document.frmd668_3_2.validdate.value="";
			    document.frmd668_3_2.validdate.select();
			    return false;
			  }
		    if (document.frmd668_3_2.expiredate.value=="")
		    {
		      rdShowMessageDialog("请输入失效时间！");
		      document.frmd668_3_2.expiredate.value="";
		      document.frmd668_3_2.expiredate.select();
		      return false;
		    }
			  if(document.frmd668_3_2.expiredate.value.length != 8)
			  {
			    rdShowMessageDialog("失效时间长度不正确！");
			    document.frmd668_3_2.expiredate.value="";
			    document.frmd668_3_2.expiredate.select();
			    return false;
			  }
			  if(!CheckIsDate(expiredate))
			  {
			    rdShowMessageDialog("失效时间不合法！");
			    document.frmd668_3_2.expiredate.value="";
			    document.frmd668_3_2.expiredate.select();
			    return false;
			  }
			  if(expiredate.localeCompare(validdate)<0)
				{
					rdShowMessageDialog("生效时间不能大于失效时间!");
					return;
				}
				if (document.frmd668_3_2.num.value=="")
		    {
		      document.frmd668_3_2.num.value="0";
		    }
		    if(rdShowConfirmDialog('确认要添加吗？')==1)
				{
					var myPacket = new AJAXPacket("fd668_add.jsp","正在提交，请稍候...");
					myPacket.data.add("dsmpType",dsmpType);
					myPacket.data.add("spid",spid);
					myPacket.data.add("bizno",bizno);
					myPacket.data.add("bizname",bizname);
					myPacket.data.add("billingtype",billingtype);
					myPacket.data.add("infofee",infofee);
					myPacket.data.add("balprop",balprop);
					myPacket.data.add("validdate",validdate);
					myPacket.data.add("expiredate",expiredate);
					myPacket.data.add("reconfirm",reconfirm);
					myPacket.data.add("num",num);
					myPacket.data.add("isthirdvalidate",isthirdvalidate);
					myPacket.data.add("optflag",optflag);
					myPacket.data.add("biztype",biztype);
					myPacket.data.add("bizdesc",bizdesc);
					myPacket.data.add("servtype",servtype);
					myPacket.data.add("servidalias",servidalias);
					myPacket.data.add("submethod",submethod);
					myPacket.data.add("accessmodel",accessmodel);
					myPacket.data.add("provaddr",provaddr);
					myPacket.data.add("provport",provport);
					myPacket.data.add("usagedesc",usagedesc);
					myPacket.data.add("introurl",introurl);
					myPacket.data.add("other_bal_obj1",other_bal_obj1);
					myPacket.data.add("other_bal_obj2",other_bal_obj2);
					myPacket.data.add("innetcount",innetcount);
					myPacket.data.add("servattr",servattr);
					myPacket.data.add("bizstatus",bizstatus);
					myPacket.data.add("serv_property",serv_property);
					core.ajax.sendPacket(myPacket);
					myPacket=null;
				}
			}
			function doCheck1()
			{
				var dsmpType =  document.frmd668_3_2.dsmpType.value;
				var spid = document.frmd668_3_2.spid.value;
				var bizno = document.frmd668_3_2.bizno.value;
				var bizname = document.frmd668_3_2.bizname.value;
				var billingtype = document.frmd668_3_2.billingtype.value;
				var infofee = document.frmd668_3_2.infofee.value;
				var balprop = document.frmd668_3_2.balprop.value;
				var validdate = document.frmd668_3_2.validdate.value;
				var expiredate = document.frmd668_3_2.expiredate.value;	
				var reconfirm = document.frmd668_3_2.reconfirm.value;
				var num = document.frmd668_3_2.num.value;	
				var isthirdvalidate = document.frmd668_3_2.isthirdvalidate.value;
				var optflag = "1";
				var biztype = document.frmd668_3_2.biztype.value;
				var bizdesc = document.frmd668_3_2.bizdesc.value;
				var servtype = document.frmd668_3_2.servtype.value;
				var servidalias = document.frmd668_3_2.servidalias.value;
				var submethod = document.frmd668_3_2.submethod.value;
				var accessmodel = document.frmd668_3_2.accessmodel.value;
				var provaddr = document.frmd668_3_2.provaddr.value;
				var provport = document.frmd668_3_2.provport.value;
				var usagedesc = document.frmd668_3_2.usagedesc.value;
				var introurl = document.frmd668_3_2.introurl.value;
				var other_bal_obj1 = document.frmd668_3_2.other_bal_obj1.value;
				var other_bal_obj2 = document.frmd668_3_2.other_bal_obj2.value;
				var innetcount = document.frmd668_3_2.innetcount.value;
				var servattr = document.frmd668_3_2.servattr.value;
				var bizstatus = document.frmd668_3_2.bizstatus.value;
				var serv_property = document.frmd668_3_2.serv_property.value;
		    if (document.frmd668_3_2.bizname.value=="")
		    {
		      rdShowMessageDialog("请输入业务名称！");
		      document.frmd668_3_2.bizname.value="";
		      document.frmd668_3_2.bizname.select();
		      return false;
		    }
		    if (document.frmd668_3_2.infofee.value=="")
		    {
		      rdShowMessageDialog("请输入信息费金额！");
		      document.frmd668_3_2.infofee.value="";
		      document.frmd668_3_2.infofee.select();
		      return false;
		    }
		    if (document.frmd668_3_2.balprop.value=="")
		    {
		      rdShowMessageDialog("请输入结算比例！");
		      document.frmd668_3_2.balprop.value="";
		      document.frmd668_3_2.balprop.select();
		      return false;
		    }  
		    if (document.frmd668_3_2.validdate.value=="")
		    {
		      rdShowMessageDialog("请输入生效时间！");
		      document.frmd668_3_2.validdate.value="";
		      document.frmd668_3_2.validdate.select();
		      return false;
		    }
		    if(document.frmd668_3_2.validdate.value.length != 8)
			  {
			    rdShowMessageDialog("生效时间长度不正确！");
			    document.frmd668_3_2.validdate.value="";
			    document.frmd668_3_2.validdate.select();
			    return false;
			  }
			  if(!CheckIsDate(validdate))
			  {
			    rdShowMessageDialog("生效时间不合法！");
			    document.frmd668_3_2.validdate.value="";
			    document.frmd668_3_2.validdate.select();
			    return false;
			  }
		    if (document.frmd668_3_2.expiredate.value=="")
		    {
		      rdShowMessageDialog("请输入失效时间！");
		      document.frmd668_3_2.expiredate.value="";
		      document.frmd668_3_2.expiredate.select();
		      return false;
		    }
			  if(document.frmd668_3_2.expiredate.value.length != 8)
			  {
			    rdShowMessageDialog("失效时间长度不正确！");
			    document.frmd668_3_2.expiredate.value="";
			    document.frmd668_3_2.expiredate.select();
			    return false;
			  }
			  if(!CheckIsDate(expiredate))
			  {
			    rdShowMessageDialog("失效时间不合法！");
			    document.frmd668_3_2.expiredate.value="";
			    document.frmd668_3_2.expiredate.select();
			    return false;
			  }
			  if(expiredate.localeCompare(validdate)<0)
				{
					rdShowMessageDialog("生效时间不能大于失效时间!");
					return;
				}
				if (document.frmd668_3_2.num.value=="")
		    {
		      document.frmd668_3_2.num.value="0";
		    }
		    if(rdShowConfirmDialog('确认要修改吗？')==1)
				{
					var myPacket = new AJAXPacket("fd668_update.jsp","正在提交，请稍候...");
					myPacket.data.add("dsmpType",dsmpType);
					myPacket.data.add("spid",spid);
					myPacket.data.add("bizno",bizno);
					myPacket.data.add("bizname",bizname);
					myPacket.data.add("billingtype",billingtype);
					myPacket.data.add("infofee",infofee);
					myPacket.data.add("balprop",balprop);
					myPacket.data.add("validdate",validdate);
					myPacket.data.add("expiredate",expiredate);
					myPacket.data.add("reconfirm",reconfirm);
					myPacket.data.add("num",num);
					myPacket.data.add("isthirdvalidate",isthirdvalidate);
					myPacket.data.add("optflag",optflag);
					myPacket.data.add("biztype",biztype);
					myPacket.data.add("bizdesc",bizdesc);
					myPacket.data.add("servtype",servtype);
					myPacket.data.add("servidalias",servidalias);
					myPacket.data.add("submethod",submethod);
					myPacket.data.add("accessmodel",accessmodel);
					myPacket.data.add("provaddr",provaddr);
					myPacket.data.add("provport",provport);
					myPacket.data.add("usagedesc",usagedesc);
					myPacket.data.add("introurl",introurl);
					myPacket.data.add("other_bal_obj1",other_bal_obj1);
					myPacket.data.add("other_bal_obj2",other_bal_obj2);
					myPacket.data.add("innetcount",innetcount);
					myPacket.data.add("servattr",servattr);
					myPacket.data.add("bizstatus",bizstatus);
					myPacket.data.add("serv_property",serv_property);
					core.ajax.sendPacket(myPacket);
					myPacket=null;
				}
			}
		</SCRIPT>
		<FORM method=post name="frmd668_3_2">
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
				<%if(opt_flag.equals("0")) {%>
				<TD><input type="text" name="spid" size="20" maxlength="20"></TD>
				<%}else{%>
				<TD><input type="text" name="spid" size="20" maxlength="20" disabled="1"></TD>
				<%}%>
				<td  class="blue">业务代码</td>
				<%if(opt_flag.equals("0")) {%>
				<TD><input type="text" name="bizno" size="20" maxlength="64"></TD>
				<%}else{%>
				<TD><input type="text" name="bizno" size="20" maxlength="64" disabled="1"></TD>
				<%}%>
      </TR>
      	<TR>
				<td  class="blue">业务产品名称</td>
				<TD><input type="text" name="bizname" size="20" maxlength="20"></TD>
				<TD class="blue" >计费类型</TD>
          <TD>
              <select name="billingtype">
                  <option value="1" selected>免费</option>
                  <option value="2">按条/按次</option>
                  <option value="3">包月</option>
                  <option value="4">包次</option>
                  <option value="5">包天</option>
                  <option value="6">按栏目</option>
                  <option value="7">时长</option>
              </select>
          </TD>
      </TR>
      <TR>
				<td  class="blue">信息费(元)</td>
				<TD><input type="text" name="infofee" size="20" maxlength="20"></TD>
				<td  class="blue">结入方比例</td>
				<TD><input type="text" name="balprop" size="20" maxlength="64"></TD>
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
				<TD class="blue" >二次确认标示</TD>
          <TD>
              <select name="reconfirm">
                  <option value="0" selected>不需要</option>
                  <option value="1">需要</option>
              </select>
          </TD>
        <td  class="blue">包次次数</td>
				<TD>
        	<input type="text" name="num" size="20" maxlength="8">
        </TD>
			</TR>
			<TR>
				<TD class="blue">第三方确认</TD>
        <TD>
            <select name="isthirdvalidate">
                <option value="0" selected>不需要</option>
                <option value="1">需要</option>
            </select>
        </TD>
       </TR>
    	 <TR>
				<TD class="blue" >业务信息</TD>
        <TD>
					<input type="text" name="biztype" size="20" maxlength="64">
        </TD>
        <td  class="blue">业务描述</td>
				<TD>
        	<input type="text" name="bizdesc" size="20" maxlength="512">
        </TD>
			</TR>
			<TR>
				<TD class="blue" >SERVTYPE</TD>
        <TD>
					<input type="text" name="servtype" size="20" maxlength="5">
        </TD>
        <td  class="blue">SERVIDALIAS</td>
				<TD>
        	<input type="text" name="servidalias" size="20" maxlength="12">
        </TD>
			</TR>
			<TR>
				<TD class="blue" >SUBMETHOD</TD>
        <TD>
					<input type="text" name="submethod" size="20" maxlength="5">
        </TD>
        <td  class="blue">ACCESSMODEL</td>
				<TD>
        	<input type="text" name="accessmodel" size="20" maxlength="32">
        </TD>
			</TR>
			<TR>
				<TD class="blue" >地址</TD>
        <TD>
					<input type="text" name="provaddr" size="20" maxlength="128">
        </TD>
        <td  class="blue">端口</td>
				<TD>
        	<input type="text" name="provport" size="20" maxlength="6">
        </TD>
			</TR>
			<TR>
				<TD class="blue" >描述信息</TD>
        <TD>
					<input type="text" name="usagedesc" size="20" maxlength="512">
        </TD>
        <td  class="blue">INTROURL</td>
				<TD>
        	<input type="text" name="introurl" size="20" maxlength="128">
        </TD>
			</TR>
			<TR>
				<TD class="blue" >备用字段1</TD>
        <TD>
					<input type="text" name="other_bal_obj1" size="20" maxlength="5">
        </TD>
        <td  class="blue">备用字段2</td>
				<TD>
        	<input type="text" name="other_bal_obj2" size="20" maxlength="5">
        </TD>
			</TR>
			<TR>
				<TD class="blue" >INNETCOUNT</TD>
        <TD>
					<input type="text" name="innetcount" size="20" maxlength="7">
        </TD>
        <td  class="blue">业务类型</td>
				<TD>
        	<select name="servattr">
                <option value="0" selected>全网业务</option>
                <option value="1">本地业务</option>
          </select>
        </TD>
			</TR>
			<TR>
				<TD class="blue" >生效标志</TD>
        <TD>
            <select name="bizstatus">
                <option value="0" selected>生效</option>
                <option value="1">失效</option>
            </select>
        </TD>
        <td  class="blue">业务特性</td>
        <TD>
            <select name="serv_property">
                <option value="0" selected>NULL</option>
                <option value="1">手机点播类</option>
                <option value="2">手机定制类</option>
                <option value="3">网站定制类</option>
                <option value="4">网站点播类</option>
                <option value="5">STK点播类</option>
                <option value="6">STK定制类</option>
                <option value="7">帮助信息类</option>
                <option value="8">同时提供手机点播和网站点播</option>
                <option value="9">同时提供手机定制和网站定制</option>
            </select>
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