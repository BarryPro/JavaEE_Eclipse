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
    	String opCode = "b559";
    	String opName = "局数据记录查询";
    	String workNo = (String)session.getAttribute("workNo");
      String workName = (String)session.getAttribute("workName");
      String regionCode=(String)session.getAttribute("regCode");
      String orgCode = (String)session.getAttribute("orgCode");
      String region_Code = orgCode.substring(0,2);
      /*公共部分*/
      String searchType=request.getParameter("searchType");
      String dsmpType = request.getParameter("dsmpType");
      String filename = request.getParameter("filename");
      String optype = request.getParameter("optype");
      String spno = request.getParameter("spno");
      String validdate = request.getParameter("validdate");
      String expiredate = request.getParameter("expiredate");
      String pagecount = request.getParameter("pagecount");
       /*sp业务信息*/
      String bizno = request.getParameter("bizno");
      String bizname = request.getParameter("bizname");
      String bizType = request.getParameter("bizType");
      String infofee = request.getParameter("infofee");
      String balprop = request.getParameter("balprop");
      String reconfirm = request.getParameter("reconfirm"); 
      
	    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	    int iPageSize = Integer.parseInt(pagecount,10);
	    int iStartPos = (iPageNumber-1)*iPageSize;
	    int iEndPos = iPageNumber*iPageSize;
      
      String sql1="";
			String sql2="";
			
			String tmp = "";
			String sptype="";
			String sptmp="";
			System.out.println("1:#################################################");
			sql1= "select a.login_accept,a.file_name,a.op_type,nvl(b.servname,a.serv_type) ,a.sp_code,a.operator_code,a.operator_name,a.bill_flag,a.fee,a.valid_date,a.expire_date,a.bal_prop,a.count a_count,a.is_third_validate,a.re_confirm,a.serv_type serv_type2 from tdsmpspbizinfosynchis a,sdsmpservtype b where a.serv_type = b.servtype(+) ";
			sql2= "select nvl(count(*),0) num from tdsmpspbizinfosynchis a ,sdsmpservtype b where a.serv_type = b.servtype(+) ";
			if(!spno.equals(""))
			{
				sql1  = sql1+" and a.sp_code like '%"+spno+"%'";
				sql2  = sql2+" and a.sp_code like '%"+spno+"%'";
			}
			if(!bizno.equals(""))
			{
				sql1  = sql1+" and a.operator_code like '%"+bizno+"%'";
				sql2  = sql2+" and a.operator_code like '%"+bizno+"%'";
			}
			if(!bizname.equals(""))
			{
				sql1  = sql1+" and a.operator_name like '%"+bizname+"%'";
				sql2  = sql2+" and a.operator_name like '%"+bizname+"%'";
			}
			if(!bizType.equals("0"))
			{
				if(bizType.equals("1"))
				{/*免费*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 1) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 0)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 1) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 0)) ";
				}
				else if(bizType.equals("2"))
				{/*按条/按次*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 2) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 1)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 2) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 1)) ";
				}
				else if(bizType.equals("3"))
				{/*包次*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 3) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 4)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 3) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 4)) ";
				}
				else if(bizType.equals("4"))
				{/*包月*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 5) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 2)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 5) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 2)) ";
				}
				else if(bizType.equals("5"))
				{/*包天*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 7) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 7)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 7) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 7)) ";
				}
				else if(bizType.equals("6"))
				{/*按栏目*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 9) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 5)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 9) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 5)) ";
				}
				else if(bizType.equals("7"))
				{/*时长*/
					sql1  = sql1+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 11) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 3)) ";
					sql2  = sql2+" and ((serv_type > '001103' and serv_type<>'008007' and bill_flag = 11) or ((serv_type <= '001103' or serv_type='008007') and bill_flag = 3)) ";
				}
			}
			if(!infofee.equals(""))
			{
				sql1  = sql1+" and a.fee like '%"+infofee+"%'";
				sql2  = sql2+" and a.fee like '%"+infofee+"%'";
			}
			if(!balprop.equals(""))
			{
				sql1  = sql1+" and a.bal_prop like '%"+balprop+"%'";
				sql2  = sql2+" and a.bal_prop like '%"+balprop+"%'";
			}
			if(!reconfirm.equals("0"))
			{
				int itmp =  Integer.parseInt(reconfirm,10)-1;
				sql1  = sql1+" and a.re_confirm like '%"+itmp+"%'";
				sql2  = sql2+" and a.re_confirm like '%"+itmp+"%'";
			}
			if(!dsmpType.equals("0"))
			{
				sql1  = sql1+" and a.serv_type like '%"+dsmpType+"%'";
				sql2  = sql2+" and a.serv_type like '%"+dsmpType+"%'";
			}
			if(!filename.equals(""))
			{
				sql1  = sql1+" and a.file_name like '%"+filename+"%'";
				sql2  = sql2+" and a.file_name like '%"+filename+"%'";
			}
			if(!validdate.equals(""))
			{
				sql1  = sql1+" and  a.valid_date like '%"+validdate+"%'";
				sql2  = sql2+" and  a.valid_date like '%"+validdate+"%'";
			}
			if(!expiredate.equals(""))
			{
				sql1  = sql1+" and a.expire_date like '%"+expiredate+"%'";
				sql2  = sql2+" and a.expire_date like '%"+expiredate+"%'";
			}
			if(!optype.equals("0"))
			{
				if(optype.equals("1")){
					sql1  = sql1+" and a.op_type = 'A' ";
					sql2  = sql2+" and a.op_type = 'A' ";
				}
				else if(optype.equals("2")){
					sql1  = sql1+" and a.op_type = 'M' ";
					sql2  = sql2+" and a.op_type = 'M' ";
				}
				else if(optype.equals("3")){
					sql1  = sql1+" and a.op_type = 'D' ";
					sql2  = sql2+" and a.op_type = 'D' ";
				}
			}
			
			sql1 = "select rownum id,c.*from ("+sql1 + " order by a.update_time ) c";
			sql1 = "select * from ("+sql1+") where id <="+iEndPos+" and id>"+iStartPos; 
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
		<TITLE>局数据记录查询</TITLE>
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
		</SCRIPT>
		<FORM method=post name="frmb559_3">
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
            <th><div align="center">导入流水</div></th>
            <th><div align="center">导入文件</div></th>              
            <th><div align="center">操作类型</div></th>
            <th><div align="center">业务类型</div></th>
            <th><div align="center">企业代码</div></th>
            <th><div align="center">业务代码</div></th>
            <th><div align="center">业务名称</div></th>
            <th><div align="center">计费类型</div></th>
            <th><div align="center">信息费</div></th>
            <th><div align="center">生效时间</div></th>
            <th><div align="center">失效时间</div></th>
            <th><div align="center">结算比例</div></th>
            <th><div align="center">次数</div></th>
            <th><div align="center">第三方确认</div></th>
            <th><div align="center">二次确认</div></th>
        </tr>
        <%
         
         for(int i=0;i<result1.length;i++){    
	         String tdClass = "";                       
        %>
	        <tr id="tr0">
		        <td align="center" name=loginaccept height="20"><%=result1[i][1]%></td>
		        <td align="center" name=filename height="20"><%=result1[i][2]%></td>
		        <%
        		tmp = result1[i][3];
        		if(tmp.equals("A"))
        		{
        			tmp = "新增";
        		}
	        	else if(tmp.equals("M"))
	        	{
	        		tmp = "修改";
        		}
        		else if(tmp.equals("D"))
        		{
        			tmp = "删除";
        		}
        		else
        		{
        			tmp = "其他";
        		}
        	%>
        	<td align="center" name=tmp height="20"><%=tmp%></td>
        	<td align="center" name=spcode height="20"><%=result1[i][4]%></td>
		      <td align="center" name=spname height="20"><%=result1[i][5]%></td>   	
        	<td align="center" name=sptype height="20"><%=result1[i][6]%></td>
        	<td align="center" name=spcode height="20"><%=result1[i][7]%></td>
        	<%
        	tmp = result1[i][8];
        	if(!tmp.equals(""))
        	{
	        	if(Integer.parseInt(result1[i][16],10)>1103||Integer.parseInt(result1[i][16],10)==8007)
	        	{
	        		if(Integer.parseInt(result1[i][8])==1)
	        		{
	        			tmp = "免费";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==2)
	        		{
	        			tmp = "按条/按次";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==3)
	        		{
	        			tmp = "包次";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==5)
	        		{
	        			tmp = "包月";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==7)
	        		{
	        			tmp = "包天";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==9)
	        		{
	        			tmp = "按栏";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==11)
	        		{
	        			tmp = "时长";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==12)
	        		{
	        			tmp = "包周";
	        		}
	        	}
	        	else
	        	{
	        		if(Integer.parseInt(result1[i][8])==0)
	        		{
	        			tmp = "免费";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==1)
	        		{
	        			tmp = "按条/按次";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==2)
	        		{
	        			tmp = "包月";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==4)
	        		{
	        			tmp = "包次";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==7)
	        		{
	        			tmp = "包天";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==5)
	        		{
	        			tmp = "按栏";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==3)
	        		{
	        			tmp = "包时";
	        		}
	        		else if(Integer.parseInt(result1[i][8])==12)
	        		{
	        			tmp = "包周";
	        		}
	        	}
        	}
        	%>
		      <td align="center" name=spname height="20"><%=tmp%></td>
		      <td align="center" name=spname height="20"><%=result1[i][9]%></td>
		      <td align="center" name=spname height="20"><%=result1[i][10]%></td>
		      <td align="center" name=spname height="20"><%=result1[i][11]%></td>
		      <td align="center" name=spname height="20"><%=result1[i][12]%></td>
		      <td align="center" name=spcode height="20"><%=result1[i][13]%></td>
		      <% 
	        		tmp =result1[i][14];
	        		if(tmp.equals("0"))
	        		{
	        			tmp = "不需要";
	        		}
	        		else if(tmp.equals("1"))
	    				{
	    					tmp = "需要";
	    				}
	        %> 
		      <td align="center" name=spname height="20"><%=tmp%></td>
		      <% 
	        		tmp =result1[i][15];
	        		if(tmp.equals("0"))
	        		{
	        			tmp = "不需要";
	        		}
	        		else if(tmp.equals("1"))
	    				{
	    					tmp = "需要";
	    				}
	        %> 
		      <td align="center" name=spname height="20"><%=tmp%></td>	
	        </tr>
				<%
				 }
				%>           
 			</table>
 			<TABLE cellSpacing="0">
				<tr> 
	        <td id="footer"> 
	           <input type="button" name="queryButton"  class="b_foot" value="返回" style="cursor:hand;" onclick="location='fb559_1.jsp'">&nbsp;
	           <input type="button" name="closeButton"  class="b_foot" value="关闭" style="cursor:hand;" onClick="parent.removeTab('<%=opCode%>')">&nbsp;
	        </td>
		     </tr>
			</TABLE>
    </FORM>
  <BODY>
<HTML>
