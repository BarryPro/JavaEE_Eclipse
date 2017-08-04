<%
  /*
   * 功能: 校验服务号码是否为宽带号码
   * 版本: 1.0
   * 日期: 2014/8/20
   * 作者: huangqi
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	String objSel = WtcUtil.repNull(request.getParameter("objSel").trim());
	String rwsj = WtcUtil.repNull(request.getParameter("rwsj").trim());
	String sim_vlaue = WtcUtil.repNull(request.getParameter("sim_vlaue").trim());
	String phoneNo =WtcUtil.repNull(request.getParameter("phoneNo").trim());
	String id_no = WtcUtil.repNull(request.getParameter("id_no").trim());
	String coutract_no = WtcUtil.repNull(request.getParameter("coutract_no").trim());
	String khxm = WtcUtil.repNull(request.getParameter("khxm").trim());
	String jftime = WtcUtil.repNull(request.getParameter("jftime").trim()); 
	String jfje = WtcUtil.repNull(request.getParameter("jfje").trim()); 
	String ym =  WtcUtil.repNull(request.getParameter("ym").trim()); 
	String wpay = "wpay"+ym;
	int i_count=0;
	String s_sql_flag="";
	System.out.println("faaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa test objSel is "+objSel);
	String[] inParam = new String[2];
	String s_flag="";
	if(objSel=="1" ||objSel.equals("1"))//入网时间
	{
		inParam[0]="select to_char(count(0)) from dCustMsgDead b where b.phone_no=:s_phone_no and contract_no=:s_contract_no and to_char(b.open_time,'yyyymm') =:s_open_ym";
		inParam[1]="s_phone_no="+phoneNo+",s_contract_no="+coutract_no+",s_open_ym="+rwsj;
		 
	}
	else if(objSel=="3" ||objSel.equals("3"))//客户姓名 这个sql得改 用账号去校验
	{
		inParam[0]="select to_char(count(0)) from dConMsgDead a,dCustMsgDead b where a.contract_no=b.contract_no and b.phone_no=:s_phone_no and a.contract_no=:s_no and a.bank_cust = :s_name";
		inParam[1]="s_phone_no="+phoneNo+",s_no="+coutract_no+",s_name="+khxm;
		 
	}
	else
	{
		//拼wpay表 用账号和金额 缴费时间查询
		inParam[0]="select to_char(count(0))  from "+wpay+" where contract_no=:s_contract_no and total_date = :s_date and pay_money=:s_money";
		inParam[1]="s_contract_no="+coutract_no+",s_date="+jftime+",s_money="+jfje;
		 
	}
	System.out.println("fffffffffffffffffffffffffff test  s_sql_flag is "+s_sql_flag+" and objSel is "+objSel);
	
	%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%

	
	String checkResult="0";
	String[][] result1  = null ;
	result1=result;
	if(result1!=null&&result1.length>0)
	{
		if(Integer.parseInt(result1[0][0])>=1)
		{
			s_flag="0";//通过
		}
		else
		{
			s_flag="1";
		}
		System.out.println("ccccccccccccccccccccccccccc result1 is "+result1[0][0]);
	}
	else
	{
		s_flag="1";//不通过
	}
	System.out.println("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB s_flag is "+s_flag);
%>
		
 
	var response = new AJAXPacket();
	response.data.add("s_flag","<%=s_flag%>");
	core.ajax.receivePacket(response);
 