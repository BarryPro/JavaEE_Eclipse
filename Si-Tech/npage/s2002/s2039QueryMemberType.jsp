<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<%
String opName  = "��Ա��������";
String opCode = "";
%>
<head>

<!--<script type="text/javascript" src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>-->
<!--<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>-->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>

<script language="javascript">

function doProcess(packet){
		error_code = packet.data.findValueByName("errorCode");
		error_msg  = packet.data.findValueByName("errorMsg");
		verifyType = packet.data.findValueByName("verifyType");
		var backArrMsg = packet.data.findValueByName("backArrMsg");
		
		
		self.status="";
		if(verifyType=="setMemType"&&backArrMsg!=""){
			document.getElementById("td"+backArrMsg[0][0]).innerHTML =backArrMsg[0][1] ;
			document.getElementById("validFlagDis"+backArrMsg[0][0]).innerHTML =backArrMsg[0][2] ;
			document.getElementById("outAbleDis"+backArrMsg[0][0]).innerHTML =backArrMsg[0][3] ;
		}
	}

function setMemType(proSpecNum){
	var memberType;
	var validFlag;
	var outAble;
	var s = "memberType = document.getElementById('"+proSpecNum+"');";
	var str = "validFlag = document.getElementById('validFlag"+proSpecNum+"');";
	var st = "outAble = document.getElementById('outAble"+proSpecNum+"');"
	eval(s);
	eval(str);
	eval(st);
	
	var myPacket = new AJAXPacket("s2039SetMemberType.jsp","�����ύ��......");				      			    

		myPacket.data.add("proSpecNum",proSpecNum);
		myPacket.data.add("memberType",memberType.value);
		myPacket.data.add("validFlag",validFlag.value);
		myPacket.data.add("outAble",outAble.value)
		myPacket.data.add("verifyType","setMemType");
	
		core.ajax.sendPacket(myPacket);	
		myPacket=null;
}
</script>

</head>

<%
	Logger logger = Logger.getLogger("f5102.jsp");
	 
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String  implRegion = baseInfo[0][16].substring(0,2);
%>

<%
	String sqlStr = "SELECT b.productspec_number,b.productspec_name,decode(a.member_type,'0','������','1','ǩԼ��Ա','2','������'),a.member_type,decode(a.valid_flag,'0','ȷ�ϱ���','1','�鵵����'),a.valid_flag,decode(a.out_able,'0','������','1','����'),a.out_able "
	                 +" FROM sMemberType a,dproductspecInfo b "
	                 +" WHERE a.productspec_number(+) = b.productspec_number";
	
	String PospecNum = request.getParameter("PospecNum")==null?"":request.getParameter("PospecNum"); 
	String PospecProNum = request.getParameter("PospecProNum")==null?"":request.getParameter("PospecProNum"); 
	
	if(!"".equals(PospecProNum)){
		sqlStr = sqlStr + " and b.productspec_number = '"+PospecProNum+"'";
	}else if(!"".equals(PospecNum)){
		sqlStr = sqlStr + " and b.POSPEC_NUMBER = '"+PospecNum+"'";	
	}
	
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
%>
<wtc:pubselect name="sPubSelect" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end" />


	
	
<body bgcolor="#FFFFFF" text="#000000" background="" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="/npage/include/header_pop.jsp" %> 
<form name="form1" method="post" action="">	
	<div style="height: 360px;width: 99%;overflow: auto">
  <table cellspacing=0>
  <tr>
  <th>��Ʒ������</th>
  <th>��Ʒ�������</th>
  <th>��Ա����</th>
  <th>����ѡ��</th>
  <th>��Ա��Ч��ʶ</th>
  <th>��Ա��Ч��ʶѡ��</th>
  <th>�����Ա</th>
  <th>�Ƿ�ɼ������Ա</th>
  <th>����</th>
  </tr>
	<%for(int i = 0;i<result1.length;i++){%>
		
		<tr>
			<td><%=result1[i][0]%>&nbsp;</td>
			<td><%=result1[i][1]%>&nbsp;</td>
			<td><a id='td<%=result1[i][0]%>'><%=result1[i][2]%></a>&nbsp;</td>
			<td><select id='<%=result1[i][0]%>'><option value=1 <%if("1".equals(result1[i][3])){%>selected<%}%> >1&rarr;ǩԼ��Ա</option><option value=0 <%if("0".equals(result1[i][3])){%>selected<%}%> >0&rarr;������</option><option value=2 <%if("2".equals(result1[i][3])){%>selected<%}%> >2&rarr;������</option></select>&nbsp;</td>
      <td><a id='validFlagDis<%=result1[i][0]%>'><%=result1[i][4]%></a>&nbsp;</td>
      <td><select id='validFlag<%=result1[i][0]%>'><option value=0 <%if("0".equals(result1[i][5])){%>selected<%}%> >0&rarr;ȷ�ϱ�����Ч</option><option value=1 <%if("1".equals(result1[i][5])){%>selected<%}%> >1&rarr;�鵵������Ч</option></select>&nbsp;</td>
			<td><a id='outAbleDis<%=result1[i][0]%>'><%=result1[i][6]%></a>&nbsp;</td>
			<td><select id='outAble<%=result1[i][0]%>'><option value=0 <%if("0".equals(result1[i][7])){%>selected<%}%> >0&rarr;���ɼ������Ա</option><option value=1 <%if("1".equals(result1[i][7])){%>selected<%}%> >1&rarr;���Լ������Ա</option></select>&nbsp;</td> 
			<td><input type=button class="b_text" value='����' onClick="setMemType('<%=result1[i][0]%>');" >&nbsp;</td>
		<tr>
	<%}%>
</table>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=�ر�>
            </TD>
        </TR>
    </TBODY>
</TABLE>
	</div>
</form>                                 
<%@ include file="/npage/include/footer.jsp" %>     

</body>
</html>
