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
    String phone_kd  = WtcUtil.repStr(request.getParameter("contractNo")," "); 
	
	String busy_type = WtcUtil.repStr(request.getParameter("busyType")," ");
   	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String return_page = WtcUtil.repStr(request.getParameter("return_page")," ");
 
	/*
	转换原则：
 

	*/
	String[] inParas2 = new String[2];
	inParas2[0]="select to_char(cust_id) from CT_CUST_REL where phone_no=:phone_No  ";
	inParas2[1]="phone_No="+phone_kd;
	//String sql_2="select phone_no from CT_CUST_REL where master_cust_id=";
%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode12" retmsg="retMsg12" outnum="1">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="result12" scope="end" />
<%
	String phone_new="";
	String cust_new="";
	String id_new="";
	String s_master_cust_id="";
	
    String s_phone_new="";

	String retResult = "";  
	String contract_out = "";

	String i_flag="";// 1家长 0个人
	String m_phone_no="";
	String s_phone_no="";
	if(result12!=null&&result12.length>0)
	{
		cust_new= (result12[0][0]).trim();

		String[] inParas3 = new String[2];
		//select phone_No       from ct_cust_rel where master_cust_id ='13023463771' and master_flag='1'; -- 18845111800
		inParas3[0]="select to_char(phone_no) from CT_CUST_REL where cust_id=:cust_id and master_flag='1' and phone_no=:m_phoneno";
		inParas3[1]="cust_id="+cust_new+",m_phoneno="+phone_kd;
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
					retResult = "true" ;	
			   }
			   else
			   {
				   retResult = "false" ;	
				   %>
					  rdShowMessageDialog("查询家长手机号码报错!");
				   <%
			   }
			   
			 
		    }
			else
		    {
				System.out.println("-----是否是个人的 ");
				//需要找到家长的phone_no + 个人的id_no(id_no = select id_no from dcustmsg where phone_no=输入的号码)
				String[] inParas4 = new String[2];
				inParas4[0]="select to_char(phone_no) from ct_cust_rel where cust_id=:cust_id and master_flag='1' ";
				inParas4[1]="cust_id="+cust_new ;	
				%>
				<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode14" retmsg="retMsg14" outnum="1">
					<wtc:param value="<%=inParas4[0]%>"/>
					<wtc:param value="<%=inParas4[1]%>"/>
				</wtc:service>
				<wtc:array id="result14" scope="end" />
				<%
					if(result14!=null&&result14.length>0)
					{
					   String[] inParas6 = new String[2];
					   inParas6[0]="select to_char(vm_phone_No) from ct_homecust_info where master_phone=:phoine_no and finish_flag='0' ";
					   inParas6[1]="phoine_no="+result14[0][0];
					   %>
						<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode16" retmsg="retMsg16" outnum="1">
							<wtc:param value="<%=inParas6[0]%>"/>
							<wtc:param value="<%=inParas6[1]%>"/>
						</wtc:service>
						<wtc:array id="result16" scope="end" />
					   <%
						if(result16!=null&&result16.length>0)
						{
						   System.out.println("-----yao找到家长的phone_no");
						   i_flag="0";//个人的
						   m_phone_no=result16[0][0]; //家长的的 手机号码
						   s_phone_no=phone_kd;
						   retResult = "true" ;	
					    }
						else
						{
							retResult = "false" ;	
							%>
								rdShowMessageDialog("查询成员家庭对应的家长信息报错!");
							<%
						}		
					   
					   
					}
					else
				    {
						retResult = "false" ;	
						%>
						  rdShowMessageDialog("查询成员家庭信息报错!");
						<%
					}		
			}
				
					 	
				
	 }
	 else
	 {
		      retResult = "false" ;	
	     %>
				    rdShowMessageDialog("查询用户家庭信息报错!");
					//rdShowMessageDialog("查询用户家庭信息报错!");
					//window.location.href="g659_1.jsp"; 
				 
		 <%
	 }

%>	

var response = new AJAXPacket  ();
var retResult = "<%=retResult%>";
var phone_new = "<%=s_phone_new%>";
var i_flag= "<%=i_flag%>";
var m_phone_no= "<%=m_phone_no%>";
var s_phone_no= "<%=s_phone_no%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retResult",retResult);
response.data.add("i_flag",i_flag);
response.data.add("m_phone_no",m_phone_no);
response.data.add("s_phone_no",s_phone_no);
core.ajax .receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
