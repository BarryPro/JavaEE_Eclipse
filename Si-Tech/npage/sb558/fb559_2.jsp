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
    	String opCode = "b559";
    	String opName = "�����ݼ�¼��ѯ";
    	String workNo = (String)session.getAttribute("workNo");
      String workName = (String)session.getAttribute("workName");
      String regionCode=(String)session.getAttribute("regCode");
      String orgCode = (String)session.getAttribute("orgCode");
      String region_Code = orgCode.substring(0,2);
      /*��������*/
      String searchType=request.getParameter("searchType");/*��ѯ���ͣ�������ҵ����ҵ������*/
      String dsmpType = request.getParameter("dsmpType");/*����������,��sdsmpservtype����ȡ����*/
      String filename = request.getParameter("filename");/*�����ļ����ƻ����ֹ���������*/
      String optype = request.getParameter("optype");/*��������*/
      String spno = request.getParameter("spno");
      String validdate = request.getParameter("validdate");/*��Ч�ڿ�ʼ*/
      String expiredate = request.getParameter("expiredate");/*��Ч�ڽ���*/
      String pagecount = request.getParameter("pagecount");/*��ʾҳ��*/
      /*sp��ҵ��Ϣ*/
      String spname = request.getParameter("spname");
      String spType = request.getParameter("spType");
      String provcode = request.getParameter("provcode");
      String balprov = request.getParameter("balprov");
      String devcode = request.getParameter("devcode");
      
	    int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	    int iPageSize = Integer.parseInt(pagecount,10);
	    int iStartPos = (iPageNumber-1)*iPageSize;
	    int iEndPos = iPageNumber*iPageSize;
      
      String sql1="";
			String sql2="";
			
			String tmp = "";
			String sptype="";
			String sptype1="";
			int spTypenum = 0;
			String servflag="";
			

			sql1 = "select a.login_accept,a.file_name,a.op_type,nvl(b.servname,a.serv_type),a.sp_code,a.sp_name,a.sp_type,a.prov_code,a.bal_prov,a.dev_code,a.valid_date,a.expire_date,a.serv_flag from  tdsmpspinfosynchis a,sdsmpservtype b where a.serv_type = b.servtype(+) ";
			sql2 = "select nvl(count(*),0) num from  tdsmpspinfosynchis a,sdsmpservtype b where a.serv_type = b.servtype(+) ";
			System.out.println("optype = "+optype);
			if(!spname.equals(""))
			{
				sql1  = sql1+" and a.sp_name like '%"+spname+"%'";
				sql2  = sql2+" and a.sp_name like '%"+spname+"%'";
			}
			if(!spno.equals(""))
			{
				sql1  = sql1+" and a.sp_code like '%"+spno+"%'";
				sql2  = sql2+" and a.sp_code like '%"+spno+"%'";
			}
			if(!spType.equals("0"))
			{
			  spTypenum = Integer.parseInt(spType) -1;
				sql1  = sql1+" and a.sp_type like '%"+spTypenum+"%'";
				sql2  = sql2+" and a.sp_type like '%"+spTypenum+"%'";
			}
			if(!provcode.equals(""))
			{
				sql1  = sql1+" and a.prov_code like '%"+provcode+"%'";
				sql2  = sql2+" and a.prov_code like '%"+provcode+"%'";
			}
			if(!balprov.equals(""))
			{
				sql1  = sql1+" and a.bal_prov like '%"+balprov+"%'";
				sql2  = sql2+" and a.bal_prov like '%"+balprov+"%'";
			}
			if(!devcode.equals(""))
			{
				sql1  = sql1+" and a.dev_code like '%"+devcode+"%'";
				sql2  = sql2+" and a.dev_code like '%"+devcode+"%'";
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
				sql1  = sql1+" and a.valid_date like '%"+validdate+"%'";
				sql2  = sql2+" and a.valid_date like '%"+validdate+"%'";
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
		<TITLE>�����ݼ�¼��ѯ</TITLE>
		<%
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
		%>
	</HEAD>
	<BODY>
		<SCRIPT language="JavaScript">
			 function fb599_2_rl(){
				location.reload(true);
				}

			function select_spmsg(i)
		  {
		   var num = <%=result2[0][0]%>;
		   if(num>1)
		   {
		   		sp_code = document.frmb559_2.checkId[i].value;
		   }else{	
		    	sp_code = document.frmb559_2.checkId.value;
		   }
		   document.frmb559_2.check_flag.value = sp_code;
		  } 
		  function add_new()
		  {
		  	var arg = "fb559_2_1.jsp";
		  	create_dialog(arg);
		  }
		  function add_copy()
		  {
		  	var checkflag = document.frmb559_2.check_flag.value
		  	if( checkflag == "")
		  	{
		  		rdShowMessageDialog("��ѡ��һ�������",0);
		  		return false;
		  	}
		  	create_dialog("fb559_2_2.jsp?opt_flag=0&check_flag="+checkflag);
		  }
		  function update()
		  {
		  	var checkflag1 = document.frmb559_2.check_flag.value
		  	if(checkflag1 == "")
		  	{
		  		rdShowMessageDialog("��ѡ��һ���޸��",0);
		  		return false;
		  	}
		  	create_dialog("fb559_2_2.jsp?opt_flag=1&check_flag="+checkflag1);
		  }
		  function del()
		  {
		  	var checkflag1 = document.frmb559_2.check_flag.value
		  	if(checkflag1 == "")
		  	{
		  		rdShowMessageDialog("��ѡ��һ��ɾ���",0);
		  		return false;
		  	}
		  	var myPacket = new AJAXPacket("fb559_del.jsp","�����ύ�����Ժ�...");
		  	myPacket.data.add("check_flag",checkflag1);
				myPacket.data.add("opt_flag","0");
				core.ajax.sendPacket(myPacket);
				myPacket=null;
		  }
			function doProcess(packet)
			{
				var retCode = packet.data.findValueByName("retCode");
				var errMsg = packet.data.findValueByName("errMsg");
				if(retCode=="000000")
					rdShowMessageDialog("SP������ɾ���ɹ�!",2);
				else
					rdShowMessageDialog("SP������ɾ��ʧ��!"+retCode+" "+errMsg,2);
			}
			
		  function create_dialog(arg)
		  {
		  	var h = 350;
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
		<FORM method=post name="frmb559_2">
		<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">�����ݵ����¼��ѯ</div>
			</div>
			<input type="hidden" name="check_flag" value="">
			<input type="hidden" name="opcode_flag" value="0">
			<table cellSpacing="0">
        <tr >
        		<td>����:</td>
        		<td><%=Integer.parseInt(result2[0][0].trim())%>��</td>
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
            <th><div >������ˮ</div></th>
            <th><div >�����ļ�</div></th>              
            <th><div >��������</div></th> 
            <th><div >ҵ������</div></th>     
            <th><div >��ҵ����</div></th>
            <th><div >��ҵ����</div></th>
            <th><div >ҵ���־</div></th>
            <th><div >����ʡ</div></th>
            <th><div >����ʡ</div></th>
            <th><div >ƽ̨����</div></th>
            <th><div >��Чʱ��</div></th>
            <th><div >ʧЧʱ��</div></th>
            <th><div >��Ӫģʽ</div></th>
           
        </tr>
        <%
         for(int i=0;i<result1.length;i++){    
        %>
	        <tr id="tr0">
		        <td  name=loginaccept height="20"><%=result1[i][1]%></td>
		        <td  name=filename height="20"><%=result1[i][2]%></td>
		        <%
        		tmp = result1[i][3];
        		if(tmp.equals("A")){
        		tmp = "����";
        		}
        	else if(tmp.equals("M")){
        		tmp = "�޸�";
        		}
        	else if(tmp.equals("D")){
        		tmp = "ɾ��";
        		}
        	else{
        		tmp = "����";
        		}
        	%>
        	<td  name=op_type height="20"><%=tmp%></td>
        	<td  name=serv_type height="20"><%=result1[i][4]%></td>
		      <td  name=sp_code height="20"><%=result1[i][5]%></td>
        	<td  name=sp_name height="20"><%=result1[i][6]%></td>
        	 <% 
        		sptype =	result1[i][7];
        		if(sptype.equals("0"))
        		{
        			sptype = "��ͨSP";
        		}
        		else if(sptype.equals("1"))
    				{
    					sptype = "���з�����SP";
    				}
        		%>
        	<td  name=sp_type height="20"><%=sptype%></td>
		      <td  name=prov_code height="20"><%=result1[i][8]%></td>
		      <td  name=bal_prov height="20"><%=result1[i][9]%></td>
		      <td  name=dev_code height="20"><%=result1[i][10]%></td>
		      <td  name=valid_date height="20"><%=result1[i][11]%></td>
		      <td  name=expire_date height="20"><%=result1[i][12]%></td>
		       <% 
        		servflag =	result1[i][13];
        		if(servflag.equals("0"))
        		{
        			servflag = "���й��ƶ���Ӫ";
        		}
        		else if(servflag.equals("1"))
    				{
    					servflag = "�й��ƶ���Ӫ";
    				}
        		%> 
		      <td  name=serv_flag height="20"><%=servflag%></td>
	        </tr>
	        
				<%
				 }
				%>           
 			</table>
 			<TABLE cellSpacing="0">
				<tr> 
	        <td id="footer"> 
	           <input type="button" name="returnButton" class="b_foot" value="����" style="cursor:hand;" onclick="location='fb559_1.jsp'">&nbsp;
	           <input type="button" name="closeButton"  class="b_foot" value="�ر�" style="cursor:hand;" onClick="parent.removeTab('<%=opCode%>')">&nbsp;
	        </td>
		     </tr>
			</TABLE>
    </FORM>
  <BODY>
<HTML>
