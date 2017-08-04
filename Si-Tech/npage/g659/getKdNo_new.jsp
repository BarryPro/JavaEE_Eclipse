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
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page contentType="text/html; charset=GBK" %>
<%
            //得到输入参数
    String contractNo= "";
    String phone_kd  = WtcUtil.repStr(request.getParameter("contractNo")," "); 
	
	String busy_type = WtcUtil.repStr(request.getParameter("busyType")," ");
   	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String return_page = WtcUtil.repStr(request.getParameter("return_page")," ");
 
	/*
	转换原则：
	1.用传入的手机号码 查CT_CUST_REL
select master_cust_id from CT_CUST_REL where phone_no = 传入的 and master_flag=1;
查出master_cust_id后
select phone_no from CT_CUST_REL where master_cust_id=查出的master_cust_id;
	2.然后select VM_USER_ID from CT_HOMECUST_INFO where master_phone=刚才查出的phone_no

	select master_cust_id from ct_cust_rel where phone_no='13674615823';
select phone_No       from ct_cust_rel where master_cust_id ='13023463771' and master_flag='1'; -- 18845111800
select vm_phone_no    from ct_homecust_info where master_phone='18845111800';

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
	if(result12!=null&&result12.length>0){
		        cust_new= (result12[0][0]).trim();

				String[] inParas3 = new String[2];
				//select phone_No       from ct_cust_rel where master_cust_id ='13023463771' and master_flag='1'; -- 18845111800
				inParas3[0]="select to_char(phone_no) from CT_CUST_REL where cust_id=:cust_id and master_flag='1'";
				inParas3[1]="cust_id="+cust_new;
				%>
				<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode13" retmsg="retMsg13" outnum="1">
					<wtc:param value="<%=inParas3[0]%>"/>
					<wtc:param value="<%=inParas3[1]%>"/>
				</wtc:service>
				<wtc:array id="result13" scope="end" />
				<%
					if(result13!=null&&result13.length>0)
					{
						phone_new=(result13[0][0]).trim();
						
						//select vm_phone_no    from ct_homecust_info where master_phone='18845111800';
						String[] inParas4 = new String[2];
						inParas4[0]="select to_char(vm_phone_no)    from ct_homecust_info where master_phone=:p_no and finish_flag='0' ";
						inParas4[1]="p_no="+phone_new;
						%>
						<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode14" retmsg="retMsg14" outnum="1">
							<wtc:param value="<%=inParas4[0]%>"/>
							<wtc:param value="<%=inParas4[1]%>"/>
						</wtc:service>
						<wtc:array id="result14" scope="end" />
						<%
							if(result14!=null&&result14.length>0)
							{
								s_phone_new=(result14[0][0]).trim();
								 
								String sqlStr = "";
								String returnCode="";
								//System.out.println("aaaaaaaaaaaaacontractNo is "+contractNo+" and phone_new is "+phone_new);
								//System.out.println("bbbbbbbbbbbbb"+busy_type);

								String Pwd0 = "";
								  String Pwd1 = "";
								  String Pwd2 = "";
								  String Pwd3 = "";
								
								  String phone_out = "";
								  
								//	System.out.println("eeeeeeeeeeeeeeeeeeeeeee"+busy_type+" and phone_new is "+phone_new);
									String[] inParas5 = new String[2];
									inParas5[0]="select a.contract_passwd,substr(c.id_iccid,length(c.id_iccid)-3,4),to_char(a.contract_no) from dConMsg a,dCustMsg b,dCustDoc c,dConUserMsg d where a.contract_no=d.contract_no and d.id_no=b.id_no and b.cust_id=c.cust_id and  b.phone_no = :phone_new ";
									inParas5[1]="phone_new="+s_phone_new;
									//sqlStr = "select a.contract_passwd,substr(c.id_iccid,length(c.id_iccid)-3,4),to_char(a.contract_no) from dConMsg a,dCustMsg b,dCustDoc c,dConUserMsg d where a.contract_no=d.contract_no and d.id_no=b.id_no and b.cust_id=c.cust_id and  b.phone_no = '?' ";
									
									%>
									<wtc:service name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="3">
										<wtc:param value="<%=inParas5[0]%>"/>
										<wtc:param value="<%=inParas5[1]%>"/>
									</wtc:service>
									<wtc:array id="result1" scope="end" />
									<%
										String cust_passwd="";
										 String iccid="";
										  
											if(result1!=null&&result1.length>0){
												cust_passwd= (result1[0][0]).trim();
												iccid = (result1[0][1]).trim();
												contract_out = (result1[0][2]).trim();

										  }else{
											 returnCode="999999";
											 retResult="没有此用户的相关资料!";
											 
										 }
										  
										  

											System.out.println("11111111111111cccccccccccccc iccid is "+iccid+" and contract_out is "+contract_out);

													
											Pwd0 = cust_passwd;
											Pwd1 = "000000";
											Pwd2 = "001234";
											Pwd3 = "00"+iccid ;
											System.out.println("cccccccccccccc"+Pwd1);
											System.out.println("cccccccccccccc"+Pwd2);
											System.out.println("cccccccccccccc"+Pwd3);
								 
										  if(1==Encrypt.checkpwd1(Pwd1,cust_passwd) || 1==Encrypt.checkpwd1(Pwd2,cust_passwd) || 1==Encrypt.checkpwd1(Pwd3,cust_passwd))
										  {
											retResult = "false" ;				
										  }else
										  {
										   retResult = "true" ;
										  }

							}
							else
							{
								%>
									rdShowMessageDialog("家庭帐号不存在");
								<%
							}
					}
					else
					{
						%>
						 rdShowMessageDialog("查询用户家庭归属信息报错");
						//alert("查询用户家庭归属信息报错!");
						//window.location.href="g659_1.jsp"; 
						<%
					}	
				
	 }else{
		      
	     %>
				    rdShowMessageDialog("查询用户家庭信息报错");
					//alert("查询用户家庭信息报错!");
					//window.location.href="g659_1.jsp"; 
				 
		 <%
		 }

%>	

var response = new AJAXPacket  ();
var retResult = "<%=retResult%>";
var phone_new = "<%=s_phone_new%>";
var contract_out = "<%=contract_out%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retResult",retResult);
response.data.add("phone_new",phone_new);
response.data.add("contract_out",contract_out);
core.ajax .receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
