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
       /*sp业务信息*/
      String bizno = request.getParameter("bizno");
      String bizname = request.getParameter("bizname");
      String bizType = request.getParameter("bizType");
      String infofee = request.getParameter("infofee");
      String balprop = request.getParameter("balprop");
      String reconfirm = request.getParameter("reconfirm"); 
      
	    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	    int iPageSize = Integer.parseInt(request.getParameter("pagecount"));
	    int iStartPos = (iPageNumber-1)*iPageSize;
	    int iEndPos = iPageNumber*iPageSize;
      
      String sql1="";
			String sql2="";
			
			String optype = "";
			String sptype="";
			String sptmp="";
			sql1= "select rownum id,nvl(b.servname,a.serv_type) as serv_type1,a.spid,"+
						"a.bizcode,a.servname as servname1,NVL(a.billingtype,'-1'),a.price,"+
						"a.validdate,a.expiredate,a.balprop,a.count,a.thirdvalidate,a.reconfirm,"+
						"a.serv_type,a.BIZTYPE,a.BIZDESC,a.SERVTYPE,a.SERVIDALIAS,a.SUBMETHOD,"+
						"a.ACCESSMODEL,a.PROVADDR,a.PROVPORT,a.USAGEDESC,a.INTROURL,"+
						"a.OTHER_BAL_OBJ1,a.OTHER_BAL_OBJ2,a.INNETCOUNT,a.SERVATTR,"+
						"a.BIZSTATUS,a.SERV_PROPERTY,a.OP_TIME,a.OP_FLAG " +
						"from ddsmpspbizinfo a ,sdsmpservtype b where a.serv_type = b.servtype(+) ";
			sql2= "select nvl(count(*),0) num from ddsmpspbizinfo a WHERE 1 = 1 ";
			if(!bizno.equals(""))
			{
				sql1  = sql1+" and a.bizcode like '%"+bizno+"%'";
				sql2  = sql2+" and a.bizcode like '%"+bizno+"%'";
			}
			if(!bizname.equals(""))
			{
				sql1  = sql1+" and a.servname like '%"+bizname+"%'";
				sql2  = sql2+" and a.servname like '%"+bizname+"%'";
			}
			if(!bizType.equals("0"))
			{
				if(bizType.equals("1"))
				{/*免费*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 1) or ((serv_type <= '001103' or serv_type='008007')  and billingtype = 0)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 1) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 0)) ";
				}
				else if(bizType.equals("2"))
				{/*按条/按次*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 2) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 1)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 2) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 1)) ";
				}
				else if(bizType.equals("3"))
				{/*包次*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 3) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 4)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 3) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 4)) ";
				}
				else if(bizType.equals("4"))
				{/*包月*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 5) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 2)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 5) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 2)) ";
				}
				else if(bizType.equals("5"))
				{/*包天*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 7) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 7)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 7) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 7)) ";
				}
				else if(bizType.equals("6"))
				{/*按栏目*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 9) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 5)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 9) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 5)) ";
				}
				else if(bizType.equals("7"))
				{/*时长*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 11) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 3)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and billingtype = 11) or ((serv_type <= '001103' or serv_type='008007') and billingtype = 3)) ";
				}
			}
			if(!infofee.equals(""))
			{
				sql1  = sql1+" and a.price like '%"+infofee+"%'";
				sql2  = sql2+" and a.price like '%"+infofee+"%'";
			}
			if(!balprop.equals(""))
			{
				sql1  = sql1+" and a.balprop like '%"+balprop+"%'";
				sql2  = sql2+" and a.balprop like '%"+balprop+"%'";
			}
			if(!reconfirm.equals("0"))
			{
				sql1  = sql1+" and a.reconfirm like '%"+reconfirm+"%'";
				sql2  = sql2+" and a.reconfirm like '%"+reconfirm+"%'";
			}
			if(!dsmpType.equals("0"))
			{
				sql1  = sql1+" and a.serv_type like '%"+dsmpType+"%'";
				sql2  = sql2+" and a.serv_type like '%"+dsmpType+"%'";
			}
			if(!spno.equals(""))
			{
				sql1  = sql1+" and a.spid like '%"+spno+"%'";
				sql2  = sql2+" and a.spid like '%"+spno+"%'";
			}
			if(!validdate.equals(""))
			{
				sql1  = sql1+" and  a.validdate like '%"+validdate+"%'";
				sql2  = sql2+" and  a.validdate like '%"+validdate+"%'";
			}
			if(!expiredate.equals(""))
			{
				sql1  = sql1+" and a.expiredate like '%"+expiredate+"%'";
				sql2  = sql2+" and a.expiredate like '%"+expiredate+"%'";
			}
			sql1 = "select * from ("+sql1+") where id <="+iEndPos+" and id>"+iStartPos; 
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sql1 = "+sql1);
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_Code%>" retval="val1" outnum="40">
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
			function fb599_2_rl()
			{
				location.reload(true);
			}
			function select_spmsg(i)
		  {
		   var num = <%=result2[0][0]%>;
		   if(num>1)
		   {
		   		sp_code = document.frmd668_3.checkId[i].value;
		   }else{	
		    	sp_code = document.frmd668_3.checkId.value;
		   }
		   document.frmd668_3.check_flag.value = sp_code;
		  }
		  function add_new()
		  {
		  	var arg = "fd668_3_1.jsp";
		  	create_dialog(arg);
		  }
		  function add_copy()
		  {
		  	var checkflag = document.frmd668_3.check_flag.value
		  	if( checkflag == "")
		  	{
		  		rdShowMessageDialog("请选择一个复制项！",0);
		  		return false;
		  	}
		  	create_dialog("fd668_3_2.jsp?opt_flag=0&check_flag="+checkflag);
		  }
		  function update()
		  {
		  	var checkflag1 = document.frmd668_3.check_flag.value
		  	if(checkflag1 == "")
		  	{
		  		rdShowMessageDialog("请选择一个修改项！",0);
		  		return false;
		  	}
		  	create_dialog("fd668_3_2.jsp?opt_flag=1&check_flag="+checkflag1);
		  }
		  function del()
		  {
		  	var checkflag1 =  document.frmd668_3.check_flag.value;
		  	if(checkflag1 == "")
		  	{
		  		rdShowMessageDialog("请选择一个删除项！",0);
		  		return false;
		  	}
		  	if(rdShowConfirmDialog('确认要删除吗？(这个操作无法回退)')==1)
	      {
			  	var myPacket = new AJAXPacket("fd668_del.jsp","正在提交，请稍候...");
			  	myPacket.data.add("check_flag",checkflag1);
					myPacket.data.add("opt_flag","1");
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
		  	var h = 550;
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
		</SCRIPT>
		<FORM method=post name="frmd668_3">
		<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">局数据导入记录查询</div>
			</div>
			<input type="hidden" name="check_flag" value="">
			<table cellSpacing="0">
        <tr >
        	  <td>共计:</td>
        		<td><%=Integer.parseInt(result2[0][0].trim())%>条</td>
            <td colspan="16" align="right"> 
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
        	  <th><div align="center">选择</div></th>
            <th><div align="center">业务类型</div></th>
            <th><div align="center">企业代码</div></th>
            <th><div align="center">业务代码</div></th>
            <th><div align="center">业务名称</div></th>
            <th><div align="center">计费类型</div></th>
            <th><div align="center">信息费(元)</div></th>
            <th><div align="center">生效时间</div></th>
            <th><div align="center">失效时间</div></th>
            <th><div align="center">结算比例</div></th>
            <th><div align="center">次数</div></th>
            <th><div align="center">第三方确认</div></th>
            <th><div align="center">二次确认</div></th>
            <th><div align="center">业务信息</div></th>
            <th><div align="center">业务描述</div></th>
            <th><div align="center">SERVTYPE</div></th>
            <th><div align="center">SERVIDALIAS</div></th>
            <th><div align="center">SUBMETHOD</div></th>
            <th><div align="center">ACCESSMODEL</div></th>
            <th><div align="center">地址</div></th>
            <th><div align="center">端口</div></th>
            <th><div align="center">描述信息</div></th>
            <th><div align="center">INTROURL</div></th>
            <th><div align="center">备用字段1</div></th>
            <th><div align="center">备用字段2</div></th>
            <th><div align="center">INNETCOUNT</div></th>
            <th><div align="center">业务类型</div></th>
            <th><div align="center">生效标志</div></th>
            <th><div align="center">业务特性</div></th>
            <th><div align="center">操作时间</div></th>
            <th><div align="center">操作标示</div></th>
        </tr>
        <%
         
         for(int i=0;i<result1.length;i++){    
	         String tdClass = "";                       
        %>
	        <tr id="tr0">
        	<td>
	        	<div align="center">
	        		<%
	        		sptmp = result1[i][2]+","+result1[i][3];
	        		%>
	        		<input type="radio" name="checkId" id="checkId<%=i%>" value="<%=sptmp%>" onclick="select_spmsg('<%=i%>')">
	        	</div>
	        </td>
        	<td align="center" name=spcode height="20"><%=result1[i][1]%></td>
		      <td align="center" name=spname height="20"><%=result1[i][2]%></td>   	
        	<td align="center" name=sptype height="20"><%=result1[i][3]%></td>
        	<td align="center" name=spcode height="20"><%=result1[i][4]%></td>
        	<%
        	optype = result1[i][5];
        	if(!optype.equals(""))
        	{
	        		if(Integer.parseInt(result1[i][5])==0)
	        		{
	        			optype = "免费";
	        		}
	        		else if(Integer.parseInt(result1[i][5])==1)
	        		{
	        			optype = "按条/按次";
	        		}
	        		else if(Integer.parseInt(result1[i][5])==2)
	        		{
	        			optype = "包月";
	        		}
	        		else if(Integer.parseInt(result1[i][5])==4)
	        		{
	        			optype = "包次";
	        		}
	        		else if(Integer.parseInt(result1[i][5])==7)
	        		{
	        			optype = "包天";
	        		}
	        		else if(Integer.parseInt(result1[i][5])==5)
	        		{
	        			optype = "按栏";
	        		}
	        		else if(Integer.parseInt(result1[i][5])==3)
	        		{
	        			optype = "包时";
	        		}
	        		else if(Integer.parseInt(result1[i][5])==12)
	        		{
	        			optype = "包周";
	        		}
        	}
        	%>
		      <td align="center" name=spname height="20"><%=optype%></td>
		      <td align="center" name=spname height="20"><%=result1[i][6]%></td>
		      <td align="center" name=spname height="20"><%=result1[i][7]%></td>
		      <td align="center" name=spname height="20"><%=result1[i][8]%></td>
		      <td align="center" name=spname height="20"><%=result1[i][9]%></td>
		      <td align="center" name=spcode height="20"><%=result1[i][10]%></td>
		      <% 
	        		optype =result1[i][11];
	        		if(optype.equals("0"))
	        		{
	        			optype = "不需要";
	        		}
	        		else if(optype.equals("1"))
	    				{
	    					optype = "需要";
	    				}
	        %> 
		      <td align="center" name=spname height="20"><%=optype%></td>
		      <% 
	        		optype =result1[i][12];
	        		if(optype.equals("0"))
	        		{
	        			optype = "不需要";
	        		}
	        		else if(optype.equals("1"))
	    				{
	    					optype = "需要";
	    				}
	        %> 
	         <td align="center" name=spname height="20"><%=optype%></td>
		      <td align="center" name=biztype height="20"><%=result1[i][14]%></td>	
          <td align="center" name=bizdesc height="20"><%=result1[i][15]%></td>	
          <td align="center" name=servtype height="20"><%=result1[i][16]%></td>	
          <td align="center" name=servidalias height="20"><%=result1[i][17]%></td>	
          <td align="center" name=submethod height="20"><%=result1[i][18]%></td>	
          <td align="center" name=accessmodel height="20"><%=result1[i][19]%></td>	
          <td align="center" name=provaddr height="20"><%=result1[i][20]%></td>	
          <td align="center" name=provport height="20"><%=result1[i][21]%></td>	
          <td align="center" name=usagedesc height="20"><%=result1[i][22]%></td>	
          <td align="center" name=introurl height="20"><%=result1[i][23]%></td>	
          <td align="center" name=other_bal_obj1 height="20"><%=result1[i][24]%></td>	
          <td align="center" name=other_bal_obj2 height="20"><%=result1[i][25]%></td>	
          <td align="center" name=innetcount height="20"><%=result1[i][26]%></td>
            <% 
	        		optype =result1[i][27];
		        	if(optype.equals("G"))
	        		{
	        			optype = "全网业务";
	        		}
	        		else if(optype.equals("L"))
	    				{
	    					optype = "本地业务";
	    				}
	        %> 
          <td align="center" name=servattr height="20"><%=optype%></td>
          <% 
        		optype =	result1[i][28];
        		if(optype.equals("A"))
        		{
        			optype = "生效";
        		}
        		else if(optype.equals("N"))
    				{
    					optype = "失效";
    				}
        		%> 
          <td align="center" name=bizstatus height="20"><%=optype%></td>
          <% 
        		optype =	result1[i][29];
        		if(optype.equals("1"))
        		{
        			optype = "手机点播类";
        		}
        		else if(optype.equals("2"))
    				{
    					optype = "手机定制类";
    				}
    				else if(optype.equals("3"))
    				{
    					optype = "网站定制类";
    				}
    				else if(optype.equals("4"))
    				{
    					optype = "网站点播类";
    				}
    				else if(optype.equals("5"))
    				{
    					optype = "STK点播类";
    				}
    				else if(optype.equals("6"))
    				{
    					optype = "STK定制类";
    				}
    				else if(optype.equals("7"))
    				{
    					optype = "帮助信息类";
    				}
    				else if(optype.equals("8"))
    				{
    					optype = "同时提供手机点播和网站点播";
    				}
    				else if(optype.equals("9"))
    				{
    					optype = "同时提供手机定制和网站定制";
    				}
        		%> 
          <td align="center" name=serv_property height="20"><%=optype%></td>	
          <td align="center" name=op_time height="20"><%=result1[i][30]%></td>	
          <td align="center" name=op_flag  height="20"><%=result1[i][31]%></td>	
	        </tr>
				<%
				 }
				%>           
 			</table>
 			<TABLE cellSpacing="0">
				<tr> 
	        <td id="footer">
	        	<input type="button" name="resetButton"  class="b_foot" value="添加" style="cursor:hand;" onclick="add_new()">&nbsp;
	           <input type="button" name="queryButton"  class="b_foot" value="复制添加" style="cursor:hand;" onclick="add_copy()">&nbsp;
	           <input type="button" name="resetButton"  class="b_foot" value="更新" style="cursor:hand;" onclick="update()">&nbsp;
	           <input type="button" name="queryButton"  class="b_foot" value="删除" style="cursor:hand;" onclick="del()">&nbsp;
	           <input type="button" name="queryButton"  class="b_foot" value="返回" style="cursor:hand;" onclick="location='fd668_1.jsp'">&nbsp;
	           <input type="button" name="closeButton"  class="b_foot" value="关闭" style="cursor:hand;" onClick="parent.removeTab('<%=opCode%>')">&nbsp;
	        </td>
		     </tr>
			</TABLE>
    </FORM>
  <BODY>
<HTML>
