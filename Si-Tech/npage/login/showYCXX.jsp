<%
/********************
 version v2.0
������: si-tech
����:�ۺ���Ϣ��ѯ֮Ԥ�������Ϣ
update:liutong@2008-8-13
update:tangsong@2010-12-30 ҳ����ʽ����,�����û���Ϣҳ
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "1500";
	String opName = "�ۺ���Ϣ��ѯ֮Ԥ�������Ϣ";

	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String contract_no  = request.getParameter("contractNo");
	String phoneNo  = request.getParameter("phoneNo");
    //contract_no="13017553273";
    System.out.println("SSSSSSSSSSSSSSSSSSSS contract_no is "+contract_no);
	String sql_str0="";
	String[] inParas2 = new String[2];
	inParas2[0]="SELECT bill_flag FROM cBillCond WHERE run_flag=1 and to_number(to_char(sysdate,'ddhh24')) between begin_dayhour and end_dayhour";
%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	  <wtc:param value="<%=inParas2[0]%>"/>
	</wtc:service>
	<wtc:array id="result0" scope="end" />
<%
	String bill_flag ="";
	if(result0==null||result0.length==0){
	}else{
		bill_flag  = (result0[0][0]).trim();
	}
 
	String sql_str;

	if(bill_flag.equals("1")){
		inParas2[0]= "select pay_name,prepay_fee,case when (allow_pay>prepay_fee) then to_char(prepay_fee) else to_char(allow_pay) end,add_prepay,live_flag,allow_pay,begin_dt,end_dt,decode(b.trans_flag,'0','��ת','1','����ת'),to_char(b.order_code) from dConMsgPreMid36 a,sPayType b where a.pay_type=b.pay_type and a.contract_no=:contractNo and a.pay_type not in (select new_pay_type from cbillcond where rownum < 2) union all select pay_name,prepay_fee,to_char(last_prepay),add_prepay,live_flag,allow_pay,begin_dt,end_dt,decode(d.trans_flag,'0','��ת','1','����ת'),to_char(d.order_code) from dConMsgPre c,sPayType d where c.pay_type=d.pay_type  and begin_dt<=to_char(sysdate,'yyyymmdd') and end_dt> to_char(sysdate,'yyyymmdd') and c.contract_no=:contractNo1 and c.pay_type = (select new_pay_type from cbillcond where rownum < 2) order by begin_dt asc";
		inParas2[1]="contractNo="+contract_no+",contractNo1="+contract_no; 
 
	}else{
		inParas2[0]="select pay_name,prepay_fee,case when (allow_pay>prepay_fee) then to_char(prepay_fee) else to_char(allow_pay) end,begin_dt,end_dt,decode(b.trans_flag,'0','��ת','1','����ת'),to_char(b.order_code) from dConMsgPre a,sPayType b ,dcustmsg c where a.pay_type=b.pay_type  and begin_dt<=to_char(sysdate,'yyyymmdd') and end_dt> to_char(sysdate,'yyyymmdd') and a.contract_no=c.contract_no and c.phone_no=:phone_no order by a.begin_dt asc";
		inParas2[1]="phone_no="+phoneNo;
	}


System.out.println("FFFFFFFFFFFFFFFFFFFFFFFFFFF inParas2[0] is "+inParas2[0]);
%>

    <wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="7">
        <wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />

	<%

	/**try{
	 	S1100View callView = new S1100View();
		arlist = callView.view_spubqry32("8",sql_str);
	}
	catch(Exception e)
	{
		//System.out.println("����EJB����ʧ�ܣ�");
	}
	String [][] result = new String[][]{{"0","1","2","3","4","5","6","7"}};
	int result_row = Integer.parseInt((String)arlist.get(1));
	**/


if(!retCode2.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("����δ�ܳɹ�,�������<%=retCode2%><br>������Ϣ<%=retMsg2%>!");
			history.go(-1);
		</script>
<%
		return;
	}


	if (result==null||result.length==0)
	{
%>
	<script language="JavaScript">
		rdShowMessageDialog("<br>û�з�������������",1);
		history.go(-1);
	</script>
<%
		return;
	}
%>

<HTML><HEAD><TITLE>Ԥ�������Ϣ</TITLE>
<script type="text/javascript">
	window.onload = function() {
		var newHeight = document.body.scrollHeight + 20 + "px";
		var newWidth = document.body.scrollWidth + 20 + "px";
		window.parent.document.getElementById("showCustWTab").style.height = newHeight;
		window.parent.document.getElementById("showCustWTab").style.width = newWidth;
		window.parent.document.getElementById("iFrame1").style.height = newHeight;
		window.parent.document.getElementById("iFrame1").style.width = newWidth;
	}
</script>
</HEAD>
<body>
	<DIV id="Operation_Table" style="width:765px;">
			<div class="title">
				<div id="title_zi">Ԥ�������Ϣ(���ṩ)</div>
			</div>
<FORM method=post name="f1500_dConMsgPre">

            <TABLE  cellSpacing="0">
              <TBODY>
                <TR align="center">
                  <th>�ʻ���Ŀ</th>
                  <th>Ԥ����</th>
                  
                  <th>��ǰ�ɻ���</th>
                  <th>ר�ʼ����</th>
                  <th>ר���������</th>
				  <th>ר���Ƿ��ת</th>
				  <th>Ԥ�����ȼ���</th>
                </TR>
<%
			String tbClass="";
			for(int y=0;y<result.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
%>
	        <tr align="center">
<%
					for(int j=0;j<result[0].length;j++)
	        {
%>
	          <td class="<%=tbClass%>"><%= result[y][j]%></td>
<%
					}
%>
	          </tr>
<%	      }
%>
	<!--
	<tr>
		<td colspan=10>
			ע��Ԥ�����ȼ�������Խ�����ȼ���Խ�͡�
		</td>
	</tr>
	-->
        </TBODY>
	    </TABLE>
      <table cellspacing="0">
        <tbody>
          <tr>
      	    <td id=footer>

    	      &nbsp;
    	    </td>
          </tr>
        </tbody>
      </table>

</FORM>
</BODY></HTML>
