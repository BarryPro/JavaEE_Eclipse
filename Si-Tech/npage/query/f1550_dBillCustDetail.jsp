  <%
/********************
 version v2.0
������: si-tech
update:anln@2009-01-09 ҳ�����,�޸���ʽ
********************/
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	//������� �û�ID���ֻ����롢��������
	String id_no= request.getParameter("idNo");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String phone_no = request.getParameter("phoneNo");	
	String table_str=id_no.substring(id_no.length()-1,id_no.length());
	String opCode = "1550";	
	String opName = "�ۺ���ʷ��Ϣ��ѯ֮��ϸ�Ż���Ϣ";	//header.jsp��Ҫ�Ĳ��� 
	
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");
	/*
	String sql_str="select a.mode_code,b.mode_name,decode(a.mode_flag,'0','���ʷ�','1','����','2','��ѡ'),"
	+" decode(a.detail_type,'0','����','1','����','2','�ʵ��Ż�','3','ͨ�������Ż�','4','�ط��Ż�','a','�ط���' ), "
	+" trim(c.note),to_char(a.begin_time,'YYYYMMDD'),to_char(a.end_time,'YYYYMMDD'),"
	+" decode(a.mode_status,'Y','�ر�','N','�ر�'),a.fav_order,a.op_code,to_char(op_time,'YYYYMMDD HH24 MI SS'),a.login_no "
	+" from dBillCustDetailDead" + " a, sBillModeCode b, sBillModeDetail c "
	+" where a.region_code=b.region_code and a.mode_code=b.mode_code and a.region_code=c.region_code and a.mode_time='Y' "
	+" and a.mode_code=c.mode_code and b.mode_code=c.mode_code and a.detail_type=c.detail_type and a.detail_code=c.detail_code "
	+" and a.id_no=" +id_no+ " order by substr(a.mode_code,3,1),to_char(a.begin_time,'YYYYMMDD')";
	*/
	String sql_str="SELECT   a.offer_id,b.offer_name,decode(b.offer_type,'10','���ʷ�','20','�ײ�����Ʒ','30','�������Ʒ','40','��ѡ�ײ�'), "
		+" to_char(a.eff_date,'YYYYMMDD'),to_char(a.exp_date,'YYYYMMDD'), "
		+" decode(a.state,'A','��Ч','X','��ȡ��','H','�鵵'),a.priority,to_char(state_date,'YYYYMMDD HH24:MI:SS'),a.HANDLE_LOGIN_NO "
        +" FROM product_offer_instance_his a, product_offer b "
        +" WHERE a.offer_id = b.offer_id AND a.serv_id = " +id_no+ " "
		+" ORDER BY a.eff_date ";	
	System.out.println("sql_str = " + sql_str);  
	//ArrayList arlist = new ArrayList();
	//s1310Impl co = new s1310Impl();
	//arlist=co.s1330Query("12",sql_str); 
	//System.out.println("------------55555575555555555--arlist---" + arlist);
%>
	<wtc:pubselect name="sPubSelect" outnum="12" retmsg="msg1" retcode="code1" routerKey="phone" routerValue="<%=phone_no%>">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end"/> 
<%	
	//String [][] result = new String[][]{};
	int retval = result2.length;
	if ( retval == 0 ){
%>
<script language="JavaScript">
	rdShowMessageDialog("<br>û�з�������������");
	history.go(-1);
</script>
<%}%>	
<wtc:service name="s1500_dBillCust" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode1" retmsg="retMsg1" outnum="7" >
	<wtc:param  value=""/>
  <wtc:param  value="01"/>
  <wtc:param  value="<%=opCode%>"/>
  <wtc:param  value="<%=work_no%>"/>
  <wtc:param  value="<%=password%>"/>
  <wtc:param  value="<%=phone_no%>"/>
  <wtc:param  value=""/>
	<wtc:param value="<%=id_no%>"/>
</wtc:service>	
<wtc:array id="result" start="0" length="2" scope="end"/>
<wtc:array id="result1" start="2" length="5" scope="end"/>
<%	
	for(int i=0;i<result.length;i++){
		for(int j=0;j<result[i].length;j++){
			System.out.println("result["+i+"]["+j+"]="+result[i][j]);
		}
	}
for(int i=0;i<result1.length;i++){
	
		System.out.println("result[0]["+i+"]="+result[0][i]);
	
}
	System.out.println(result.length+"==================result.length");
	
	int valid = 0;
	if( result==null||result.length==0||result1==null){	
		valid = 1;
	}else{			
		if( !result[0][0].equals("000000") ){			
			valid = 2;			
		}else{
			valid = 0;				
		}
	}	
	if( valid == 1 ){
%>
		<script language="JavaScript">
			rdShowMessageDialog("ϵͳ��������ϵͳ����Ա��ϵ��лл!!");
			history.go(-1);
		</script>	
<%
	}else if( valid == 2){
%>
	<script language="JavaScript">
		rdShowMessageDialog("ҵ�����<br>������� '<%=result[0][0]%>'��<br>������Ϣ '<%=result[0][1]%>'��");
		history.go(-1);
	</script>
<%
	}
	else{
%>
<HTML>
	<HEAD>
		<TITLE>��ϸ�Ż���Ϣ</TITLE>
	</HEAD>
	<body>
		<FORM method=post name="f1550_dBillCustDetail02">     
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">��ϸ�Ż���Ϣ</div>
			</div> 	    
			<TABLE cellSpacing="0">
			              <TBODY>
			                <TR align="center">
			                  <th>�Żݴ���</th>
			                  <th>�Ż�����</th>
                  			  <TH>�Ż�����</TH>
                              <TH>��ϸ�Ż�����</TH>
                              <TH>�Ż�˵��</TH>			                  
			                  <th>��ʼʱ��</th>
			                  <th>����ʱ��</th> 
                              <TH>״̬</TD>
                              <TH>�Ż�˳��</TH>
                              <TH>����ģ��</TH>			                                   
			                  <th>����ʱ��</th>
			                  <TH>��������</TH>
			                </TR>
					<%	      for(int y=0;y<result2.length;y++)
						      {
					%>
						        <tr>
					<%    		for(int j=0;j<result2[0].length;j++)
							{
					%>
							  <td><%= result2[y][j]%></td>
					<%
							}
					%>
						        </tr>
					<%
						      }			               
			        for (int i=0;i<result1.length;i++){%>
					<tr>
					  <td>
			                    <div align="center"><%=result1[i][0]%></div>
			                  </td>
			                  <td>
			                    <div align="center"><%=result1[i][1]%></div>
			                  </td>
			                   <td>
			                    <div align="center"><%=result1[i][2]%></div>
			                  </td>
			                   <td>
			                    <div align="center"><%=result1[i][3]%></div>
			                  </td>
			                   <td>
			                    <div align="center"><%=result1[i][4]%></div>
			                  </td>
					</tr>
					<%}%>
			          </TBODY>
			</TABLE>
			        
      <table cellspacing=0>
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
      <%
      	}
      %>
      <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
