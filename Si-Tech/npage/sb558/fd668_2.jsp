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
      /*公共部分*/
      String dsmpType = request.getParameter("dsmpType");
      String spno = request.getParameter("spno");
      String validdate = request.getParameter("validdate");
      String expiredate = request.getParameter("expiredate");
      /*sp企业信息*/
      String spname = request.getParameter("spname");
      String spType = request.getParameter("spType");
      String provcode = request.getParameter("provcode");
      String balprov = request.getParameter("balprov");
      String devcode = request.getParameter("devcode");
      
	    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	    int iPageSize = Integer.parseInt(request.getParameter("pagecount"));
	    int iStartPos = (iPageNumber-1)*iPageSize;
	    int iEndPos = iPageNumber*iPageSize;
      
      String sql1="";
			String sql2="";
			
			String optype = "";
			String sptype="";
			String sptype1="";
			int spTypenum = 0;
			String servflag="";
			
	
			sql1 = "select rownum id,nvl(b.servname,a.servtype) as servname , a.spid,a.spname,a.sptype, a.provcode,  " +
						 "a.balprov, a.devcode, a.validdate, a.expiredate, a.serv_flag, nvl(a.SPATTR,'G'),nvl(a.SPSTATUS,'A'), " +
						 "a.spsvcid,a.spenname,a.spshortname,a.spdesc,a.csrtel,a.csrurl,a.contactperson, " +
						 "a.fixedline,a.op_time,a.op_flag " +
						 "from ddsmpspinfo a,sdsmpservtype b,sOBBizType c " +
						 "where a.servtype = b.servtype(+) " +
						 "and a.biztype = c.oprcode(+) ";
			sql2 = "select nvl(count(*),0) num from  ddsmpspinfo a where 1=1 ";
			if(!spname.equals(""))
			{
				sql1  = sql1+" and a.spname like '%"+spname+"%'";
				sql2  = sql2+" and a.spname like '%"+spname+"%'";
			}
			if(!spType.equals("0"))
			{
			  spTypenum = Integer.parseInt(spType) -1;
				sql1  = sql1+" and a.sptype like '%"+spTypenum+"%'";
				sql2  = sql2+" and a.sptype like '%"+spTypenum+"%'";
			}
			if(!provcode.equals(""))
			{
				sql1  = sql1+" and a.provcode like '%"+provcode+"%'";
				sql2  = sql2+" and a.provcode like '%"+provcode+"%'";
			}
			if(!balprov.equals(""))
			{
				sql1  = sql1+" and a.balprov like '%"+balprov+"%'";
				sql2  = sql2+" and a.balprov like '%"+balprov+"%'";
			}
			if(!devcode.equals(""))
			{
				sql1  = sql1+" and a.devcode like '%"+devcode+"%'";
				sql2  = sql2+" and a.devcode like '%"+devcode+"%'";
			}
			if(!dsmpType.equals("0"))
			{
				sql1  = sql1+" and a.servtype like '%"+dsmpType+"%'";
				sql2  = sql2+" and a.servtype like '%"+dsmpType+"%'";
			}
			if(!spno.equals(""))
			{
				sql1  = sql1+" and a.spid like '%"+spno+"%'";
				sql2  = sql2+" and a.spid like '%"+spno+"%'";
			}
			if(!validdate.equals(""))
			{
				sql1  = sql1+" and a.validdate like '%"+validdate+"%'";
				sql2  = sql2+" and a.validdate like '%"+validdate+"%'";
			}
			if(!expiredate.equals(""))
			{
				sql1  = sql1+" and a.expiredate like '%"+expiredate+"%'";
				sql2  = sql2+" and a.expiredate like '%"+expiredate+"%'";
			}
			sql1 = "select * from ("+sql1+") where id <="+iEndPos+" and id>"+iStartPos; 
			
			System.out.println("sql1 = "+sql1);
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_Code%>" retval="val1" outnum="30">
<wtc:sql><%=sql1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" property="val1" scope="end" />

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_Code%>" retval="val2" outnum="1">
<wtc:sql><%=sql2%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result2" property="val2" scope="end" />
<HTML>
	<HEAD>
		<TITLE>局数据管理</TITLE>
		<%
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
		%>
	</HEAD>
	<BODY>
		<SCRIPT language="JavaScript">
			function select_spmsg(i)
		  {
		   var num = <%=result2[0][0]%>;
		   if(num>1)
		   {
		   		sp_code = document.frmd668_2.checkId[i].value;
		   }else{	
		    	sp_code = document.frmd668_2.checkId.value;
		   }
		   document.frmd668_2.check_flag.value = sp_code;
		  }
		  function add_new()
		  {
		  	var arg = "fd668_2_1.jsp";
		  	create_dialog(arg);
		  }
		  function add_copy()
		  {
		  	var checkflag = document.frmd668_2.check_flag.value
		  	if( checkflag == "")
		  	{
		  		rdShowMessageDialog("请选择一个复制项！",0);
		  		return false;
		  	}
		  	create_dialog("fd668_2_2.jsp?opt_flag=0&check_flag="+checkflag);
		  }
		  function update()
		  {
		  	var checkflag1 = document.frmd668_2.check_flag.value
		  	if(checkflag1 == "")
		  	{
		  		rdShowMessageDialog("请选择一个修改项！",0);
		  		return false;
		  	}
		  	create_dialog("fd668_2_2.jsp?opt_flag=1&check_flag="+checkflag1);
		  }
		  function del()
		  {
		  	var checkflag1 = document.frmd668_2.check_flag.value
		  	if(checkflag1 == "")
		  	{
		  		rdShowMessageDialog("请选择一个删除项！",0);
		  		return false;
		  	}
		  	if(rdShowConfirmDialog('确认要删除吗？(这个操作无法回退)')==1)
	      {
		      var myPacket = new AJAXPacket("fd668_del.jsp","正在提交，请稍候...");
			  	myPacket.data.add("check_flag",checkflag1);
					myPacket.data.add("opt_flag","0");
					core.ajax.sendPacket(myPacket);
					myPacket=null;
	      }
		  }
		  function doProcess(packet)
			{
				var retCode = packet.data.findValueByName("retCode");
				var errMsg = packet.data.findValueByName("errMsg");
				if(retCode=="000000")
					rdShowMessageDialog("SP局数据删除成功!",2);
				else
					rdShowMessageDialog("SP局数据删除失败!"+retCode+" "+errMsg,2);
			}
		  function create_dialog(arg)
		  {
		  	var h = 500;
        var w = 720;
        var t = screen.availHeight - h - 20;
        var l = screen.availWidth / 2 - w / 2;
        var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no"
        var ret_msg = window.showModalDialog(arg, "", prop);
        window.location.reload();
        if (ret_msg == null) 
        {
					return false;
				}
				return true;
		  }
		  function fb599_2_rl()
			{
				location.reload(true);
			}
		</SCRIPT>
		<FORM method=post name="frmd668_2">
		<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">局数据导入记录查询</div>
			</div>
			<input type="hidden" name="check_flag" value="">
			<input type="hidden" name="opcode_flag" value="0">
			<table cellSpacing="0">
        <tr > 
        		<td>共计:</td>
        		<td><%=Integer.parseInt(result2[0][0].trim())%>条</td>
            <td colspan="14" align="right"> 
            	<%
            	  int recordNum = Integer.parseInt(result2[0][0].trim());
            	  int iQuantity =recordNum;
						    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
								PageView view = new PageView(request,out,pg); 
						   	view.setVisible(true,true,0,1); 
            	%>
            </td>
        </tr>
        <tr class="title">
        		<th><div >选择</div></th>
            <th><div >业务类型</div></th>     
            <th><div >企业代码</div></th>
            <th><div >企业名称</div></th>
            <th><div >业务标志</div></th>
            <th><div >接入省</div></th>
            <th><div >结算省</div></th>
            <th><div >平台代码</div></th>
            <th><div >生效时间</div></th>
            <th><div >失效时间</div></th>
            <th><div >运营模式</div></th>
            <th><div >业务类型</div></th>
            <th><div >状态标示</div></th>
            <th><div >服务代码</div></th>
            <th><div >企业英文名称</div></th>
            <th><div >企业短名</div></th>
            <th><div >企业描述</div></th>
            <th><div >联系电话</div></th>
            <th><div >介绍网址</div></th>
            <th><div >联系人</div></th>
            <th><div >fixedline</div></th>
        </tr>
        <%
         for(int i=0;i<result1.length;i++){    
        %>
        	<tr>
      		<td>
	        	<div>
	        		<input type="radio" name="checkId" id="checkId<%=i%>" value="<%=result1[i][2]%>" onclick="select_spmsg('<%=i%>')">
	        	</div>
	        </td>
        	<td  name=serv_type height="20"><%=result1[i][1]%></td>
		      <td  name=sp_code height="20"><%=result1[i][2]%></td>
        	<td  name=sp_name height="20"><%=result1[i][3]%></td>
        	 <% 
        		sptype =	result1[i][4];
        		if(sptype.equals("0"))
        		{
        			sptype = "普通SP";
        		}
        		else if(sptype.equals("1"))
    				{
    					sptype = "自有服务类SP";
    				}
        		%>
        	<td  name=sp_type height="20"><%=sptype%></td>
		      <td  name=prov_code height="20"><%=result1[i][5]%></td>
		      <td  name=bal_prov height="20"><%=result1[i][6]%></td>
		      <td  name=dev_code height="20"><%=result1[i][7]%></td>
		      <td  name=valid_date height="20"><%=result1[i][8]%></td>
		      <td  name=expire_date height="20"><%=result1[i][9]%></td>
		       <% 
        		servflag =	result1[i][10];
        		if(servflag.equals("0"))
        		{
        			servflag = "非中国移动运营";
        		}
        		else if(servflag.equals("1"))
    				{
    					servflag = "中国移动运营";
    				}
        		%> 
		      <td  name=serv_flag height="20"><%=servflag%></td>
		        <% 
        		servflag =	result1[i][11];
        		if(servflag.equals("G"))
        		{
        			servflag = "全网业务";
        		}
        		else if(servflag.equals("L"))
    				{
    					servflag = "本地业务";
    				}
        		%> 
		      <td  name=spattr height="20"><%=servflag%></td>
		      <% 
        		servflag =	result1[i][12];
        		if(servflag.equals("A"))
        		{
        			servflag = "生效";
        		}
        		else if(servflag.equals("N"))
    				{
    					servflag = "失效";
    				}
        		%> 
		      <td  name=spstatus height="20"><%=servflag%></td>
		      <td  name=spsvcid height="20"><%=result1[i][13]%></td>
		      <td  name=spenname height="20"><%=result1[i][14]%></td>
		      <td  name=spshortname height="20"><%=result1[i][15]%></td>
		      <td  name=spdesc height="20"><%=result1[i][16]%></td>
		      <td  name=csrtel height="20"><%=result1[i][17]%></td>
		      <td  name=csrurl height="20"><%=result1[i][18]%></td>
		      <td  name=contactperson height="20"><%=result1[i][19]%></td>
		      <td  name=fixedline height="20"><%=result1[i][20]%></td>
	        </tr>
				<%
				 }
				%>           
 			</table>
 			<TABLE cellSpacing="0">
				<tr> 
	        <td id="footer">
	        	 <input type="button" name="addButton"    class="b_foot" value="添加" style="cursor:hand;" onclick="add_new()">&nbsp;
	           <input type="button" name="copyButton"   class="b_foot" value="复制添加" style="cursor:hand;" onclick="add_copy()">&nbsp;
	           <input type="button" name="updateButton" class="b_foot" value="更新" style="cursor:hand;" onclick="update()">&nbsp;
	           <input type="button" name="delButton"    class="b_foot" value="删除" style="cursor:hand;" onclick="del()">&nbsp;
	           <input type="button" name="returnButton" class="b_foot" value="返回" style="cursor:hand;" onclick="location='fd668_1.jsp'">&nbsp;
	           <input type="button" name="closeButton"  class="b_foot" value="关闭" style="cursor:hand;" onClick="parent.removeTab('<%=opCode%>')">&nbsp;
	        </td>
		     </tr>
			</TABLE>
    </FORM>
  <BODY>
<HTML>
