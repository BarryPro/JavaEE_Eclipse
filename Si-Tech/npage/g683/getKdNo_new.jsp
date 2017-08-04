<%
/********************
 version v2.0
开发商: si-tech
*******************
xl 新增修改操作
增加对输入宽带号码 -->phone_no的判断 并将phone_no对应的contract_no输出

*/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
            //得到输入参数
    String contractNo= "";
    //String phone_kd  = WtcUtil.repStr(request.getParameter("contractNo")," "); 
	
	String busy_type = WtcUtil.repStr(request.getParameter("busyType")," ");
   	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String return_page = WtcUtil.repStr(request.getParameter("return_page")," ");
 
	/*
	转换原则：
 

	*/
	String phone_new="";
	String cust_new="";
	String id_new="";
	String s_master_cust_id="";
	
    String s_phone_new="";
 
 

	String i_flag="";// 1家长 0个人
	String m_phone_no="";
	String s_phone_no="";


	String check_flag  = request.getParameter("check_flag");
	String jzPhone  = request.getParameter("jzPhone");
	String jtPhone  = request.getParameter("jtPhone");
	
    System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaa check_flag is "+check_flag+" and jzPhone is "+jzPhone+" and jtPhone is "+jtPhone);
	String s_contract_out=""; //家长或家庭的帐号
	String retResult="";//true成功 false失败
	
	String ret_msg="";
	
	String s_out_pno="";
	if(check_flag=="1" || check_flag.equals("1"))
	{
		String[] inParas2 = new String[2];
		inParas2[0]="select to_char(cust_id) from CT_CUST_REL where phone_no=:phone_No  ";
		inParas2[1]="phone_No="+jzPhone;
		//String sql_2="select phone_no from CT_CUST_REL where master_cust_id=";
	%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode12" retmsg="retMsg12" outnum="1">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
		</wtc:service>
		<wtc:array id="result12" scope="end" />
	<%
		
		if(result12!=null&&result12.length>0)
		{
			cust_new= (result12[0][0]).trim();

			String[] inParas3 = new String[2];
			//select phone_No       from ct_cust_rel where master_cust_id ='13023463771' and master_flag='1'; -- 18845111800
			inParas3[0]="select to_char(phone_no) from CT_CUST_REL where cust_id=:cust_id and master_flag='1' and phone_no=:m_phoneno";
			inParas3[1]="cust_id="+cust_new+",m_phoneno="+jzPhone;
			%>
			<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode13" retmsg="retMsg13" outnum="1">
				<wtc:param value="<%=inParas3[0]%>"/>
				<wtc:param value="<%=inParas3[1]%>"/>
			</wtc:service>
			<wtc:array id="result13" scope="end" />
			<%
				if(result13!=null&&result13.length>0)
				{
				   System.out.println("-----家长的");
				   String[] inParas5 = new String[2];
				   inParas5[0]="select to_char(vm_phone_No) from ct_homecust_info where master_phone=:phoine_no and finish_flag='0'  ";
				   inParas5[1]="phoine_no="+result13[0][0];
				   %>
					<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode15" retmsg="retMsg15" outnum="1">
						<wtc:param value="<%=inParas5[0]%>"/>
						<wtc:param value="<%=inParas5[1]%>"/>
					</wtc:service>
					<wtc:array id="result15" scope="end" />
				   <%
				   if(result15!=null&&result15.length>0)
				   {
						i_flag="1";
						m_phone_no=result15[0][0]; //家长的的 手机号码
						String[] inParas8 = new String[2];
						inParas8[0]="select to_char(contract_no) from dcustmsg where phone_no=:m_no ";
						inParas8[1]="m_no="+m_phone_no;
						%>
							<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode8" retmsg="retMsg8" outnum="1">
								<wtc:param value="<%=inParas8[0]%>"/>
								<wtc:param value="<%=inParas8[1]%>"/>
							</wtc:service>
							<wtc:array id="result8" scope="end" />
						<%
							if(result8!=null&&result8.length>0)
							{
								s_phone_new=m_phone_no;
								s_contract_out=(result8[0][0]).trim();
								retResult = "true" ;
							}
							else
							{
								retResult = "false" ;
								ret_msg="查询家长账户信息失败！";
								%>
									//rdShowMessageDialog("查询家长账户信息失败！");
									
									//history.go(-1);
								<%
							}	
							
				   }
				   else
				   {
					   retResult = "false" ;
					   ret_msg="查询家长手机号码报错";
					   %>
						  //rdShowMessageDialog("查询家长手机号码报错!");
					   <%
				   }
				   
				 
				}
				else
				{
					ret_msg="非家长手机号码不可以退费";
					%>
						//  rdShowMessageDialog("非家长手机号码不可以退费!");
					   <%
				} 
					
							
					
		 }
		 else
		 {
				  retResult = "false" ;	
				  ret_msg="查询用户家庭信息报错";	
			 %>
					//	rdShowMessageDialog("查询用户家庭信息报错!");
						//rdShowMessageDialog("查询用户家庭信息报错!");
						//window.location.href="g659_1.jsp"; 
					 
			 <%
		 }
	}
	//end 家长

	//直接输入的家庭帐号 判断209号码是否在dcustmsg有记录即可
	if(check_flag=="2" || check_flag.equals("2"))
	{
		
		
		
		//家庭 输入的就是20号码
		s_phone_new=jtPhone;
		//s_contract_out 取值
		String[] inParas9 = new String[2];
		inParas9[0]="select to_char(vm_phone_no) from ct_homecust_info where vm_phone_no=:m_no1 and finish_flag='0' ";
		inParas9[1]="m_no1="+s_phone_new;
		%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode81" retmsg="retMsg81" outnum="1">
			<wtc:param value="<%=inParas9[0]%>"/>
			<wtc:param value="<%=inParas9[1]%>"/>
		</wtc:service>
		<wtc:array id="result81" scope="end" />
	
	<%
		if(result81!=null&&result81.length>0)
		{
			s_out_pno=(result81[0][0]).trim();
			String[] inParas91 = new String[2];
			inParas91[0]="select to_char(contract_no) from dcustmsg where phone_no=:s_pno  ";
			inParas91[1]="s_pno="+s_out_pno;
			%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode91" retmsg="retMsg91" outnum="1">
			<wtc:param value="<%=inParas91[0]%>"/>
			<wtc:param value="<%=inParas91[1]%>"/>
		</wtc:service>
		<wtc:array id="result91" scope="end" />
	
	<%		
			if(result81!=null&&result81.length>0)
			{
				s_contract_out=(result91[0][0]).trim();
				retResult="true";
			}
			else
			{
				retResult = "false" ;	
				ret_msg="查询家庭账户错误！";
			%>
				//rdShowMessageDialog("查询家庭账户错误！");
				//history.go(-1);
			<%
		}	
			
			
		}
		else
		{
			retResult = "false" ;	
			ret_msg="家庭账户不存在！";
			%>
				//rdShowMessageDialog("家庭账户不存在！");
				//history.go(-1);
			<%
		}
	}

%>	

var response = new AJAXPacket  ();
var retResult = "<%=retResult%>";
var s_contract_out = "<%=s_contract_out%>";
var s_phone_new= "<%=s_phone_new%>";
var ret_msg= "<%=ret_msg%>"; 

response.guid = '<%= request.getParameter("guid") %>';

response.data.add("retResult",retResult);
response.data.add("s_phone_new",s_phone_new);
response.data.add("s_contract_out",s_contract_out);
response.data.add("ret_msg",ret_msg);
core.ajax .receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
