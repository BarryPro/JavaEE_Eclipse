<%
  /*
   * ����: ���ſͻ���Ϣ 
�� * �汾: v1.0
�� * ����: 2011��05��10��
�� * ����: zhoujf 
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	  String opCode     = "";
	  String opName     = "���ſͻ���Ϣ";
    String unit_id    = request.getParameter("unit_id")==null?"":request.getParameter("unit_id");
    String implRegion = (String)session.getAttribute("regCode");	
    String ipAddr     = (String)session.getAttribute("ipAddr");
	  String orgCode    = (String)session.getAttribute("orgCode");
	  String regionCode = orgCode.substring(0,2);
	  
	  String sqlStr              = "select a.unit_id,a.unit_name,b.agency_name,SUBSTR(a.boss_org_code,1,2),SUBSTR(a.boss_org_code,3,2),a.unit_addr,a.unit_zip,a.contact_person,a.contact_phone,a.contact_mobile_phone from dgrpcustmsg a left join  sgrpagencytype b on a.agency_code =b.agency_code where a.unit_id="+unit_id;
	  String sqlStr1             = "select a.unit_id,e.pro_name from dgrpcustmsg a left join sgrpprovincemsg e on e.pro_code = a.province_code where a.unit_id="+unit_id;
	  String sqlStr2             = "select a.unit_id,c.trade_name from dgrpcustmsg a left join sgrpbigtradecode c on a.big_trade_code = c.trade_code where a.unit_id="+unit_id;
	  String sqlStr3             = "select a.unit_id,d.operate_name from dgrpcustmsg a left join sgrpoperateregion d on a.operate_code = d.operate_code where a.unit_id="+unit_id;
    String sqlDic   					 = "SELECT T1.NAME FROM DGRPCUSTMSG T,(SELECT *  FROM DGRPGROUPS T WHERE T.PARENT_GROUP_ID = '10015' AND T.DENORM_LEVEL = 1) T1, DGRPGROUPS T2 WHERE  T.ORG_CODE = T2.GROUP_ID AND T1.GROUP_ID = T2.PARENT_GROUP_ID and T.UNIT_ID = "+unit_id;
    String sqlTown   					 = "SELECT T1.NAME FROM DGRPCUSTMSG T, (SELECT * FROM DGRPGROUPS T WHERE T.PARENT_GROUP_ID = '10015' AND T.DENORM_LEVEL = 2) T1, DGRPGROUPS T2 WHERE T.ORG_CODE = T2.GROUP_ID AND T1.GROUP_ID = T2.PARENT_GROUP_ID and T.UNIT_ID = "+unit_id;
    String sqlStu1    = "select b.grp_status_name,c.CREATE_TIME,d.owner_name  from dgrpcustmsg a,sGrpStatusCode b,dcustdoc c,sgrpownercode d WHERE a.grp_status = b.grp_status and a.cust_id=c.cust_id and d.owner_code=a.owner_code and a.unit_id = "+unit_id;
    String sqlStu2 = "SELECT distroy_date FROM dgrpcustmsg_distroy WHERE unit_id ="+unit_id;
    String sqlStu3      = "SELECT COUNT(1)  FROM dgrpmembermsg      WHERE unit_id  = "+unit_id;
    String sqlGroup    = " SELECT  a.customer_name ,b.customer_id,b.customer_name, a.customer_id from dcustomerinfo a, dcustomerinfo b, dgrpcustmsg c where a.customer_id=rpad(to_char(c.unit_id),18,' ')and a.customer_parent_id=b.custmoter_ec_id and a.customer_parent_id!='0' AND c.unit_id="+unit_id;
	  String sqlContract     = "  select a.contract_id,a.contract_name,a.item_manager,a.deal_time,a.complete_time from dgrpcontract a where unit_id="+unit_id;
	   String sqlChannel    ="select t.develop_channel_code,t.service_channel_code,t1.develop_channel_name,t2.service_channel_name from dbvipadm.dgrpcustmsg t,dbvipadm.sgrpdevelopchannel t1,dbvipadm.sgrpservicechannel t2 where  t.develop_channel_code = t1.develop_channel_code and t2.service_channel_code = t.service_channel_code and t.unit_id ="+unit_id;
%>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
				<wtc:sql>
						<%=sqlGroup%>
				</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end" />
    
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
				<wtc:sql>
						<%=sqlTown%>
				</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result7" scope="end" />
    
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
				<wtc:sql>
						<%=sqlDic%>
				</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result6" scope="end" />
    
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
				<wtc:sql>
						<%=sqlStu3%>
				</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result5" scope="end" />
<!--    
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
				<wtc:sql>
						<%=sqlStu2%>
				</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result4" scope="end" />
-->			
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode2" retmsg="retMsg2" outnum="3">
				<wtc:sql>
						<%=sqlStu1%>
				</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result3" scope="end" />
    
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode2" retmsg="retMsg2" outnum="13">
				<wtc:sql>
						<%=sqlStr%>
				</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />
			
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode2" retmsg="retMsg2" outnum="13">
				<wtc:sql>
						<%=sqlStr1%>
				</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result11" scope="end" />
			
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode2" retmsg="retMsg2" outnum="13">
				<wtc:sql>
						<%=sqlStr2%>
				</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result12" scope="end" />
			
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode2" retmsg="retMsg2" outnum="13">
				<wtc:sql>
						<%=sqlStr3%>
				</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result13" scope="end" />
    
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
				<wtc:sql>
						<%=sqlContract%>
				</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
			
		  <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
				<wtc:sql>
						<%=sqlChannel%>
				</wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultA" scope="end" />	
<%
		System.out.println("Opcode 1023 ���ſͻ���Ϣ sqlDic : \n"+sqlDic);
		System.out.println("result13==================1023  START"+result13.length);
		for(int ii=0;ii<result13.length;ii++)
		{
				for(int jj=0;jj<result13[ii].length;jj++)
				{
					  System.out.println("result13["+ii+"]["+jj+"]="+result13[ii][jj]);
				}
		}
		System.out.println("result============1023  END======");
%>
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<FORM name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title"><div id="title_zi">���ſͻ���������</div></div>
	<table cellSpacing=0>
	  <table id="tabList"  cellspacing=0 >			
	  	<tr>	     
			  <TD width="16%" class="blue">���ű���</TD>
		  	<TD >
			  	<input type=text  id="unit_id"  value=<%=result1[0][0]%> readonly />
			  </TD>		 
			  <TD width="16%" class="blue">��������</TD>
		  	<td >
					<input type=text  id="unit_name"  value=<%=result1[0][1]%> readonly />
	      </td>
	    	<TD width="16%" class="blue">���Ż�������</TD>
		  	<td>
					<input type=text  id="agency_name"  value="<%=result1[0][2]%>"  readonly />
	      </td>
			</tr>
			<tr>
	      <TD width="16%" class="blue">����ʡ��</TD>
		  	<TD >
			  	<input type=text  id="provice"  value=<%=result11[0][1]%> readonly  />
			  </TD>	
			  <TD width="16%" class="blue">��������</TD>
		  	<TD >
			  	<input type=text  id="city" value=<%=result6[0][0]%> readonly  />
			  </TD>
			  <TD width="16%" class="blue">��������</TD>
		  	<TD >
			  	<% if(result7.length == 0){ %>
			  	<input type=text  id="town"  value="" readonly  />
			  	<%}else{%>
			  	<input type=text  id="town"  value=<%=result7[0][0]%> readonly  />
			  	<%}%>
			  </TD>
			</tr>
			<tr>
			  <TD width="16%" class="blue">���ŵ�ַ</TD>
		  	<TD >
			  	<input type=text  id="unit_add"  value="<%=result1[0][5]%>" readonly  />
			  </TD>
			  <TD width="16%" class="blue">���ŵ�ַ�ʱ�</TD>
		  	<TD >
			  	<input type=text  id="unit_zip"  value="<%=result1[0][6]%>" readonly />
			  </TD>
			  <TD width="16%" class="blue">������ҵ���</TD>
		  	<TD >
			  	<input type=text  id="trade_name"  value="<%=result12[0][1]%>" readonly />
			  </TD>
			</tr>
			<tr>
			  <TD width="16%" class="blue">���ž�Ӫ��������</TD>
		  	<TD >
			  	<input type=text  id="operate_name" value="<%=result13[0][1]%>" readonly  />
			  </TD>
		  </tr>

	</table>
	
	<br>
	
	<div class="title"><div id="title_zi">������ϵ����Ϣ</div></div>
	  <table id="tabList"  cellspacing=0 readonly>			
				<tr>	     
			  <TD width="16%" class="blue">������ϵ������</TD>
		  	<TD >
			  	<input type=text name="" id="name" value="<%=result1[0][7]%>" readonly />
			  </TD>		 
			  <TD width="16%" class="blue">������ϵ�˵绰</TD>
		  	<td >
					<input type=text name="" id="phone"  value="<%=result1[0][8]%>" readonly  />
	      </td>
	    	<TD width="16%" class="blue">������ϵ���ƶ��绰</TD>
		  	<td>
					<input type=text name="" id="mobile"  value="<%=result1[0][9]%>"  readonly  />
	      </td>
			</tr>
		</table>
	
	<br>
	
	<div class="title"><div id="title_zi">����״̬��Ϣ</div></div>
	  <table id="tabList"  cellspacing=0 >			
	  	<tr>	    	  	
			  <TD width="16%" class="blue">���ſ���ʱ��</TD>
		  	<TD >
			  	<input type=text name="" id="time1"  value="<%=result3[0][1]%>" readonly />
			  </TD>		 
<!--			  <TD width="16%" class="blue">��������ʱ��</TD>
		  	<td >
		  	<%
			  if( result4.length == 0){
			  %>
					<input type=text name="" id="time2"  value="" readonly />
				<%
				}else{
				%>
					<input type=text name="" id="time3"  value=<%=result4[0][1]%> readonly />
				<%
				}
				%>
	      </td>
-->
	    	<TD width="16%" class="blue">���ų�Ա��</TD>
		  	<td>
					<input type=text name="" id="num"  value="<%=result5[0][0]%>" readonly />
	      </td>
	    </tr>
	    <tr>
	      <TD width="16%" class="blue">���Ź�ģ</TD>
		  	<TD >
			  	<input type=text name="" id="guimo"  value="<%=result3[0][2]%>" readonly />
			  </TD>	
			  <TD width="16%" class="blue">����״̬</TD>
		  	<TD >
			  	<input type=text name="" id="stu"  value="<%=result3[0][0]%>"  readonly />
			  </TD>

		  </tr>
	</table>
		<br>
	
	<div class="title"><div id="title_zi">���ź�ͬ��Ϣ</div></div>
	<table cellSpacing=0>
	  <table id="tabList"  cellspacing=0 >			
				<tr align='center'>				
					<th>Э����</th>
					<th>��ͬ����</th>
					<th>��Ŀ����</th>
					<th>����ʱ��</th>		
					<th>���ʱ��</th>
				</tr>
			<%	
			for(int i = 0; i < result.length; i++)
			{		  
			%>			
				<tr>				
					<td nowrap align='center'><%=result[i][0].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=result[i][1].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=result[i][2].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=result[i][3].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=result[i][4].trim()%>&nbsp;</td>
				</tr>
			<%
			}
			%>				
	</table>
	<br>
	
	<div class="title"><div id="title_zi">���ſͻ���֯�ܹ�</div></div>
	<table cellSpacing=0>
	  <table id="tabList"  cellspacing=0 >			
				<tr align='center'>				
					<th>�ܲ�����(��֯�������ڵ�)</th>
					<th>��ʡ�ϼ��������ű���</th>	
					<th>��ʡ�ϼ���������</th>		
					
				</tr>
			<%	
			for(int i = 0; i < result2.length; i++)
			{		  
			%>			
				<tr>				
					<td nowrap align='center'><%=result2[i][0].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=result2[i][1].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=result2[i][2].trim()%>&nbsp;</td>
					
				</tr>
			<%
			}
			%>				
	</table>
	<br>
	
		<div class="title"><div id="title_zi">����Ӫ��������Ϣ</div></div>
	<table cellSpacing=0>
	  <table id="tabList"  cellspacing=0 >			
				<tr align='center'>				
					<th>��չ����</th>
					<th>��������</th>
					
				</tr>
			<%	
			for(int i = 0; i < resultA.length; i++)
			{		  
			%>			
				<tr>				
					<td nowrap align='center'><%=resultA[i][2].trim()%>&nbsp;</td>
					<td nowrap align='center'><%=resultA[i][3].trim()%>&nbsp;</td>
					
					
				</tr>
			<%
			}
			%>				
	</table>
	<br>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>


