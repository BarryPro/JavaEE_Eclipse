<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String[] inParas = new String[2];
		String opCode = "1302";
		String opName="账号缴费";
		String phone_no = WtcUtil.repStr(request.getParameter("phone_no")," ");
		String gift_type = WtcUtil.repStr(request.getParameter("gift_type")," ");
		String open_time = WtcUtil.repStr(request.getParameter("open_time")," ");
          
		System.out.println("aaaaaaaaaaaaa"+phone_no);
		System.out.println("bbbbbbbbbbbbb"+gift_type);
		System.out.println("cccccc"+open_time);
		
		String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
		String sqlStr1 = "";
		//sqlStr1 = "select to_char(id_no) from dcustmsg where phone_no='?'";
		inParas[0]="select to_char(id_no) from dcustmsg where phone_no=:phone_no";
		inParas[1]="phone_no="+phone_no;
%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
			String id_no = "";
			if(result1!=null&&result1.length>0){
				id_no = (result1[0][0]).trim();
			}
			System.out.println("id_no="+id_no);

			String sqlStr2 = "";
			//sqlStr2 = "select count(*)  from wawarddata where phone_no='?' and award_code='01' and award_detail_code='0855'  and id_no=?";
			inParas[0]="select to_char(count(*))  from wawarddata where phone_no=:phone_no and award_code='01' and award_detail_code='0855'  and id_no=:id_no";
			inParas[1]="phone_no="+phone_no+",id_no="+id_no;

%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		 <wtc:param value="<%=inParas[0]%>"/>
		 <wtc:param value="<%=inParas[1]%>"/>
		</wtc:service>
		<wtc:array id="result2" scope="end" />
<%
		String num = "";
		if(result2!=null&&result2.length>0){
			num = (result2[0][0]).trim();
		}
		
		String sqlStr3 = "";
		sqlStr3 = "select  case when to_char(to_date('?','yyyy-mm-dd hh24:mi:ss'),'yyyymmdd') between '20030101' and to_char(sysdate,'yyyymmdd') then '1021' when to_char(to_date('?','yyyy-mm-dd hh24:mi:ss'),'yyyymmdd') between '19980101'and '20021231' then '1022'  else '1023' end from dual  ";
		 
%>
		<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
		<wtc:sql><%=sqlStr3%></wtc:sql>
		<wtc:param value="<%=open_time%>"/>
		<wtc:param value="<%=open_time%>"/>
		</wtc:pubselect>
		<wtc:array id="result3" scope="end" />
<%			
		String type = "";
		if(result3!=null&&result3.length>0){
			type = (result3[0][0]).trim();
		}
		System.out.println("dddddddddd type="+type);
		String giftflag="";
		
		if(type.equals(gift_type)){
			giftflag="0";
		}else{
			giftflag="1";
		}
System.out.println("dddddddddd giftflag="+giftflag);			
  
%>
		var response = new AJAXPacket();
		var num = "<%=num%>";
		var giftflag = "<%=giftflag%>";
		response.data.add("num",num);
		response.data.add("giftflag",giftflag);
		core.ajax.receivePacket(response);


 